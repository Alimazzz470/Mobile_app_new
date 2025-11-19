import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrimaryCard extends StatelessWidget {
  final double? width;
  final Widget child;
  final EdgeInsetsGeometry? padding;

  const PrimaryCard({
    this.width,
    required this.child,
    this.padding,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: padding ??
          EdgeInsets.symmetric(
            horizontal: 20.w,
            vertical: 24.h,
          ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5.r),
      ),
      child: child,
    );
  }
}
