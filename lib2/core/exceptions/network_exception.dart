import 'coded_exception.dart';
import 'exception_codes.dart';

class NetworkException extends CodedException {
  const NetworkException();
  @override
  ExceptionCodes get code => ExceptionCodes.network;
}
