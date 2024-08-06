import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

import '/ui/common/index.dart';
import '/ui/common/widgets/index.dart';
import '/ui/bottom_sheets/bank_details/bank_details_sheet.form.dart';
import '/ui/views/primary_person_detail/registration_viewmodel.dart';

@FormView(fields: [
  FormTextField(
      name: 'accountNumber', validator: FormValidator.validateAccountNumber),
  FormTextField(name: 'ifsc', validator: FormValidator.validateIfscCode),
])
class BankDetailsSheet extends StackedView<RegistrationViewModel>
    with $BankDetailsSheet {
  final Function(SheetResponse response)? completer;
  final SheetRequest request;
  const BankDetailsSheet({
    Key? key,
    required this.completer,
    required this.request,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    RegistrationViewModel viewModel,
    Widget? child,
  ) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: const BoxDecoration(
        color: backgroundcolor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                SingleChildScrollView(child: renderBankDetail(viewModel)),
                Builder(builder: (context) {
                  if (viewModel.isBusy) {
                    return renderValidateAccount();
                  }
                  if (viewModel.invalidate) {
                    return renderInvalidAccount(viewModel);
                  }

                  return const SizedBox();
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Invalid bank accoung message view
  renderInvalidAccount(RegistrationViewModel viewModel) {
    return Container(
      height: 400,
      width: double.infinity,
      color: backgroundcolor.withOpacity(0.9),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SvgPicture.asset(Images().invalidAcIcon, width: 57, height: 77),
          verticalSpaceLarge,
          Text(invalidAc,
              style: AppTextStyle().loadingLabelTextStyle,
              textAlign: TextAlign.center),
          verticalSpaceSmall,
          Text(
            bankDetailsNotMatch,
            style: AppTextStyle().loadingDescriptionTextStyle,
            textAlign: TextAlign.center,
          ),
          verticalSpaceLarge,
          verticalSpaceSmall,
          Button(
              onPressed: () {
                viewModel.refillAccountDetails();
              },
              title: changeAccount),
          verticalSpaceMedium,
          verticalSpaceSmall,
        ],
      ),
    );
  }

  // Bank account validate message view
  renderValidateAccount() {
    return WillPopScope(
      onWillPop: () async => false,
      child: Container(
        height: 400,
        width: double.infinity,
        color: backgroundcolor.withOpacity(0.9),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(Images().validateBankAcIcon),
            verticalSpaceExtraSmall,
            Text(
              validateUrAc,
              style: AppTextStyle().loadingDescriptionTextStyle,
            )
          ],
        ),
      ),
    );
  }

  // Bank account details view
  renderBankDetail(RegistrationViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        BottomSheetHeader(imageUrl: Images().bankWithBg),
        verticalSpaceExtraSmall,
        Center(
          child: Text(needUrBankAccount,
              style: AppTextStyle().loadingDescriptionTextStyle),
        ),
        verticalSpaceSmall,
        InputWithLabel(
          labelText: accountNumber,
          controller: accountNumberController,
          maxLength: 20,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r"[0-9]"))
          ],
          keyboardType: TextInputType.number,
        ),
        verticalSpaceTiny,
        Visibility(
          visible: viewModel.hasAccountNumberValidationMessage,
          child: Text(
            viewModel.accountNumberValidationMessage ?? '',
            style: const TextStyle(color: Colors.red),
          ),
        ),
        verticalSpaceMedium,
        InputWithLabel(
          labelText: ifsc,
          controller: ifscController,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r"[A-Z0-9]"))
          ],
          textInputAction: TextInputAction.done,
          textCapitalization: TextCapitalization.characters,
          keyboardType: TextInputType.name,
        ),
        verticalSpaceTiny,
        Visibility(
          visible: viewModel.hasIfscValidationMessage,
          child: Text(
            viewModel.ifscValidationMessage ?? '',
            style: const TextStyle(color: Colors.red),
          ),
        ),
        verticalSpaceSmall,
        verticalSpaceTiny,
        Button(
            onPressed: () => viewModel.bankVerification(
                accountNumber: accountNumberController.text,
                ifsc: ifscController.text,
                email: request.data['email'],
                mobile: request.data['mobile'],
                entityId: request.data['entityId'],
                entityType: request.data['entityType'],
                primarycontactname: request.data['primarycontactname'],
                gstin: request.data['gstin'],
                panNumber: request.data['panNumber'],
                reraId: request.data['reraId'],
                address: request.data['address'],
                channelPartnerName: request.data['channelPartnerName'],
                city: request.data['city'],
                state: request.data['state'],
                website: request.data['website'],
                zipCode: request.data['zipCode']),
            title: continu),
      ],
    );
  }

  @override
  RegistrationViewModel viewModelBuilder(BuildContext context) =>
      RegistrationViewModel();
  @override
  void onViewModelReady(RegistrationViewModel viewModel) {
    syncFormWithViewModel(viewModel);
  }
}
