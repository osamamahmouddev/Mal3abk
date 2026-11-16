import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../core/styles/app_colors.dart';

/// One gallery photo: pinch or double-tap to zoom, double-tap again to reset.
class ZoomablePhotoWidget extends HookWidget {
  const ZoomablePhotoWidget({
    required this.url,
    required this.onZoomChanged,
    super.key,
  });

  static const double _zoomedScale = 2.5;

  final String url;

  /// Reports whether the photo is zoomed, so the gallery can stop paging
  /// while the player pans around it.
  final ValueChanged<bool> onZoomChanged;

  @override
  Widget build(BuildContext context) {
    final controller = useTransformationController();
    final doubleTapAt = useRef(Offset.zero);

    void reportZoom() =>
        onZoomChanged(controller.value.getMaxScaleOnAxis() > 1.01);

    void toggleZoom() {
      if (controller.value.getMaxScaleOnAxis() > 1.01) {
        controller.value = Matrix4.identity();
      } else {
        final point = doubleTapAt.value;
        controller.value = Matrix4.identity()
          ..translateByDouble(
            -point.dx * (_zoomedScale - 1),
            -point.dy * (_zoomedScale - 1),
            0,
            1,
          )
          ..scaleByDouble(_zoomedScale, _zoomedScale, 1, 1);
      }
      reportZoom();
    }

    return GestureDetector(
      onDoubleTapDown: (details) => doubleTapAt.value = details.localPosition,
      onDoubleTap: toggleZoom,
      child: InteractiveViewer(
        transformationController: controller,
        maxScale: 4,
        onInteractionEnd: (_) => reportZoom(),
        child: SizedBox.expand(
          child: CachedNetworkImage(
            imageUrl: url,
            fit: BoxFit.contain,
            memCacheWidth: 2048,
            placeholder: (_, _) => const Center(
              child: CircularProgressIndicator(color: AppColors.white),
            ),
            errorWidget: (_, _, _) => const Center(
              child: Icon(
                Icons.broken_image_outlined,
                color: AppColors.white60,
                size: 48,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
