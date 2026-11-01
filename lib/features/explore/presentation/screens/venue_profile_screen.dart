import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../cubit/venue_profile_cubit.dart';
import '../widgets/venue_profile_bloc_builder.dart';

class VenueProfileScreen extends HookWidget {
  const VenueProfileScreen({this.venueId, super.key});

  final String? venueId;

  @override
  Widget build(BuildContext context) {
    final selectedTab = useState(0);

    useEffect(() {
      final targetId = venueId ?? 'd4f21692-d657-46a4-9961-191d88dccdef';
      context.read<VenueProfileCubit>().loadVenue(targetId);
      return null;
    }, [venueId]);

    return VenueProfileBlocBuilder(
      selectedTab: selectedTab.value,
      onTabSelected: (index) => selectedTab.value = index,
    );
  }
}
