import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

/// Returns a responsive empty box with the given height.
///
/// In a vertical layout (Column, vertical ListView) it expands vertically.
/// In a horizontal layout (Row, horizontal ListView) it adapts horizontally,
/// ensuring that layout spacing is never collapsed to zero.
Widget hSpace(double height) => _AppSpacer(size: height, isHeight: true);

/// Returns a responsive empty box with the given width.
///
/// In a horizontal layout (Row, horizontal ListView) it expands horizontally.
/// In a vertical layout (Column, vertical ListView) it adapts vertically,
/// ensuring that layout spacing is never collapsed to zero.
Widget vSpace(double width) => _AppSpacer(size: width, isHeight: false);

/// Whether [widget] is one of the [hSpace] / [vSpace] gaps.
bool isAppSpacer(Widget widget) => widget is _AppSpacer;

class _AppSpacer extends LeafRenderObjectWidget {
  const _AppSpacer({required this.size, required this.isHeight});

  final double size;
  final bool isHeight;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderAppSpacer(size: size, isHeight: isHeight);
  }

  @override
  void updateRenderObject(BuildContext context, _RenderAppSpacer renderObject) {
    renderObject
      ..sizeValue = size
      ..isHeight = isHeight;
  }
}

class _RenderAppSpacer extends RenderBox {
  _RenderAppSpacer({required double size, required bool isHeight})
    : _sizeValue = size,
      _isHeight = isHeight;

  double _sizeValue;
  bool _isHeight;

  set sizeValue(double value) {
    if (_sizeValue == value) return;
    _sizeValue = value;
    markNeedsLayout();
  }

  set isHeight(bool value) {
    if (_isHeight == value) return;
    _isHeight = value;
    markNeedsLayout();
  }

  double get _effectiveHeight => _sizeValue.h;
  double get _effectiveWidth => _sizeValue.w;

  @override
  double computeMinIntrinsicWidth(double height) => _effectiveWidth;

  @override
  double computeMaxIntrinsicWidth(double height) => _effectiveWidth;

  @override
  double computeMinIntrinsicHeight(double width) => _effectiveHeight;

  @override
  double computeMaxIntrinsicHeight(double width) => _effectiveHeight;

  @override
  void performLayout() {
    final parentNode = parent;
    if (parentNode is RenderFlex) {
      if (parentNode.direction == Axis.vertical) {
        size = constraints.constrain(Size(0, _effectiveHeight));
      } else {
        size = constraints.constrain(Size(_effectiveWidth, 0));
      }
    } else {
      if (constraints.hasBoundedWidth && !constraints.hasBoundedHeight) {
        size = constraints.constrain(Size(0, _effectiveHeight));
      } else if (constraints.hasBoundedHeight && !constraints.hasBoundedWidth) {
        size = constraints.constrain(Size(_effectiveWidth, 0));
      } else if (_isHeight) {
        size = constraints.constrain(Size(0, _effectiveHeight));
      } else {
        size = constraints.constrain(Size(_effectiveWidth, 0));
      }
    }
  }
}
