import '../../core/entities/image_upload_link.dart';
import '../../network/clients/cancel_token.dart';
import '../utils/enums.dart';
import '../utils/result.dart';

abstract class SharedRepository {
  const SharedRepository();

  FutureResult<ImageUploadLink> getUploadLinks(
    int count,
    UploadImageType type, [
    String? fileNames,
    CancellationToken? cancelToken,
  ]);
}
