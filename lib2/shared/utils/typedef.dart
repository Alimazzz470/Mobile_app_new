import '../../core/exceptions/exceptions.dart';

typedef OnSuccessVoidCallback = void Function();
typedef OnSuccessCallback<T> = void Function(T? data);
typedef OnErrorCallback = void Function(CodedException message);
