import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/app_badge_widget.dart';
import '../../../../core/widgets/custom_app_bar_widget.dart';
import '../../../../core/widgets/custom_card_widget.dart';
import '../widgets/faq_item_widget.dart';
import '../widgets/help_topic_card_widget.dart';

class HelpAndSupportScreen extends StatelessWidget {
  const HelpAndSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: CustomAppBarWidget(
        title: 'settings.help_and_support.title'.tr(context: context),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'settings.help_and_support.need_help_prompt'.tr(context: context),
                style: AppTextStyles.font15Bold,
              ),
              hSpace(10),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 10.h,
                crossAxisSpacing: 10.w,
                childAspectRatio: 2.4,
                children: [
                  HelpTopicCardWidget(
                    title: 'settings.help_and_support.topic_booking'.tr(context: context),
                  ),
                  HelpTopicCardWidget(
                    title: 'settings.help_and_support.topic_deposit'.tr(context: context),
                  ),
                  HelpTopicCardWidget(
                    title: 'settings.help_and_support.topic_cancellation'.tr(context: context),
                  ),
                  HelpTopicCardWidget(
                    title: 'settings.help_and_support.topic_pitch_complaint'.tr(context: context),
                  ),
                  HelpTopicCardWidget(
                    title: 'settings.help_and_support.topic_team'.tr(context: context),
                  ),
                  HelpTopicCardWidget(
                    title: 'settings.help_and_support.topic_account'.tr(context: context),
                  ),
                ],
              ),
              hSpace(20),
              Text(
                'settings.help_and_support.faq_title'.tr(context: context),
                style: AppTextStyles.font15Bold,
              ),
              hSpace(10),
              CustomCardWidget(
                padding: EdgeInsets.zero,
                child: Column(
                  children: [
                    FaqItemWidget(
                      question: 'settings.help_and_support.faq1_q'.tr(context: context),
                      answer: 'settings.help_and_support.faq1_a'.tr(context: context),
                    ),
                    const Divider(height: 1, color: AppColors.border),
                    FaqItemWidget(
                      question: 'settings.help_and_support.faq2_q'.tr(context: context),
                      answer: 'settings.help_and_support.faq2_a'.tr(context: context),
                    ),
                    const Divider(height: 1, color: AppColors.border),
                    FaqItemWidget(
                      question: 'settings.help_and_support.faq3_q'.tr(context: context),
                      answer: 'settings.help_and_support.faq3_a'.tr(context: context),
                    ),
                  ],
                ),
              ),
              hSpace(20),
              Text(
                'settings.help_and_support.past_requests'.tr(context: context),
                style: AppTextStyles.font15Bold,
              ),
              hSpace(10),
              CustomCardWidget(
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'settings.help_and_support.sample_req_title'.tr(context: context),
                            style: AppTextStyles.font14Bold,
                          ),
                          hSpace(2),
                          Text(
                            'settings.help_and_support.sample_req_sub'.tr(context: context),
                            style: AppTextStyles.font11Regular,
                          ),
                        ],
                      ),
                    ),
                    AppBadgeWidget(
                      text: 'settings.help_and_support.resolved'.tr(context: context),
                      type: AppBadgeType.success,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
