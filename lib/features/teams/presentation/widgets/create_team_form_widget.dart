import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/extensions/app_display_extensions.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/bottom_action_bar_widget.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../../../core/widgets/initials_avatar_widget.dart';
import '../../../../core/widgets/plain_note_box_widget.dart';
import '../../../../core/widgets/radio_option_card_widget.dart';
import '../../../reference/data/models/governorate_model.dart';
import '../../data/models/create_team_request_body.dart';
import '../cubit/create_team_cubit.dart';
import 'create_team_location_bloc_builder.dart';
import 'create_team_submit_bloc_builder.dart';

class CreateTeamFormWidget extends HookWidget {
  const CreateTeamFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final nameController = useTextEditingController();
    final bioController = useTextEditingController();
    final name = useValueListenable(nameController);
    final governorate = useMemoized(
      () => ValueNotifier<GovernorateModel?>(null),
    );
    final area = useMemoized(() => ValueNotifier<String?>(null));
    final isPublic = useState(true);
    useEffect(
      () => () {
        governorate.dispose();
        area.dispose();
      },
      const [],
    );
    String t(String key) => 'teams.create.$key'.tr(context: context);

    return Column(
      children: [
        Expanded(
          child: ListView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.fromLTRB(16.w, 18.h, 16.w, 18.h),
            children: [
              Center(
                child: InitialsAvatarWidget(
                  initials: name.text.trim().isEmpty ? '؟' : name.text.initials,
                  color: AppColors.brandRed,
                  size: 76,
                  textStyle: AppTextStyles.font22Bold.copyWith(
                    color: AppColors.white,
                  ),
                ),
              ),
              hSpace(14),
              Text('${t('name')} *', style: AppTextStyles.font14SemiBold),
              hSpace(12),
              CustomTextFormField(
                controller: nameController,
                hintText: t('name_hint'),
                inputFormatters: [LengthLimitingTextInputFormatter(40)],
                style: AppTextStyles.font16Regular,
              ),
              hSpace(14),
              Text(
                '${t('bio')} ${'onboarding.profile_setup.optional'.tr(context: context)}',
                style: AppTextStyles.font14SemiBold,
              ),
              hSpace(12),
              CustomTextFormField(
                controller: bioController,
                hintText: t('bio_hint'),
                minLines: 2,
                maxLines: 3,
              ),
              hSpace(14),
              CreateTeamLocationBlocBuilder(
                governorate: governorate,
                area: area,
              ),
              hSpace(14),
              Text(t('visibility'), style: AppTextStyles.font14SemiBold),
              hSpace(10),
              RadioOptionCardWidget(
                title: t('public'),
                subtitle: t('public_sub'),
                isSelected: isPublic.value,
                onTap: () => isPublic.value = true,
              ),
              hSpace(8),
              RadioOptionCardWidget(
                title: t('private'),
                subtitle: t('private_sub'),
                isSelected: !isPublic.value,
                onTap: () => isPublic.value = false,
              ),
              hSpace(18),
              PlainNoteBoxWidget(text: t('captain_note')),
            ],
          ),
        ),
        BottomActionBarWidget(
          child: CreateTeamSubmitBlocBuilder(
            onSubmit: () => context.read<CreateTeamCubit>().create(
              CreateTeamRequestBody(
                name: nameController.text,
                description: bioController.text,
                governorate: governorate.value?.nameAr ?? '',
                city: governorate.value?.nameAr ?? '',
                district: area.value,
              ),
              isPublic: isPublic.value,
            ),
          ),
        ),
      ],
    );
  }
}
