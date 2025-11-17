import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/dto/option.dart';
import '../theme/app_colors.dart';
import 'padding.dart';

class PrimaryDropdown extends StatelessWidget {
  final String? value;
  final String hint;
  final List<Option> options;
  final void Function(String?)? onChanged;

  const PrimaryDropdown({
    required this.hint,
    this.value,
    required this.options,
    this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: hint.isNotEmpty,
          child: Column(
            children: [
              Text(
                hint,
                style: Theme.of(context).primaryTextTheme.displaySmall,
              ),
              const VerticalSpace(),
            ],
          ),
        ),
        DropdownButtonFormField<String>(
          value: value,
          hint: Text(
            hint,
            style: Theme.of(context).primaryTextTheme.displayMedium!.copyWith(
                  color: SECONDARY_TEXT_COLOR.withOpacity(0.6),
                  fontWeight: FontWeight.w500,
                ),
          ),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
              horizontal: 15.w,
              vertical: 18.h,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.r),
            ),
          ),
          icon: const Icon(
            Icons.keyboard_arrow_down,
          ),
          dropdownColor: Colors.white,
          items: options
              .map(
                (e) => DropdownMenuItem(
                  value: e.value,
                  child: Text(e.label),
                ),
              )
              .toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }
}
