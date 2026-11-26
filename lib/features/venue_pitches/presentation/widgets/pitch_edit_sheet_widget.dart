import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/app_top_snack_bar.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_dialog_widget.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../../../core/widgets/searchable_picker_sheet_widget.dart';
import '../../../../core/widgets/sheet_drag_handle_widget.dart';
import '../../../venue_setup/data/models/venue_setup_form.dart';
import '../../../venue_setup/presentation/widgets/venue_photo_grid_widget.dart';
import '../../../venue_shell/presentation/venue_format.dart';
import '../cubit/venue_pitches_cubit.dart';
import '../cubit/venue_pitches_state.dart';

/// Edits one pitch: name, size, surface, length and width, photos, delete.
class PitchEditSheetWidget extends HookWidget {
  const PitchEditSheetWidget({required this.pitchId, super.key});

  final String pitchId;

  static Future<void> show(
    BuildContext context, {
    required VenuePitchesCubit cubit,
    required String pitchId,
  }) => showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: Colors.transparent,
    builder: (_) => BlocProvider.value(
      value: cubit,
      child: PitchEditSheetWidget(pitchId: pitchId),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<VenuePitchesCubit>();
    final initial = cubit.state.pitches.firstWhere((p) => p.id == pitchId);
    final name = useTextEditingController(text: initial.name);
    final length = useTextEditingController(
      text: initial.lengthMeters?.toString() ?? '',
    );
    final width = useTextEditingController(
      text: initial.widthMeters?.toString() ?? '',
    );
    final capacity = useState(initial.capacity);
    final turf = useState(initial.turfType);
    final lang = context.locale.languageCode;
    String t(String key) => 'venue.pitches.$key'.tr(context: context);

    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 20.h),
        child: BlocBuilder<VenuePitchesCubit, VenuePitchesState>(
          builder: (context, state) {
            final pitch = state.pitches
                .where((p) => p.id == pitchId)
                .firstOrNull;
            if (pitch == null) return const SizedBox.shrink();
            final surface = state.surfaces
                .where((s) => s.code == turf.value)
                .firstOrNull;
            final busy = state.busyId == pitchId;
            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Center(child: SheetDragHandleWidget()),
                  hSpace(12),
                  Text(
                    'venue.pitches.edit_title'.tr(
                      context: context,
                      args: [pitch.name],
                    ),
                    style: AppTextStyles.font18Bold,
                  ),
                  hSpace(14),
                  CustomTextFormField(
                    controller: name,
                    labelText: 'venue.setup.pitches.name'.tr(context: context),
                    hintText: 'venue.setup.pitches.name_hint'.tr(
                      context: context,
                    ),
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
                                        title: 'venue.setup.pitches.surface'.tr(
                                          context: context,
                                        ),
                                        options: [
                                          for (final s in state.surfaces)
                                            s.nameFor(lang),
                                        ],
                                        searchHint: 'venue.setup.pitches.search'
                                            .tr(context: context),
                                        emptyText: 'venue.shell.no_match'.tr(
                                          context: context,
                                        ),
                                      );
                                  if (i != null) {
                                    turf.value = state.surfaces[i].code;
                                  }
                                },
                          child: Text(
                            '${'venue.setup.pitches.surface'.tr(context: context)}: ${surface?.nameFor(lang) ?? turf.value}',
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      DropdownButton<int>(
                        value: DayHours.capacities.contains(capacity.value)
                            ? capacity.value
                            : null,
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
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextFormField(
                          controller: length,
                          labelText: t('length'),
                          hintText: '40',
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: CustomTextFormField(
                          controller: width,
                          labelText: t('width'),
                          hintText: '20',
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                  hSpace(14),
                  Text(
                    'venue.setup.pitches.photos'.tr(context: context),
                    style: AppTextStyles.font13SemiBold,
                  ),
                  hSpace(8),
                  VenuePhotoGridWidget(
                    photos: pitch.photos,
                    busy: state.uploading || busy,
                    onAdd: (bytes) async {
                      final result = await cubit.addPhoto(pitch, bytes);
                      if (!context.mounted) return;
                      if (result case PitchActionFailed(:final message)) {
                        AppTopSnackBar.showError(
                          context,
                          message.tr(context: context),
                        );
                      } else {
                        AppTopSnackBar.showSuccess(context, t('photo_added'));
                      }
                    },
                    onRemove: (photo) => cubit.removePhoto(pitch, photo),
                  ),
                  hSpace(18),
                  CustomButton(
                    text: t('save'),
                    height: 50.h,
                    borderRadius: 14,
                    isLoading: busy,
                    textStyle: AppTextStyles.font15Bold.copyWith(
                      color: AppColors.white,
                    ),
                    onTap: () async {
                      final navigator = Navigator.of(context);
                      final result = await cubit.save(
                        pitch,
                        name: name.text,
                        turfType: turf.value,
                        capacity: capacity.value,
                        lengthMeters: double.tryParse(length.text.trim()),
                        widthMeters: double.tryParse(width.text.trim()),
                      );
                      if (!context.mounted) return;
                      if (result case PitchActionFailed(:final message)) {
                        AppTopSnackBar.showError(
                          context,
                          message.tr(context: context),
                        );
                        return;
                      }
                      navigator.pop();
                      AppTopSnackBar.showSuccess(
                        context,
                        'venue.pitches.saved'.tr(
                          context: context,
                          args: [name.text.trim()],
                        ),
                      );
                    },
                  ),
                  hSpace(8),
                  CustomButton(
                    text: t('delete'),
                    type: CustomButtonType.ghost,
                    foregroundColor: AppColors.brandRed,
                    height: 44.h,
                    onTap: () => CustomDialogWidget.show<void>(
                      context: context,
                      title: 'venue.pitches.delete_confirm_title'.tr(
                        context: context,
                        args: [pitch.name],
                      ),
                      description: t('delete_confirm_body'),
                      primaryActionText: t('delete'),
                      secondaryActionText: 'common.cancel'.tr(context: context),
                      isDestructive: true,
                      onPrimaryAction: () async {
                        final navigator = Navigator.of(context);
                        Navigator.of(context, rootNavigator: true).pop();
                        final result = await cubit.delete(pitch);
                        if (!context.mounted) return;
                        if (result case PitchActionFailed(:final message)) {
                          AppTopSnackBar.showError(
                            context,
                            message.tr(context: context),
                          );
                          return;
                        }
                        navigator.pop();
                        AppTopSnackBar.showSuccess(context, t('deleted'));
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
