import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import '/ui/common/index.dart';
import '/ui/common/widgets/index.dart';
import '/ui/views/primary_person_detail/registration_viewmodel.dart';
import '/ui/bottom_sheets/assign_connect_to/assign_connect_to_sheet_model.dart';
import 'verify_otp_view.form.dart';

@FormView(fields: [
  FormTextField(name: 'phoneOtp'),
  FormTextField(name: 'emailOtp'),
])
class VerifyOtpView extends StackedView<RegistrationViewModel>
    with $VerifyOtpView {
  final String? email;
  final String? mobileNumber;
  final String? primarycontactname;
  final String? entityType;
  final String? entityId;

  const VerifyOtpView({
    this.email,
    this.mobileNumber,
    this.entityId,
    this.entityType,
    this.primarycontactname,
    Key? key,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    RegistrationViewModel viewModel,
    Widget? child,
  ) {
    return Screen(
      bodyChild: _renderVerifyOTP(viewModel, context),
      headerChild: Padding(
        padding: const EdgeInsets.only(bottom: 45.0),
        child: Row(children: [
          GestureDetector(
            onTap: viewModel.goBackToPrimaryDetailView,
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
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'REGISTER',
                style: AppTextStyle().agreementTitleTextStyle(),
              ),
              Text(
                'as $userCreationType',
                style: AppTextStyle().agreementSubtitleTextStyle(),
              ),
            ],
          ),
        ]),
      ),
    );
  }

  @override
  RegistrationViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      RegistrationViewModel()..verifyOtpViewInit();

  @override
  void onDispose(RegistrationViewModel viewModel) {
    super.onDispose(viewModel);
    disposeForm();
  }

  Widget _renderVerifyOTP(
      RegistrationViewModel viewModel, BuildContext context) {
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
                                    email: email)
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
                                    mobileNumber: mobileNumber)
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
              onPressed: () => emailOtpController.text.isNotEmpty &&
                      phoneOtpController.text.isNotEmpty
                  ? viewModel.channelPartnerVerification(
                      email: email!,
                      mobile: mobileNumber!,
                      emailOtp: emailOtpController.text,
                      mobileNumberOtp: phoneOtpController.text,
                      entityId: entityId!,
                      entityType: entityType!,
                      primarycontactname: primarycontactname!)
                  : showCustomToast(context, "Please enter the OTP", ''),
              title: 'SUBMIT'),
          verticalSpaceSmall,
        ],
      ),
    );
  }
}
