import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../features/auth/providers/auth_provider.dart';
import 'routes.dart';

final navigatorKeyProvider = Provider((_) => GlobalKey<NavigatorState>());

final routerListenableProvider =
    AsyncNotifierProvider.autoDispose<RouterListenable, void>(() {
  return RouterListenable();
});

class RouterListenable extends AutoDisposeAsyncNotifier<void>
    implements Listenable {
  VoidCallback? _routerListener;
  bool? _isAuth;

  @override
  FutureOr<void> build() {
    ref.watch(authStateProvider).whenData((v) => _isAuth = v);

    ref.listenSelf((_, __) {
      // One could write more conditional logic for when to call redirection
      if (state.isLoading) return;
      _routerListener?.call();
    });
  }

  Future<String?> redirect(BuildContext context, GoRouterState state) async {
    if (this.state.isLoading || this.state.hasError) return null;

    final isSplash = state.uri.toString() == Routes.splash;
    var isAuthorized = _isAuth;
    if (isAuthorized == null) {
      //Displays the splash screen
      return null;
    }

    if (isSplash) {
      return isAuthorized ? Routes.home : Routes.signIn;
    }

    final isLoggingIn = state.uri.toString() == Routes.signIn;
    if (isLoggingIn) return isAuthorized ? Routes.home : null;

    return isAuthorized ? null : Routes.splash;
  }

  @override
  void addListener(VoidCallback listener) {
    _routerListener = listener;
  }

  @override
  void removeListener(VoidCallback listener) {
    _routerListener = null;
  }
}
