import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import '/ui/common/widgets/index.dart';
import '/ui/common/index.dart';
import '/ui/widgets/common/scroll_screen/scroll_screen.dart';
import '/ui/bottom_sheets/assign_connect_to/assign_connect_to_sheet_model.dart';
import '../registration_viewmodel.dart';
import 'primary_person_details_view.form.dart';

@FormView(fields: [
  FormTextField(
      name: 'primaryPersonName', validator: FormValidator.requriedValidator),
  FormTextField(
      name: 'primaryPersonEmail', validator: FormValidator.emailValidatior),
  FormTextField(
      name: 'primaryPersonMobile',
      validator: FormValidator.mobileNumberValidator),
  FormTextField(name: 'entityId', validator: FormValidator.requriedValidator),
])
class PrimaryPersonDetailsView extends StackedView<RegistrationViewModel>
    with $PrimaryPersonDetailsView {
  const PrimaryPersonDetailsView({Key? key}) : super(key: key);
  @override
  Widget builder(
    BuildContext context,
    RegistrationViewModel viewModel,
    Widget? child,
  ) {
    return ImageScrollBarHeader(
      bodyChild: Builder(builder: (context) {
        if (viewModel.isBusy) {
          return Padding(
            padding: EdgeInsets.only(top: screenHeight(context) / 3),
            child: const Center(
                child: CircularProgressIndicator(
              color: primaryColor,
            )),
          );
        } else {
          return renderBody(context, viewModel);
        }
      }),
      onBackArrowTap: viewModel.goBack,
      isRegistration: true,
      userCreationType: userCreationType,
    );
  }

  @override
  RegistrationViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      RegistrationViewModel()..primaryPersonDetailViewInit();

  @override
  void onViewModelReady(RegistrationViewModel viewModel) {
    syncFormWithViewModel(viewModel);
  }

  @override
  void onDispose(RegistrationViewModel viewModel) {
    super.onDispose(viewModel);
    disposeForm();
  }

  Widget renderBody(BuildContext context, RegistrationViewModel viewModel) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
              height: 3,
              width: screenWidth(context) / 6,
              decoration: BoxDecoration(
                  color: customLightGrey,
                  borderRadius: BorderRadius.circular(1.5))),
          verticalSpaceExtraSmall,
          const StepperIndicator(index: 0),
          verticalSpaceSmall,
          InputWithLabel(
            labelText: 'Primary Contact Person\'s Name',
            controller: primaryPersonNameController,
            keyboardType: TextInputType.name,
          ),
          verticalSpaceTiny,
          Visibility(
            visible: viewModel.hasPrimaryPersonNameValidationMessage,
            child: Text(
              '${viewModel.primaryPersonNameValidationMessage}',
              style: const TextStyle(color: primaryColor),
            ),
          ),
          verticalSpaceMedium,
          InputWithLabel(
            labelText: 'Primary Contact Person\'s Email ID',
            controller: primaryPersonEmailController,
            keyboardType: TextInputType.emailAddress,
          ),
          verticalSpaceTiny,
          Visibility(
            visible: viewModel.hasPrimaryPersonEmailValidationMessage,
            child: Text(
              '${viewModel.primaryPersonEmailValidationMessage}',
              style: const TextStyle(color: primaryColor),
            ),
          ),
          verticalSpaceMedium,
          InputWithLabel(
            labelText: 'Primary Contact Person\'s Mobile',
            maxLength: 10,
            prefixIcon: SizedBox(
              height: 30,
              child: Row(
                children: [
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Text('+91',
                          style: AppTextStyle().countryCodeTextStyle)),
                  horizontalSpaceTiny,
                  Container(width: 1, height: 30, color: FontColor().lightGrey),
                ],
              ),
            ),
            controller: primaryPersonMobileController,
            keyboardType: TextInputType.number,
          ),
          verticalSpaceTiny,
          Visibility(
            visible: viewModel.hasPrimaryPersonMobileValidationMessage,
            child: Text(
              '${viewModel.primaryPersonMobileValidationMessage}',
              style: const TextStyle(color: primaryColor),
            ),
          ),
          verticalSpaceMedium,
          SizedBox(
              child: SelectDropList(
            viewModel.entityOption,
            viewModel.entityDropListModel,
            (optionItem) {
              viewModel.onEntityChange(optionItem,
                  viewModel.entityDropListModel.indexOf(optionItem));
            },
            labelText: 'Entity Type',
          )),
          if (viewModel.entityOption.title == 'Select') ...[
            verticalSpaceTiny,
            const Text(
              'Required',
              style: TextStyle(color: primaryColor),
            )
          ],
          verticalSpaceMedium,
          InputWithLabel(
            labelText: 'Entity ID (CIN or LLP No.)',
            controller: entityIdController,
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.number,
          ),
          verticalSpaceTiny,
          Visibility(
            visible: viewModel.hasEntityIdValidationMessage,
            child: Text(
              '${viewModel.entityIdValidationMessage}',
              style: const TextStyle(color: primaryColor),
            ),
          ),
          verticalSpaceMedium,
          Button(
              disabled: !viewModel.isFormValid(),
              onPressed: () => viewModel.sendEmailAndMobileVerificationOtp(
                  email: primaryPersonEmailController.text,
                  mobile: primaryPersonMobileController.text,
                  entityId: entityIdController.text,
                  primarycontactname: primaryPersonNameController.text),
              title: 'CONTINUE'),
          verticalSpaceSmall,
        ],
      ),
    );
  }
}
