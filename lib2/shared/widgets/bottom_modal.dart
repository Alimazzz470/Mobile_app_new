import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<void> showBottomModal({
  required BuildContext context,
  required Widget child,
  double? height,
  bool isDismissible = true,
  bool isDraggable = true,
  VoidCallback? initCode,
}) {
  final completer = Completer<void>();

  WidgetsBinding.instance.addPostFrameCallback((_) => initCode?.call());

  showModalBottomSheet(
    context: context,
    useRootNavigator: true,
    enableDrag: isDraggable,
    useSafeArea: true,
    isDismissible: isDismissible,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10.r),
        topRight: Radius.circular(10.r),
      ),
    ),
    backgroundColor: Colors.white,
    isScrollControlled: true,
    builder: (context) {
      return WillPopScope(
        onWillPop: () async {
          return isDismissible;
        },
        child: SizedBox(
          height: height ?? 0.75.sh,
          width: ScreenUtil().screenWidth,
          child: child,
        ),
      );
    },
  ).then((_) => completer.complete());

  return completer.future;
}
