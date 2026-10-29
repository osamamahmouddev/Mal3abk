import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';

/// Answers Dio requests in-process so interceptors can be tested end to end.
class FakeHttpAdapter implements HttpClientAdapter {
  FakeHttpAdapter(this.respond);

  final ResponseBody Function(RequestOptions options) respond;
  final List<RequestOptions> requests = [];

  static ResponseBody json(int statusCode, Map<String, dynamic> body) {
    return ResponseBody.fromString(
      jsonEncode(body),
      statusCode,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    requests.add(options);
    return respond(options);
  }

  @override
  void close({bool force = false}) {}
}
