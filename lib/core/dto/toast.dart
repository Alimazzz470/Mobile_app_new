import '../../shared/utils/enums.dart';
import '../exceptions/coded_exception.dart';

class ToastDto {
  final String? message;
  final ToastType? type;
  final CodedException? exception;
  final void Function()? onRetry;

  const ToastDto({
    this.message,
    this.type,
    this.exception,
    this.onRetry,
  });
}
