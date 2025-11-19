import '../core/dto/query_params.dart';

const String BASE_URL = 'https://spartrans1.site/api';
const String DEV_BASE_URL = 'http://localhost:4000/api';
const String ANDROID_BASE_URL = 'http://10.0.2.2:4000/api';
const String SOCKET_URL = 'https://spartrans1.site';

class ApiConfig {
  static const String login = "/auth/login";

  static const String refreshToken = "auth/refresh";

  static const String logout = "/auth/logout";

  static const String me = "/auth/me";

  static const String createLeave = "/leaves";

  static const String getLeaveTypes = "/leaves/available-leaves";

  static String getLeaves({
    required QueryParams params,
  }) {
    return createUrl(
      path: '/leaves',
      queryParameters: params.toMap(),
    );
  }

  static const String getTimeTrackingStatus = "/timeTrackings/status";

  static const String startTimeTracking = "/timeTrackings/start-time-tracking";

  static const String endTimeTracking = "/timeTrackings/end-time-tracking";

  static const String startBreak = "/timeTrackings/break-start";

  static const String endBreak = "/timeTrackings/break-end";

  static String timeTrackingSignature(String id) =>
      "/timeTrackings/time-tracking-signature/$id";

  static String getNotifications({
    required QueryParams params,
  }) {
    return createUrl(
      path: '/notifications',
      queryParameters: params.toMap(),
    );
  }

  static String markAllAsRead({required DateTime dateTime}) =>
      "/notifications/mark-all-as-read/${dateTime.toIso8601String()}";

  static String markAsRead({required String id}) =>
      "/notifications/mark-as-read/$id";

  static String getTodoTasks({
    required QueryParams params,
  }) {
    return createUrl(
      path: '/todotask/my-tasks',
      queryParameters: params.toMap(),
    );
  }

  static String getSingleTask({
    required String taskId,
  }) =>
      "/todotask/$taskId";

  static String changeTaskStatus({
    required String taskId,
  }) =>
      "/todotask/my-task/$taskId";

  static String getDriverLogs({
    required QueryParams params,
  }) {
    return createUrl(
      path: '/timeTrackings/for-user',
      queryParameters: params.toMap(),
    );
  }

  static String downloadLogs({
    required QueryParams params,
  }) {
    return createUrl(
      path: '/timeTrackings/pdf',
      queryParameters: params.toMap(),
    );
  }

  static String getVehicles({
    required QueryParams params,
  }) {
    return createUrl(
      path: '/vehicles',
      queryParameters: params.toMap(),
    );
  }

  static const String getVehicleTypes = "/vehicles/vehicle-types";

  static const String vehicleAssigned = "/vehicles/user-has-vehicle-for-user";

  static String requestVehicle(String vehicleId) {
    return "/vehicles/assign-for-user/$vehicleId";
  }

  static String returnVehicle(String vehicleId) {
    return "/vehicles/return-for-user/$vehicleId";
  }

  static String monthlyInspection(String inspectionId) {
    return "/vehicles/vehicle-inspection-update/$inspectionId";
  }

  static String imageUploadLinks(int count, String type, String? fileNames) =>
      "/images/link?count=$count&uploadType=$type${fileNames != null ? '&fileNames=$fileNames' : ''}";

  static String get getChats => "/chat/chats?takeAll=true";

  static String getChatDetails({
    required String chatId,
  }) =>
      "/chat/chats/$chatId";

  static String get unReadCount => "/chat/unread-chat-count";

  static String getChatMessages({
    required String chatId,
    required QueryParams params,
  }) {
    return createUrl(
      path: '/chat/all-messages/$chatId',
      queryParameters: params.toMap(),
    );
  }

  static String get getUsers => "/chat/all-users";

  static String get createChat => "/chat/create-chat-with-admin";

  static String get requestAdvance =>
      "/salary-manager/advance/request/for-user";

  static String getAdvances({
    required QueryParams params,
  }) {
    return createUrl(
      path: '/salary-manager/advance/request/for-user',
      queryParameters: params.toMap(),
    );
  }

  static String getSingleAdvance({
    required String advanceId,
  }) =>
      "/salary-manager/advance/for-user/$advanceId";

  static String getDeductions({
    required QueryParams params,
  }) {
    return createUrl(
      path: '/salary-manager/deduction/for-user',
      queryParameters: params.toMap(),
    );
  }

  static String getSingleDeduction({
    required String deductionId,
  }) =>
      "/salary-manager/deduction/for-user/$deductionId";

  static String getPenalty({
    required QueryParams params,
  }) {
    return createUrl(
      path: '/salary-manager/penalty/for-user',
      queryParameters: params.toMap(),
    );
  }

  static String getSinglePenalty({
    required String penaltyId,
  }) =>
      "/salary-manager/penalty/for-user/$penaltyId";

  static String getBonus({
    required QueryParams params,
  }) {
    return createUrl(
      path: '/salary-manager/bonus/for-user',
      queryParameters: params.toMap(),
    );
  }

  static String getSingleBonus({
    required String bonusId,
  }) =>
      "/salary-manager/bonus/for-user/$bonusId";

  static String get salaryTypes => "/salary-manager/details";

  static String getPayslip({
    required QueryParams params,
  }) {
    return createUrl(
      path: '/paySlips/pay-slip',
      queryParameters: params.toMap(),
    );
  }

  static String get inspectionAvailability => "/vehicles/user-has-inspection";

  static String get userDetails => "/users/me/get-user-details";

  static String get updateProfile => "/users/me/update-user-details";

  static String get updateFcmToken => "/users/updateFcmToken";
}

String createUrl({
  required String path,
  Map<String, dynamic>? queryParameters,
}) {
  queryParameters?.removeWhere((key, value) => value == null);

  final uri = Uri(
    path: path,
    queryParameters: queryParameters,
  );
  return uri.toString();
}
