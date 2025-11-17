import 'coded_exception.dart';
import 'exception_codes.dart';

class NoStoredTokenException extends CodedException {
  const NoStoredTokenException();

  @override
  ExceptionCodes get code => ExceptionCodes.noStoredToken;
}
