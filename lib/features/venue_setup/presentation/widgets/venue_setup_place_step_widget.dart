import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/location/location_service.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/utils/egyptian_phone_input_formatter.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../../../core/widgets/searchable_picker_sheet_widget.dart';
import '../../../venue_shell/presentation/widgets/venue_section_card_widget.dart';
import '../../data/models/venue_setup_form.dart';
import '../cubit/venue_setup_cubit.dart';
import '../cubit/venue_setup_state.dart';
import 'venue_photo_grid_widget.dart';

/// Step 1: the place's name, governorate and area, contact number, address,
/// location on the map, description, facilities and photos.
class VenueSetupPlaceStepWidget extends HookWidget {
  const VenueSetupPlaceStepWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<VenueSetupCubit>();
    final initial = cubit.state.venue;
    final name = useTextEditingController(text: initial?.name ?? '');
    final phone = useTextEditingController(text: initial?.phoneNumber ?? '');
    final address = useTextEditingController(text: initial?.address ?? '');
    final area = useTextEditingController(text: initial?.area ?? '');
    final description = useTextEditingController(
      text: initial?.description ?? '',
    );
    final lat = useTextEditingController(
      text: initial?.latitude?.toStringAsFixed(6) ?? '',
    );
    final lng = useTextEditingController(
      text: initial?.longitude?.toStringAsFixed(6) ?? '',
    );
    final paste = useTextEditingController();
    final city = useState(initial?.city ?? '');
    final facilities = useState<List<String>>(initial?.facilities ?? const []);
    final locationNote = useState<(bool, String)?>(null);
    final locating = useState(false);
    final customArea = useState(false);
    // Rebuild on every keystroke so "save" enables as the form fills.
    useListenable(Listenable.merge([name, phone, address, area, lat, lng]));
    String t(String key) => 'venue.setup.place.$key'.tr(context: context);

    VenueSetupForm form() => VenueSetupForm(
      name: name.text,
      city: city.value,
      area: area.text,
      phoneNumber: phone.text,
      address: address.text,
      description: description.text,
      facilities: facilities.value,
      latitude: double.tryParse(lat.text.trim()),
      longitude: double.tryParse(lng.text.trim()),
    );

    void setPoint(double la, double lo) {
      lat.text = la.toStringAsFixed(6);
      lng.text = lo.toStringAsFixed(6);
    }

    return BlocBuilder<VenueSetupCubit, VenueSetupState>(
      builder: (context, state) {
        final governorate = state.governorates
            .where((g) => g.nameAr == city.value)
            .firstOrNull;
        final current = form();
        final la = current.latitude;
        final lo = current.longitude;
        final outside =
            la != null && lo != null && !VenueSetupForm.inEgypt(la, lo);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            VenueSectionCardWidget(
              title: t('basics'),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CustomTextFormField(
                    controller: name,
                    labelText: t('name'),
                    hintText: t('name_hint'),
                  ),
                  hSpace(12),
                  _Picker(
                    label: t('governorate'),
                    value: city.value.isEmpty ? t('choose') : city.value,
                    onTap: () async {
                      final i = await SearchablePickerSheetWidget.show(
                        context,
                        title: t('governorate'),
                        options: [for (final g in state.governorates) g.nameAr],
                        searchHint: t('search'),
                        emptyText: 'venue.shell.no_match'.tr(context: context),
                      );
                      if (i == null) return;
                      city.value = state.governorates[i].nameAr;
                      customArea.value = false;
                      area.clear();
                    },
                  ),
                  hSpace(12),
                  if (governorate != null &&
                      governorate.areas.isNotEmpty &&
                      !customArea.value)
                    _Picker(
                      label: t('area'),
                      value: area.text.isEmpty ? t('choose') : area.text,
                      onTap: () async {
                        final areas = governorate.areas;
                        final i = await SearchablePickerSheetWidget.show(
                          context,
                          title: t('area'),
                          options: [for (final a in areas) a.nameAr],
                          searchHint: t('search'),
                          emptyText: 'venue.shell.no_match'.tr(
                            context: context,
                          ),
                          extraOption: t('area_other'),
                        );
                        if (i == null) return;
                        if (i >= areas.length) {
                          area.clear();
                          customArea.value = true;
                          return;
                        }
                        area.text = areas[i].nameAr;
                      },
                    )
                  else
                    CustomTextFormField(
                      controller: area,
                      labelText: t('area'),
                      hintText: t('area_hint'),
                    ),
                  hSpace(12),
                  CustomTextFormField(
                    controller: phone,
                    labelText: t('phone'),
                    hintText: '010 1234 5678',
                    keyboardType: TextInputType.phone,
                    textDirection: TextDirection.ltr,
                    inputFormatters: const [EgyptianPhoneInputFormatter()],
                  ),
                  hSpace(12),
                  CustomTextFormField(
                    controller: address,
                    labelText: t('address'),
                    hintText: t('address_hint'),
                  ),
                  hSpace(12),
                  CustomTextFormField(
                    controller: description,
                    labelText: t('description'),
                    hintText: t('description_hint'),
                    minLines: 2,
                    maxLines: 4,
                  ),
                ],
              ),
            ),
            hSpace(12),
            VenueSectionCardWidget(
              title: t('location'),
              subtitle: t('location_hint'),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CustomTextFormField(
                    controller: paste,
                    labelText: t('paste_link'),
                    hintText: 'https://maps.google.com/…',
                    textDirection: TextDirection.ltr,
                    onChanged: (text) {
                      if (text.trim().isEmpty) {
                        locationNote.value = null;
                        return;
                      }
                      final point = VenueSetupForm.parseCoordinates(text);
                      if (point != null) {
                        setPoint(point.$1, point.$2);
                        locationNote.value = (true, t('link_ok'));
                      } else if (RegExp(
                        r'goo\.gl|maps\.app',
                        caseSensitive: false,
                      ).hasMatch(text)) {
                        locationNote.value = (false, t('link_short'));
                      } else {
                        locationNote.value = (false, t('link_bad'));
                      }
                    },
                  ),
                  hSpace(10),
                  CustomButton(
                    text: t('use_my_location'),
                    type: CustomButtonType.outline,
                    height: 44.h,
                    borderRadius: 12,
                    isLoading: locating.value,
                    icon: Icon(Icons.my_location_rounded, size: 18.r),
                    onTap: () async {
                      locating.value = true;
                      final point = await sl<LocationService>().current(
                        ask: true,
                      );
                      locating.value = false;
                      if (point == null) {
                        locationNote.value = (false, t('locate_failed'));
                        return;
                      }
                      setPoint(point.latitude, point.longitude);
                      locationNote.value = (true, t('locate_ok'));
                    },
                  ),
                  hSpace(10),
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextFormField(
                          controller: lat,
                          labelText: t('latitude'),
                          hintText: '30.0444',
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                            signed: true,
                          ),
                          textDirection: TextDirection.ltr,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: CustomTextFormField(
                          controller: lng,
                          labelText: t('longitude'),
                          hintText: '31.2357',
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                            signed: true,
                          ),
                          textDirection: TextDirection.ltr,
                        ),
                      ),
                    ],
                  ),
                  if (locationNote.value case (final ok, final text)) ...[
                    hSpace(6),
                    Text(
                      text,
                      style: AppTextStyles.font12SemiBold.copyWith(
                        color: ok ? AppColors.successText : AppColors.redText,
                      ),
                    ),
                  ],
                  if (outside) ...[
                    hSpace(6),
                    Text(
                      t('outside_egypt'),
                      style: AppTextStyles.font12SemiBold.copyWith(
                        color: AppColors.redText,
                      ),
                    ),
                  ],
                  if (current.hasLocation)
                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: TextButton.icon(
                        onPressed: () => launchUrl(
                          Uri.parse(
                            'https://www.google.com/maps/search/?api=1&query=$la,$lo',
                          ),
                          mode: LaunchMode.externalApplication,
                        ),
                        icon: const Icon(Icons.open_in_new_rounded, size: 16),
                        label: Text(t('open_map')),
                      ),
                    ),
                ],
              ),
            ),
            hSpace(12),
            VenueSectionCardWidget(
              title: t('facilities'),
              child: Wrap(
                spacing: 8.w,
                runSpacing: 8.h,
                children: [
                  for (final f in state.facilities)
                    FilterChip(
                      label: Text(f.nameFor(context.locale.languageCode)),
                      selected: facilities.value.contains(f.code),
                      onSelected: (on) => facilities.value = on
                          ? [...facilities.value, f.code]
                          : [
                              for (final c in facilities.value)
                                if (c != f.code) c,
                            ],
                    ),
                ],
              ),
            ),
            hSpace(12),
            VenueSectionCardWidget(
              title: t('photos'),
              subtitle: t('photos_hint'),
              child: VenuePhotoGridWidget(
                photos: state.venuePhotos,
                busy: state.uploading,
                onAdd: cubit.uploadVenuePhoto,
                onRemove: cubit.removeVenuePhoto,
              ),
            ),
            hSpace(16),
            if (!current.isValid)
              Padding(
                padding: EdgeInsets.only(bottom: 8.h),
                child: Text(
                  current.hasLocation ? t('fill_required') : t('need_location'),
                  textAlign: TextAlign.center,
                  style: AppTextStyles.font12Regular.copyWith(
                    color: AppColors.textMuted,
                  ),
                ),
              ),
            CustomButton(
              text: t('save_next'),
              height: 52.h,
              borderRadius: 14,
              enabled: current.isValid,
              isLoading: state.saving,
              textStyle: AppTextStyles.font16Bold.copyWith(
                color: AppColors.white,
              ),
              onTap: () => cubit.saveVenue(current),
            ),
          ],
        );
      },
    );
  }
}

class _Picker extends StatelessWidget {
  const _Picker({
    required this.label,
    required this.value,
    required this.onTap,
  });

  final String label;
  final String value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.font14SemiBold),
        hSpace(8),
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12.r),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.borderInput),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              children: [
                Expanded(child: Text(value, style: AppTextStyles.font14Medium)),
                Icon(
                  Icons.keyboard_arrow_down_rounded,
                  size: 20.r,
                  color: AppColors.textMuted,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
