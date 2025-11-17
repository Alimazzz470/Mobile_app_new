import '../../core/entities/image_upload_link.dart';
import '../../core/exceptions/exceptions.dart';
import '../../network/clients/cancel_token.dart';
import '../../network/data_sources/shared_data_source.dart';
import '../utils/enums.dart';
import '../utils/result.dart';
import 'shared_repository.dart';

class SharedRepoImpl implements SharedRepository {
  final SharedDataSource _dataSource;

  const SharedRepoImpl({
    required SharedDataSource dataSource,
  }) : _dataSource = dataSource;

  @override
  FutureResult<ImageUploadLink> getUploadLinks(
    int count,
    UploadImageType type, [
    String? fileNames,
    CancellationToken? cancelToken,
  ]) async {
    try {
      final result = await _dataSource.getUploadLinks(count, type, fileNames, cancelToken);

      return Success(result);
    } on RequestCanceledException {
      return const Canceled();
    } catch (e, stackTrace) {
      if (e is CodedException) {
        return Failure(e, stackTrace);
      }
      return Failure(UnknownException(e.toString()), stackTrace);
    }
  }
}
