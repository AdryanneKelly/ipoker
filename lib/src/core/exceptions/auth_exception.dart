import 'package:planning_poker_ifood/src/core/exceptions/base_exception.dart';

class AuthException extends BaseException {
  AuthException({required super.message, super.stackTrace, super.data, super.code});

}
