import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/utils/cairo_time.dart';
import '../../../../core/widgets/alert_banner_widget.dart';
import '../../../../core/widgets/app_badge_widget.dart';
import '../../../../core/widgets/app_top_snack_bar.dart';
import '../../../../core/widgets/custom_app_bar_widget.dart';
import '../../../../core/widgets/custom_dialog_widget.dart';
import '../../../../core/widgets/shimmer_list_skeleton_widget.dart';
import '../../../venue_shell/data/models/my_permissions_model.dart';
import '../../../venue_shell/data/models/venue_model.dart';
import '../../../venue_shell/presentation/cubit/venue_session_cubit.dart';
import '../../../venue_shell/presentation/cubit/venue_session_state.dart';
import '../../../venue_shell/presentation/venue_format.dart';
import '../../../venue_shell/presentation/widgets/venue_section_card_widget.dart';
import '../../data/models/price_rule_model.dart';
import '../../domain/repos/venue_pricing_repo.dart';
import '../cubit/venue_pricing_cubit.dart';
import '../pricing_format.dart';
import '../widgets/price_preview_card_widget.dart';
import '../widgets/price_rule_editor_sheet_widget.dart';

/// Pricing rules and temporary discounts, like the web "prices" page. The
/// API computes every price; this only edits the rules.
class VenuePricingScreen extends StatelessWidget {
  const VenuePricingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final session = context.watch<VenueSessionCubit>().state;
    if (session is! VenueSessionReady) return const SizedBox.shrink();
    return BlocProvider<VenuePricingCubit>(
      create: (_) => VenuePricingCubit(
        venuePricingRepo: sl<VenuePricingRepo>(),
        venueId: session.venue.id,
      )..load(),
      child: Scaffold(
        backgroundColor: AppColors.pageBackground,
        appBar: CustomAppBarWidget(
          title: 'venue.pricing.title'.tr(context: context),
        ),
        body: _Body(
          venue: session.venue,
          editable: session.can(VenuePermissions.venueEdit),
        ),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({required this.venue, required this.editable});

  final VenueModel venue;
  final bool editable;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<VenuePricingCubit>();
    String t(String key) => 'venue.pricing.$key'.tr(context: context);
    String pitchName(String? id) => id == null
        ? t('all_pitches')
        : venue.pitches.where((p) => p.id == id).firstOrNull?.name ?? '';

    void report(String? error, String success) {
      if (!context.mounted) return;
      if (error == null) {
        AppTopSnackBar.showSuccess(context, success);
      } else {
        AppTopSnackBar.showError(context, error.tr(context: context));
      }
    }

    Future<void> edit(PriceRuleDraft draft) async {
      final saved = await PriceRuleEditorSheetWidget.show(
        context,
        cubit: cubit,
        venue: venue,
        draft: draft,
      );
      if (saved == true && context.mounted) {
        report(null, draft.id == null ? t('added') : t('saved'));
      }
    }

    void confirmDelete(PriceRuleModel r) => CustomDialogWidget.show<void>(
      context: context,
      title: 'venue.pricing.delete_title'.tr(context: context, args: [r.name]),
      description: r.kind == 'Discount'
          ? t('delete_discount_body')
          : t('delete_body'),
      primaryActionText: t('delete'),
      secondaryActionText: 'common.cancel'.tr(context: context),
      isDestructive: true,
      onPrimaryAction: () async {
        Navigator.of(context, rootNavigator: true).pop();
        final success = t('deleted');
        report(await cubit.delete(r), success);
      },
    );

    Widget ruleTile(PriceRuleModel r) {
      final isDiscount = r.kind == 'Discount';
      final (statusText, ok) = isDiscount
          ? PricingFormat.discountStatus(context, r)
          : ('', true);
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 6.h),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(r.name, style: AppTextStyles.font14Bold),
                      ),
                      if (isDiscount) ...[
                        SizedBox(width: 6.w),
                        AppBadgeWidget(
                          text: statusText,
                          type: ok
                              ? AppBadgeType.success
                              : AppBadgeType.neutral,
                        ),
                      ],
                    ],
                  ),
                  hSpace(2),
                  Text(
                    PricingFormat.value(context, r),
                    style: AppTextStyles.font13SemiBold.copyWith(
                      color: AppColors.brandNavy,
                    ),
                  ),
                  Text(
                    '${pitchName(r.pitchId)} · ${PricingFormat.when(context, r)}',
                    style: AppTextStyles.font12Regular.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            if (editable) ...[
              Switch(
                value: r.isActive,
                onChanged: (_) async {
                  final success = t('saved');
                  report(await cubit.toggle(r), success);
                },
              ),
              PopupMenuButton<String>(
                onSelected: (v) => v == 'edit'
                    ? edit(PriceRuleDraft.fromRule(r))
                    : confirmDelete(r),
                itemBuilder: (_) => [
                  PopupMenuItem(value: 'edit', child: Text(t('edit'))),
                  PopupMenuItem(value: 'delete', child: Text(t('delete'))),
                ],
              ),
            ],
          ],
        ),
      );
    }

    return BlocBuilder<VenuePricingCubit, VenuePricingState>(
      builder: (context, state) {
        if (state.loading) {
          return const ShimmerListSkeletonWidget(itemHeight: 90);
        }
        final regular = state.visible.where((r) => r.kind != 'Discount');
        final today = CairoTime.today();
        return RefreshIndicator(
          onRefresh: cubit.load,
          child: ListView(
            padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 32.h),
            children: [
              Text(
                t('intro'),
                style: AppTextStyles.font12Regular.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              hSpace(10),
              SizedBox(
                height: 40.h,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    for (final (id, label) in [
                      (null, t('all_pitches')),
                      for (final p in venue.pitches) (p.id, p.name),
                    ])
                      Padding(
                        padding: EdgeInsetsDirectional.only(end: 8.w),
                        child: ChoiceChip(
                          label: Text(label),
                          selected: state.pitchFilter == id,
                          onSelected: (_) => cubit.setPitchFilter(id),
                        ),
                      ),
                  ],
                ),
              ),
              hSpace(10),
              if (state.error case final e?) ...[
                AlertBannerWidget(
                  type: AlertBannerType.error,
                  message: e.tr(context: context),
                  actionText: 'common.retry'.tr(context: context),
                  onActionTap: cubit.load,
                ),
                hSpace(10),
              ],
              if (!state.hasBase && state.error == null) ...[
                AlertBannerWidget(
                  type: AlertBannerType.warning,
                  message: t('no_base'),
                ),
                hSpace(10),
              ],
              if (editable)
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () => edit(
                          PriceRuleDraft.discount(
                            name: t('discount_default_name'),
                            today: VenueFormat.apiDate(today),
                            weekLater: VenueFormat.apiDate(
                              today.add(const Duration(days: 7)),
                            ),
                          ),
                        ),
                        icon: const Icon(Icons.sell_outlined),
                        label: Text(t('add_discount')),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: FilledButton.icon(
                        onPressed: () {
                          final kind = state.hasBase ? 'Peak' : 'Base';
                          edit(
                            PriceRuleDraft.empty(
                              kind,
                              PricingFormat.kindLabel(context, kind),
                            ),
                          );
                        },
                        icon: const Icon(Icons.add_rounded),
                        label: Text(t('add_rule')),
                      ),
                    ),
                  ],
                ),
              hSpace(14),
              VenueSectionCardWidget(
                title: t('discounts_title'),
                child: state.discounts.isEmpty
                    ? Text(
                        t('discounts_empty'),
                        style: AppTextStyles.font12Regular.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      )
                    : Column(
                        children: [
                          for (final r in state.discounts) ruleTile(r),
                        ],
                      ),
              ),
              hSpace(12),
              for (final kind in PriceRuleDraft.kinds.where(
                (k) => k != 'Discount',
              ))
                if (regular.where((r) => r.kind == kind).toList()
                    case final group when group.isNotEmpty) ...[
                  VenueSectionCardWidget(
                    title: PricingFormat.kindLabel(context, kind),
                    subtitle: 'venue.pricing.kind_hint.$kind'.tr(
                      context: context,
                    ),
                    child: Column(
                      children: [for (final r in group) ruleTile(r)],
                    ),
                  ),
                  hSpace(12),
                ],
              if (state.rules.isEmpty)
                Text(t('empty'), style: AppTextStyles.font13Regular),
              if (venue.pitches.isNotEmpty) ...[
                hSpace(12),
                PricePreviewCardWidget(venue: venue),
              ],
            ],
          ),
        );
      },
    );
  }
}
