import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/widgets/booking_card_widget.dart';
import '../../../../core/widgets/fade_slide_in_widget.dart';
import '../cubit/my_bookings_cubit.dart';
import '../cubit/my_bookings_state.dart';
import 'my_bookings_fallback_widget.dart';

class MyBookingsBlocBuilder extends StatelessWidget {
  const MyBookingsBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyBookingsCubit, MyBookingsState>(
      builder: (context, state) {
        return switch (state) {
          MyBookingsLoading() => const Center(
            child: CircularProgressIndicator.adaptive(),
          ),
          MyBookingsSuccess(:final data) =>
            data.items.isNotEmpty
                ? ListView.separated(
                    padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 16.h),
                    itemCount: data.items.length,
                    separatorBuilder: (_, _) => vSpace(12),
                    itemBuilder: (context, index) {
                      final booking = data.items[index];
                      final status = _mapStatus(booking.status);
                      final statusText = _statusLabel(booking.status);
                      final venueName = _formatVenueName(booking.venueId);
                      final pitchName = _formatPitchName(booking.pitchId);
                      final formattedDate = _formatDateTime(
                        booking.startUtc,
                        booking.endUtc,
                      );

                      return FadeSlideInWidget(
                        index: index,
                        child: BookingCardWidget(
                          venueName: venueName,
                          pitchName: pitchName,
                          dateTime: formattedDate,
                          bookingCode: booking.reference,
                          status: status,
                          statusText: statusText,
                          depositRowText: 'العربون',
                          depositAmount: '${booking.depositAmount.toInt()} ج.م',
                          primaryActionText:
                              booking.allowedActions.canUploadProof
                              ? 'رفع الإيصال'
                              : null,
                          onPrimaryAction: booking.allowedActions.canUploadProof
                              ? () => Navigator.of(context).pushNamed(
                                  AppRoutes.uploadProof,
                                  arguments: booking.id,
                                )
                              : null,
                          secondaryActionText: 'التفاصيل',
                          onSecondaryAction: () =>
                              Navigator.of(context).pushNamed(
                                AppRoutes.bookingDetails,
                                arguments: booking.id,
                              ),
                          onTap: () => Navigator.of(context).pushNamed(
                            AppRoutes.bookingDetails,
                            arguments: booking.id,
                          ),
                        ),
                      );
                    },
                  )
                : const MyBookingsFallbackWidget(),
          _ => const MyBookingsFallbackWidget(),
        };
      },
    );
  }

  static BookingStatus _mapStatus(dynamic status) {
    final str = status?.toString().toLowerCase() ?? '';
    return switch (str) {
      '4' || 'confirmed' => BookingStatus.confirmed,
      '7' || 'completed' => BookingStatus.completed,
      '6' || 'rejected' => BookingStatus.rejected,
      '5' || 'cancelled' => BookingStatus.cancelled,
      _ => BookingStatus.pendingReview,
    };
  }

  static String _statusLabel(dynamic status) {
    final str = status?.toString().toLowerCase() ?? '';
    return switch (str) {
      '2' || 'pendingdeposit' => 'بانتظار العربون',
      '3' || 'pendingreview' || 'inreview' || 'in_review' => 'قيد المراجعة',
      '4' || 'confirmed' => 'مؤكد',
      '5' || 'cancelled' => 'ملغي',
      '6' || 'rejected' => 'مرفوض',
      '7' || 'completed' => 'مكتمل',
      _ => 'قيد المراجعة',
    };
  }

  static String _formatVenueName(String id) {
    if (id == 'd4f21692-d657-46a4-9961-191d88dccdef') {
      return 'ملعب التجربة';
    }
    if (id == '44444444-4444-4444-4444-444444444444') {
      return 'ملاعب النادي الأهلي';
    }
    return id.contains('-') ? 'ملعب كرة قدم' : id;
  }

  static String _formatPitchName(String id) {
    if (id == 'a567375b-672d-4379-9781-f672effc3d1d') {
      return 'ملعب ١ (خماسي)';
    }
    if (id == 'bedfe9c4-f468-4797-973c-0b4795be4ab4') {
      return 'ملعب ٢ (سباعي)';
    }
    if (id == '55555555-5555-5555-5555-555555555551') {
      return 'ملعب التتش الصغير';
    }
    return id.contains('-') ? 'الملعب الرئيسي' : id;
  }

  static String _formatDateTime(String start, String end) {
    try {
      final s = DateTime.parse(start).toLocal();
      final e = DateTime.parse(end).toLocal();
      final days = [
        'الإثنين',
        'الثلاثاء',
        'الأربعاء',
        'الخميس',
        'الجمعة',
        'السبت',
        'الأحد',
      ];
      final months = [
        'يناير',
        'فبراير',
        'مارس',
        'أبريل',
        'مايو',
        'يونيو',
        'يوليو',
        'أغسطس',
        'سبتمبر',
        'أكتوبر',
        'نوفمبر',
        'ديسمبر',
      ];
      final dayName = days[s.weekday - 1];
      final monthName = months[s.month - 1];
      final sHour = s.hour > 12 ? s.hour - 12 : (s.hour == 0 ? 12 : s.hour);
      final sPeriod = s.hour >= 12 ? 'م' : 'ص';
      final eHour = e.hour > 12 ? e.hour - 12 : (e.hour == 0 ? 12 : e.hour);
      final ePeriod = e.hour >= 12 ? 'م' : 'ص';
      return '$dayName ${s.day} $monthName · ${sHour.toString().padLeft(2, '0')}:00 $sPeriod - ${eHour.toString().padLeft(2, '0')}:00 $ePeriod';
    } catch (_) {
      return '$start - $end';
    }
  }
}
