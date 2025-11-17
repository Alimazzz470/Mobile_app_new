import 'coded_exception.dart';
import 'exception_codes.dart';

class RequestCanceledException extends CodedException {
  const RequestCanceledException();
  @override
  ExceptionCodes get code => ExceptionCodes.requestCanceled;
}
