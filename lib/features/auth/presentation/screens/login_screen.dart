import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/routes/routes.dart';
import '../../../../core/styles/app_assets.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_form_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  bool _isOtpSent = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _phoneController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  void _handleSendCode() {
    if (_phoneController.text.trim().isEmpty) return;
    setState(() {
      _isLoading = true;
    });
    Future.delayed(const Duration(milliseconds: 600), () {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
        _isOtpSent = true;
      });
    });
  }

  void _handleVerifyOtp() {
    setState(() {
      _isLoading = true;
    });
    Future.delayed(const Duration(milliseconds: 600), () {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
      });
      Navigator.of(context).pushReplacementNamed(AppRoutes.profileSetup);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.brandNavy),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Image.asset(
                  AppAssets.logoStacked,
                  width: 120.w,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: 24.h),
              Text(
                'سجّل الدخول',
                style: AppTextStyles.font22Bold,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8.h),
              Text(
                _isOtpSent
                    ? 'أدخل كود التأكيد المرسل إلى رقمك'
                    : 'هنبعتلك كود تأكيد على رقم موبايلك',
                style: AppTextStyles.font14Regular,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 32.h),
              if (!_isOtpSent) ...[
                CustomTextFormField(
                  controller: _phoneController,
                  labelText: 'رقم الموبايل',
                  hintText: '01012345678',
                  keyboardType: TextInputType.phone,
                  prefixIcon: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: Center(
                      widthFactor: 1.0,
                      child: Text(
                        '+20',
                        style: AppTextStyles.font14Bold.copyWith(
                          color: AppColors.brandNavy,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 24.h),
                CustomButton(
                  text: 'إرسال الكود',
                  type: CustomButtonType.primary,
                  height: 54.h,
                  isLoading: _isLoading,
                  onTap: _handleSendCode,
                ),
                SizedBox(height: 16.h),
                Text(
                  'أول مرة؟ هنعملك حساب جديد تلقائياً.',
                  style: AppTextStyles.font13Regular.copyWith(
                    color: AppColors.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ] else ...[
                CustomTextFormField(
                  controller: _otpController,
                  labelText: 'كود التأكيد (OTP)',
                  hintText: '••••',
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 24.h),
                CustomButton(
                  text: 'تأكيد ودخول',
                  type: CustomButtonType.primary,
                  height: 54.h,
                  isLoading: _isLoading,
                  onTap: _handleVerifyOtp,
                ),
                SizedBox(height: 16.h),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _isOtpSent = false;
                    });
                  },
                  child: Text(
                    'تعديل رقم الموبايل',
                    style: AppTextStyles.font14SemiBold.copyWith(
                      color: AppColors.brandNavy,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
