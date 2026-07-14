import 'package:flutter/material.dart';

/// Below this width the app switches to a narrower, single-column
/// layout better suited to phones.
const double kMobileBreakpoint = 600;

/// The content column never grows wider than this, so the app stays
/// readable on very large / high-resolution screens.
const double kMaxContentWidth = 900;

bool isMobileLayout(BuildContext context) =>
    MediaQuery.of(context).size.width < kMobileBreakpoint;

/// Centers [child] and clamps its width to [kMaxContentWidth].
class MaxWidthCenter extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;

  const MaxWidthCenter({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(24),
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: kMaxContentWidth),
        child: Padding(padding: padding, child: child),
      ),
    );
  }
}
