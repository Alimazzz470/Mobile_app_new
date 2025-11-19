import 'package:flutter/material.dart';

class NoDataPlaceholder extends StatelessWidget {
  final String text;

  const NoDataPlaceholder({
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight,
            ),
            child: Center(
              child: Text(
                text,
                style: Theme.of(context).primaryTextTheme.displaySmall!.copyWith(
                      color: Colors.grey,
                    ),
              ),
            ),
          ),
        );
      },
    );
  }
}
