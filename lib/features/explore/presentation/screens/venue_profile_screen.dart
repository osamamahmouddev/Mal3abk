import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../widgets/venue_profile_bloc_builder.dart';

class VenueProfileScreen extends HookWidget {
  const VenueProfileScreen({required this.venueId, super.key});

  final String venueId;

  @override
  Widget build(BuildContext context) {
    final selectedTab = useState(0);
    return VenueProfileBlocBuilder(
      venueId: venueId,
      selectedTab: selectedTab.value,
      onTabSelected: (index) => selectedTab.value = index,
    );
  }
}
