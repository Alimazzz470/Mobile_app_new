import 'package:dio/dio.dart';
import 'package:taxiapp_mobile/core/entities/advance.dart';
import 'package:taxiapp_mobile/core/entities/bonus.dart';
import 'package:taxiapp_mobile/core/entities/deduction.dart';
import 'package:taxiapp_mobile/core/entities/penalty.dart';

import '../../core/dto/query_params.dart';
import '../../core/exceptions/exceptions.dart';
import '../../core/exceptions/no_payslip_exception.dart';
import '../../core/exceptions/no_user_found_exception.dart';
import '../../shared/pagination/model.dart';
import '../api_config.dart';
import '../clients/api_client.dart';
import '../clients/cancel_token.dart';
import '../models/advance_model.dart';
import '../models/bonus_model.dart';
import '../models/deduction_model.dart';
import '../models/input/advance_input.dart';
import '../models/input/user_details_input.dart';
import '../models/penalty_model.dart';
import '../models/salary_type_model.dart';
import '../models/user_details_model.dart';

class ProfileDataSource {
  final ApiClient _apiClient;

  const ProfileDataSource(this._apiClient);

  Future<AdvanceModel> requestAdvance(
    AdvanceInput input,
    CancellationToken? cancelToken,
  ) async {
    var res = await _apiClient.post(
      ApiConfig.requestAdvance,
      cancelToken: cancelToken,
      body: input.toJson,
    );
    if (res != null) {
      return AdvanceModel.fromJson(res.data);
    }
    throw const NullDataException();
  }

  Future<PaginatedResponse<AdvanceModel>> getAdvances({
    QueryParams? params,
    CancellationToken? cancelToken,
  }) async {
    params ??= QueryParams(
      page: params?.page ?? 1,
      limit: 10,
    );

    try {
      var res = await _apiClient.get(
        ApiConfig.getAdvances(params: params),
        cancelToken: cancelToken,
      );

      if (res != null) {
        return AdvanceListModel(res.data);
      }

      throw const NullDataException();
    } on DioException catch (e) {
      var error = ExceptionModel.fromJson(e.response?.data);
      throw UnknownException(error.message);
    }
  }

  Future<Advance> getSingleAdvance({required String advanceId}) async {
    try {
      var res = await _apiClient.get(
        ApiConfig.getSingleAdvance(
          advanceId: advanceId,
        ),
      );

      if (res != null) {
        return AdvanceModel.fromJson(res.data);
      }

      throw const NullDataException();
    } on DioException catch (e) {
      var error = ExceptionModel.fromJson(e.response?.data);
      throw UnknownException(error.message);
    }
  }

  Future<PaginatedResponse<DeductionModel>> getDeductions({
    QueryParams? params,
    CancellationToken? cancelToken,
  }) async {
    params ??= QueryParams(
      page: params?.page ?? 1,
      limit: 10,
    );

    try {
      var res = await _apiClient.get(
        ApiConfig.getDeductions(params: params),
        cancelToken: cancelToken,
      );

      if (res != null) {
        return DeductionListModel(res.data);
      }

      throw const NullDataException();
    } on DioException catch (e) {
      var error = ExceptionModel.fromJson(e.response?.data);
      throw UnknownException(error.message);
    }
  }

  Future<Deduction> getSingleDeduction({required String deductionId}) async {
    try {
      var res = await _apiClient.get(
        ApiConfig.getSingleDeduction(
          deductionId: deductionId,
        ),
      );

      if (res != null) {
        return DeductionModel.fromJson(res.data);
      }

      throw const NullDataException();
    } on DioException catch (e) {
      var error = ExceptionModel.fromJson(e.response?.data);
      throw UnknownException(error.message);
    }
  }

  Future<PaginatedResponse<BonusModel>> getBonus({
    QueryParams? params,
    CancellationToken? cancelToken,
  }) async {
    params ??= QueryParams(
      page: params?.page ?? 1,
      limit: 10,
    );

    try {
      var res = await _apiClient.get(
        ApiConfig.getBonus(params: params),
        cancelToken: cancelToken,
      );

      if (res != null) {
        return BonusListModel(res.data);
      }

      throw const NullDataException();
    } on DioException catch (e) {
      var error = ExceptionModel.fromJson(e.response?.data);
      throw UnknownException(error.message);
    }
  }

  Future<Bonus> getSingleBonus({required String bonusId}) async {
    try {
      var res = await _apiClient.get(
        ApiConfig.getSingleBonus(
          bonusId: bonusId,
        ),
      );

      if (res != null) {
        return BonusModel.fromJson(res.data);
      }

      throw const NullDataException();
    } on DioException catch (e) {
      var error = ExceptionModel.fromJson(e.response?.data);
      throw UnknownException(error.message);
    }
  }

  Future<PaginatedResponse<PenaltyModal>> getPenalties({
    QueryParams? params,
    CancellationToken? cancelToken,
  }) async {
    params ??= QueryParams(
      page: params?.page ?? 1,
      limit: 10,
    );

    try {
      var res = await _apiClient.get(
        ApiConfig.getPenalty(params: params),
        cancelToken: cancelToken,
      );

      if (res != null) {
        return PenaltyListModel(res.data);
      }

      throw const NullDataException();
    } on DioException catch (e) {
      var error = ExceptionModel.fromJson(e.response?.data);
      throw UnknownException(error.message);
    }
  }

  Future<Penalty> getSinglePenalty({required String penaltyId}) async {
    try {
      var res = await _apiClient.get(
        ApiConfig.getSinglePenalty(
          penaltyId: penaltyId,
        ),
      );

      if (res != null) {
        return PenaltyModal.fromJson(res.data);
      }

      throw const NullDataException();
    } on DioException catch (e) {
      var error = ExceptionModel.fromJson(e.response?.data);
      throw UnknownException(error.message);
    }
  }

  Future<List<SalaryTypeModel>> getSalaryTypes(
      CancellationToken? cancelToken) async {
    try {
      var res = await _apiClient.get(
        ApiConfig.salaryTypes,
        cancelToken: cancelToken,
      );

      if (res != null) {
        return (res.data as List)
            .map((e) => SalaryTypeModel.fromJson(e))
            .toList(growable: false);
      }

      throw const NullDataException();
    } on DioException catch (e) {
      var error = ExceptionModel.fromJson(e.response?.data);
      throw UnknownException(error.message);
    }
  }

  Future<String> getPayslip(
    QueryParams? params,
    CancellationToken? cancelToken,
  ) async {
    try {
      var res = await _apiClient.get(
        ApiConfig.getPayslip(params: params!),
        cancelToken: cancelToken,
      );

      if (res != null) {
        return res.data["url"];
      }

      throw const NullDataException();
    } on DioException catch (e) {
      var error = ExceptionModel.fromJson(e.response?.data);

      if (error.message == "error.paySlipNotFound") {
        throw const NoPayslipException();
      }

      throw UnknownException(error.message);
    }
  }

  Future<UserDetailsModel> getUserDetails(
    CancellationToken? cancelToken,
  ) async {
    try {
      var res = await _apiClient.get(
        ApiConfig.userDetails,
        cancelToken: cancelToken,
      );

      if (res != null) {
        return UserDetailsModel.fromJson(res.data);
      }

      throw const NullDataException();
    } on DioException catch (e) {
      var error = ExceptionModel.fromJson(e.response?.data);

      if (error.message == "error.userNotFound") {
        throw const NoUserFoundException();
      }

      throw UnknownException(error.message);
    }
  }

  Future<String?> updateProfile(
    UserDetailsInput input,
    CancellationToken? cancelToken,
  ) async {
    try {
      var res = await _apiClient.patch(
        ApiConfig.updateProfile,
        cancelToken: cancelToken,
        body: input.toJson,
      );

      if (res != null) {
        return res.data["avatarS3Upload"]["url"];
      }

      throw const NullDataException();
    } on DioException catch (e) {
      var error = ExceptionModel.fromJson(e.response?.data);

      if (error.message == "error.userNotFound") {
        throw const NoUserFoundException();
      }

      throw UnknownException(error.message);
    }
  }
}
