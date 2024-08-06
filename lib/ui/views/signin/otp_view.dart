import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_svg/svg.dart';

import '/ui/common/index.dart';
import '/ui/common/widgets/index.dart';
import 'signin_viewmodel.dart';
import 'mobile_number_view.form.dart';

class OtpView extends StackedView<SigninViewModel> with $MobileNumberView {
  const OtpView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    SigninViewModel viewModel,
    Widget? child,
  ) {
    return Screen(
      bodyChild: ListView(
        padding: EdgeInsets.zero,
        children: [
          verticalSpaceSmall,
          Text('Enter OTP', style: AppTextStyle().signHeaderStyle()),
          verticalSpaceTiny,
          Text('a 4 digit OTP has been sent to your mobile number',
              style: AppTextStyle().tncTextStyle()),
          verticalSpaceExtraSmall,
          SvgPicture.asset(Images().unlockImg),
          verticalSpaceMedium,
          // OTP fields
          OTPTextField(
              onChanged: (p0) => viewModel.notifyListeners(),
              otpController: otpController),
          verticalSpaceSmall,
          // Verify OTP button
          Button(
              loading: viewModel.isBusy,
              disabled: !viewModel.isFormValid(),
              onPressed: () {
                viewModel.signInWithOTP();
              },
              title: 'SUBMIT'),
          verticalSpaceSmall,
          // Resend OTP text button
          RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  text: viewModel.isResendOTP() ? 'Didn’t receive OTP? ' : '',
                  style: AppTextStyle().tncTextStyle(),
                  children: [
                    TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => viewModel.isResendOTP()
                              ? viewModel.restartTimer(context)
                              : null,
                        text: viewModel.isResendOTP()
                            ? 'Resend'
                            : 'Resend in ${viewModel.timerText} secs',
                        style: AppTextStyle().tncTextStyle(
                            textColor: FontColor().brown,
                            fontWeight: FontWeight.w600))
                  ])),
          verticalSpaceTiny,
        ],
      ),
      headerChild: _renderHeader(viewModel, context),
    );
  }

  @override
  SigninViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      SigninViewModel()..startTimer();

  @override
  void onDispose(SigninViewModel viewModel) {
    super.onDispose(viewModel);
    otpController.clear();
  }

  @override
  void onViewModelReady(SigninViewModel viewModel) {
    syncFormWithViewModel(viewModel);
  }

  //Render Header
  _renderHeader(SigninViewModel viewModel, BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 15, bottom: 45),
        child: InkWell(
          onTap: () => viewModel.goBack(),
          child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
            const Icon(Icons.arrow_back, color: whiteColor),
            horizontalSpaceTiny,
            Text('SIGN IN', style: Theme.of(context).textTheme.displayLarge)
          ]),
        ));
  }
}
