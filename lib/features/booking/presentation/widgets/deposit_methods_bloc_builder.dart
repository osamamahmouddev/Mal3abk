import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/alert_banner_widget.dart';
import '../../../../core/widgets/radio_option_card_widget.dart';
import '../../../../core/widgets/shimmer_list_skeleton_widget.dart';
import '../cubit/deposit_methods_cubit.dart';
import '../cubit/deposit_methods_state.dart';
import 'deposit_wallet_card_widget.dart';

/// The venue's payment methods for this booking and the chosen one's account.
class DepositMethodsBlocBuilder extends HookWidget {
  const DepositMethodsBlocBuilder({
    required this.bookingId,
    required this.bookingReference,
    super.key,
  });

  final String bookingId;
  final String bookingReference;

  @override
  Widget build(BuildContext context) {
    final selected = useState(0);
    String t(String key) => 'booking.deposit.$key'.tr(context: context);

    return BlocBuilder<DepositMethodsCubit, DepositMethodsState>(
      builder: (context, state) => switch (state) {
        DepositMethodsSuccess(:final methods) when methods.isEmpty =>
          AlertBannerWidget(
            type: AlertBannerType.warning,
            message: t('no_methods'),
          ),
        DepositMethodsSuccess(:final methods) => Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(t('choose_method'), style: AppTextStyles.font15Bold),
            hSpace(12),
            for (final (i, method) in methods.indexed) ...[
              if (i > 0) hSpace(8),
              RadioOptionCardWidget(
                title: method.isInstaPay ? t('instapay') : t('wallet'),
                subtitle: method.recipientName,
                isSelected: selected.value == i,
                onTap: () {
                  HapticFeedback.selectionClick();
                  selected.value = i;
                },
              ),
            ],
            hSpace(12),
            DepositWalletCardWidget(
              accountNumber: methods[selected.value].accountDetails,
              recipientName: methods[selected.value].recipientName,
              instructions: methods[selected.value].instructions,
              bookingNo: bookingReference,
              label: methods[selected.value].isInstaPay
                  ? t('instapay_address')
                  : t('wallet_number'),
            ),
          ],
        ),
        DepositMethodsError(:final message) => AlertBannerWidget(
          type: AlertBannerType.error,
          message: message.tr(context: context),
          actionText: 'common.retry'.tr(context: context),
          onActionTap: () =>
              context.read<DepositMethodsCubit>().load(bookingId),
        ),
        _ => const ShimmerListSkeletonWidget(
          itemHeight: 64,
          itemCount: 2,
          padding: EdgeInsets.zero,
        ),
      },
    );
  }
}
