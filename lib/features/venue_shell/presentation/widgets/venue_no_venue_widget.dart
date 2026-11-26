import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/widgets/custom_state_widget.dart';
import '../../../auth/presentation/cubit/logout_cubit.dart';
import '../cubit/venue_session_cubit.dart';

/// A new owner without a venue: set one up first, like the web dashboard.
class VenueNoVenueWidget extends StatelessWidget {
  const VenueNoVenueWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      body: SafeArea(
        child: CustomStateWidget(
          icon: Icon(
            Icons.stadium_rounded,
            size: 64.r,
            color: AppColors.brandNavy,
          ),
          title: 'venue.shell.no_venue_title'.tr(context: context),
          description: 'venue.shell.no_venue_body'.tr(context: context),
          actionText: 'venue.shell.start_setup'.tr(context: context),
          onActionTap: () async {
            final cubit = context.read<VenueSessionCubit>();
            final venueId = await context.pushNamed<String>(
              AppRoutes.venueSetup,
            );
            await cubit.load(preferVenueId: venueId);
          },
          footer: TextButton(
            onPressed: () => context.read<LogoutCubit>().logout(),
            child: Text('auth.logout'.tr(context: context)),
          ),
        ),
      ),
    );
  }
}
