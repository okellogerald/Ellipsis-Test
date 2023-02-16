import 'package:flutter/material.dart';

import 'colors.dart';

final theme = ThemeData(
  colorScheme: _colorScheme,
  fontFamily: "Euclid",
);
final _colorScheme = ColorScheme.light(
  primary: AppColors.primary,
  onPrimary: AppColors.onPrimary,
  secondary: AppColors.secondary,
  onSecondary: AppColors.onSecondary,
  primaryContainer: AppColors.primaryContainer,
  onPrimaryContainer: AppColors.onPrimaryContainer,
  error: AppColors.primary,
  onError: AppColors.onPrimary,
  background: AppColors.background,
  onBackground: Colors.black,
  surface: Colors.white,
  onSurface: Colors.black,
  surfaceTint: Colors.black87,
);

extension TextStyleExtension on TextStyle? {
  TextStyle get withPrimaryColor => this!.copyWith(color: AppColors.primary);
  TextStyle get withSecondaryColor =>
      this!.copyWith(color: AppColors.secondary);

  TextStyle get withOnPrimaryColor =>
      this!.copyWith(color: AppColors.onPrimary);
}
