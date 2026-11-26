import 'package:json_annotation/json_annotation.dart';

part 'price_rule_model.g.dart';

/// One pricing rule (`PriceRuleDto`).
@JsonSerializable(createToJson: false)
class PriceRuleModel {
  const PriceRuleModel({
    required this.id,
    required this.kind,
    required this.adjustment,
    required this.name,
    this.pitchId,
    this.amount,
    this.currency = 'EGP',
    this.percent,
    this.days,
    this.startTime,
    this.endTime,
    this.startDate,
    this.endDate,
    this.minDurationMinutes,
    this.isActive = true,
  });

  final String id;
  final String? pitchId;

  /// `Base`, `Peak`, `Weekend`, `Holiday`, `SpecialDate`, `Discount`.
  final String kind;

  /// `FixedHourlyRate`, `Percentage`, `FixedAmountOff`.
  final String adjustment;
  final String name;
  final double? amount;
  final String currency;
  final double? percent;

  /// .NET day names: `Sunday` … `Saturday`.
  final List<String>? days;
  final String? startTime;
  final String? endTime;
  final String? startDate;
  final String? endDate;
  final int? minDurationMinutes;
  final bool isActive;

  factory PriceRuleModel.fromJson(Map<String, dynamic> json) =>
      _$PriceRuleModelFromJson(json);
}

/// A price the rules give one slot (`PriceQuoteSnapshot`, the part shown).
class PriceQuoteModel {
  const PriceQuoteModel({
    required this.subtotal,
    required this.discount,
    required this.total,
    required this.deposit,
    this.discountRule,
    this.currency = 'EGP',
  });

  final double subtotal;
  final double discount;
  final String? discountRule;
  final double total;
  final double deposit;
  final String currency;

  factory PriceQuoteModel.fromJson(Map<String, dynamic> json) {
    double n(String key) => (json[key] as num?)?.toDouble() ?? 0;
    return PriceQuoteModel(
      subtotal: n('subtotal'),
      discount: n('discount'),
      discountRule: json['discountRule'] as String?,
      total: n('total'),
      deposit: n('deposit'),
      currency: json['currency'] as String? ?? 'EGP',
    );
  }
}

/// The editor's draft of a rule, sent as `PriceRuleApiRequest`.
class PriceRuleDraft {
  const PriceRuleDraft({
    required this.kind,
    required this.adjustment,
    required this.name,
    this.id,
    this.pitchId,
    this.value = '',
    this.days = const [],
    this.startTime = '',
    this.endTime = '',
    this.startDate = '',
    this.endDate = '',
    this.minDurationMinutes = '',
    this.isActive = true,
  });

  final String? id;
  final String kind;
  final String adjustment;
  final String? pitchId;
  final String name;
  final String value;

  /// .NET day numbers (Sunday = 0).
  final List<int> days;
  final String startTime;
  final String endTime;
  final String startDate;
  final String endDate;
  final String minDurationMinutes;
  final bool isActive;

  static const List<String> kinds = [
    'Base',
    'Peak',
    'Weekend',
    'Holiday',
    'SpecialDate',
    'Discount',
  ];
  static const List<String> adjustments = [
    'FixedHourlyRate',
    'Percentage',
    'FixedAmountOff',
  ];
  static const Map<String, List<String>> allowed = {
    'Base': ['FixedHourlyRate'],
    'Peak': ['FixedHourlyRate', 'Percentage'],
    'Weekend': ['FixedHourlyRate', 'Percentage'],
    'Holiday': ['FixedHourlyRate', 'Percentage'],
    'SpecialDate': ['FixedHourlyRate', 'Percentage'],
    'Discount': ['Percentage', 'FixedAmountOff'],
  };
  static const List<String> dayNames = [
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
  ];

  bool get isDiscount => kind == 'Discount';
  bool get isPercent => adjustment == 'Percentage';

  /// A new rule of [kind]; [defaultName] is its translated label.
  factory PriceRuleDraft.empty(String kind, String defaultName) =>
      PriceRuleDraft(
        kind: kind,
        adjustment: allowed[kind]!.first,
        name: defaultName,
        days: kind == 'Weekend' ? const [4, 5] : const [],
        startTime: kind == 'Peak' ? '18:00' : '',
        endTime: kind == 'Peak' ? '00:00' : '',
      );

  factory PriceRuleDraft.discount({
    required String name,
    required String today,
    required String weekLater,
  }) => PriceRuleDraft(
    kind: 'Discount',
    adjustment: 'Percentage',
    name: name,
    value: '15',
    startDate: today,
    endDate: weekLater,
  );

  factory PriceRuleDraft.fromRule(PriceRuleModel r) => PriceRuleDraft(
    id: r.id,
    kind: r.kind,
    adjustment: r.adjustment,
    pitchId: r.pitchId,
    name: r.name,
    value: _number(r.adjustment == 'Percentage' ? r.percent : r.amount),
    days: [
      for (final d in r.days ?? const <String>[])
        if (dayNames.contains(d)) dayNames.indexOf(d),
    ],
    startTime: r.startTime?.substring(0, 5) ?? '',
    endTime: r.endTime?.substring(0, 5) ?? '',
    startDate: r.startDate ?? '',
    endDate: r.endDate ?? '',
    minDurationMinutes: r.minDurationMinutes?.toString() ?? '',
    isActive: r.isActive,
  );

  static String _number(double? v) {
    if (v == null) return '';
    return v == v.roundToDouble() ? v.toInt().toString() : v.toString();
  }

  PriceRuleDraft copyWith({
    String? kind,
    String? adjustment,
    String? Function()? pitchId,
    String? name,
    String? value,
    List<int>? days,
    String? startTime,
    String? endTime,
    String? startDate,
    String? endDate,
    String? minDurationMinutes,
    bool? isActive,
  }) => PriceRuleDraft(
    id: id,
    kind: kind ?? this.kind,
    adjustment: adjustment ?? this.adjustment,
    pitchId: pitchId != null ? pitchId() : this.pitchId,
    name: name ?? this.name,
    value: value ?? this.value,
    days: days ?? this.days,
    startTime: startTime ?? this.startTime,
    endTime: endTime ?? this.endTime,
    startDate: startDate ?? this.startDate,
    endDate: endDate ?? this.endDate,
    minDurationMinutes: minDurationMinutes ?? this.minDurationMinutes,
    isActive: isActive ?? this.isActive,
  );

  /// The localization key of what's wrong, or null when it can be saved.
  String? get error {
    final v = double.tryParse(value.trim());
    if (name.trim().isEmpty) {
      return isDiscount
          ? 'venue.pricing.errors.discount_name'
          : 'venue.pricing.errors.name';
    }
    if (v == null) {
      return isDiscount
          ? 'venue.pricing.errors.discount_value'
          : 'venue.pricing.errors.value';
    }
    if (isPercent && isDiscount && (v < 1 || v > 100)) {
      return 'venue.pricing.errors.discount_percent_range';
    }
    if (isPercent && !isDiscount && (v == 0 || v < -90 || v > 300)) {
      return 'venue.pricing.errors.percent_range';
    }
    if (!isPercent && v <= 0) return 'venue.pricing.errors.positive';
    if (kind == 'SpecialDate' && (startDate.isEmpty || endDate.isEmpty)) {
      return 'venue.pricing.errors.dates_required';
    }
    if (startDate.isNotEmpty &&
        endDate.isNotEmpty &&
        endDate.compareTo(startDate) < 0) {
      return 'venue.pricing.errors.dates_order';
    }
    if (startTime.isEmpty != endTime.isEmpty) {
      return 'venue.pricing.errors.hours_pair';
    }
    return null;
  }

  Map<String, dynamic> toJson() {
    final v = double.tryParse(value.trim()) ?? 0;
    final conditional = kind != 'Base';
    String? time(String t) => conditional && t.isNotEmpty ? '$t:00' : null;
    String? date(String d) => conditional && d.isNotEmpty ? d : null;
    return {
      'kind': kinds.indexOf(kind),
      'adjustment': adjustments.indexOf(adjustment),
      'pitchId': pitchId,
      'name': name.trim(),
      'amount': isPercent ? null : v,
      'percent': isPercent ? v : null,
      'days': conditional && days.isNotEmpty ? days : null,
      'startTime': time(startTime),
      'endTime': time(endTime),
      'startDate': date(startDate),
      'endDate': date(endDate),
      'minDurationMinutes': isDiscount && minDurationMinutes.isNotEmpty
          ? int.tryParse(minDurationMinutes)
          : null,
      'isActive': isActive,
    };
  }
}
