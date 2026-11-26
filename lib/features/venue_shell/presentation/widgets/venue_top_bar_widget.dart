import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/searchable_picker_sheet_widget.dart';
import '../cubit/venue_session_cubit.dart';
import '../cubit/venue_session_state.dart';

/// Navy top bar of every venue tab: the section title and the venue open now,
/// which a user with several venues taps to switch.
class VenueTopBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const VenueTopBarWidget({required this.title, this.actions, super.key});

  final String title;
  final List<Widget>? actions;

  @override
  Size get preferredSize => Size.fromHeight(64.h);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VenueSessionCubit, VenueSessionState>(
      builder: (context, state) {
        final ready = state is VenueSessionReady ? state : null;
        final canSwitch = (ready?.venues.length ?? 0) > 1;
        return AppBar(
          backgroundColor: AppColors.brandNavy,
          foregroundColor: AppColors.white,
          systemOverlayStyle: SystemUiOverlayStyle.light,
          elevation: 0,
          toolbarHeight: 64.h,
          automaticallyImplyLeading: false,
          titleSpacing: 16.w,
          title: InkWell(
            borderRadius: BorderRadius.circular(10.r),
            onTap: canSwitch ? () => _pickVenue(context, ready!) : null,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 4.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.font18Bold.copyWith(
                      color: AppColors.white,
                    ),
                  ),
                  if (ready != null)
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: Text(
                            ready.venue.name,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.font12Medium.copyWith(
                              color: AppColors.onNavyMuted,
                            ),
                          ),
                        ),
                        if (canSwitch)
                          Icon(
                            Icons.keyboard_arrow_down_rounded,
                            size: 18.r,
                            color: AppColors.onNavyMuted,
                          ),
                      ],
                    ),
                ],
              ),
            ),
          ),
          actions: [
            ...?actions,
            SizedBox(width: 8.w),
          ],
        );
      },
    );
  }

  Future<void> _pickVenue(BuildContext context, VenueSessionReady state) async {
    final cubit = context.read<VenueSessionCubit>();
    final index = await SearchablePickerSheetWidget.show(
      context,
      title: 'venue.shell.switch_venue'.tr(context: context),
      options: [for (final v in state.venues) v.name],
      selectedIndex: state.venues.indexWhere((v) => v.id == state.venue.id),
      searchHint: 'venue.shell.search_venue'.tr(context: context),
      emptyText: 'venue.shell.no_match'.tr(context: context),
    );
    if (index != null) await cubit.selectVenue(state.venues[index].id);
  }
}
