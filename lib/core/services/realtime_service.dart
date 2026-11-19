import 'dart:async';

import 'package:dio/dio.dart';
import 'package:signalr_netcore/signalr_client.dart';

import '../config/env_config.dart';
import '../utils/app_logger.dart';

/// A slot was held, booked or freed on a venue someone is looking at.
class SlotStatusUpdate {
  const SlotStatusUpdate({
    required this.venueId,
    required this.pitchId,
    required this.startUtc,
    required this.endUtc,
    required this.status,
    required this.changedAtUtc,
  });

  /// Reads the hub's `SlotStatusChanged` payload; null when it is malformed.
  static SlotStatusUpdate? fromHub(Object? payload) {
    if (payload is! Map) return null;
    final start = DateTime.tryParse('${payload['startUtc']}');
    final end = DateTime.tryParse('${payload['endUtc']}');
    final changed = DateTime.tryParse('${payload['changedAtUtc']}');
    final pitchId = payload['pitchId'];
    final status = payload['status'];
    if (start == null ||
        end == null ||
        pitchId is! String ||
        status is! String) {
      return null;
    }
    return SlotStatusUpdate(
      venueId: payload['venueId'] is String ? payload['venueId'] as String : '',
      pitchId: pitchId,
      startUtc: start.toUtc(),
      endUtc: end.toUtc(),
      status: status,
      changedAtUtc: (changed ?? DateTime.now()).toUtc(),
    );
  }

  final String venueId;
  final String pitchId;
  final DateTime startUtc;
  final DateTime endUtc;

  /// `free`, `held` or `booked`.
  final String status;
  final DateTime changedAtUtc;

  bool get isFree => status == 'free';

  /// The availability API's slot state for this update: 0 available,
  /// 1 held, 2 booked.
  int get slotState => switch (status) {
    'free' => 0,
    'held' => 1,
    _ => 2,
  };
}

/// One of the signed-in player's bookings changed (approved, rejected, ...).
class BookingStatusUpdate {
  const BookingStatusUpdate({required this.bookingId, required this.status});

  static BookingStatusUpdate? fromHub(Object? payload) {
    if (payload is! Map) return null;
    final id = payload['bookingId'];
    final status = payload['status'];
    if (id is! String || status is! String) return null;
    return BookingStatusUpdate(bookingId: id, status: status);
  }

  final String bookingId;
  final String status;
}

/// Live booking updates from the API's `/hubs/booking` (SignalR over
/// WebSockets only).
abstract class RealtimeService {
  /// Slots changing on the venue days being watched.
  Stream<SlotStatusUpdate> get slotUpdates;

  /// The signed-in player's own bookings changing.
  Stream<BookingStatusUpdate> get bookingUpdates;

  /// Fires after a dropped connection is back: updates sent meanwhile were
  /// missed, so screens reload what they show.
  Stream<void> get reconnected;

  /// Follows one venue's business day (`YYYY-MM-DD`, Cairo). Connects when
  /// needed; a guest without a session gets no live updates.
  Future<void> watchVenue(String venueId, String date);

  Future<void> leaveVenue(String venueId, String date);

  /// Opens the connection without watching a venue, for the player's own
  /// booking updates. Does nothing when already connected.
  Future<void> connect();

  /// Signs the connection out (sign-out): the next watch opens a new one
  /// for whoever is signed in then.
  Future<void> disconnect();
}

/// [RealtimeService] on SignalR. Every connection, reconnections included,
/// opens with a fresh single-use ticket from `POST /realtime/ticket`, so the
/// negotiate step is skipped: it would spend the ticket before the socket.
class SignalRRealtimeService implements RealtimeService {
  SignalRRealtimeService({required this.dio, required this.envConfig});

  /// The app's authenticated client, used only to get tickets.
  final Dio dio;
  final EnvConfig envConfig;

  static const String hubPath = '/hubs/booking';
  static const String ticketPath = '/api/v1/realtime/ticket';

  final _slots = StreamController<SlotStatusUpdate>.broadcast();
  final _bookings = StreamController<BookingStatusUpdate>.broadcast();
  final _reconnected = StreamController<void>.broadcast();

  /// Venue days being watched, re-joined after every reconnect.
  final Set<(String, String)> _watched = {};

  HubConnection? _connection;
  Future<HubConnection?>? _connecting;

  @override
  Stream<SlotStatusUpdate> get slotUpdates => _slots.stream;

  @override
  Stream<BookingStatusUpdate> get bookingUpdates => _bookings.stream;

  @override
  Stream<void> get reconnected => _reconnected.stream;

  @override
  Future<void> watchVenue(String venueId, String date) async {
    _watched.add((venueId, date));
    final connection = await _ensureConnected();
    if (connection == null) return;
    try {
      await connection.invoke('WatchVenue', args: [venueId, date]);
    } on Exception catch (e) {
      AppLogger.w('Live slots unavailable: ${e.runtimeType}');
    }
  }

  @override
  Future<void> leaveVenue(String venueId, String date) async {
    _watched.remove((venueId, date));
    final connection = _connection;
    if (connection?.state != HubConnectionState.Connected) return;
    try {
      await connection!.invoke('LeaveVenue', args: [venueId, date]);
    } on Exception {
      // The room is dropped with the connection anyway.
    }
  }

  @override
  Future<void> connect() => _ensureConnected();

  @override
  Future<void> disconnect() async {
    _watched.clear();
    final connection = _connection;
    _connection = null;
    _connecting = null;
    try {
      await connection?.stop();
    } on Exception {
      // Already closed.
    }
  }

  Future<HubConnection?> _ensureConnected() {
    final current = _connection;
    if (current != null && current.state == HubConnectionState.Connected) {
      return Future.value(current);
    }
    return _connecting ??= _connect().whenComplete(() => _connecting = null);
  }

  Future<HubConnection?> _connect() async {
    final previous = _connection;
    if (previous != null) {
      try {
        await previous.stop();
      } on Exception {
        // Replaced below.
      }
    }

    final connection =
        HubConnectionBuilder()
            .withUrl(
              '${envConfig.baseUrl}$hubPath',
              options: HttpConnectionOptions(
                transport: HttpTransportType.WebSockets,
                skipNegotiation: true,
                accessTokenFactory: _ticket,
                requestTimeout: 15000,
              ),
            )
            .withAutomaticReconnect(
              retryDelays: [0, 2000, 5000, 10000, 20000, 30000],
            )
            .build()
          // Quiet sockets are kept open through proxies (SECURITY.md: 15-30 s).
          ..keepAliveIntervalInMilliseconds = 15000
          ..serverTimeoutInMilliseconds = 40000;

    connection.on('SlotStatusChanged', (args) {
      final update = SlotStatusUpdate.fromHub(args?.firstOrNull);
      if (update != null) _slots.add(update);
    });
    connection.on('BookingUpdated', (args) {
      final update = BookingStatusUpdate.fromHub(args?.firstOrNull);
      if (update != null) _bookings.add(update);
    });
    connection.onreconnected(({connectionId}) async {
      // A new connection has no rooms: join them again, then let screens
      // catch up on what changed while it was down.
      for (final (venueId, date) in _watched.toList()) {
        try {
          await connection.invoke('WatchVenue', args: [venueId, date]);
        } on Exception {
          // Retried on the next reconnect.
        }
      }
      _reconnected.add(null);
    });

    try {
      await connection.start();
      _connection = connection;
      return connection;
    } on Exception catch (e) {
      // Signed out, offline or the hub is down: the screens still work,
      // only without live updates.
      AppLogger.w('Realtime connection failed: ${e.runtimeType}');
      return null;
    }
  }

  Future<String> _ticket() async {
    final response = await dio.post<Map<String, dynamic>>(ticketPath);
    final ticket = response.data?['ticket'];
    if (ticket is! String || ticket.isEmpty) {
      throw StateError('No realtime ticket');
    }
    return ticket;
  }
}
