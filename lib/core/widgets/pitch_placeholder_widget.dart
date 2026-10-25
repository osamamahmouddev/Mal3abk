import 'package:flutter/material.dart';

import '../styles/app_assets.dart';

class PitchPlaceholderWidget extends StatelessWidget {
  const PitchPlaceholderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(AppAssets.pitchPhoto, fit: BoxFit.cover);
  }
}
