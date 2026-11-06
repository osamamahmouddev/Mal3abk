import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/app_top_snack_bar.dart';
import '../cubit/avatar_cubit.dart';
import '../cubit/avatar_state.dart';
import 'profile_avatar_picker_widget.dart';

class ProfileAvatarBlocBuilder extends StatelessWidget {
  const ProfileAvatarBlocBuilder({required this.initials, super.key});

  final String initials;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AvatarCubit>();

    Future<void> pick(ImageSource source) async {
      Navigator.of(context).pop();
      final file = await ImagePicker().pickImage(
        source: source,
        requestFullMetadata: false,
      );
      if (file == null) return;
      await cubit.upload(await file.readAsBytes());
    }

    void openOptions(bool hasAvatar) {
      HapticFeedback.selectionClick();
      showModalBottomSheet<void>(
        context: context,
        backgroundColor: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        builder: (sheetContext) => SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library_rounded),
                title: Text('profile.avatar.gallery'.tr(context: context)),
                onTap: () => pick(ImageSource.gallery),
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera_rounded),
                title: Text('profile.avatar.camera'.tr(context: context)),
                onTap: () => pick(ImageSource.camera),
              ),
              if (hasAvatar)
                ListTile(
                  leading: const Icon(
                    Icons.delete_outline_rounded,
                    color: AppColors.redText,
                  ),
                  title: Text(
                    'profile.avatar.remove'.tr(context: context),
                    style: AppTextStyles.font15SemiBold.copyWith(
                      color: AppColors.redText,
                    ),
                  ),
                  onTap: () {
                    Navigator.of(sheetContext).pop();
                    cubit.remove();
                  },
                ),
            ],
          ),
        ),
      );
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
