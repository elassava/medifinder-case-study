import 'package:flutter/material.dart';

/// Shared corner radii — single source for rounded surfaces.
abstract final class AppShapes {
  static const double xxs = 4;
  static const double xs = 8;
  static const double sm = 12;
  static const double md = 16;
  static const double lg = 20;
  static const double xl = 24;
  static const double xxl = 28;

  static BorderRadius get radiusXxs => BorderRadius.circular(xxs);
  static BorderRadius get radiusXs => BorderRadius.circular(xs);
  static BorderRadius get radiusSm => BorderRadius.circular(sm);
  static BorderRadius get radiusMd => BorderRadius.circular(md);
  static BorderRadius get radiusLg => BorderRadius.circular(lg);
  static BorderRadius get radiusXl => BorderRadius.circular(xl);
  static BorderRadius get radiusXxl => BorderRadius.circular(xxl);

  static BorderRadius verticalTopXl = const BorderRadius.vertical(
    top: Radius.circular(xl),
  );
}
