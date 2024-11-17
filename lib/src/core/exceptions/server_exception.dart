import 'package:planning_poker_ifood/src/core/exceptions/base_exception.dart';

class ServerException extends BaseException {
  ServerException({required super.message, super.stackTrace, super.data, super.code});
}
