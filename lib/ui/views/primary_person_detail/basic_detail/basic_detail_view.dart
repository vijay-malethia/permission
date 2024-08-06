import 'package:flutter/material.dart';
import 'package:sales_lead/ui/views/primary_person_detail/registration_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import 'package:sales_lead/ui/widgets/common/scroll_screen/scroll_screen.dart';
import '/ui/common/index.dart';
import '/ui/common/widgets/index.dart';
import '/ui/bottom_sheets/assign_connect_to/assign_connect_to_sheet_model.dart';
import 'basic_detail_view.form.dart';

@FormView(fields: [
  FormTextField(name: 'nameOfEntity'),
  FormTextField(name: 'address '),
  FormTextField(name: 'city'),
  FormTextField(name: 'state'),
  FormTextField(name: 'pincode'),
  FormTextField(name: 'website'),
])
class BasicDetailView extends StackedView<RegistrationViewModel>
    with $BasicDetailView {
  final String? email;
  final String? mobileNumber;
  final String? primarycontactname;
  final String? entityType;
  final String? entityId;
  final String? gstin;
  final String? panNumber;
  final String? reraId;
  const BasicDetailView(
      {this.email,
      this.mobileNumber,
      this.gstin,
      this.panNumber,
      this.reraId,
      this.entityId,
      this.entityType,
      this.primarycontactname,
      Key? key})
      : super(key: key);

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
          const StepperIndicator(index: 2),
          verticalSpaceSmall,
          InputWithLabel(
            labelText: 'Name of Entity',
            controller: nameOfEntityController,
            keyboardType: TextInputType.name,
          ),
          verticalSpaceMedium,
          InputWithLabel(
            labelText: 'Address ',
            maxLines: 4,
            controller: addressController,
            keyboardType: TextInputType.streetAddress,
          ),
          verticalSpaceMedium,
          InputWithLabel(
            labelText: 'City',
            controller: cityController,
            keyboardType: TextInputType.name,
          ),
          verticalSpaceMedium,
          InputWithLabel(
            labelText: 'State',
            controller: stateController,
            keyboardType: TextInputType.name,
          ),
          verticalSpaceMedium,
          InputWithLabel(
            labelText: 'Pincode',
            controller: pincodeController,
            maxLength: 6,
            keyboardType: TextInputType.number,
          ),
          verticalSpaceMedium,
          InputWithLabel(
            labelText: 'Website',
            controller: websiteController,
            keyboardType: TextInputType.url,
            textInputAction: TextInputAction.done,
          ),
          verticalSpaceMedium,
          Button(
              onPressed: () {
                viewModel.showBankBottomSheet(
                  email: email,
                  mobile: mobileNumber,
                  entityId: entityId,
                  entityType: entityType,
                  primarycontactname: primarycontactname,
                  gstin: gstin,
                  panNumber: panNumber,
                  reraId: reraId,
                  address: addressController.text,
                  channelPartnerName: nameOfEntityController.text,
                  city: cityController.text,
                  state: stateController.text,
                  website: websiteController.text,
                  zipCode: pincodeController.text,
                );
              },
              title: 'CONTINUE'),
          verticalSpaceSmall,
        ],
      ),
    );
  }
}
