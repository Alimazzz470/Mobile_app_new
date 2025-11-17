import '../../network/clients/cancel_token.dart';

mixin RequestCancellation {
  final cancellationToken = CancellationToken();

  void cancel() {
    cancellationToken.cancel("Request cancelled");
  }
}
