import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../shared/providers/common_providers.dart';
import 'api_config.dart' show BASE_URL, DEV_BASE_URL, ANDROID_BASE_URL;
import 'clients/api_client.dart';
import 'data_sources/token_data_source.dart';
import 'data_sources/token_sign_out_facade.dart';

final apiClient = Provider(
  (ref) {
    // TODO: Remove when dev is done
    final _baseUrl = Platform.isAndroid ? ANDROID_BASE_URL : DEV_BASE_URL;

    return ApiClient(
      connectivity: ref.read(connectivityProvider),
      tokenDataSource: ref.read(tokenSignOutFacade),
      baseUrl: BASE_URL,
      // baseUrl: _baseUrl,
    );
  },
);

final tokenDataSource = Provider((_) => TokenDataSource());

final tokenSignOutFacade = Provider((ref) {
  return TokenSignOutFacade(
    dataSource: ref.watch(tokenDataSource),
    performSignOut: () {
      ref.invalidate(loggedInUserProvider);
    },
  );
});
