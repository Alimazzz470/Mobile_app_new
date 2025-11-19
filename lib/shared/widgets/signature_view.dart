import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:signature/signature.dart';

import '../../translations/locale_keys.g.dart';
import '../theme/app_colors.dart';
import 'button.dart';
import 'padding.dart';

class SignatureView extends StatelessWidget {
  final Function(Uint8List?) onSigned;

  const SignatureView({
    required this.onSigned,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 30.h,
        horizontal: 24.w,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocaleKeys.signature_required.tr(),
            style: Theme.of(context).primaryTextTheme.displayMedium,
          ),
          const VerticalSpace(),
          Text(
            LocaleKeys.signature_required_description.tr(),
            style: Theme.of(context).primaryTextTheme.displaySmall!.copyWith(
                  color: SECONDARY_TEXT_COLOR,
                ),
          ),
          const VerticalSpace(space: 40),
          _SignatureBody(
            onSigned: onSigned,
          ),
        ],
      ),
    );
  }
}

class _SignatureBody extends StatefulWidget {
  final Function(Uint8List?) onSigned;
  const _SignatureBody({
    required this.onSigned,
    Key? key,
  }) : super(key: key);

  @override
  State<_SignatureBody> createState() => _SignatureBodyState();
}

class _SignatureBodyState extends State<_SignatureBody> {
  late final SignatureController _controller;

  @override
  void initState() {
    super.initState();

    _controller = SignatureController(
      penStrokeWidth: 5,
      penColor: Colors.black,
      exportBackgroundColor: Colors.white,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Signature(
          controller: _controller,
          width: double.infinity,
          height: 400.w,
          backgroundColor: Colors.white,
        ),
        const VerticalSpace(space: 40),
        Button(
          label: LocaleKeys.clear.tr(),
          isSecondary: true,
          onPressed: () {
            _controller.clear();
          },
        ),
        const VerticalSpace(),
        Button(
          label: LocaleKeys.confirm.tr(),
          onPressed: () async {
            final Uint8List? data = await _controller.toPngBytes();
            if (data == null) {
              return;
            }

            widget.onSigned(data);
          },
        ),
      ],
    );
  }
}
