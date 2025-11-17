import 'coded_exception.dart';
import 'exception_codes.dart';

class SignatureUploadException extends CodedException {
  const SignatureUploadException();
  @override
  ExceptionCodes get code => ExceptionCodes.signatureUpload;
}
