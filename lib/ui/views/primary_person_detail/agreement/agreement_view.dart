import 'package:flutter/material.dart';
import 'package:sales_lead/ui/views/primary_person_detail/registration_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '/ui/common/widgets/index.dart';
import '/ui/common/index.dart';
import '/ui/bottom_sheets/assign_connect_to/assign_connect_to_sheet_model.dart';

class AgreementView extends StackedView<RegistrationViewModel> {
  final String? accountNumber;
  final String? ifscCode;
  final String? bankName;
  final String? accountHolderName;
  final String? branchName;
  final String? email;
  final String? mobileNumber;
  final String? entityType;
  final String? entityId;
  final String? gstin;
  final String? panNumber;
  final String? reraId;
  final String? channelPartnerName;
  final String? primaryContactName;
  final String? accountType;
  final String? address1;
  final String? city;
  final String? state;
  final String? zipCode;
  final String? website;
  final bool? isActive;
  const AgreementView(
      {this.accountHolderName,
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
      this.channelPartnerName,
      this.address1,
      this.city,
      this.state,
      this.zipCode,
      this.website,
      this.isActive,
      this.accountType,
      this.primaryContactName,
      Key? key})
      : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    RegistrationViewModel viewModel,
    Widget? child,
  ) {
    return Screen(
      bodyChild: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          verticalSpaceSmall,
          Expanded(child: WebViewWidget(controller: viewModel.controller)),
          verticalSpaceExtraSmall,
          Button(
              onPressed: () => viewModel.createChannelPartner(
                    channelPartnerName: channelPartnerName!,
                    entityType: entityType!,
                    entityId: entityId!,
                    panNumber: panNumber!,
                    gstin: gstin!,
                    primaryContactName: primaryContactName!,
                    accountNumber: accountNumber!,
                    accountType: accountType!,
                    accountHolderName: accountHolderName!,
                    bankName: bankName!,
                    branchName: branchName!,
                    ifscCode: ifscCode!,
                    isActive: isActive!,
                    address1: address1,
                    city: city,
                    reraId: reraId,
                    state: state,
                    website: website,
                    zipCode: zipCode,
                    email: email,
                    mobileNumber: mobileNumber,
                  ),
              title: 'AGREE'),
          verticalSpaceSmall,
        ],
      ),
      headerChild: Padding(
        padding: const EdgeInsets.only(bottom: 45.0),
        child: Row(children: [
          GestureDetector(
            onTap: viewModel.goBack,
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
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'AGREEMENT',
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
      RegistrationViewModel()
        ..agreementInitState(
            address: address1,
            channelPartnerName: channelPartnerName,
            panNumber: panNumber,
            primaryContactName: primaryContactName);
}
