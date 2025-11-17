import '../models/token_model.dart';
import 'token_data_source.dart';

typedef PerformSignOut = void Function();

class TokenSignOutFacade implements TokenDataSource {
  final TokenDataSource dataSource;
  final PerformSignOut performSignOut;

  const TokenSignOutFacade({
    required this.dataSource,
    required this.performSignOut,
  });

  @override
  Future<void> clear() async {
    await dataSource.clear();
    performSignOut();
  }

  @override
  Future<TokenModel> get() => dataSource.get();

  @override
  Future<void> save(TokenModel token) => dataSource.save(token);
}
