import 'package:flutter/material.dart';
import 'package:sales_lead/ui/views/primary_person_detail/registration_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import 'package:sales_lead/ui/widgets/common/scroll_screen/scroll_screen.dart';
import '/ui/bottom_sheets/assign_connect_to/assign_connect_to_sheet_model.dart';
import '/ui/common/index.dart';
import '/ui/common/widgets/index.dart';
import 'account_detail_view.form.dart';

@FormView(fields: [
  FormTextField(name: 'accountNumber'),
  FormTextField(name: 'IFSC'),
  FormTextField(name: 'accountName'),
  FormTextField(name: 'accountType'),
  FormTextField(name: 'bankName'),
  FormTextField(name: 'Branch'),
])
class AccountDetailView extends StackedView<RegistrationViewModel>
    with $AccountDetailView {
  final String? accountNumber;
  final String? ifscCode;
  final String? bankName;
  final String? accountHolderName;
  final String? branchName;
  final String? email;
  final String? mobileNumber;
  final String? primarycontactname;
  final String? entityType;
  final String? entityId;
  final String? gstin;
  final String? panNumber;
  final String? reraId;
  final String? channelPartnerName;
  final String? address;
  final String? state;
  final String? city;
  final String? zipCode;
  final String? website;
  final bool? isActive;
  const AccountDetailView({
    this.accountHolderName,
    this.accountNumber,
    this.bankName,
    this.branchName,
    this.ifscCode,
    this.email,
    this.mobileNumber,
    this.gstin,
    this.panNumber,
    this.reraId,
    this.entityId,
    this.entityType,
    this.primarycontactname,
    this.channelPartnerName,
    this.address,
    this.city,
    this.state,
    this.zipCode,
    this.website,
    this.isActive,
    Key? key,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    RegistrationViewModel viewModel,
    Widget? child,
  ) {
    return ImageScrollBarHeader(
        bodyChild: renderBody(context, viewModel),
        onBackArrowTap: viewModel.goBack,
        isRegistration: true,
        userCreationType: userCreationType);
  }

  @override
  RegistrationViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      RegistrationViewModel();
  Widget renderBody(BuildContext context, RegistrationViewModel viewModel) {
    return SingleChildScrollView(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          Container(
            height: 3,
            width: screenWidth(context) / 6,
            decoration: BoxDecoration(
                color: customLightGrey,
                borderRadius: BorderRadius.circular(1.5)),
          ),
          verticalSpaceExtraSmall,
          const StepperIndicator(index: 4),
          verticalSpaceExtraSmall,
          InputWithLabel(
            labelText: 'Account Number',
            initialValue: accountNumber,
            keyboardType: TextInputType.number,
            readOnly: true,
          ),
          verticalSpaceMedium,
          InputWithLabel(
            labelText: 'IFSC',
            initialValue: ifscCode,
            keyboardType: TextInputType.name,
            readOnly: true,
          ),
          verticalSpaceMedium,
          InputWithLabel(
            labelText: 'Account Name',
            initialValue: accountHolderName,
            keyboardType: TextInputType.name,
            readOnly: true,
          ),
          verticalSpaceMedium,
          SizedBox(
              child: SelectDropList(
            viewModel.accountTypeOption,
            viewModel.accountTypeDropListModel,
            (optionItem) {
              viewModel.onAccountTypeChange(optionItem,
                  viewModel.accountTypeDropListModel.indexOf(optionItem));
            },
            labelText: 'Account Type',
          )),
          verticalSpaceMedium,
          InputWithLabel(
            labelText: 'Bank Name',
            initialValue: bankName,
            keyboardType: TextInputType.name,
            readOnly: true,
          ),
          verticalSpaceMedium,
          InputWithLabel(
            labelText: 'Branch',
            initialValue: branchName,
            keyboardType: TextInputType.name,
            readOnly: true,
          ),
          verticalSpaceMedium,
          Button(
              onPressed: () => viewModel.goToAgreementPage(
                  email: email,
                  mobileNumber: mobileNumber,
                  entityId: entityId,
                  entityType: entityType,
                  primarycontactname: primarycontactname,
                  accountHolderName: accountHolderName,
                  accountNumber: accountNumber,
                  bankName: bankName,
                  branchName: branchName,
                  ifscCode: ifscCode,
                  gstin: gstin,
                  panNumber: panNumber,
                  reraId: reraId,
                  accountType: viewModel.accountTypeOption.title,
                  address1: address,
                  channelPartnerName: channelPartnerName,
                  city: city,
                  isActive: isActive,
                  primaryContactName: primarycontactname,
                  state: state,
                  website: website,
                  zipCode: zipCode),
              title: 'CONTINUE'),
          verticalSpaceSmall,
        ],
      ),
    );
  }
}
