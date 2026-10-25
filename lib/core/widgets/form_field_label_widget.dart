import 'package:flutter/material.dart';

import '../styles/app_colors.dart';
import '../styles/app_text_styles.dart';

class FormFieldLabelWidget extends StatelessWidget {
  const FormFieldLabelWidget({
    required this.label,
    super.key,
    this.isRequired = false,
    this.hint,
  });

  final String label;
  final bool isRequired;
  final String? hint;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        style: AppTextStyles.font14SemiBold,
        children: [
          TextSpan(text: label),
          if (isRequired)
            const TextSpan(
              text: '*',
              style: TextStyle(color: AppColors.redText),
            ),
          if (hint != null)
            TextSpan(
              text: ' $hint',
              style: AppTextStyles.font14Regular,
            ),
        ],
      ),
    );
  }
}
