import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_assets.dart';
import '../../../../core/utils/cairo_time.dart';
import '../../../../core/widgets/app_top_snack_bar.dart';
import '../../data/models/player_booking_detail_model.dart';
import 'booking_quick_action_widget.dart';

class BookingPassActionsWidget extends StatelessWidget {
  const BookingPassActionsWidget({required this.booking, super.key});

  final PlayerBookingDetailModel booking;

  @override
  Widget build(BuildContext context) {
    final lang = context.locale.languageCode;
    final venue = booking.venue;
    final title = [?venue?.name, ?booking.pitchName].join(' · ');
    final when =
        '${CairoTime.dayAndTime(booking.startAt, lang)} – ${CairoTime.time(booking.endAt, lang)}';

    Future<void> directions() async {
      HapticFeedback.selectionClick();
      final uri = Uri.https('www.google.com', '/maps/dir/', {
        'api': '1',
        'destination': '${venue!.latitude},${venue.longitude}',
      });
      final opened = await launchUrl(uri, mode: LaunchMode.externalApplication);
      if (!opened && context.mounted) {
        AppTopSnackBar.showError(
          context,
          'booking.pass.maps_unavailable'.tr(context: context),
        );
      }
    }

    Future<void> addToCalendar() async {
      HapticFeedback.selectionClick();
      await Add2Calendar.addEvent2Cal(
        Event(
          title: title,
          description: 'booking.pass.calendar_note'.tr(
            context: context,
            args: [booking.reference],
          ),
          location: venue?.address,
          startDate: booking.startAt,
          endDate: booking.endAt,
          timeZone: 'Africa/Cairo',
        ),
      );
    }

    Future<void> share() async {
      HapticFeedback.selectionClick();
      await SharePlus.instance.share(
        ShareParams(
          text: 'booking.pass.share_text'.tr(
            context: context,
            args: [title, when, venue?.address ?? '', booking.reference],
          ),
        ),
      );
    }

    final actions = [
      if (venue?.hasLocation ?? false)
        (AppAssets.icDirections, 'directions', directions),
      (AppAssets.icCalendar, 'calendar', addToCalendar),
      (AppAssets.icShare, 'share', share),
    ];

    return Row(
      children: [
        for (final (i, (icon, key, onTap)) in actions.indexed) ...[
          if (i > 0) vSpace(8),
          Expanded(
            child: BookingQuickActionWidget(
              iconAsset: icon,
              label: 'booking.pass.$key'.tr(context: context),
              onTap: onTap,
            ),
          ),
        ],
      ],
    );
  }
}
