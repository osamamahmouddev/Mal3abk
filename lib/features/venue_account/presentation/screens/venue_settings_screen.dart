import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/alert_banner_widget.dart';
import '../../../../core/widgets/app_top_snack_bar.dart';
import '../../../../core/widgets/custom_app_bar_widget.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../../../core/widgets/shimmer_list_skeleton_widget.dart';
import '../../../auth/presentation/cubit/logout_cubit.dart';
import '../../../venue_shell/presentation/cubit/venue_session_cubit.dart';
import '../../../venue_shell/presentation/cubit/venue_session_state.dart';
import '../../../venue_shell/presentation/widgets/venue_section_card_widget.dart';
import '../../domain/repos/venue_account_repo.dart';
import '../cubit/venue_account_cubit.dart';
import '../widgets/venue_fields_sheet_widget.dart';

/// Venue details and the owner's account and security, like the web
/// settings page.
class VenueSettingsScreen extends StatelessWidget {
  const VenueSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final session = context.watch<VenueSessionCubit>().state;
    if (session is! VenueSessionReady) return const SizedBox.shrink();
    return BlocProvider<VenueAccountCubit>(
      create: (_) =>
          VenueAccountCubit(venueAccountRepo: sl<VenueAccountRepo>())..load(),
      child: Scaffold(
        backgroundColor: AppColors.pageBackground,
        appBar: CustomAppBarWidget(
          title: 'venue.settings.title'.tr(context: context),
        ),
        body: _Body(session: session),
      ),
    );
  }
}

class _Body extends StatefulWidget {
  const _Body({required this.session});

  final VenueSessionReady session;

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  final _current = TextEditingController();
  final _next = TextEditingController();
  final _totp = TextEditingController();

  @override
  void dispose() {
    _current.dispose();
    _next.dispose();
    _totp.dispose();
    super.dispose();
  }

  String t(String key) => 'venue.settings.$key'.tr(context: context);

  void _report(String? error, String success) {
    if (!mounted) return;
    if (error == null) {
      AppTopSnackBar.showSuccess(context, success);
    } else {
      AppTopSnackBar.showError(context, error.tr(context: context));
    }
  }

  /// After an email or phone change every device is signed out.
  Future<void> _signInAgain(String title, String body) async {
    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog(
        title: Text(title),
        content: Text(body),
        actions: [
          FilledButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(t('sign_in_again')),
          ),
        ],
      ),
    );
    if (mounted) await context.read<LogoutCubit>().logout();
  }

  Future<void> _changeEmail(VenueAccountCubit cubit) async {
    var email = '';
    final started = await VenueFieldsSheetWidget.show(
      context,
      title: t('email_title'),
      note: t('email_note'),
      fields: [
        VenueSheetField(
          label: t('new_email'),
          ltr: true,
          keyboardType: TextInputType.emailAddress,
        ),
        VenueSheetField(label: t('current_password'), obscure: true, ltr: true),
      ],
      submitText: t('send_code'),
      onSubmit: (v) {
        email = v[0].trim();
        return cubit.startEmailChange(email, v[1]);
      },
    );
    if (started != true || !mounted) return;
    final done = await VenueFieldsSheetWidget.show(
      context,
      title: t('email_title'),
      note: 'venue.settings.email_code_note'.tr(
        context: context,
        args: [email],
      ),
      fields: [
        VenueSheetField(
          label: t('code'),
          ltr: true,
          keyboardType: TextInputType.number,
        ),
      ],
      submitText: t('confirm'),
      onSubmit: (v) => cubit.confirmEmailChange(v[0]),
    );
    if (done == true && mounted) {
      await _signInAgain(
        t('email_changed'),
        'venue.settings.email_changed_body'.tr(context: context, args: [email]),
      );
    }
  }

  Future<void> _changePhone(VenueAccountCubit cubit) async {
    final started = await VenueFieldsSheetWidget.show(
      context,
      title: t('phone_title'),
      note: t('phone_note'),
      fields: [
        VenueSheetField(
          label: t('new_phone'),
          ltr: true,
          keyboardType: TextInputType.phone,
        ),
        VenueSheetField(label: t('current_password'), obscure: true, ltr: true),
      ],
      submitText: t('send_code'),
      onSubmit: (v) => cubit.startPhoneChange(v[0], v[1]),
    );
    if (started != true || !mounted) return;
    final old = await VenueFieldsSheetWidget.show(
      context,
      title: t('phone_title'),
      note: t('old_code_note'),
      fields: [
        VenueSheetField(
          label: t('code'),
          ltr: true,
          keyboardType: TextInputType.number,
        ),
      ],
      submitText: t('next'),
      onSubmit: (v) => cubit.verifyOldPhone(v[0]),
    );
    if (old != true || !mounted) return;
    final done = await VenueFieldsSheetWidget.show(
      context,
      title: t('phone_title'),
      note: t('new_code_note'),
      fields: [
        VenueSheetField(
          label: t('code'),
          ltr: true,
          keyboardType: TextInputType.number,
        ),
      ],
      submitText: t('confirm'),
      onSubmit: (v) => cubit.verifyNewPhone(v[0]),
    );
    if (done == true && mounted) {
      await _signInAgain(t('phone_changed'), t('phone_changed_body'));
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<VenueAccountCubit>();
    final sessionCubit = context.read<VenueSessionCubit>();
    return BlocBuilder<VenueAccountCubit, VenueAccountState>(
      builder: (context, state) {
        if (state.loading) {
          return const ShimmerListSkeletonWidget(itemHeight: 80);
        }
        final p = state.profile;
        return ListView(
          padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 32.h),
          children: [
            if (state.error case final e?) ...[
              AlertBannerWidget(
                type: AlertBannerType.error,
                message: e.tr(context: context),
                actionText: 'common.retry'.tr(context: context),
                onActionTap: cubit.load,
              ),
              hSpace(10),
            ],
            VenueSectionCardWidget(
              title: t('venue_info'),
              subtitle: widget.session.venue.name,
              child: OutlinedButton.icon(
                onPressed: () async {
                  await context.pushNamed<String>(
                    AppRoutes.venueSetup,
                    arguments: widget.session.venue,
                  );
                  await sessionCubit.load();
                },
                icon: const Icon(Icons.storefront_outlined),
                label: Text(t('edit_venue')),
              ),
            ),
            hSpace(12),
            VenueSectionCardWidget(
              title: t('account'),
              child: Column(
                children: [
                  _Row(
                    label: t('owner'),
                    value: p?.fullName ?? '—',
                    onEdit: () async {
                      final success = t('name_saved');
                      final ok = await VenueFieldsSheetWidget.show(
                        context,
                        title: t('edit_name'),
                        fields: [
                          VenueSheetField(
                            label: t('name'),
                            initial: p?.fullName ?? '',
                          ),
                        ],
                        submitText: t('save'),
                        onSubmit: (v) => cubit.updateName(v[0]),
                      );
                      if (ok == true) _report(null, success);
                    },
                  ),
                  _Row(
                    label: t('email'),
                    value: p?.email ?? '—',
                    ltr: true,
                    onEdit: p?.email == null ? null : () => _changeEmail(cubit),
                  ),
                  _Row(
                    label: t('phone'),
                    value: p?.phoneNumber ?? '—',
                    ltr: true,
                    onEdit: () => _changePhone(cubit),
                  ),
                ],
              ),
            ),
            hSpace(12),
            VenueSectionCardWidget(
              title: t('password_title'),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CustomTextFormField(
                    controller: _current,
                    hintText: t('current_password'),
                    obscureText: true,
                    textDirection: TextDirection.ltr,
                    autofillHints: const [AutofillHints.password],
                  ),
                  hSpace(8),
                  CustomTextFormField(
                    controller: _next,
                    hintText: t('new_password'),
                    obscureText: true,
                    textDirection: TextDirection.ltr,
                    autofillHints: const [AutofillHints.newPassword],
                  ),
                  hSpace(10),
                  CustomButton(
                    text: t('change'),
                    height: 46.h,
                    borderRadius: 12,
                    type: CustomButtonType.outline,
                    isLoading: state.busy,
                    onTap: () async {
                      final success = t('password_changed');
                      final error = await cubit.changePassword(
                        _current.text,
                        _next.text,
                      );
                      if (error == null) {
                        _current.clear();
                        _next.clear();
                      }
                      _report(error, success);
                    },
                  ),
                ],
              ),
            ),
            hSpace(12),
            VenueSectionCardWidget(
              title: t('totp_title'),
              subtitle: t('totp_hint'),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (state.totpUri case final uri?) ...[
                    Text(t('totp_scan'), style: AppTextStyles.font13Regular),
                    hSpace(8),
                    Center(
                      child: QrImageView(data: uri, size: 180.r),
                    ),
                    hSpace(6),
                    SelectableText(
                      state.totpSecret ?? '',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.font14Bold,
                    ),
                    TextButton.icon(
                      onPressed: () => Clipboard.setData(
                        ClipboardData(text: state.totpSecret ?? ''),
                      ),
                      icon: const Icon(Icons.copy_rounded, size: 16),
                      label: Text(t('copy_key')),
                    ),
                    CustomTextFormField(
                      controller: _totp,
                      hintText: t('totp_code'),
                      keyboardType: TextInputType.number,
                      textDirection: TextDirection.ltr,
                      autofillHints: const [AutofillHints.oneTimeCode],
                    ),
                    hSpace(8),
                    CustomButton(
                      text: t('totp_confirm'),
                      height: 46.h,
                      borderRadius: 12,
                      isLoading: state.busy,
                      textStyle: AppTextStyles.font14Bold.copyWith(
                        color: AppColors.white,
                      ),
                      onTap: () async {
                        final success = t('totp_enabled');
                        final error = await cubit.confirmTotp(_totp.text);
                        if (error == null) _totp.clear();
                        _report(error, success);
                      },
                    ),
                  ] else
                    CustomButton(
                      text: t('totp_enable'),
                      height: 46.h,
                      borderRadius: 12,
                      type: CustomButtonType.outline,
                      isLoading: state.busy,
                      onTap: () async {
                        final error = await cubit.enrollTotp();
                        if (error != null) _report(error, '');
                      },
                    ),
                ],
              ),
            ),
            hSpace(12),
            VenueSectionCardWidget(
              title: t('devices_title'),
              child: OutlinedButton.icon(
                onPressed: () =>
                    context.pushNamed<void>(AppRoutes.activeSessions),
                icon: const Icon(Icons.devices_other_rounded),
                label: Text(t('devices_open')),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _Row extends StatelessWidget {
  const _Row({
    required this.label,
    required this.value,
    this.onEdit,
    this.ltr = false,
  });

  final String label;
  final String value;
  final VoidCallback? onEdit;
  final bool ltr;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        label,
        style: AppTextStyles.font12Regular.copyWith(
          color: AppColors.textSecondary,
        ),
      ),
      subtitle: Text(
        value,
        textDirection: ltr ? TextDirection.ltr : null,
        textAlign: TextAlign.start,
        style: AppTextStyles.font14SemiBold,
      ),
      trailing: onEdit == null
          ? null
          : TextButton(
              onPressed: onEdit,
              child: Text('venue.settings.edit'.tr(context: context)),
            ),
    );
  }
}
