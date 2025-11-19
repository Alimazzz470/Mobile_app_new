import 'package:flutter/material.dart';

import '../../../core/exceptions/exceptions.dart';
import '../../helpers/coded_exception_helper.dart';
import 'placeholder_content.dart';

class EmptyPlaceholder extends StatelessWidget {
  final String? imagePath;
  final CodedException error;
  final Future<void> Function()? onRefresh;

  EmptyPlaceholder(
    Object error, {
    this.imagePath,
    this.onRefresh,
    Key? key,
  })  : error = error is CodedException ? error : UnknownException(error.toString()),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: PlaceholderContent(
              message: error.getString(context),
              subtitle: error.message,
              image: imagePath,
              onRefresh: onRefresh,
            ),
          ),
        );
      },
    );
  }
}
