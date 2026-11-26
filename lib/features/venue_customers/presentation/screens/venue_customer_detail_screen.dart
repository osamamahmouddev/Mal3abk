import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/network/api_result.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/alert_banner_widget.dart';
import '../../../../core/widgets/app_badge_widget.dart';
import '../../../../core/widgets/app_top_snack_bar.dart';
import '../../../../core/widgets/custom_app_bar_widget.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../../../core/widgets/shimmer_list_skeleton_widget.dart';
import '../../../venue_calendar/data/models/venue_customer_model.dart';
import '../../../venue_calendar/presentation/screens/venue_manual_booking_screen.dart';
import '../../../venue_shell/data/models/my_permissions_model.dart';
import '../../../venue_shell/presentation/cubit/venue_session_cubit.dart';
import '../../../venue_shell/presentation/cubit/venue_session_state.dart';
import '../../../venue_shell/presentation/venue_format.dart';
import '../../../venue_shell/presentation/widgets/venue_section_card_widget.dart';
import '../../data/models/venue_customer_detail_model.dart';
import '../../domain/repos/venue_customers_repo.dart';
import '../cubit/venue_customers_cubit.dart';

/// A customer's numbers, last bookings and staff-only notes.
class VenueCustomerDetailScreen extends HookWidget {
  const VenueCustomerDetailScreen({required this.customer, super.key});

  final VenueCustomerModel customer;

  @override
  Widget build(BuildContext context) {
    final session = context.watch<VenueSessionCubit>().state;
    if (session is! VenueSessionReady) return const SizedBox.shrink();
    final note = useTextEditingController();
    String t(String key) => 'venue.customers.$key'.tr(context: context);
    String pitchName(String id) =>
        session.venue.pitches.where((p) => p.id == id).firstOrNull?.name ?? '';

    return BlocProvider<VenueCustomerDetailCubit>(
      create: (_) => VenueCustomerDetailCubit(
        venueCustomersRepo: sl<VenueCustomersRepo>(),
        venueId: session.venue.id,
        customerKey: customer.customerKey,
      )..load(),
      child: Scaffold(
        backgroundColor: AppColors.pageBackground,
        appBar: CustomAppBarWidget(
          title: customer.name.isEmpty ? t('customer') : customer.name,
        ),
        body:
            BlocBuilder<
              VenueCustomerDetailCubit,
              ApiResult<VenueCustomerDetailModel>?
            >(
              builder: (context, result) {
                final cubit = context.read<VenueCustomerDetailCubit>();
                if (result == null) {
                  return const ShimmerListSkeletonWidget(itemHeight: 80);
                }
                if (result case ApiFailure(:final failure)) {
                  return Padding(
                    padding: EdgeInsets.all(16.r),
                    child: AlertBannerWidget(
                      type: AlertBannerType.error,
                      message: failure.message.tr(context: context),
                      actionText: 'common.retry'.tr(context: context),
                      onActionTap: cubit.load,
                    ),
                  );
                }
                final d = (result as Success<VenueCustomerDetailModel>).data;
                final c = d.customer;
                return ListView(
                  padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 32.h),
                  children: [
                    Text(
                      c.phone ?? t('app_player_hint'),
                      textDirection: c.phone == null ? null : TextDirection.ltr,
                      style: AppTextStyles.font13Regular.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    hSpace(10),
                    Row(
                      children: [
                        for (final (value, label) in [
                          (
                            VenueFormat.number(context, c.totalBookings),
                            t('stat_bookings'),
                          ),
                          (
                            VenueFormat.money(
                              context,
                              c.totalSpent,
                              c.currency,
                            ),
                            t('stat_spent'),
                          ),
                          (
                            VenueFormat.number(context, c.noShows),
                            t('stat_no_shows'),
                          ),
                        ])
                          Expanded(
                            child: Column(
                              children: [
                                Text(value, style: AppTextStyles.font16Bold),
                                Text(
                                  label,
                                  style: AppTextStyles.font11Regular.copyWith(
                                    color: AppColors.textMuted,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                    hSpace(14),
                    VenueSectionCardWidget(
                      title: t('last_bookings'),
                      child: Column(
                        children: [
                          for (final b in d.bookings)
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: Text(
                                '${pitchName(b.pitchId)} · ${VenueFormat.dateTime(context, b.startUtc)}',
                                style: AppTextStyles.font13SemiBold,
                              ),
                              subtitle: Text(b.reference),
                              trailing: AppBadgeWidget(
                                text: VenueFormat.statusLabel(
                                  context,
                                  b.status,
                                ),
                                type: VenueFormat.statusTone(b.status),
                              ),
                            ),
                        ],
                      ),
                    ),
                    hSpace(12),
                    VenueSectionCardWidget(
                      title: t('notes_title'),
                      subtitle: t('notes_hint'),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          for (final n in d.notes)
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: Text(
                                n.text,
                                style: AppTextStyles.font13Regular,
                              ),
                              subtitle: Text(
                                '${n.authorName.isEmpty ? t('staff') : n.authorName} · ${VenueFormat.dateTime(context, n.createdAtUtc)}',
                              ),
                              trailing: n.canDelete
                                  ? IconButton(
                                      tooltip: t('delete_note'),
                                      onPressed: () async {
                                        final error = await cubit.deleteNote(
                                          n.id,
                                        );
                                        if (error != null && context.mounted) {
                                          AppTopSnackBar.showError(
                                            context,
                                            error.tr(context: context),
                                          );
                                        }
                                      },
                                      icon: const Icon(
                                        Icons.delete_outline_rounded,
                                      ),
                                    )
                                  : null,
                            ),
                          CustomTextFormField(
                            controller: note,
                            hintText: t('note_placeholder'),
                            minLines: 2,
                            maxLines: 4,
                          ),
                          hSpace(8),
                          CustomButton(
                            text: t('save_note'),
                            height: 44.h,
                            borderRadius: 12,
                            type: CustomButtonType.outline,
                            onTap: () async {
                              final success = t('note_saved');
                              final error = await cubit.addNote(note.text);
                              if (!context.mounted) return;
                              if (error == null) {
                                note.clear();
                                AppTopSnackBar.showSuccess(context, success);
                              } else {
                                AppTopSnackBar.showError(
                                  context,
                                  error.tr(context: context),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    if (session.can(VenuePermissions.bookingsApprove)) ...[
                      hSpace(12),
                      CustomButton(
                        text: t('manual_for_customer'),
                        height: 50.h,
                        borderRadius: 14,
                        textStyle: AppTextStyles.font15Bold.copyWith(
                          color: AppColors.white,
                        ),
                        onTap: () => context.pushNamed<bool>(
                          AppRoutes.venueManualBooking,
                          arguments: VenueManualBookingArgs(
                            venue: session.venue,
                            customerName: c.name,
                            customerPhone: c.phone,
                          ),
                        ),
                      ),
                    ],
                  ],
                );
              },
            ),
      ),
    );
  }
}
