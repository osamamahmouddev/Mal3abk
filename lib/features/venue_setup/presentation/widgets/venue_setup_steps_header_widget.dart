import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../venue_shell/presentation/venue_format.dart';
import '../cubit/venue_setup_cubit.dart';
import '../cubit/venue_setup_state.dart';

class VenueSetupStepsHeaderWidget extends StatelessWidget {
  const VenueSetupStepsHeaderWidget({required this.state, super.key});

  final VenueSetupState state;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<VenueSetupCubit>();
    return Row(
      children: [
        for (var n = 1; n <= 4; n++)
          Expanded(
            child: Semantics(
              button: true,
              selected: n == state.step,
              child: InkWell(
                borderRadius: BorderRadius.circular(10.r),
                onTap: n > 1 && state.venue == null
                    ? null
                    : () => cubit.goTo(n),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 6.h),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 15.r,
                        backgroundColor: n < state.step
                            ? AppColors.successGreen
                            : n == state.step
                            ? AppColors.brandNavy
                            : AppColors.lightSurfaceDeep,
                        child: n < state.step
                            ? Icon(
                                Icons.check_rounded,
                                size: 16.r,
                                color: AppColors.white,
                              )
                            : Text(
                                VenueFormat.number(context, n),
                                style: AppTextStyles.font13Bold.copyWith(
                                  color: n == state.step
                                      ? AppColors.white
                                      : AppColors.textBody,
                                ),
                              ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'venue.setup.step_$n'.tr(context: context),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.font11Bold.copyWith(
                          color: n == state.step
                              ? AppColors.brandNavy
                              : AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
