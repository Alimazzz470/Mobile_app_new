import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../translations/locale_keys.g.dart';
import '../button.dart';
import '../padding.dart';

class PlaceholderContent extends StatelessWidget {
  final String message;
  final String? subtitle;
  final String? image;
  final Future<void> Function()? onRefresh;

  const PlaceholderContent({
    required this.message,
    this.subtitle,
    this.image,
    this.onRefresh,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 24.w,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (image != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Image.asset(
                  image!,
                  width: 0.6.sw,
                ),
              ),
            Text(
              message,
              style: Theme.of(context).primaryTextTheme.displaySmall!.copyWith(
                    color: Colors.grey,
                  ),
              textAlign: TextAlign.center,
            ),
            if (subtitle != null)
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text(
                  "Error code: $subtitle",
                  style: Theme.of(context).primaryTextTheme.displaySmall!.copyWith(
                        color: Colors.grey,
                      ),
                  textAlign: TextAlign.center,
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
              ),
          ],
        ),
      ),
    );
  }
}
