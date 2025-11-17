import 'coded_exception.dart';
import 'exception_codes.dart';

class NullDataException extends CodedException {
  const NullDataException();
  @override
  ExceptionCodes get code => ExceptionCodes.receivedNullData;
}
