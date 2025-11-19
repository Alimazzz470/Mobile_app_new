import 'coded_exception.dart';
import 'exception_codes.dart';

class ServerException extends CodedException {
  const ServerException([this.message]);

  @override
  final String? message;

  @override
  ExceptionCodes get code => ExceptionCodes.server;
}
