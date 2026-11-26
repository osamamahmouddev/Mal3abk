import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/alert_banner_widget.dart';
import '../../../../core/widgets/app_badge_widget.dart';
import '../../../../core/widgets/app_top_snack_bar.dart';
import '../../../../core/widgets/custom_app_bar_widget.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_dialog_widget.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../../../core/widgets/shimmer_list_skeleton_widget.dart';
import '../../../venue_shell/data/models/my_permissions_model.dart';
import '../../../venue_shell/presentation/cubit/venue_session_cubit.dart';
import '../../../venue_shell/presentation/cubit/venue_session_state.dart';
import '../../../venue_shell/presentation/venue_format.dart';
import '../../../venue_shell/presentation/widgets/venue_section_card_widget.dart';
import '../../data/models/venue_staff_model.dart';
import '../../domain/repos/venue_staff_repo.dart';
import '../cubit/venue_staff_cubit.dart';

/// Staff and their roles, like the web "staff and permissions" page.
class VenueStaffScreen extends StatelessWidget {
  const VenueStaffScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final session = context.watch<VenueSessionCubit>().state;
    if (session is! VenueSessionReady) return const SizedBox.shrink();
    String t(String key) => 'venue.staff.$key'.tr(context: context);
    if (!session.can(VenuePermissions.staffManage)) {
      return Scaffold(
        appBar: CustomAppBarWidget(title: t('title')),
        body: Padding(
          padding: EdgeInsets.all(16.r),
          child: AlertBannerWidget(
            type: AlertBannerType.info,
            message: t('owner_only'),
          ),
        ),
      );
    }
    return BlocProvider<VenueStaffCubit>(
      create: (_) => VenueStaffCubit(
        venueStaffRepo: sl<VenueStaffRepo>(),
        venueId: session.venue.id,
      )..load(),
      child: Scaffold(
        backgroundColor: AppColors.pageBackground,
        appBar: CustomAppBarWidget(title: t('title')),
        body: const _Body(),
      ),
    );
  }
}

class _Body extends HookWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<VenueStaffCubit>();
    final contact = useTextEditingController();
    final role = useState('Receptionist');
    String t(String key) => 'venue.staff.$key'.tr(context: context);
    String roleLabel(String r) => 'venue.staff.role.$r'.tr(context: context);

    Future<void> report(Future<String?> action, String success) async {
      final error = await action;
      if (!context.mounted) return;
      if (error == null) {
        AppTopSnackBar.showSuccess(context, success);
      } else {
        AppTopSnackBar.showError(context, error.tr(context: context));
      }
    }

    return BlocBuilder<VenueStaffCubit, VenueStaffState>(
      builder: (context, state) {
        if (state.loading) {
          return const ShimmerListSkeletonWidget(itemHeight: 80);
        }
        return RefreshIndicator(
          onRefresh: cubit.load,
          child: ListView(
            padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 32.h),
            children: [
              if (state.error case final e?) ...[
                AlertBannerWidget(
                  type: AlertBannerType.error,
                  message: e.tr(context: context),
                  actionText: 'common.retry'.tr(context: context),
                  onActionTap: cubit.load,
                ),
                hSpace(10),
              ],
              VenueSectionCardWidget(
                title: t('members_title'),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (state.staff.members.isEmpty)
                      Text(t('empty'), style: AppTextStyles.font13Regular),
                    for (final m in state.staff.members) ...[
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 18.r,
                            backgroundColor: AppColors.tableHead,
                            child: Text(
                              (m.fullName?.isNotEmpty ?? false)
                                  ? m.fullName!.characters.first
                                  : '؟',
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  m.fullName ?? t('member'),
                                  style: AppTextStyles.font14Bold,
                                ),
                                Text(
                                  'venue.staff.since'.tr(
                                    context: context,
                                    args: [
                                      VenueFormat.day(
                                        context,
                                        DateTime.parse(m.addedAtUtc),
                                      ),
                                    ],
                                  ),
                                  style: AppTextStyles.font11Regular,
                                ),
                              ],
                            ),
                          ),
                          TextButton(
                            onPressed: state.busy
                                ? null
                                : () => CustomDialogWidget.show<void>(
                                    context: context,
                                    title: 'venue.staff.remove_title'.tr(
                                      context: context,
                                      args: [m.fullName ?? t('member')],
                                    ),
                                    description: t('remove_body'),
                                    primaryActionText: t('remove'),
                                    secondaryActionText: 'common.cancel'.tr(
                                      context: context,
                                    ),
                                    isDestructive: true,
                                    onPrimaryAction: () {
                                      Navigator.of(
                                        context,
                                        rootNavigator: true,
                                      ).pop();
                                      report(
                                        cubit.remove(m.memberId),
                                        'venue.staff.removed'.tr(
                                          context: context,
                                          args: [m.fullName ?? t('member')],
                                        ),
                                      );
                                    },
                                  ),
                            child: Text(
                              t('remove'),
                              style: const TextStyle(color: AppColors.brandRed),
                            ),
                          ),
                        ],
                      ),
                      Wrap(
                        spacing: 6.w,
                        children: [
                          for (final r in StaffRoles.all)
                            ChoiceChip(
                              label: Text(roleLabel(r)),
                              selected: m.role == r,
                              showCheckmark: false,
                              onSelected: state.busy || m.role == r
                                  ? null
                                  : (_) => report(
                                      cubit.changeRole(m.memberId, r),
                                      t('role_changed'),
                                    ),
                            ),
                        ],
                      ),
                      const Divider(),
                    ],
                  ],
                ),
              ),
              hSpace(12),
              if (state.staff.pendingInvitations.isNotEmpty) ...[
                VenueSectionCardWidget(
                  title: t('pending_title'),
                  child: Column(
                    children: [
                      for (final inv in state.staff.pendingInvitations)
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 6.h),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      inv.email ?? inv.phoneNumber ?? '',
                                      textDirection: TextDirection.ltr,
                                      style: AppTextStyles.font13SemiBold,
                                    ),
                                    Text(
                                      'venue.staff.invite_valid'.tr(
                                        context: context,
                                        args: [
                                          roleLabel(inv.role),
                                          VenueFormat.dateTime(
                                            context,
                                            inv.expiresAtUtc,
                                          ),
                                        ],
                                      ),
                                      style: AppTextStyles.font11Regular,
                                    ),
                                  ],
                                ),
                              ),
                              AppBadgeWidget(
                                text: t('waiting'),
                                type: AppBadgeType.warning,
                              ),
                              PopupMenuButton<String>(
                                onSelected: (v) => v == 'resend'
                                    ? report(
                                        cubit.resend(inv.invitationId),
                                        t('resent'),
                                      )
                                    : report(
                                        cubit.cancelInvitation(
                                          inv.invitationId,
                                        ),
                                        t('cancelled'),
                                      ),
                                itemBuilder: (_) => [
                                  PopupMenuItem(
                                    value: 'resend',
                                    child: Text(t('resend')),
                                  ),
                                  PopupMenuItem(
                                    value: 'cancel',
                                    child: Text(t('cancel')),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
                hSpace(12),
              ],
              VenueSectionCardWidget(
                title: t('invite_title'),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CustomTextFormField(
                      controller: contact,
                      labelText: t('contact'),
                      hintText: 'name@example.com / 010…',
                      textDirection: TextDirection.ltr,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    hSpace(10),
                    Text(t('role_label'), style: AppTextStyles.font13SemiBold),
                    Wrap(
                      spacing: 6.w,
                      children: [
                        for (final r in StaffRoles.all)
                          ChoiceChip(
                            label: Text(roleLabel(r)),
                            selected: role.value == r,
                            showCheckmark: false,
                            onSelected: (_) => role.value = r,
                          ),
                      ],
                    ),
                    hSpace(6),
                    Text(
                      t('invite_note'),
                      style: AppTextStyles.font11Regular.copyWith(
                        color: AppColors.textMuted,
                      ),
                    ),
                    hSpace(10),
                    CustomButton(
                      text: t('send_invite'),
                      height: 48.h,
                      borderRadius: 14,
                      isLoading: state.busy,
                      textStyle: AppTextStyles.font15Bold.copyWith(
                        color: AppColors.white,
                      ),
                      onTap: () async {
                        final viaEmail = contact.text.contains('@');
                        final success = viaEmail
                            ? t('sent_email')
                            : t('sent_sms');
                        final error = await cubit.invite(
                          contact.text,
                          role.value,
                        );
                        if (!context.mounted) return;
                        if (error == null) {
                          contact.clear();
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
              hSpace(12),
              VenueSectionCardWidget(
                title: t('matrix_title'),
                child: Table(
                  columnWidths: const {0: FlexColumnWidth(2.4)},
                  children: [
                    TableRow(
                      children: [
                        const SizedBox.shrink(),
                        for (final r in ['Owner', ...StaffRoles.all])
                          Text(
                            roleLabel(r),
                            textAlign: TextAlign.center,
                            style: AppTextStyles.font11Bold,
                          ),
                      ],
                    ),
                    for (final (key, allowed) in StaffRoles.matrix)
                      TableRow(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 6.h),
                            child: Text(
                              t('matrix.$key'),
                              style: AppTextStyles.font12Regular,
                            ),
                          ),
                          for (final ok in allowed)
                            Icon(
                              ok ? Icons.check_rounded : Icons.remove_rounded,
                              size: 16.r,
                              color: ok
                                  ? AppColors.successGreen
                                  : AppColors.textMuted,
                            ),
                        ],
                      ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
