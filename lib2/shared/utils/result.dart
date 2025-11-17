import '../../core/exceptions/coded_exception.dart';

sealed class Result<E extends CodedException, S> {
  const Result();

  R when<R>({
    required R Function(S value) success,
    required R Function(E exception, StackTrace stackTrace) failure,
    R Function()? canceled,
  }) {
    if (this is Success) {
      return success((this as Success).value);
    } else if (this is Failure<E, S>) {
      final e = this as Failure<E, S>;
      return failure(e.exception, e.stackTrace);
    } else if (this is Canceled<E, S>) {
      return canceled?.call() ?? {} as R;
    } else {
      throw StateError('Invalid result type: $runtimeType');
    }
  }
}

final class Success<E extends CodedException, S> extends Result<E, S> {
  final S value;
  Success(this.value);
}

final class Failure<E extends CodedException, S> extends Result<E, S> {
  final E exception;
  final StackTrace stackTrace;
  Failure(this.exception, this.stackTrace);
}

final class Canceled<E extends CodedException, S> extends Result<E, S> {
  const Canceled();
}

typedef FutureResult<T> = Future<Result<CodedException, T>>;

typedef FutureVoid = Future<Result<CodedException, void>>;
