import 'coded_exception.dart';
import 'exception_codes.dart';

class NoUserFoundException extends CodedException {
  const NoUserFoundException();

  @override
  ExceptionCodes get code => ExceptionCodes.noUserFound;
}
