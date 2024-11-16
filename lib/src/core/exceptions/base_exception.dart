// ignore_for_file: public_member_api_docs, sort_constructors_first
abstract class BaseException implements Exception {
  final String message;
  final int? code;
  final dynamic data;
  final dynamic stackTrace;

  BaseException({
    required this.message,
    this.code,
    required this.data,
    required this.stackTrace,
  });
}
