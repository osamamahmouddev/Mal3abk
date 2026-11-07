import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/widgets/app_top_snack_bar.dart';
import '../../../../core/widgets/image_source_sheet_widget.dart';
import '../cubit/avatar_cubit.dart';
import '../cubit/avatar_state.dart';
import 'profile_avatar_picker_widget.dart';

class ProfileAvatarBlocBuilder extends StatelessWidget {
  const ProfileAvatarBlocBuilder({required this.initials, super.key});

  final String initials;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AvatarCubit>();

    Future<void> openOptions(bool hasAvatar) async {
      final choice = await ImageSourceSheetWidget.show(
        context,
        title: 'common.image_source.avatar_title'.tr(context: context),
        subtitle: 'common.image_source.avatar_subtitle'.tr(context: context),
        removeLabel: hasAvatar
            ? 'profile.avatar.remove'.tr(context: context)
            : null,
      );
      switch (choice) {
        case null:
          return;
        case ImageSourceChoice.remove:
          await cubit.remove();
        case ImageSourceChoice.gallery || ImageSourceChoice.camera:
          final file = await ImagePicker().pickImage(
            source: choice == ImageSourceChoice.camera
                ? ImageSource.camera
                : ImageSource.gallery,
            requestFullMetadata: false,
          );
          if (file == null) return;
          await cubit.upload(await file.readAsBytes());
      }
    }

    return BlocConsumer<AvatarCubit, AvatarState>(
      listener: (context, state) {
        if (state case AvatarError(:final message)) {
          HapticFeedback.heavyImpact();
          AppTopSnackBar.showError(context, message.tr(context: context));
        }
      },
      builder: (context, state) => ProfileAvatarPickerWidget(
        initials: initials,
        avatarUrl: state.avatarUrl,
        isUploading: state is AvatarUploading,
        onTap: () => openOptions(state.avatarUrl != null),
      ),
    );
  }
}
