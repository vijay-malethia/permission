import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:stacked/stacked_annotations.dart';

import '/ui/common/index.dart';
import '/ui/common/widgets/index.dart';
import '/ui/views/primary_person_detail/registration_viewmodel.dart';
import '/ui/bottom_sheets/assign_connect_to/assign_connect_to_sheet_model.dart';

@FormView(fields: [
  FormTextField(name: 'gstin'),
  FormTextField(name: 'pancard'),
  FormTextField(name: 'reraCertificate'),
])
class TaxDocumentView extends StackedView<RegistrationViewModel> {
  final String? email;
  final String? mobileNumber;
  final String? primarycontactname;
  final String? entityType;
  final String? entityId;
  const TaxDocumentView(
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
          verticalSpaceTiny,
          UploadDocument(
              title: 'Upload GSTIN',
              buttonTitle: gstinPath != null
                  ? gstinPath!.path.toString().split('/').last
                  : null,
              viewModel: viewModel,
              onPressed: () {
                viewModel.showImagePickerBottomSheet('GSTIN');
                // viewModel.pickGstinImage();
              },
              bottomText: gstinPath!=null?'Preview':'Required',),
          UploadDocument(
              title: 'Upload PAN',
              buttonTitle: pancardPath != null
                  ? pancardPath!.path.toString().split('/').last
                  : null,
              viewModel: viewModel,
              onPressed: () {
                viewModel.showImagePickerBottomSheet('PAN');
              },
              bottomText: pancardPath!=null?'Preview':'Required',),
          UploadDocument(
              title: 'Upload RERA Certificate',
              buttonTitle: reraCertificatePath != null
                  ? reraCertificatePath!.path.toString().split('/').last
                  : null,
              viewModel: viewModel,
              onPressed: () {
                viewModel.showImagePickerBottomSheet('RERA');
              },bottomText: 'Preview',),
          verticalSpaceExtraSmall,
          Button(
          
            disabled: !viewModel.isDocFormValid(),
              onPressed: () => viewModel.showLoadingBottomSheet(
                    email: email,
                    mobile: mobileNumber,
                    entityId: entityId,
                    entityType: entityType,
                    primarycontactname: primarycontactname,
                  ),
              title: 'CONTINUE')
        ],
      ),
    );
  }
}

class UploadDocument extends StatelessWidget {
  final String title;
  final String? buttonTitle;
  final void Function()? onPressed;
  final RegistrationViewModel viewModel;
  final String? bottomText;

  const UploadDocument({
    Key? key,
    required this.title,
    this.buttonTitle,
    required this.onPressed,
    required this.viewModel,
    this.bottomText
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTextStyle().inputLabelTextStyle()),
        verticalSpaceSmall,
        DottedBorder(
            dashPattern: const [5],
            padding: const EdgeInsets.all(1),
            borderType: BorderType.RRect,
            color: borderColor,
            radius: const Radius.circular(5),
            child: Button(
              onPressed: onPressed,
              textColor: primaryColor,
              backgroundColor: Colors.white,
              title: buttonTitle != null
                  ? buttonTitle!.split('/').last.toString()
                  : 'Click To Capture/Browse',
              height: 44,
            )),
        Container(
          height: 20,
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () =>bottomText=='Preview'? viewModel.showPreviewDialog(title):null,
            style: TextButton.styleFrom(
                minimumSize: const Size(50, 20),
                padding: EdgeInsets.zero,
                foregroundColor: primaryColor,
                textStyle: AppTextStyle()
                    .textButtonTextStyle(textColor: primaryColor)),
            child:  Text(bottomText!),
          ),
        )
      ],
    );
  }
}
