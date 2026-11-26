import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:share_plus/share_plus.dart';

import '../../../venue_shell/data/models/venue_model.dart';
import '../../../venue_shell/presentation/venue_format.dart';
import '../../data/models/venue_booking_item_model.dart';

/// Shares the bookings shown now as a CSV file, like the web "export page".
abstract final class VenueBookingsCsv {
  static Future<void> share(
    BuildContext context,
    VenueModel venue,
    List<VenueBookingItemModel> items,
  ) async {
    String t(String key) => 'venue.bookings.csv.$key'.tr(context: context);
    String pitch(String id) =>
        venue.pitches.where((p) => p.id == id).firstOrNull?.name ?? '';
    final rows = [
      [
        t('reference'),
        t('customer'),
        t('phone'),
        t('pitch'),
        t('time'),
        t('price'),
        t('deposit'),
        t('status'),
      ],
      for (final b in items)
        [
          b.reference,
          b.customerName ?? '',
          b.customerPhone ?? '',
          pitch(b.pitchId),
          VenueFormat.dateTime(context, b.startUtc),
          '${b.totalPrice}',
          '${b.depositAmount}',
          VenueFormat.statusLabel(
            context,
            b.status,
            isManual: b.isManual,
            deposit: b.depositAmount,
          ),
        ],
    ];
    final csv = rows.map((r) => r.map(_cell).join(',')).join('\r\n');
    // BOM so spreadsheet apps read Arabic correctly.
    final bytes = utf8.encode('﻿$csv');
    await SharePlus.instance.share(
      ShareParams(
        files: [
          XFile.fromData(bytes, mimeType: 'text/csv', name: 'reservations.csv'),
        ],
        fileNameOverrides: const ['reservations.csv'],
      ),
    );
  }

  /// Quotes a value and neutralises spreadsheet formulas (CSV injection).
  static String _cell(String value) {
    var v = value;
    if (v.isNotEmpty && '=+-@\t\r'.contains(v[0])) v = "'$v";
    return '"${v.replaceAll('"', '""')}"';
  }
}
