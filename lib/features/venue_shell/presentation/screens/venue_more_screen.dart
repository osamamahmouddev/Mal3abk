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
import '../../data/models/my_permissions_model.dart';
import '../cubit/venue_session_cubit.dart';
import '../cubit/venue_session_state.dart';
import '../widgets/venue_top_bar_widget.dart';

/// The dashboard sections that are not bottom tabs, filtered by what the
/// user's role at this venue may open.
class VenueMoreScreen extends StatelessWidget {
  const VenueMoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String t(String key) => 'venue.more.$key'.tr(context: context);
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: VenueTopBarWidget(title: 'venue.nav.more'.tr(context: context)),
      body: BlocBuilder<VenueSessionCubit, VenueSessionState>(
        builder: (context, state) {
          if (state is! VenueSessionReady) return const SizedBox.shrink();
          return ListView(
            padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 120.h),
            children: [
              if (state.can(VenuePermissions.venueEdit)) ...[
                CustomCardWidget(
                  padding: EdgeInsets.zero,
                  child: SettingsActionTileWidget(
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
                ),
                hSpace(12),
              ],
              CustomCardWidget(
                padding: EdgeInsets.zero,
                child: SettingsActionTileWidget(
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
