import 'coded_exception.dart';
import 'exception_codes.dart';

class UnknownException extends CodedException {
  const UnknownException(this.message);

  @override
  final String? message;

  @override
  ExceptionCodes get code => ExceptionCodes.unknown;

  @override
  String toString() => "UnknownException: $message";
}
