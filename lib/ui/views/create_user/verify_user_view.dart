import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '/ui/common/index.dart';
import '/ui/views/create_user/create_user_view.form.dart';
import '/ui/views/create_user/create_user_viewmodel.dart';
import '../../common/widgets/index.dart';

class VerifyUserView extends StackedView<CreateUserViewModel>
    with $CreateUserView {
  const VerifyUserView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    CreateUserViewModel viewModel,
    Widget? child,
  ) {
    return Screen(
      bodyChild: _renderVerifyOTP(viewModel, context),
      headerChild: Padding(
        padding: const EdgeInsets.only(bottom: 45.0),
        child: Row(children: [
          GestureDetector(
            onTap: () {
              viewModel.goBack();
            },
            child: Container(
              height: 50,
              width: 50,
              padding: const EdgeInsets.only(top: 5),
              alignment: Alignment.topCenter,
              child: const Icon(
                Icons.arrow_back,
                size: 30,
                color: whiteColor,
              ),
            ),
          ),
          horizontalSpaceTiny,
          Text(
            'Verify DST USer',
            style: AppTextStyle().agreementTitleTextStyle(),
          ),
        ]),
      ),
    );
  }

  @override
  CreateUserViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      CreateUserViewModel()..verifyOtpViewInit();

  Widget _renderVerifyOTP(CreateUserViewModel viewModel, BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          verticalSpaceMedium,
          Text('Verify Details', style: AppTextStyle().registerTitleTextStyle),
          verticalSpaceTiny,
          Text(
              'Please enter 4 digit verification code sent on your email and mobile',
              style: AppTextStyle().registerDescriptionTextStyle),
          verticalSpaceExtraSmall,
          Text('Code received on Email ID',
              style: AppTextStyle().inputLabelTextStyle()),
          verticalSpaceSmall,
          OTPTextField(
              otpController: emailOtpController,
              onChanged: (p0) => viewModel.notifyListeners()),
          verticalSpaceSmall,
          verticalSpaceTiny,
          RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  text: viewModel.emailTimerText == '00'
                      ? 'Didn’t receive OTP? '
                      : '',
                  style: AppTextStyle().resendOtpTextStyle(),
                  children: [
                    TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            viewModel.emailTimerText == '00'
                                ? viewModel.restartEmailOtpTimer(context,
                                    email: emailController.text)
                                : null;
                          },
                        text: viewModel.emailTimerText == '00'
                            ? 'Resend'
                            : 'Resend in ${viewModel.emailTimerText} secs',
                        style: AppTextStyle().resendOtpTextStyle(
                            textColor: borderColor,
                            fontWeight: FontWeight.w600))
                  ])),
          verticalSpaceSmall,
          Text('Code received on Mobile',
              style: AppTextStyle().inputLabelTextStyle()),
          verticalSpaceSmall,
          OTPTextField(
              otpController: phoneOtpController,
              onChanged: (p0) => viewModel.notifyListeners()),
          verticalSpaceSmall,
          RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  text: viewModel.mobileTimerText == '00'
                      ? 'Didn’t receive OTP? '
                      : '',
                  style: AppTextStyle().resendOtpTextStyle(),
                  children: [
                    TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            viewModel.mobileTimerText == '00'
                                ? viewModel.restartMobileOtpTimer(context,
                                    mobileNumber: mobileController.text)
                                : null;
                          },
                        text: viewModel.mobileTimerText == '00'
                            ? 'Resend'
                            : 'Resend in ${viewModel.mobileTimerText} secs',
                        style: AppTextStyle().resendOtpTextStyle(
                            textColor: borderColor,
                            fontWeight: FontWeight.w600))
                  ])),
          verticalSpaceSmall,
          Button(
              onPressed: () {
                emailOtpController.text.isNotEmpty &&
                        phoneOtpController.text.isNotEmpty
                    ? viewModel.otpVerification(
                        email: emailController,
                        mobile: mobileController,
                        emailOtp: emailOtpController,
                        mobileNumberOtp: phoneOtpController,
                        name: nameController,
                        profilePicture: userImagePath)
                    : showCustomToast(context, "Please enter the OTP", '');
              },
              title: 'SUBMIT'),
          verticalSpaceSmall,
        ],
      ),
    );
  }
}
