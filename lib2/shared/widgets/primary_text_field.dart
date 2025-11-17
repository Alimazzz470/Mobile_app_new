import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../helpers/app_assets.dart';
import '../theme/app_colors.dart';
import 'padding.dart';
import 'svg_widget.dart';

enum SuffixIcon { PASSWORD }

class PrimaryTextField extends StatefulWidget {
  final String? label;
  final TextEditingController? controller;
  final String? hintText;
  final TextInputType? keyboardType;
  final bool obscureText;
  final SuffixIcon? suffixIcon;
  final Widget? prefixIcon;
  final TextCapitalization textCapitalization;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final VoidCallback? onTap;
  final bool readOnly;
  final int? maxLines;

  const PrimaryTextField({
    this.label,
    this.controller,
    this.hintText,
    this.keyboardType,
    this.obscureText = false,
    this.suffixIcon,
    this.prefixIcon,
    this.textCapitalization = TextCapitalization.none,
    this.validator,
    this.onChanged,
    this.onTap,
    this.readOnly = false,
    this.maxLines = 1,
    super.key,
  });

  @override
  State<PrimaryTextField> createState() => _PrimaryTextFieldState();
}

class _PrimaryTextFieldState extends State<PrimaryTextField> {
  late bool obscureText = false;

  @override
  void initState() {
    super.initState();
    obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: widget.label != null && widget.label != '',
          child: Column(
            children: [
              Text(
                widget.label ?? '',
                style: Theme.of(context).primaryTextTheme.displaySmall,
              ),
              VerticalSpace(
                space: widget.label != '' ? 10.0 : 0.0,
              ),
            ],
          ),
        ),
        TextFormField(
          controller: widget.controller,
          cursorRadius: Radius.circular(3.r),
          textCapitalization: widget.textCapitalization,
          obscureText: obscureText,
          onTap: widget.onTap,
          readOnly: widget.readOnly,
          maxLines: widget.maxLines,
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
              horizontal: 15.w,
              vertical: 18.w,
            ),
            hintText: widget.hintText ?? widget.label,
            hintStyle: Theme.of(context).primaryTextTheme.displayMedium!.copyWith(
                  color: SECONDARY_TEXT_COLOR.withOpacity(0.6),
                  fontWeight: FontWeight.w500,
                ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(3.r),
              borderSide: const BorderSide(
                color: SECONDARY_TEXT_COLOR,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(3.r),
              borderSide: const BorderSide(
                color: SECONDARY_TEXT_COLOR,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(3.r),
              borderSide: const BorderSide(
                color: SECONDARY_TEXT_COLOR,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(3.r),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.error,
              ),
            ),
            prefixIcon: widget.prefixIcon,
            suffixIcon: suffixIconWidget,
          ),
          validator: widget.validator,
          onChanged: widget.onChanged,
        ),
      ],
    );
  }

  Widget? get suffixIconWidget {
    switch (widget.suffixIcon) {
      case SuffixIcon.PASSWORD:
        return IconButton(
          onPressed: () {
            setState(() {
              obscureText = !obscureText;
            });
          },
          icon: SvgWidget(
            imagePath: obscureText ? SHOW_PASSWORD_ICON : HIDE_PASSWORD_ICON,
          ),
        );
      default:
        return null;
    }
  }
}
