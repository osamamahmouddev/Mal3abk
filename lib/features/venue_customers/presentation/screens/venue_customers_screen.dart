import 'dart:convert';

import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/alert_banner_widget.dart';
import '../../../../core/widgets/app_badge_widget.dart';
import '../../../../core/widgets/custom_app_bar_widget.dart';
import '../../../../core/widgets/custom_card_widget.dart';
import '../../../../core/widgets/custom_search_field_widget.dart';
import '../../../../core/widgets/shimmer_list_skeleton_widget.dart';
import '../../../venue_bookings/presentation/widgets/venue_bookings_csv.dart';
import '../../../venue_calendar/data/models/venue_customer_model.dart';
import '../../../venue_shell/presentation/cubit/venue_session_cubit.dart';
import '../../../venue_shell/presentation/cubit/venue_session_state.dart';
import '../../../venue_shell/presentation/venue_format.dart';
import '../../../venue_shell/presentation/venue_page_route.dart';
import '../../domain/repos/venue_customers_repo.dart';
import '../cubit/venue_customers_cubit.dart';
import 'venue_customer_detail_screen.dart';

/// Customers who booked at this venue, with search, filters, export and
/// each customer's profile.
class VenueCustomersScreen extends StatelessWidget {
  const VenueCustomersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final session = context.watch<VenueSessionCubit>().state;
    if (session is! VenueSessionReady) return const SizedBox.shrink();
    String t(String key) => 'venue.customers.$key'.tr(context: context);
    return BlocProvider<VenueCustomersCubit>(
      create: (_) => VenueCustomersCubit(
        venueCustomersRepo: sl<VenueCustomersRepo>(),
        venueId: session.venue.id,
      )..load(),
      child: Builder(
        builder: (context) {
          final cubit = context.read<VenueCustomersCubit>();
          return Scaffold(
            backgroundColor: AppColors.pageBackground,
            appBar: CustomAppBarWidget(
              title: t('title'),
              actions: [
                IconButton(
                  tooltip: t('export'),
                  icon: const Icon(Icons.ios_share_rounded),
                  onPressed: () => _export(context, cubit.state.visible),
                ),
              ],
            ),
            body: BlocBuilder<VenueCustomersCubit, VenueCustomersState>(
              builder: (context, state) => Column(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          t('privacy'),
                          style: AppTextStyles.font12Regular.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                        hSpace(8),
                        CustomSearchFieldWidget(
                          hintText: t('search'),
                          onChanged: cubit.setSearch,
                        ),
                        hSpace(8),
                        Wrap(
                          spacing: 8.w,
                          children: [
                            for (final f in VenueCustomersFilter.values)
                              ChoiceChip(
                                label: Text(t('filter_${f.name}')),
                                selected: state.filter == f,
                                onSelected: (_) => cubit.setFilter(f),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: state.loading && state.items.isEmpty
                        ? const ShimmerListSkeletonWidget(itemHeight: 76)
                        : RefreshIndicator(
                            onRefresh: cubit.load,
                            child: ListView(
                              padding: EdgeInsets.fromLTRB(
                                16.w,
                                12.h,
                                16.w,
                                32.h,
                              ),
                              children: [
                                if (state.error case final e?)
                                  AlertBannerWidget(
                                    type: AlertBannerType.error,
                                    message: e.tr(context: context),
                                    actionText: 'common.retry'.tr(
                                      context: context,
                                    ),
                                    onActionTap: cubit.load,
                                  ),
                                if (state.visible.isEmpty &&
                                    state.error == null)
                                  Padding(
                                    padding: EdgeInsets.all(24.r),
                                    child: Text(
                                      state.search.isEmpty
                                          ? t('empty')
                                          : t('no_match'),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                for (final c in state.visible) ...[
                                  _CustomerTile(
                                    customer: c,
                                    onTap: () => openVenuePage<void>(
                                      context,
                                      name: '/venue/customer',
                                      builder: (_) => VenueCustomerDetailScreen(
                                        customer: c,
                                      ),
                                    ),
                                  ),
                                  hSpace(8),
                                ],
                                if (state.pages > 1)
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      TextButton(
                                        onPressed: state.page > 1
                                            ? () => cubit.load(
                                                page: state.page - 1,
                                              )
                                            : null,
                                        child: Text(t('previous')),
                                      ),
                                      Text(
                                        'venue.customers.page_of'.tr(
                                          context: context,
                                          args: [
                                            VenueFormat.number(
                                              context,
                                              state.page,
                                            ),
                                            VenueFormat.number(
                                              context,
                                              state.pages,
                                            ),
                                          ],
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: state.page < state.pages
                                            ? () => cubit.load(
                                                page: state.page + 1,
                                              )
                                            : null,
                                        child: Text(t('next')),
                                      ),
                                    ],
                                  ),
                              ],
                            ),
                          ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _export(
    BuildContext context,
    List<VenueCustomerModel> list,
  ) async {
    String t(String key) => 'venue.customers.csv.$key'.tr(context: context);
    final rows = [
      [
        t('name'),
        t('phone'),
        t('type'),
        t('bookings'),
        t('completed'),
        t('cancelled'),
        t('no_shows'),
        t('spent'),
        t('last'),
      ],
      for (final c in list)
        [
          c.name,
          c.phone ?? '',
          c.isRegisteredPlayer ? t('player') : t('manual'),
          '${c.totalBookings}',
          '${c.completed}',
          '${c.cancelled}',
          '${c.noShows}',
          '${c.totalSpent}',
          c.lastBookingUtc == null
              ? ''
              : VenueFormat.dateTime(context, c.lastBookingUtc!),
        ],
    ];
    final csv = rows
        .map((r) => r.map(VenueBookingsCsv.cell).join(','))
        .join('\r\n');
    await SharePlus.instance.share(
      ShareParams(
        files: [
          XFile.fromData(
            utf8.encode('﻿$csv'),
            mimeType: 'text/csv',
            name: 'customers.csv',
          ),
        ],
        fileNameOverrides: const ['customers.csv'],
      ),
    );
  }
}

class _CustomerTile extends StatelessWidget {
  const _CustomerTile({required this.customer, required this.onTap});

  final VenueCustomerModel customer;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = customer;
    String t(String key) => 'venue.customers.$key'.tr(context: context);
    final (tag, type) = c.noShows > 0
        ? (t('tag_no_show'), AppBadgeType.error)
        : c.totalBookings >= 10
        ? (t('tag_regular'), AppBadgeType.success)
        : (t('tag_new'), AppBadgeType.accent);
    return CustomCardWidget(
      padding: EdgeInsets.all(12.r),
      borderRadius: 14,
      onTap: onTap,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  c.name.isEmpty ? t('customer') : c.name,
                  style: AppTextStyles.font14Bold,
                ),
                Text(
                  c.phone ?? (c.isRegisteredPlayer ? t('app_player') : ''),
                  textDirection: TextDirection.ltr,
                  style: AppTextStyles.font12Regular.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                Text(
                  'venue.customers.summary'.tr(
                    context: context,
                    args: [
                      VenueFormat.number(context, c.totalBookings),
                      VenueFormat.number(context, c.cancelled),
                      VenueFormat.number(context, c.noShows),
                    ],
                  ),
                  style: AppTextStyles.font11Regular.copyWith(
                    color: AppColors.textMuted,
                  ),
                ),
              ],
            ),
          ),
          AppBadgeWidget(text: tag, type: type),
        ],
      ),
    );
  }
}
