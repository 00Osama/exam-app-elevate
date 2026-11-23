import 'package:flutter/widgets.dart';

extension ViewWidthAndHeight on BuildContext {
  /// The width of the current view in logical pixels.
  double get viewWidth => MediaQuery.sizeOf(this).width;

  /// The height of the current view in logical pixels.
  double get viewHeight => MediaQuery.sizeOf(this).height;
}
