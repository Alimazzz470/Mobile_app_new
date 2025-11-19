import 'dart:html' as html;

class ConnectivityService {
  Future<bool> get isConnected async {
    try {
      return html.window.navigator.onLine ?? true;
    } catch (_) {
      return false;
    }
  }
}
