import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

bool get isIOS => defaultTargetPlatform == TargetPlatform.iOS;

bool get isAndroid => defaultTargetPlatform == TargetPlatform.android;

extension BuildContextExtension on BuildContext {
  ThemeData get theme => Theme.of(this);

  ColorScheme get colorScheme => theme.colorScheme;

  TextTheme get textTheme => theme.textTheme;

  MediaQueryData get mediaQuery => MediaQuery.of(this);

  double get deviceWidth => mediaQuery.size.width;

  double get deviceHeight => mediaQuery.size.height;

}
