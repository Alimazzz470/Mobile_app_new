import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../core/exceptions/coded_exception.dart';
import '../../core/exceptions/exception_codes.dart';

extension CodedExceptionTranslation on CodedException {
  String getString(BuildContext context, {bool displayReason = false}) {
    switch (code) {
      case ExceptionCodes.noStoredToken:
      case ExceptionCodes.notRefreshedToken:
        return "";
      case ExceptionCodes.server:
        return "Server exception";
      case ExceptionCodes.network:
        return "No connectivity";
      case ExceptionCodes.receivedNullData:
        return "Received null data";
      case ExceptionCodes.unknown:
        var reason = displayReason ? (message ?? "") : "";
        return reason.isEmpty ? "Unknown exception" : reason.tr();
      case ExceptionCodes.requestCanceled:
        return "Request canceled";
      case ExceptionCodes.noPayslip:
        return "No payslip found";
      case ExceptionCodes.forbidden:
        return "Your account is not allowed to access this resource, please contact your administrator.";
      case ExceptionCodes.signatureUpload:
        return "Signature upload failed";
      case ExceptionCodes.noUserFound:
        return "No user found";
    }
  }
}
