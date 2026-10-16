import 'package:flutter/material.dart';

import '../theme/app_text_styles.dart';

/// Типовий каркас сторінки всередині [AppShell]:
/// прокрутка, адаптивні відступи, заголовок та кнопки дій.
class PageScaffold extends StatelessWidget {
  const PageScaffold({
    super.key,
    required this.title,
    required this.children,
    this.actions = const [],
    this.maxWidth = 1400,
    this.alignment = Alignment.topCenter,
  });

  final String title;
  final List<Widget> children;
  final List<Widget> actions;
  final double maxWidth;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final compact = constraints.maxWidth < 600;
        final padding = compact ? 16.0 : 32.0;

        return SingleChildScrollView(
          padding: EdgeInsets.all(padding),
          child: Align(
            alignment: alignment,
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: maxWidth),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Wrap(
                    alignment: WrapAlignment.spaceBetween,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 16,
                    runSpacing: 12,
                    children: [
                      Text(
                        title,
                        style: compact
                            ? AppTextStyles.pageTitle.copyWith(fontSize: 26)
                            : AppTextStyles.pageTitle,
                      ),
                      if (actions.isNotEmpty)
                        Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: actions,
                        ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  ...children,
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
