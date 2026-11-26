import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/utils/cairo_time.dart';
import '../../../venue_calendar/presentation/cubit/venue_calendar_cubit.dart';
import '../../../venue_setup/presentation/widgets/week_hours_editor_widget.dart';
import '../../../venue_shell/data/models/venue_model.dart';
import '../../../venue_shell/presentation/venue_format.dart';
import '../../../venue_shell/presentation/widgets/venue_section_card_widget.dart';
import '../cubit/venue_pricing_cubit.dart';

/// "Try a price": what the rules charge for a pitch, day, time and length.
class PricePreviewCardWidget extends HookWidget {
  const PricePreviewCardWidget({required this.venue, super.key});

  final VenueModel venue;

  static const _hours = [1.0, 1.5, 2.0, 3.0];

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<VenuePricingCubit>();
    final pitchId = useState(venue.pitches.first.id);
    final date = useState(CairoTime.today());
    final time = useState('20:00');
    final hours = useState(1.0);
    final rulesCount = context.select<VenuePricingCubit, int>(
      (c) => c.state.rules.length,
    );
    String t(String key) => 'venue.pricing.preview.$key'.tr(context: context);

    useEffect(() {
      final parts = time.value.split(':').map(int.parse).toList();
      final start = VenueCalendarCubit.dayStartUtc(
        date.value,
      ).add(Duration(hours: parts[0], minutes: parts[1]));
      cubit.preview(
        pitchId: pitchId.value,
        startUtc: start,
        endUtc: start.add(Duration(minutes: (hours.value * 60).round())),
      );
      return null;
    }, [pitchId.value, date.value, time.value, hours.value, rulesCount]);

    return VenueSectionCardWidget(
      title: t('title'),
      child: BlocBuilder<VenuePricingCubit, VenuePricingState>(
        buildWhen: (a, b) =>
            a.quote != b.quote ||
            a.quoting != b.quoting ||
            a.quoteError != b.quoteError,
        builder: (context, state) => Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButton<String>(
              isExpanded: true,
              value: pitchId.value,
              items: [
                for (final p in venue.pitches)
                  DropdownMenuItem(value: p.id, child: Text(p.name)),
              ],
              onChanged: (v) => pitchId.value = v ?? pitchId.value,
            ),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: date.value,
                        firstDate: DateTime(date.value.year - 1),
                        lastDate: DateTime(date.value.year + 1, 12, 31),
                      );
                      if (picked != null) {
                        date.value = DateTime(
                          picked.year,
                          picked.month,
                          picked.day,
                        );
                      }
                    },
                    child: Text(VenueFormat.day(context, date.value)),
                  ),
                ),
                Expanded(
                  child: HalfHourTimeDropdownWidget(
                    value: time.value,
                    onChanged: (v) => time.value = v,
                  ),
                ),
                SizedBox(width: 8.w),
                DropdownButton<double>(
                  value: hours.value,
                  items: [
                    for (final h in _hours)
                      DropdownMenuItem(
                        value: h,
                        child: Text(
                          'venue.pricing.preview.hours'.tr(
                            context: context,
                            args: [VenueFormat.number(context, h)],
                          ),
                        ),
                      ),
                  ],
                  onChanged: (v) => hours.value = v ?? 1,
                ),
              ],
            ),
            hSpace(8),
            if (state.quoting)
              const LinearProgressIndicator(minHeight: 2)
            else if (state.quoteError case final e?)
              Text(
                e.tr(context: context),
                style: AppTextStyles.font12SemiBold.copyWith(
                  color: AppColors.redText,
                ),
              )
            else if (state.quote case final q?) ...[
              _Line(
                t('subtotal'),
                VenueFormat.money(context, q.subtotal, q.currency),
              ),
              if (q.discount > 0)
                _Line(
                  q.discountRule ?? t('discount'),
                  '− ${VenueFormat.money(context, q.discount, q.currency)}',
                ),
              _Line(
                t('total'),
                VenueFormat.money(context, q.total, q.currency),
                bold: true,
              ),
              _Line(
                t('deposit'),
                VenueFormat.money(context, q.deposit, q.currency),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _Line extends StatelessWidget {
  const _Line(this.label, this.value, {this.bold = false});

  final String label;
  final String value;
  final bool bold;

  @override
  Widget build(BuildContext context) {
    final style = bold ? AppTextStyles.font15Bold : AppTextStyles.font13Regular;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 3.h),
      child: Row(
        children: [
          Expanded(child: Text(label, style: style)),
          Text(value, style: style),
        ],
      ),
    );
  }
}
