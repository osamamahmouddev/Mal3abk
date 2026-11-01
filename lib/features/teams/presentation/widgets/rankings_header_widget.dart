import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/widgets/app_on_dark_back_button_widget.dart';
import '../../../../core/styles/app_assets.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import 'rankings_podium_column_widget.dart';
import 'rankings_segment_widget.dart';

class RankingsHeaderWidget extends HookWidget {
  const RankingsHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final scope = useState(0);
    String t(String key) => 'teams.$key'.tr(context: context);
    String pts(String value) =>
        'teams.rankings.points'.tr(context: context, args: [value]);

    return Container(
      color: AppColors.brandNavy,
      child: Stack(
        children: [
          Positioned.fill(
            child: SvgPicture.asset(
              AppAssets.rankingsPattern,
              fit: BoxFit.fill,
            ),
          ),
          SafeArea(
            bottom: false,
            child: Padding(
              padding: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 0),
              child: Column(
                children: [
                  Row(
                    children: [
                      const AppOnDarkBackButtonWidget(),
                      Expanded(
                        child: Text(
                          t('rankings.title'),
                          textAlign: TextAlign.center,
                          style: AppTextStyles.font18Bold.copyWith(
                            color: AppColors.white,
                          ),
                        ),
                      ),
                      vSpace(44),
                    ],
                  ),
                  hSpace(14),
                  RankingsSegmentWidget(
                    labels: [t('rankings.area'), t('rankings.all_cairo')],
                    selectedIndex: scope.value,
                    onSelect: (index) => scope.value = index,
                  ),
                  hSpace(14),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: RankingsPodiumColumnWidget(
                          initials: t('sample.soqour_i'),
                          name: t('sample.soqour'),
                          rank: '٢',
                          points: pts('٣٦'),
                          blockHeight: 60,
                        ),
                      ),
                      vSpace(8),
                      Expanded(
                        child: RankingsPodiumColumnWidget(
                          initials: t('sample.shabab_i'),
                          name: t('sample.shabab'),
                          rank: '١',
                          points: pts('٣٨'),
                          blockHeight: 78,
                          isWinner: true,
                        ),
                      ),
                      vSpace(8),
                      Expanded(
                        child: RankingsPodiumColumnWidget(
                          initials: t('sample.osoud_i'),
                          name: t('sample.osoud'),
                          rank: '٣',
                          points: pts('٣٤'),
                          blockHeight: 48,
                        ),
                      ),
                    ],
                  ),
                  hSpace(18),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
