import 'package:flutter/material.dart';

import '../styles/app_assets.dart';
import 'app_header_icon_button_widget.dart';

class AppBackButtonWidget extends StatelessWidget {
  const AppBackButtonWidget({super.key, this.onTap, this.isClose = false});

  final VoidCallback? onTap;

  /// Shows the close (X) glyph instead of the back arrow.
  final bool isClose;

  @override
  Widget build(BuildContext context) {
    return AppHeaderIconButtonWidget(
      iconAsset: isClose ? AppAssets.icClose : AppAssets.icArrowBack,
      iconSize: isClose ? 20 : 22,
      mirrorInLtr: !isClose,
      onTap: onTap ?? () => Navigator.of(context).maybePop(),
    );
  }
}
