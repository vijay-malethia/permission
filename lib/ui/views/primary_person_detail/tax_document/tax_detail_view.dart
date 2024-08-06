import 'package:flutter/material.dart';
import 'package:sales_lead/ui/views/primary_person_detail/registration_viewmodel.dart';
import 'package:stacked/stacked.dart';

import '/ui/common/index.dart';
import '/ui/common/widgets/index.dart';
import '/ui/bottom_sheets/assign_connect_to/assign_connect_to_sheet_model.dart';
import 'tax_document_view.form.dart';

class TaxDetailView extends StackedView<RegistrationViewModel>
    with $TaxDocumentView {
  final String? email;
  final String? mobileNumber;
  final String? primarycontactname;
  final String? entityType;
  final String? entityId;
  const TaxDetailView(
      {this.email,
      this.mobileNumber,
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
    return Screen(
      bodyChild: renderBody(context, viewModel),
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
      RegistrationViewModel();

  Widget renderBody(BuildContext context, RegistrationViewModel viewModel) {
    return SingleChildScrollView(
      child: Column(
        children: [
          verticalSpaceSmall,
          const StepperIndicator(index: 1),
          verticalSpaceSmall,
          InputWithLabel(
            labelText: 'GSTIN Number',
            controller: gstinController,
            keyboardType: TextInputType.number,
          ),
          verticalSpaceTiny,
          renderImageAndAction(context, 'Upload GSTIN', viewModel,
              onPressed: viewModel.goBack,
              imageName: gstinPath == null
                  ? '----'
                  : gstinPath!.path.toString().split('/').last),
          verticalSpaceMedium,
          InputWithLabel(
            labelText: 'PAN Number',
            controller: pancardController,
            keyboardType: TextInputType.name,
          ),
          verticalSpaceTiny,
          renderImageAndAction(context, 'Upload PAN', viewModel,
              onPressed: viewModel.goBack,
              imageName: pancardPath == null
                  ? '----'
                  : pancardPath!.path.toString().split('/').last),
          verticalSpaceMedium,
          InputWithLabel(
            labelText: 'RERA ID',
            controller: reraCertificateController,
            keyboardType: TextInputType.number,
          ),
          verticalSpaceTiny,
          renderImageAndAction(context, 'Upload RERA Certificate', viewModel,
              onPressed: viewModel.goBack,
              imageName: reraCertificatePath == null
                  ? '----'
                  : reraCertificatePath!.path.toString().split('/').last),
          verticalSpaceMedium,
          Button(
              onPressed: () {
                gstinController.text.isNotEmpty && pancardController.text.isNotEmpty?
                viewModel.goToBasicDetailPage(
                  email: email,
                  mobile: mobileNumber,
                  entityId: entityId,
                  entityType: entityType,
                  primarycontactname: primarycontactname,
                  gstin: gstinController.text,
                  panNumber: pancardController.text,
                  reraId: reraCertificateController.text,
                ):showCustomToast(context, 'GST number and PAN number should not be empty', '');
              },
              title: 'CONTINUE')
        ],
      ),
    );
  }

  Widget renderImageAndAction(
      BuildContext context, String previewName, RegistrationViewModel viewModel,
      {required String imageName, required void Function()? onPressed}) {
    return Row(
      children: [
        horizontalSpaceTiny,
        SizedBox(
          width: screenWidth(context) * 0.5,
          child: Text(
            imageName,
            overflow: TextOverflow.ellipsis,
            style:
                AppTextStyle().textButtonTextStyle(textColor: FontColor().grey),
          ),
        ),
        const Expanded(child: SizedBox()),
        Container(
          height: 25,
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () => viewModel.showPreviewDialog(previewName),
            style: TextButton.styleFrom(
                minimumSize: const Size(50, 20),
                padding: EdgeInsets.zero,
                foregroundColor: primaryColor,
                textStyle: AppTextStyle()
                    .textButtonTextStyle(textColor: primaryColor)),
            child: const Text('Preview'),
          ),
        ),
        Container(height: 10, width: 1, color: primaryColor),
        Container(
          height: 25,
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: onPressed,
            style: TextButton.styleFrom(
                minimumSize: const Size(50, 20),
                padding: EdgeInsets.zero,
                foregroundColor: primaryColor,
                textStyle: AppTextStyle()
                    .textButtonTextStyle(textColor: primaryColor)),
            child: const Text('Replace'),
          ),
        ),
      ],
    );
  }
}
