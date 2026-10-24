import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/network/dio_factory.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import '../widgets/home_header_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const HomeHeaderWidget(),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(20.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.stadium_outlined,
                    size: 80.r,
                    color: AppColors.brandPrimary,
                  ),
                  hSpace(16),
                  Text(
                    'home.fields'.tr(),
                    style: AppTextStyles.font20SemiBold,
                  ),
                  hSpace(32),
                  CustomButton(
                    text: 'auth.logout'.tr(),
                    backgroundColor: AppColors.error,
                    onTap: () async {
                      await DioFactory.clearToken();
                      if (context.mounted) {
                        context.pushNamedAndRemoveUntil(
                          AppRoutes.login,
                          (route) => false,
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
