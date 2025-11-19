import 'stub_connectivity.dart'
    if (dart.library.io) 'io_connectivity.dart'
    if (dart.library.js) 'web_connectivity.dart';

class ConnectivityManager {
  late final ConnectivityService _service;

  ConnectivityManager() {
    _service = ConnectivityService();
  }

  Future<bool> call() => _service.isConnected;
}
