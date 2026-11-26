import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/alert_banner_widget.dart';
import '../../../../core/widgets/app_badge_widget.dart';
import '../../../../core/widgets/app_top_snack_bar.dart';
import '../../../../core/widgets/custom_app_bar_widget.dart';
import '../../../../core/widgets/custom_card_widget.dart';
import '../../../../core/widgets/custom_tab_bar_widget.dart';
import '../../../../core/widgets/shimmer_list_skeleton_widget.dart';
import '../../../reference/domain/repos/reference_repo.dart';
import '../../../venue_setup/domain/repos/venue_setup_repo.dart';
import '../../../venue_shell/data/models/my_permissions_model.dart';
import '../../../venue_shell/presentation/cubit/venue_session_cubit.dart';
import '../../../venue_shell/presentation/cubit/venue_session_state.dart';
import '../../../venue_shell/presentation/venue_format.dart';
import '../cubit/venue_pitches_cubit.dart';
import '../cubit/venue_pitches_state.dart';
import '../widgets/pitch_edit_sheet_widget.dart';

/// Pitches of the open venue (add, edit, pause, delete, photos) and the
/// owner's branches (publish, add), like the web page.
class VenuePitchesScreen extends StatefulWidget {
  const VenuePitchesScreen({super.key});

  @override
  State<VenuePitchesScreen> createState() => _VenuePitchesScreenState();
}

class _VenuePitchesScreenState extends State<VenuePitchesScreen> {
  int _tab = 0;

  @override
  Widget build(BuildContext context) {
    final session = context.watch<VenueSessionCubit>().state;
    if (session is! VenueSessionReady) return const SizedBox.shrink();
    String t(String key) => 'venue.pitches.$key'.tr(context: context);
    return BlocProvider<VenuePitchesCubit>(
      create: (_) => VenuePitchesCubit(
        venueSetupRepo: sl<VenueSetupRepo>(),
        referenceRepo: sl<ReferenceRepo>(),
        venueId: session.venue.id,
      )..load(),
      child: Scaffold(
        backgroundColor: AppColors.pageBackground,
        appBar: CustomAppBarWidget(title: t('title')),
        body: Column(
          children: [
            Container(
              color: AppColors.white,
              child: CustomTabBarWidget(
                tabs: [t('tab_pitches'), t('tab_branches')],
                selectedIndex: _tab,
                onTabSelected: (i) => setState(() => _tab = i),
              ),
            ),
            Expanded(
              child: _tab == 0
                  ? _PitchesTab(session: session)
                  : _BranchesTab(session: session),
            ),
          ],
        ),
      ),
    );
  }
}

void _showResult(
  BuildContext context,
  PitchActionResult result,
  String success,
) {
  if (!context.mounted) return;
  switch (result) {
    case PitchActionDone():
      AppTopSnackBar.showSuccess(context, success);
    case PitchActionFailed(:final message):
      AppTopSnackBar.showError(context, message.tr(context: context));
  }
}

class _PitchesTab extends StatelessWidget {
  const _PitchesTab({required this.session});

  final VenueSessionReady session;

  @override
  Widget build(BuildContext context) {
    String t(String key) => 'venue.pitches.$key'.tr(context: context);
    final cubit = context.read<VenuePitchesCubit>();
    final canManage = session.can(VenuePermissions.pitchesManage);
    final lang = context.locale.languageCode;

    Future<void> edit(VenuePitchModelRef pitch) =>
        PitchEditSheetWidget.show(context, cubit: cubit, pitchId: pitch.id);

    return BlocBuilder<VenuePitchesCubit, VenuePitchesState>(
      builder: (context, state) {
        if (state.loading) {
          return const ShimmerListSkeletonWidget(itemHeight: 90);
        }
        return RefreshIndicator(
          onRefresh: cubit.load,
          child: ListView(
            padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 32.h),
            children: [
              if (state.error case final e?)
                AlertBannerWidget(
                  type: AlertBannerType.error,
                  message: e.tr(context: context),
                  actionText: 'common.retry'.tr(context: context),
                  onActionTap: cubit.load,
                ),
              Text(
                'venue.pitches.count'.tr(
                  context: context,
                  args: [
                    VenueFormat.number(context, state.pitches.length),
                    session.venue.name,
                  ],
                ),
                style: AppTextStyles.font13Regular.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              hSpace(12),
              if (state.pitches.isEmpty)
                Text(t('empty'), style: AppTextStyles.font14Regular),
              for (final p in state.pitches) ...[
                CustomCardWidget(
                  padding: EdgeInsets.all(14.r),
                  borderRadius: 16,
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    p.name,
                                    style: AppTextStyles.font15Bold,
                                  ),
                                ),
                                SizedBox(width: 8.w),
                                AppBadgeWidget(
                                  text: p.isActive ? t('active') : t('paused'),
                                  type: p.isActive
                                      ? AppBadgeType.success
                                      : AppBadgeType.neutral,
                                ),
                              ],
                            ),
                            hSpace(4),
                            Text(
                              'venue.setup.pitches.summary'.tr(
                                context: context,
                                args: [
                                  VenueFormat.number(context, p.capacity),
                                  lang == 'ar'
                                      ? p.surfaceArabicDisplayName
                                      : p.surfaceDisplayName,
                                ],
                              ),
                              style: AppTextStyles.font12Regular.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                            if (p.photos.isNotEmpty)
                              Text(
                                'venue.pitches.photos_count'.tr(
                                  context: context,
                                  args: [
                                    VenueFormat.number(
                                      context,
                                      p.photos.length,
                                    ),
                                  ],
                                ),
                                style: AppTextStyles.font11Regular.copyWith(
                                  color: AppColors.textMuted,
                                ),
                              ),
                          ],
                        ),
                      ),
                      if (canManage) ...[
                        Switch(
                          value: p.isActive,
                          onChanged: state.busyId == p.id
                              ? null
                              : (_) async {
                                  final paused = p.isActive;
                                  final result = await cubit.toggleActive(p);
                                  if (!context.mounted) return;
                                  final upcoming = result is PitchActionDone
                                      ? result.upcomingBookings
                                      : 0;
                                  _showResult(
                                    context,
                                    result,
                                    !paused
                                        ? 'venue.pitches.resumed'.tr(
                                            context: context,
                                            args: [p.name],
                                          )
                                        : upcoming > 0
                                        ? 'venue.pitches.paused_with_bookings'
                                              .tr(
                                                context: context,
                                                args: [
                                                  p.name,
                                                  VenueFormat.number(
                                                    context,
                                                    upcoming,
                                                  ),
                                                ],
                                              )
                                        : 'venue.pitches.paused_toast'.tr(
                                            context: context,
                                            args: [p.name],
                                          ),
                                  );
                                },
                        ),
                        IconButton(
                          tooltip: t('edit'),
                          onPressed: () => edit(VenuePitchModelRef(p.id)),
                          icon: const Icon(Icons.edit_outlined),
                        ),
                      ],
                    ],
                  ),
                ),
                hSpace(10),
              ],
              if (canManage)
                OutlinedButton.icon(
                  onPressed: state.busyId == 'new'
                      ? null
                      : () async {
                          final name = 'venue.pitches.default_name'.tr(
                            context: context,
                            args: [
                              VenueFormat.number(
                                context,
                                state.pitches.length + 1,
                              ),
                            ],
                          );
                          final (result, added) = await cubit.addPitch(name);
                          if (!context.mounted) return;
                          if (result is PitchActionFailed) {
                            _showResult(context, result, '');
                          } else if (added != null) {
                            await edit(VenuePitchModelRef(added.id));
                          }
                        },
                  icon: const Icon(Icons.add_rounded),
                  label: Text(t('add')),
                ),
            ],
          ),
        );
      },
    );
  }
}

/// Which pitch the edit sheet shows; it re-reads it from the cubit.
class VenuePitchModelRef {
  const VenuePitchModelRef(this.id);
  final String id;
}

class _BranchesTab extends StatelessWidget {
  const _BranchesTab({required this.session});

  final VenueSessionReady session;

  @override
  Widget build(BuildContext context) {
    String t(String key) => 'venue.pitches.branches.$key'.tr(context: context);
    final cubit = context.read<VenuePitchesCubit>();
    final sessionCubit = context.read<VenueSessionCubit>();

    return BlocBuilder<VenuePitchesCubit, VenuePitchesState>(
      builder: (context, state) => ListView(
        padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 32.h),
        children: [
          for (final v in session.venues) ...[
            CustomCardWidget(
              padding: EdgeInsets.all(14.r),
              borderRadius: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(v.name, style: AppTextStyles.font15Bold),
                  hSpace(2),
                  Text(
                    '${'venue.pitches.branches.pitch_count'.tr(context: context, args: [VenueFormat.number(context, v.pitches.length)])} · ${v.address}',
                    style: AppTextStyles.font12Regular.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  hSpace(8),
                  if (v.isApproved)
                    SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(t('visible')),
                      subtitle: Text(
                        v.isPublished ? t('visible_on') : t('visible_off'),
                      ),
                      value: v.isPublished,
                      onChanged:
                          state.busyId == v.id ||
                              !session.can(VenuePermissions.venuePublish)
                          ? null
                          : (on) async {
                              final result = await cubit.publishVenue(v.id, on);
                              if (!context.mounted) return;
                              _showResult(
                                context,
                                result,
                                on ? t('published') : t('hidden'),
                              );
                              await sessionCubit.load();
                            },
                    )
                  else ...[
                    Text(
                      t('waiting_approval'),
                      style: AppTextStyles.font12Regular.copyWith(
                        color: AppColors.goldText,
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: TextButton(
                        onPressed: () async {
                          await context.pushNamed<String>(
                            AppRoutes.venueSetup,
                            arguments: v,
                          );
                          await sessionCubit.load();
                        },
                        child: Text(t('complete')),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            hSpace(10),
          ],
          OutlinedButton.icon(
            onPressed: () async {
              final id = await context.pushNamed<String>(AppRoutes.venueSetup);
              await sessionCubit.load(preferVenueId: id);
            },
            icon: const Icon(Icons.add_business_rounded),
            label: Text(t('add')),
          ),
        ],
      ),
    );
  }
}
