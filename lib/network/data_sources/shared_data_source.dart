import 'package:dio/dio.dart';

import '../../core/exceptions/exceptions.dart';
import '../../shared/utils/enums.dart';
import '../api_config.dart';
import '../clients/api_client.dart';
import '../clients/cancel_token.dart';
import '../models/image_upload_link_model.dart';

class SharedDataSource {
  final ApiClient _apiClient;
  const SharedDataSource(this._apiClient);

  Future<ImageUploadLinkModel> getUploadLinks(
    int count,
    UploadImageType type,
    String? fileNames,
    CancellationToken? cancelToken,
  ) async {
    var res = await _apiClient.post(
      ApiConfig.imageUploadLinks(count, type.dbValue, fileNames),
      cancelToken: cancelToken,
    );

    if (res != null) {
      return ImageUploadLinkModel.fromJson(res.data);
    }
    throw const NullDataException();
  }

  Future<void> monthlyInspection({
    required int kms,
    required String vehicleId,
    required String confirmationId,
    required String signatureId,
    CancellationToken? cancelToken,
  }) async {
    try {
      await _apiClient.patch(
        ApiConfig.monthlyInspection(vehicleId),
        body: {
          "kms": kms,
          "vehicleId": vehicleId,
          "confirmationId": confirmationId,
          "signatureId": signatureId,
        },
        cancelToken: cancelToken,
      );
    } on DioException catch (e) {
      var error = ExceptionModel.fromJson(e.response?.data);
      throw UnknownException(error.message);
    }
  }
}
