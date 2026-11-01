import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/profile_cubit.dart';
import '../cubit/profile_state.dart';
import 'profile_header_card_widget.dart';

class ProfileHeaderBlocBuilder extends StatelessWidget {
  const ProfileHeaderBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return switch (state) {
          ProfileSuccess(:final profile) => ProfileHeaderCardWidget(
            name: profile.fullName,
            subtitle: [
              if (profile.city != null && profile.city!.isNotEmpty)
                profile.city,
              if (profile.area != null && profile.area!.isNotEmpty)
                profile.area,
              if (profile.positions.isNotEmpty) profile.positions.join(' · '),
              if (profile.skillLevel != null && profile.skillLevel!.isNotEmpty)
                profile.skillLevel,
            ].join(' · '),
            initials: _getInitials(profile.fullName),
          ),
          _ => const ProfileHeaderCardWidget(),
        };
      },
    );
  }

  static String _getInitials(String? name) {
    if (name == null || name.trim().isEmpty) return 'م';
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}';
    }
    return parts[0][0];
  }
}
