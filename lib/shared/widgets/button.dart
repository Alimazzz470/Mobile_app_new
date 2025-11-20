import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/app_colors.dart';

class Button extends StatelessWidget {
  final Widget? leadingIcon;
  final String label;
  final bool isSecondary;
  final bool isDisabled;
  final double? width;
  final EdgeInsets? padding;
  final TextStyle? textStyle;
  final VoidCallback onPressed;

  const Button({
    this.leadingIcon,
    required this.label,
    this.isSecondary = false,
    this.isDisabled = false,
    this.width,
    this.padding,
    this.textStyle,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      child: ElevatedButton(
        onPressed: isDisabled ? null : onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(3.r),
            side: isSecondary
                ? BorderSide(
                    color: isDisabled ? Colors.grey : PRIMARY_COLOR,
                    width: 1.w,
                  )
                : BorderSide.none,
          ),
          elevation: 0.0,
          shadowColor: Colors.transparent,
          backgroundColor: isSecondary ? Colors.transparent : PRIMARY_COLOR,
          foregroundColor: isSecondary ? Colors.black : Colors.white,
          padding:
              padding ?? EdgeInsets.symmetric(vertical: 18.w, horizontal: 5.w),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          overflow: TextOverflow.clip,
          style: textStyle ??
              Theme.of(context).primaryTextTheme.displayMedium!.copyWith(
                    color: isSecondary
                        ? Theme.of(context).primaryColor
                        : Colors.white,
                  ),
        ),
      ),
    );
  }
}
