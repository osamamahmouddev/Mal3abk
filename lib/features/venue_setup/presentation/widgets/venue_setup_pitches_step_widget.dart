import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../../../core/widgets/searchable_picker_sheet_widget.dart';
import '../../../venue_shell/presentation/venue_format.dart';
import '../../../venue_shell/presentation/widgets/venue_section_card_widget.dart';
import '../../data/models/venue_setup_form.dart';
import '../cubit/venue_setup_cubit.dart';
import '../cubit/venue_setup_state.dart';
import 'venue_photo_grid_widget.dart';

/// Step 2: the venue's pitches, each with its surface, size and photos.
class VenueSetupPitchesStepWidget extends HookWidget {
  const VenueSetupPitchesStepWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<VenueSetupCubit>();
    final name = useTextEditingController();
    final turf = useState('ArtificialTurf');
    final capacity = useState(5);
    useListenable(name);
    final lang = context.locale.languageCode;
    String t(String key) => 'venue.setup.pitches.$key'.tr(context: context);

    return BlocBuilder<VenueSetupCubit, VenueSetupState>(
      builder: (context, state) {
        final surface = state.surfaces
            .where((s) => s.code == turf.value)
            .firstOrNull;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              t('intro'),
              style: AppTextStyles.font13Regular.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            hSpace(12),
            for (final p in state.pitches) ...[
              VenueSectionCardWidget(
                title: p.name,
                subtitle: 'venue.setup.pitches.summary'.tr(
                  context: context,
                  args: [
                    VenueFormat.number(context, p.capacity),
                    lang == 'ar'
                        ? p.surfaceArabicDisplayName
                        : p.surfaceDisplayName,
                  ],
                ),
                trailing: IconButton(
                  tooltip: 'venue.setup.pitches.delete'.tr(
                    context: context,
                    args: [p.name],
                  ),
                  onPressed: state.saving
                      ? null
                      : () => cubit.deletePitch(p.id),
                  icon: const Icon(
                    Icons.delete_outline_rounded,
                    color: AppColors.brandRed,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(t('photos'), style: AppTextStyles.font13SemiBold),
                    hSpace(8),
                    VenuePhotoGridWidget(
                      photos: p.photos,
                      busy: state.uploading,
                      onAdd: (bytes) => cubit.uploadPitchPhoto(p.id, bytes),
                      onRemove: (photo) => cubit.removePitchPhoto(p.id, photo),
                    ),
                  ],
                ),
              ),
              hSpace(12),
            ],
            VenueSectionCardWidget(
              title: t('add_title'),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CustomTextFormField(
                    controller: name,
                    labelText: t('name'),
                    hintText: t('name_hint'),
                  ),
                  hSpace(12),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: state.surfaces.isEmpty
                              ? null
                              : () async {
                                  final i =
                                      await SearchablePickerSheetWidget.show(
                                        context,
                                        title: t('surface'),
                                        options: [
                                          for (final s in state.surfaces)
                                            s.nameFor(lang),
                                        ],
                                        searchHint: t('search'),
                                        emptyText: 'venue.shell.no_match'.tr(
                                          context: context,
                                        ),
                                      );
                                  if (i != null) {
                                    turf.value = state.surfaces[i].code;
                                  }
                                },
                          child: Text(
                            '${t('surface')}: ${surface?.nameFor(lang) ?? turf.value}',
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      DropdownButton<int>(
                        value: capacity.value,
                        items: [
                          for (final c in DayHours.capacities)
                            DropdownMenuItem(
                              value: c,
                              child: Text(
                                'venue.setup.pitches.capacity'.tr(
                                  context: context,
                                  args: [VenueFormat.number(context, c)],
                                ),
                              ),
                            ),
                        ],
                        onChanged: (c) => capacity.value = c ?? 5,
                      ),
                    ],
                  ),
                  hSpace(12),
                  Text(t('draft_photos'), style: AppTextStyles.font13SemiBold),
                  hSpace(8),
                  VenuePhotoGridWidget(
                    photos: state.draftPitchPhotos,
                    busy: state.uploading,
                    onAdd: cubit.uploadDraftPitchPhoto,
                    onRemove: cubit.removeDraftPitchPhoto,
                  ),
                  hSpace(14),
                  CustomButton(
                    text: t('add'),
                    height: 48.h,
                    borderRadius: 14,
                    enabled: name.text.trim().isNotEmpty && !state.uploading,
                    isLoading: state.saving,
                    icon: Icon(
                      Icons.add_rounded,
                      size: 18.r,
                      color: AppColors.white,
                    ),
                    textStyle: AppTextStyles.font15Bold.copyWith(
                      color: AppColors.white,
                    ),
                    onTap: () async {
                      final added = await cubit.addPitch(
                        name: name.text,
                        turfType: turf.value,
                        capacity: capacity.value,
                      );
                      if (added) name.clear();
                    },
                  ),
                ],
              ),
            ),
            hSpace(16),
            CustomButton(
              text: t('next'),
              height: 52.h,
              borderRadius: 14,
              textStyle: AppTextStyles.font16Bold.copyWith(
                color: AppColors.white,
              ),
              onTap: () => cubit.goTo(3),
            ),
          ],
        );
      },
    );
  }
}
