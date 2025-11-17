import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../shared/widgets/padding.dart';
import '../../../translations/locale_keys.g.dart';
import '../button.dart';

class GenericEmptyPlaceholder extends StatelessWidget {
  final String text;
  final Future<void> Function()? onRefresh;
  const GenericEmptyPlaceholder({
    required this.text,
    this.onRefresh,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Text(
              text,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          if (onRefresh != null)
            Column(
              children: [
                const VerticalSpace(),
                Button(
                  label: LocaleKeys.refresh.tr(),
                  padding: EdgeInsets.symmetric(
                    vertical: 8.h,
                  ),
                  onPressed: onRefresh ?? () {},
                ),
              ],
            )
        ],
      ),
    );
  }
}
