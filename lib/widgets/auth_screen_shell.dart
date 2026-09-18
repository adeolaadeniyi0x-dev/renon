import 'package:flutter/material.dart';

import '../theme/renon_spacing.dart';

class AuthScreenShell extends StatelessWidget {
  const AuthScreenShell({
    super.key,
    required this.title,
    required this.subtitle,
    required this.child,
    this.actions,
  });

  final String title;
  final String subtitle;
  final Widget child;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: actions),
      body: SafeArea(
        top: false,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: EdgeInsets.fromLTRB(
                RenonSpacing.lg,
                RenonSpacing.md,
                RenonSpacing.lg,
                MediaQuery.viewInsetsOf(context).bottom + RenonSpacing.lg,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: RenonSpacing.xs),
                    Text(subtitle),
                    const SizedBox(height: RenonSpacing.xl),
                    child,
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
