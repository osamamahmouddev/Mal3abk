import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/local_storage/secure_storage.dart';
import '../../../../core/styles/app_assets.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_shadows.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/utils/cairo_time.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../explore/data/models/explore_filter_model.dart';
import '../../../main_shell/presentation/widgets/main_shell_scope_widget.dart';
import '../../data/models/play_time_model.dart';
import '../cubit/home_feed_cubit.dart';
import '../cubit/home_feed_state.dart';
import 'home_hero_pill_widget.dart';
import 'home_play_time_sheet_widget.dart';

/// "When do you want to play?": the player picks a day this week and a
/// kick-off hour, and the search opens Explore with venues free then.
///
/// Until the player picks, the card offers the hour they usually search for,
/// else the earliest free slot near them, else the next hour ahead.
class HomeHeroSearchCardWidget extends HookWidget {
  const HomeHeroSearchCardWidget({super.key});

  /// The kick-off hour of the player's last search.
  static const String usualHourKey = 'home_usual_play_hour';

  @override
  Widget build(BuildContext context) {
    final lang = context.locale.languageCode;
    final usualHour = useState<int?>(null);
    final picked = useState<PlayTimeModel?>(null);

    useEffect(() {
      SharedPrefHelper.getString(usualHourKey).then((value) {
        if (context.mounted) usualHour.value = int.tryParse(value);
      }, onError: (_) {});
      return null;
    }, const []);

    final freeSlotUtc = context.select<HomeFeedCubit, String?>(
      (cubit) => switch (cubit.state) {
        HomeFeedSuccess(:final located) => _earliest([
          for (final venue in located.feed.nearby.items)
            venue.nextAvailableStartUtc,
        ]),
        _ => null,
      },
    );

    final choice =
        picked.value ??
        PlayTimeModel.suggest(
          CairoTime.now(),
          usualHour: usualHour.value,
          freeSlotCairo: freeSlotUtc == null
              ? null
              : CairoTime.fromUtc(CairoTime.parseUtc(freeSlotUtc)),
        );
    final day = choice.dayFrom(CairoTime.today());

    Future<void> pickTime() async {
      final next = await HomePlayTimeSheetWidget.show(context, initial: choice);
      if (next != null) picked.value = next;
    }

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.brandNavy,
        borderRadius: BorderRadius.circular(22.r),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: SvgPicture.asset(
              AppAssets.homeHeroPattern,
              fit: BoxFit.fill,
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'home.play_prompt'.tr(context: context),
                  style: AppTextStyles.font18Bold.copyWith(
                    color: AppColors.white,
                  ),
                ),
                hSpace(18),
                Row(
                  children: [
                    Expanded(
                      child: HomeHeroPillWidget(
                        iconAsset: AppAssets.icCalendarWhite,
                        label: CairoTime.dayLabel(
                          day,
                          lang,
                          today: 'home.today'.tr(context: context),
                          tomorrow: 'home.tomorrow'.tr(context: context),
                        ),
                        onTap: pickTime,
                      ),
                    ),
                    vSpace(8),
                    Expanded(
                      child: HomeHeroPillWidget(
                        iconAsset: AppAssets.icClockWhite,
                        label: CairoTime.clockLabel(choice.hour, lang),
                        onTap: pickTime,
                      ),
                    ),
                  ],
                ),
                hSpace(12),
                CustomButton(
                  text: 'home.search_pitch'.tr(context: context),
                  icon: SvgPicture.asset(
                    AppAssets.icSearchWhite,
                    width: 18.r,
                    height: 18.r,
                  ),
                  height: 50.h,
                  borderRadius: 12,
                  boxShadow: AppShadows.redGlow,
                  textStyle: AppTextStyles.font16Bold.copyWith(
                    color: AppColors.white,
                  ),
                  onTap: () {
                    // The card may have been on screen for hours: an hour
                    // that has passed moves to the next one still ahead.
                    final now = CairoTime.now();
                    final current = choice.onDay(choice.dayOffset, now);
                    if (picked.value != null) picked.value = current;
                    // Next time the card starts from the hour played most
                    // recently.
                    usualHour.value = current.hour;
                    SharedPrefHelper.setData(
                      usualHourKey,
                      current.hour.toString(),
                    ).ignore();
                    MainShellScopeWidget.openExplore(
                      context,
                      ExploreFilterModel(
                        day: current.dayFrom(CairoTime.today()),
                        startHour: current.hour,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// The earliest of the venues' next free slots (ISO UTC strings).
  static String? _earliest(Iterable<String?> slots) {
    String? best;
    DateTime? bestAt;
    for (final slot in slots) {
      if (slot == null) continue;
      final at = DateTime.tryParse(slot);
      if (at == null) continue;
      if (bestAt == null || at.isBefore(bestAt)) {
        best = slot;
        bestAt = at;
      }
    }
    return best;
  }
}
