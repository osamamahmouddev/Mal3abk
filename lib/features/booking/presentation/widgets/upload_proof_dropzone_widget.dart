import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/animations/app_animations.dart';
import '../../../../core/styles/app_colors.dart';
import 'upload_proof_empty_dropzone_widget.dart';
import 'upload_proof_ready_receipt_widget.dart';

/// Where the receipt photo is chosen. Empty it invites a photo; once a photo is chosen it turns green and shows
/// that photo with a check mark, so it is obvious the receipt is attached and ready.
class UploadProofDropzoneWidget extends StatelessWidget {
  const UploadProofDropzoneWidget({
    required this.fileBytes,
    required this.onTap,
    super.key,
  });

  final Uint8List? fileBytes;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(16.r);
    final bytes = fileBytes;
    final hasFile = bytes != null;

    return AnimatedContainer(
      duration: AppAnimations.duration(context, AppAnimations.base),
      curve: AppAnimations.standard,
      decoration: BoxDecoration(
        color: hasFile ? AppColors.successLight : AppColors.white,
        borderRadius: radius,
        border: Border.all(
          color: hasFile ? AppColors.successGreen : AppColors.checkboxBorder,
          width: 2,
        ),
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: onTap,
          borderRadius: radius,
          child: AnimatedSize(
            duration: AppAnimations.duration(context, AppAnimations.slow),
            curve: AppAnimations.standard,
            alignment: Alignment.topCenter,
            child: AnimatedSwitcher(
              duration: AppAnimations.duration(context, AppAnimations.slow),
              switchInCurve: AppAnimations.standard,
              switchOutCurve: AppAnimations.exit,
              child: hasFile
                  ? UploadProofReadyReceiptWidget(
                      key: const ValueKey('ready'),
                      bytes: bytes,
                    )
                  : const UploadProofEmptyDropzoneWidget(
                      key: ValueKey('empty'),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
