import 'localized_item_model.dart';

/// Whitelisted explore filter values; the server rejects any other code.
class FilterOptionsModel {
  const FilterOptionsModel({
    required this.pitchTypes,
    required this.surfaces,
    required this.facilities,
  });

  final List<LocalizedItemModel> pitchTypes;
  final List<LocalizedItemModel> surfaces;
  final List<LocalizedItemModel> facilities;
}
