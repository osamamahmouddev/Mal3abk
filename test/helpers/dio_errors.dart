import 'package:dio/dio.dart';

DioException badResponse(int statusCode, [Object? data]) {
  final options = RequestOptions(path: '/test');
  return DioException.badResponse(
    statusCode: statusCode,
    requestOptions: options,
    response: Response<dynamic>(
      requestOptions: options,
      statusCode: statusCode,
      data: data,
    ),
  );
}
