import 'coded_exception.dart';
import 'exception_codes.dart';

class NoPayslipException extends CodedException {
  const NoPayslipException();

  @override
  ExceptionCodes get code => ExceptionCodes.noPayslip;
}
