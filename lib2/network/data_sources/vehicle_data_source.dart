import 'package:dio/dio.dart';

import '../../core/dto/query_params.dart';
import '../../core/entities/vehicle/vehicle.dart';
import '../../core/entities/vehicle/vehicle_type.dart';
import '../../core/exceptions/exceptions.dart';
import '../../shared/pagination/model.dart';
import '../api_config.dart';
import '../clients/api_client.dart';
import '../clients/cancel_token.dart';
import '../models/vehicle/vehicle_model.dart';
import '../models/vehicle/vehicle_type_model.dart';

class VehicleDataSource {
  final ApiClient _apiClient;

  const VehicleDataSource(this._apiClient);

  Future<PaginatedResponse<Vehicle>> getVehicles({
    QueryParams? params,
    CancellationToken? cancelToken,
  }) async {
    params ??= QueryParams(
      page: params?.page ?? 1,
      limit: 10,
    );

    try {
      var res = await _apiClient.get(
        ApiConfig.getVehicles(params: params),
        cancelToken: cancelToken,
      );

      if (res != null) {
        return VehicleListModel(res.data);
      }

      throw const NullDataException();
    } on DioException catch (e) {
      var error = ExceptionModel.fromJson(e.response?.data);
      throw UnknownException(error.message);
    }
  }

  Future<List<VehicleType>> getVehicleTypes({
    CancellationToken? cancelToken,
  }) async {
    try {
      var res = await _apiClient.get(
        ApiConfig.getVehicleTypes,
        cancelToken: cancelToken,
      );

      if (res != null) {
        return (res.data as List).map((e) => VehicleTypeModel.fromJson(e)).toList(growable: false);
      }

      throw const NullDataException();
    } on DioException catch (e) {
      var error = ExceptionModel.fromJson(e.response?.data);
      throw UnknownException(error.message);
    }
  }

  Future<Vehicle?> vehicleAssigned({
    CancellationToken? cancelToken,
  }) async {
    try {
      var res = await _apiClient.get(
        ApiConfig.vehicleAssigned,
        cancelToken: cancelToken,
      );

      if (res != null) {
        return res.data == "" ? null : VehicleModel.fromJson(res.data);
      }

      throw const NullDataException();
    } on DioException catch (e) {
      var error = ExceptionModel.fromJson(e.response?.data);
      throw UnknownException(error.message);
    }
  }

  Future<void> requestVehicle({
    required String vehicleId,
    CancellationToken? cancelToken,
  }) async {
    try {
      var res = await _apiClient.patch(
        ApiConfig.requestVehicle(vehicleId),
        cancelToken: cancelToken,
      );

      if (res != null) {
        return;
      }

      throw const NullDataException();
    } on DioException catch (e) {
      var error = ExceptionModel.fromJson(e.response?.data);
      throw UnknownException(error.message);
    }
  }

  Future<void> returnVehicle({
    required int kms,
    required String vehicleId,
    required String confirmationId,
    required String signatureId,
    CancellationToken? cancelToken,
  }) async {
    try {
      await _apiClient.patch(
        ApiConfig.returnVehicle(vehicleId),
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

  Future<void> monthlyInspection({
    required String inspectionId,
    required int kms,
    required String vehicleId,
    required String confirmationId,
    required String signatureId,
    CancellationToken? cancelToken,
  }) async {
    try {
      await _apiClient.patch(
        ApiConfig.monthlyInspection(inspectionId),
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
