import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../helpers/app_assets.dart';
import '../theme/app_colors.dart';

class Loader extends StatelessWidget {
  final Widget child;
  final bool isLoading;
  final double? progress;
  final String message;

  const Loader({
    required this.child,
    required this.isLoading,
    this.progress,
    this.message = '',
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 10,
                sigmaY: 10,
              ),
              child: Container(
                color: PRIMARY_COLOR.withOpacity(0.2),
                child: progress != null
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (progress! > 0.0 && progress! < 1.0)
                            CircularProgressIndicator(
                              value: progress,
                            ),
                          if (message.isNotEmpty)
                            Text(
                              message,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16.0,
                              ),
                            ),
                          if (progress == 1.0)
                            const Icon(
                              Icons.done,
                              color: Colors.black,
                              size: 32.0,
                            ),
                        ],
                      )
                    : Center(
                        child: Lottie.asset(
                          LOADING_ANIMATION,
                          width: 250.w,
                        ),
                      ),
              ),
            ),
          )
      ],
    );
  }
}
