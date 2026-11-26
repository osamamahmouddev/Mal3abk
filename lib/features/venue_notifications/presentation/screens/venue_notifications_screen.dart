import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/alert_banner_widget.dart';
import '../../../../core/widgets/custom_app_bar_widget.dart';
import '../../../../core/widgets/custom_card_widget.dart';
import '../../../../core/widgets/shimmer_list_skeleton_widget.dart';
import '../../../notifications/data/apis/notifications_api_service.dart';
import '../../../settings/presentation/cubit/notification_preferences_cubit.dart';
import '../../../settings/presentation/widgets/notification_preferences_bloc_builder.dart';
import '../../../venue_shell/presentation/venue_format.dart';
import '../cubit/venue_notifications_cubit.dart';

/// The venue's notifications and the user's notification preferences. A tap
/// pops with where the notification leads (see
/// [VenueNotificationsCubit.targetOf]).
class VenueNotificationsScreen extends StatelessWidget {
  const VenueNotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String t(String key) => 'venue.notifications.$key'.tr(context: context);
    return MultiBlocProvider(
      providers: [
        BlocProvider<VenueNotificationsCubit>(
          create: (_) => VenueNotificationsCubit(
            notificationsApiService: sl<NotificationsApiService>(),
          )..load(),
        ),
        BlocProvider<NotificationPreferencesCubit>(
          create: (_) => sl<NotificationPreferencesCubit>()..load(),
        ),
      ],
      child: Builder(
        builder: (context) {
          final cubit = context.read<VenueNotificationsCubit>();
          return Scaffold(
            backgroundColor: AppColors.pageBackground,
            appBar: CustomAppBarWidget(
              title: t('title'),
              actions: [
                BlocBuilder<VenueNotificationsCubit, VenueNotificationsState>(
                  buildWhen: (a, b) => a.unreadCount != b.unreadCount,
                  builder: (context, state) => TextButton(
                    onPressed: state.unreadCount == 0
                        ? null
                        : cubit.markAllRead,
                    child: Text(t('mark_all')),
                  ),
                ),
              ],
            ),
            body: BlocBuilder<VenueNotificationsCubit, VenueNotificationsState>(
              builder: (context, state) {
                if (state.loading) {
                  return const ShimmerListSkeletonWidget(itemHeight: 76);
                }
                return NotificationListener<ScrollNotification>(
                  onNotification: (n) {
                    if (n.metrics.extentAfter < 300) cubit.loadMore();
                    return false;
                  },
                  child: RefreshIndicator(
                    onRefresh: cubit.load,
                    child: ListView(
                      padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 32.h),
                      children: [
                        if (state.error case final e?)
                          AlertBannerWidget(
                            type: AlertBannerType.error,
                            message: e.tr(context: context),
                            actionText: 'common.retry'.tr(context: context),
                            onActionTap: cubit.load,
                          ),
                        if (state.items.isEmpty && state.error == null)
                          Padding(
                            padding: EdgeInsets.all(24.r),
                            child: Text(
                              t('empty'),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        for (final n in state.items) ...[
                          CustomCardWidget(
                            padding: EdgeInsets.all(12.r),
                            borderRadius: 14,
                            backgroundColor: n.isRead
                                ? AppColors.white
                                : AppColors.tableHead,
                            onTap: () async {
                              final navigator = Navigator.of(context);
                              await cubit.markRead(n);
                              final target = VenueNotificationsCubit.targetOf(
                                n.type,
                              );
                              if (target != null) navigator.pop(target);
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (!n.isRead)
                                  Padding(
                                    padding: EdgeInsets.only(top: 6.h),
                                    child: Container(
                                      width: 8.r,
                                      height: 8.r,
                                      decoration: const BoxDecoration(
                                        color: AppColors.brandRed,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ),
                                SizedBox(width: 8.w),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        n.title,
                                        style: AppTextStyles.font14Bold,
                                      ),
                                      hSpace(2),
                                      Text(
                                        n.body,
                                        style: AppTextStyles.font13Regular,
                                      ),
                                      hSpace(4),
                                      Text(
                                        VenueFormat.dateTime(
                                          context,
                                          n.createdAtUtc.toIso8601String(),
                                        ),
                                        style: AppTextStyles.font11Regular
                                            .copyWith(
                                              color: AppColors.textMuted,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          hSpace(8),
                        ],
                        if (state.loadingMore)
                          const Center(child: CircularProgressIndicator()),
                        hSpace(16),
                        Text(t('preferences'), style: AppTextStyles.font15Bold),
                        hSpace(8),
                        const NotificationPreferencesBlocBuilder(),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
