import 'coded_exception.dart';
import 'exception_codes.dart';

class NotRefreshedTokenException extends CodedException {
  const NotRefreshedTokenException();

  @override
  ExceptionCodes get code => ExceptionCodes.notRefreshedToken;
}
