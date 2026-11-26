import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/custom_search_field_widget.dart';
import '../../../../core/widgets/sheet_drag_handle_widget.dart';
import '../../../venue_shell/presentation/venue_format.dart';
import '../../data/models/venue_customer_model.dart';
import '../cubit/manual_booking_cubit.dart';
import '../cubit/manual_booking_state.dart';

/// Picks a customer who booked at the venue before.
class ManualBookingCustomerSheetWidget extends HookWidget {
  const ManualBookingCustomerSheetWidget({
    required this.initialSearch,
    super.key,
  });

  final String initialSearch;

  static Future<VenueCustomerModel?> show(
    BuildContext context, {
    required ManualBookingCubit cubit,
    required String initialSearch,
  }) => showModalBottomSheet<VenueCustomerModel>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: Colors.transparent,
    builder: (_) => BlocProvider.value(
      value: cubit,
      child: ManualBookingCustomerSheetWidget(initialSearch: initialSearch),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ManualBookingCubit>();
    final controller = useTextEditingController(text: initialSearch);
    String t(String key) => 'venue.manual.customers.$key'.tr(context: context);
    useEffect(() {
      cubit.searchCustomers(initialSearch);
      return null;
    }, const []);

    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: Container(
        height: MediaQuery.sizeOf(context).height * 0.75,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Center(child: SheetDragHandleWidget()),
            hSpace(12),
            Text(t('title'), style: AppTextStyles.font18Bold),
            hSpace(12),
            CustomSearchFieldWidget(
              controller: controller,
              hintText: t('search'),
              onChanged: cubit.searchCustomers,
            ),
            hSpace(8),
            Expanded(
              child: BlocBuilder<ManualBookingCubit, ManualBookingState>(
                buildWhen: (a, b) =>
                    a.customers != b.customers ||
                    a.customersLoading != b.customersLoading,
                builder: (context, state) {
                  if (state.customersLoading && state.customers.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state.customers.isEmpty) {
                    return Center(
                      child: Text(
                        controller.text.trim().isEmpty
                            ? t('none_yet')
                            : t('no_match'),
                        textAlign: TextAlign.center,
                        style: AppTextStyles.font13Regular.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    );
                  }
                  return ListView.separated(
                    itemCount: state.customers.length,
                    separatorBuilder: (_, _) => const Divider(height: 1),
                    itemBuilder: (context, i) {
                      final c = state.customers[i];
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(c.name, style: AppTextStyles.font14Bold),
                        subtitle: Text(
                          [
                            c.phone ?? t('no_phone'),
                            if (c.totalBookings > 0)
                              'venue.manual.customers.bookings'.tr(
                                context: context,
                                args: [
                                  VenueFormat.number(context, c.totalBookings),
                                ],
                              ),
                            if (c.noShows > 0)
                              'venue.manual.customers.no_shows'.tr(
                                context: context,
                                args: [VenueFormat.number(context, c.noShows)],
                              ),
                          ].join(' · '),
                          style: AppTextStyles.font12Regular,
                        ),
                        trailing: Text(
                          t('pick'),
                          style: AppTextStyles.font13Bold.copyWith(
                            color: AppColors.brandRed,
                          ),
                        ),
                        onTap: () => Navigator.of(context).pop(c),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
