import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/routes/deep_link_resolver.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/utils/relative_time.dart';
import '../../../../core/widgets/custom_state_widget.dart';
import '../../../../core/widgets/shimmer_list_skeleton_widget.dart';
import '../../data/models/notification_model.dart';
import '../cubit/notifications_cubit.dart';
import '../cubit/notifications_state.dart';
import 'notification_category_icon.dart';
import 'notification_item_card_widget.dart';

class NotificationsBlocBuilder extends StatelessWidget {
  const NotificationsBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<NotificationsCubit>();
    final lang = context.locale.languageCode;

    void open(NotificationModel notification) {
      HapticFeedback.selectionClick();
      cubit.markRead(notification.id);
      final target = DeepLinkResolver.resolve(notification.deepLink);
      Navigator.of(context).pushNamed(
        target?.route ?? AppRoutes.notificationDetail,
        arguments: target == null ? notification : target.arguments,
      );
    }

    return BlocBuilder<NotificationsCubit, NotificationsState>(
      builder: (context, state) {
        return switch (state) {
          NotificationsSuccess(:final items) when items.isEmpty =>
            CustomStateWidget(
              icon: const Icon(Icons.notifications_none_rounded, size: 48),
              title: 'notifications.empty_title'.tr(context: context),
              description: 'notifications.empty_desc'.tr(context: context),
            ),
          NotificationsSuccess(:final items, :final hasMore) =>
            RefreshIndicator.adaptive(
              onRefresh: cubit.load,
              child: NotificationListener<ScrollNotification>(
                onNotification: (scroll) {
                  if (hasMore && scroll.metrics.extentAfter < 300) {
                    cubit.loadMore();
                  }
                  return false;
                },
                child: ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(
                    parent: BouncingScrollPhysics(),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 12.h,
                  ),
                  itemCount: items.length + (hasMore ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == items.length) {
                      return const ShimmerListSkeletonWidget(
                        itemHeight: 72,
                        itemCount: 1,
                        padding: EdgeInsets.zero,
                      );
                    }
                    final notification = items[index];
                    final (icon, color) = NotificationCategoryIcon.of(
                      notification.category,
                    );
                    return NotificationItemCardWidget(
                      icon: icon,
                      iconColor: color,
                      title: notification.title,
                      time:
                          '${RelativeTime.since(notification.createdAtUtc, lang)} · ${notification.body}',
                      isUnread: !notification.isRead,
                      onTap: () => open(notification),
                    );
                  },
                ),
              ),
            ),
          NotificationsError(:final message) => CustomStateWidget(
            title: message.tr(context: context),
            description: '',
            actionText: 'common.retry'.tr(context: context),
            onActionTap: cubit.load,
          ),
          _ => const ShimmerListSkeletonWidget(itemHeight: 72, itemCount: 6),
        };
      },
    );
  }
}
