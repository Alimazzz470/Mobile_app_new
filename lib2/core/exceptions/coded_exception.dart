import 'exception_codes.dart';

abstract class CodedException implements Exception {
  const CodedException();
  ExceptionCodes get code;
  String? get message => null;
  StackTrace? get stackTrace => null;
  void Function()? get actionCallback => null;
}
