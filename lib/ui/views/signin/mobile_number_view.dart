import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import '/ui/common/widgets/index.dart';
import '/ui/common/index.dart';
import 'signin_viewmodel.dart';
import 'mobile_number_view.form.dart';

@FormView(fields: [
  FormTextField(
      name: 'phoneNumber', validator: FormValidator.mobileNumberValidator),
  FormTextField(name: 'otp'),
])
class MobileNumberView extends StackedView<SigninViewModel>
    with $MobileNumberView {
  const MobileNumberView({Key? key}) : super(key: key);

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
          Text('Have an account?', style: AppTextStyle().signHeaderStyle()),
          verticalSpaceExtraSmall,
          Text('Sign in to continue', style: AppTextStyle().signSubHeader),
          verticalSpaceMedium,
          verticalSpaceTiny,
          // Mobile number field
          InputWithLabel(
              controller: phoneNumberController,
              labelText: 'User ID',
              hintText: 'Mobile Number',
              maxLength: 10,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.number),
          Visibility(
            visible: viewModel.hasPhoneNumberValidationMessage &&
                viewModel.showValidation,
            child: Text(
              '${viewModel.phoneNumberValidationMessage}',
              textAlign: TextAlign.end,
              style: const TextStyle(color: primaryColor),
            ),
          ),
          verticalSpaceLarge,
          verticalSpaceExtraSmall,
          // Sign in with OTP button
          Button(
              // disabled: !viewModel.isSiginValid(),
              onPressed: () {
                viewModel.isSiginValid();
              },
              title: 'SIGN IN WITH OTP',
              loading: viewModel.isBusy),
          verticalSpaceMedium,
          // Register as a existing customer or channel partner bottomsheet link
          RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  text: 'No account? ',
                  style: AppTextStyle().tncTextStyle(),
                  children: [
                    TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = viewModel.showAssignConnectBottomSheet,
                        text: 'Register',
                        style: AppTextStyle().tncTextStyle(
                            textColor: FontColor().brown,
                            fontWeight: FontWeight.w600))
                  ])),
        ],
      ),
    );
  }

  @override
  SigninViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      SigninViewModel();

  @override
  void onViewModelReady(SigninViewModel viewModel) {
    syncFormWithViewModel(viewModel);
  }
}
