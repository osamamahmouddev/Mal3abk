import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/alert_banner_widget.dart';
import '../../../../core/widgets/app_top_snack_bar.dart';
import '../../../../core/widgets/custom_app_bar_widget.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../../../core/widgets/shimmer_list_skeleton_widget.dart';
import '../../../venue_shell/data/models/my_permissions_model.dart';
import '../../../venue_shell/presentation/cubit/venue_session_cubit.dart';
import '../../../venue_shell/presentation/cubit/venue_session_state.dart';
import '../../../venue_shell/presentation/venue_format.dart';
import '../../../venue_shell/presentation/widgets/venue_section_card_widget.dart';
import '../../data/models/booking_policy_model.dart';
import '../../domain/repos/venue_policies_repo.dart';
import '../cubit/venue_policies_cubit.dart';

/// Booking policies with a preview of what players read, like the web page.
class VenuePoliciesScreen extends StatelessWidget {
  const VenuePoliciesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final session = context.watch<VenueSessionCubit>().state;
    if (session is! VenueSessionReady) return const SizedBox.shrink();
    return BlocProvider<VenuePoliciesCubit>(
      create: (_) => VenuePoliciesCubit(
        venuePoliciesRepo: sl<VenuePoliciesRepo>(),
        venueId: session.venue.id,
      )..load(),
      child: Scaffold(
        backgroundColor: AppColors.pageBackground,
        appBar: CustomAppBarWidget(
          title: 'venue.policies.title'.tr(context: context),
        ),
        body: _Body(
          venueName: session.venue.name,
          editable: session.can(VenuePermissions.policiesManage),
        ),
      ),
    );
  }
}

class _Body extends HookWidget {
  const _Body({required this.venueName, required this.editable});

  final String venueName;
  final bool editable;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<VenuePoliciesCubit>();
    final terms = useTextEditingController();
    String t(String key) => 'venue.policies.$key'.tr(context: context);
    String option(String key) =>
        'venue.policies.option.$key'.tr(context: context);

    String depositText(BookingPolicyModel p) {
      final value = VenueFormat.number(
        context,
        (p.values['depositValue'] as num?) ?? 0,
      );
      return switch (p.values['depositType']) {
        1 => VenueFormat.money(
          context,
          (p.values['depositValue'] as num?) ?? 0,
        ),
        2 => t('deposit_full'),
        _ => 'venue.policies.deposit_percent'.tr(
          context: context,
          args: [value],
        ),
      };
    }

    String label(BookingPolicyModel p, String group) {
      final key = PolicyOptionGroup.selected(p, group);
      return key == null ? '—' : option(key);
    }

    return BlocConsumer<VenuePoliciesCubit, VenuePoliciesState>(
      listenWhen: (a, b) => a.loading && !b.loading,
      listener: (context, state) =>
          terms.text = (state.policy.values['terms'] as String?) ?? '',
      builder: (context, state) {
        if (state.loading) {
          return const ShimmerListSkeletonWidget(itemHeight: 90);
        }
        final p = state.policy;
        final preview = [
          'venue.policies.preview.deposit'.tr(
            context: context,
            args: [depositText(p), label(p, 'proof_window')],
          ),
          'venue.policies.preview.review'.tr(
                context: context,
                args: [label(p, 'review_window')],
              ) +
              (p.values['pendingBookingsBlockSlots'] == true
                  ? t('preview.held')
                  : '.'),
          'venue.policies.preview.cancel'.tr(
            context: context,
            args: [label(p, 'free_cancel'), label(p, 'refund')],
          ),
          'venue.policies.preview.late'.tr(
            context: context,
            args: [label(p, 'late'), label(p, 'no_show')],
          ),
          'venue.policies.preview.reschedule'.tr(
            context: context,
            args: [label(p, 'reschedule')],
          ),
        ];
        return ListView(
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
            Row(
              children: [
                if (p.version != null)
                  Text(
                    'venue.policies.version'.tr(
                      context: context,
                      args: [VenueFormat.number(context, p.version!)],
                    ),
                    style: AppTextStyles.font12Regular.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                const Spacer(),
                if (state.dirty)
                  Text(
                    t('unsaved'),
                    style: AppTextStyles.font12SemiBold.copyWith(
                      color: AppColors.goldText,
                    ),
                  ),
              ],
            ),
            hSpace(10),
            for (final (section, groups) in PolicyOptionGroup.sections) ...[
              VenueSectionCardWidget(
                title: t('section.$section'),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (section == 'deposit') ...[
                      Text(t('deposit_value'), style: AppTextStyles.font14Bold),
                      Text(
                        t('deposit_value_hint'),
                        style: AppTextStyles.font12Regular.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      hSpace(4),
                      Text(
                        depositText(p),
                        style: AppTextStyles.font15Bold.copyWith(
                          color: AppColors.brandNavy,
                        ),
                      ),
                      hSpace(12),
                    ],
                    for (final g in groups) ...[
                      Text(
                        t('group.${g.key}'),
                        style: AppTextStyles.font14Bold,
                      ),
                      Text(
                        t('hint.${g.key}'),
                        style: AppTextStyles.font12Regular.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      hSpace(6),
                      Wrap(
                        spacing: 6.w,
                        runSpacing: 6.h,
                        children: [
                          for (final (key, patch) in g.options)
                            ChoiceChip(
                              label: Text(option(key)),
                              selected: p.matches(patch),
                              showCheckmark: false,
                              onSelected: editable
                                  ? (_) => cubit.choose(patch)
                                  : null,
                            ),
                        ],
                      ),
                      hSpace(12),
                    ],
                  ],
                ),
              ),
              hSpace(12),
            ],
            VenueSectionCardWidget(
              title: t('section.terms'),
              child: CustomTextFormField(
                controller: terms,
                hintText: t('terms_hint'),
                minLines: 2,
                maxLines: 5,
                enabled: editable,
                onChanged: cubit.setTerms,
              ),
            ),
            hSpace(12),
            VenueSectionCardWidget(
              title: 'venue.policies.preview_title'.tr(
                context: context,
                args: [venueName],
              ),
              subtitle: t('preview_subtitle'),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  for (final line in preview)
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 4.h),
                      child: Text(
                        '• $line',
                        style: AppTextStyles.font13Regular,
                      ),
                    ),
                ],
              ),
            ),
            if (editable) ...[
              hSpace(16),
              CustomButton(
                text: t('save'),
                height: 52.h,
                borderRadius: 14,
                enabled: state.dirty,
                isLoading: state.saving,
                textStyle: AppTextStyles.font16Bold.copyWith(
                  color: AppColors.white,
                ),
                onTap: () async {
                  final success = t('saved');
                  final error = await cubit.save();
                  if (!context.mounted) return;
                  if (error == null) {
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
          ],
        );
      },
    );
  }
}
