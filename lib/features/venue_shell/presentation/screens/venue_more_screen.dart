import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/custom_card_widget.dart';
import '../../../auth/presentation/cubit/logout_cubit.dart';
import '../../../auth/presentation/cubit/logout_state.dart';
import '../../../settings/presentation/widgets/settings_action_tile_widget.dart';
import '../../../venue_account/presentation/screens/venue_settings_screen.dart';
import '../../../venue_customers/presentation/screens/venue_customers_screen.dart';
import '../../../venue_notifications/presentation/screens/venue_notifications_screen.dart';
import '../../../venue_pitches/presentation/screens/venue_pitches_screen.dart';
import '../../../venue_policies/presentation/screens/venue_policies_screen.dart';
import '../../../venue_pricing/presentation/screens/venue_pricing_screen.dart';
import '../../../venue_reports/presentation/screens/venue_payouts_screen.dart';
import '../../../venue_reports/presentation/screens/venue_reports_screen.dart';
import '../../../venue_schedule/presentation/screens/venue_schedule_screen.dart';
import '../../../venue_staff/presentation/screens/venue_staff_screen.dart';
import '../../data/models/my_permissions_model.dart';
import '../cubit/venue_session_cubit.dart';
import '../cubit/venue_session_state.dart';
import '../venue_page_route.dart';
import '../widgets/venue_top_bar_widget.dart';

/// One dashboard section in the "More" tab. [permission] hides it from roles
/// that can't open it (the API checks every request anyway).
class VenueMoreItem {
  const VenueMoreItem({
    required this.key,
    required this.icon,
    required this.builder,
    this.permission,
  });

  final String key;
  final IconData icon;
  final WidgetBuilder builder;
  final String? permission;
}

/// The dashboard sections that are not bottom tabs, like the web sidebar.
class VenueMoreScreen extends StatelessWidget {
  const VenueMoreScreen({required this.onOpenTab, super.key});

  /// Opens a bottom tab (where a notification about a booking leads).
  final ValueChanged<int> onOpenTab;

  static final List<VenueMoreItem> items = [
    VenueMoreItem(
      key: 'pitches',
      icon: Icons.stadium_outlined,
      builder: (_) => const VenuePitchesScreen(),
    ),
    VenueMoreItem(
      key: 'schedule',
      icon: Icons.schedule_rounded,
      builder: (_) => const VenueScheduleScreen(),
    ),
    VenueMoreItem(
      key: 'pricing',
      icon: Icons.sell_outlined,
      permission: VenuePermissions.venueView,
      builder: (_) => const VenuePricingScreen(),
    ),
    VenueMoreItem(
      key: 'policies',
      icon: Icons.policy_outlined,
      builder: (_) => const VenuePoliciesScreen(),
    ),
    VenueMoreItem(
      key: 'customers',
      icon: Icons.groups_outlined,
      permission: VenuePermissions.customersView,
      builder: (_) => const VenueCustomersScreen(),
    ),
    VenueMoreItem(
      key: 'reports',
      icon: Icons.bar_chart_rounded,
      permission: VenuePermissions.reportsView,
      builder: (_) => const VenueReportsScreen(),
    ),
    VenueMoreItem(
      key: 'payouts',
      icon: Icons.payments_outlined,
      permission: VenuePermissions.reportsView,
      builder: (_) => const VenuePayoutsScreen(),
    ),
    VenueMoreItem(
      key: 'notifications',
      icon: Icons.notifications_none_rounded,
      builder: (_) => const VenueNotificationsScreen(),
    ),
    VenueMoreItem(
      key: 'staff',
      icon: Icons.manage_accounts_outlined,
      permission: VenuePermissions.staffManage,
      builder: (_) => const VenueStaffScreen(),
    ),
    VenueMoreItem(
      key: 'settings',
      icon: Icons.settings_outlined,
      builder: (_) => const VenueSettingsScreen(),
    ),
  ];

  /// Follows a notification to the screen that handles it.
  Future<void> _openTarget(
    BuildContext context,
    VenueSessionReady state,
    String target,
  ) async {
    switch (target) {
      case 'bookings':
        onOpenTab(2);
      case 'overview':
        onOpenTab(0);
      case 'setup':
        final cubit = context.read<VenueSessionCubit>();
        await context.pushNamed<String>(
          AppRoutes.venueSetup,
          arguments: state.venue,
        );
        await cubit.load();
      default:
        final item = items.where((i) => i.key == target).firstOrNull;
        if (item == null) return;
        await openVenuePage<void>(
          context,
          name: '/venue/${item.key}',
          builder: item.builder,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    String t(String key) => 'venue.more.$key'.tr(context: context);
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: VenueTopBarWidget(title: 'venue.nav.more'.tr(context: context)),
      body: BlocBuilder<VenueSessionCubit, VenueSessionState>(
        builder: (context, state) {
          if (state is! VenueSessionReady) return const SizedBox.shrink();
          final visible = [
            for (final item in items)
              if (item.permission == null || state.can(item.permission!)) item,
          ];
          return ListView(
            padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 120.h),
            children: [
              CustomCardWidget(
                padding: EdgeInsets.zero,
                child: Column(
                  children: [
                    for (final (i, item) in visible.indexed) ...[
                      if (i > 0) const Divider(height: 1),
                      SettingsActionTileWidget(
                        icon: item.icon,
                        title: t(item.key),
                        onTap: () async {
                          final target = await openVenuePage<Object?>(
                            context,
                            name: '/venue/${item.key}',
                            builder: item.builder,
                          );
                          if (target is String && context.mounted) {
                            await _openTarget(context, state, target);
                          }
                        },
                      ),
                    ],
                  ],
                ),
              ),
              hSpace(16),
              CustomCardWidget(
                padding: EdgeInsets.zero,
                child: Column(
                  children: [
                    if (state.can(VenuePermissions.venueEdit)) ...[
                      SettingsActionTileWidget(
                        icon: Icons.storefront_rounded,
                        title: t('venue_setup'),
                        onTap: () async {
                          final cubit = context.read<VenueSessionCubit>();
                          await context.pushNamed<String>(
                            AppRoutes.venueSetup,
                            arguments: state.venue,
                          );
                          await cubit.load();
                        },
                      ),
                      const Divider(height: 1),
                    ],
                    SettingsActionTileWidget(
                      icon: Icons.add_business_rounded,
                      title: t('add_venue'),
                      onTap: () async {
                        final cubit = context.read<VenueSessionCubit>();
                        final venueId = await context.pushNamed<String>(
                          AppRoutes.venueSetup,
                        );
                        await cubit.load(preferVenueId: venueId);
                      },
                    ),
                  ],
                ),
              ),
              hSpace(20),
              Text(
                t('account'),
                style: AppTextStyles.font14Bold.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              hSpace(8),
              CustomCardWidget(
                padding: EdgeInsets.zero,
                child: BlocBuilder<LogoutCubit, LogoutState>(
                  builder: (context, logout) => SettingsActionTileWidget(
                    icon: Icons.logout_rounded,
                    title: 'auth.logout'.tr(context: context),
                    isDestructive: true,
                    isLoading: logout is LogoutLoading,
                    onTap: () => context.read<LogoutCubit>().logout(),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
