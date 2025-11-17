import 'coded_exception.dart';
import 'exception_codes.dart';

class ForbiddenException extends CodedException {
  const ForbiddenException();
  @override
  ExceptionCodes get code => ExceptionCodes.forbidden;
}
