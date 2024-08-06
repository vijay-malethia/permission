import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import '../home/home_viewmodel.dart';
import '/ui/common/widgets/index.dart';
import '/ui/common/index.dart';
import 'create_user_view.form.dart';
import 'create_user_viewmodel.dart';

@FormView(fields: [
  FormTextField(name: 'name'),
  FormTextField(name: 'email'),
  FormTextField(name: 'mobile'),
  FormTextField(name: 'phoneOtp'),
  FormTextField(name: 'emailOtp'),
])
class CreateUserView extends StackedView<CreateUserViewModel>
    with $CreateUserView {
  final bool isUserDstMember;
  const CreateUserView({required this.isUserDstMember, Key? key})
      : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    CreateUserViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      body: Stack(
        children: [
          Screen(
            headerChild: Row(
              children: [
                IconButton(
                    onPressed: () {
                      viewModel.goBack();
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: whiteColor,
                    )),
                Text(
                  isUserDstMember
                      ? 'Add DST Member'
                      : 'Add Channel Partner User',
                  style: AppTextStyle().agreementTitleTextStyle(),
                )
              ],
            ),
            bodyChild: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    height: 3,
                    width: screenWidth(context) / 6,
                    decoration: BoxDecoration(
                        color: customLightGrey,
                        borderRadius: BorderRadius.circular(1.5)),
                  ),
                  verticalSpaceMedium,
                  InputWithLabel(
                    labelText: 'Name',
                    controller: nameController,
                    keyboardType: TextInputType.name,
                  ),
                  verticalSpaceTiny,
                  Visibility(
                    visible: viewModel.hasNameValidationMessage,
                    child: Text(
                      '${viewModel.nameValidationMessage}',
                      style: const TextStyle(color: primaryColor),
                    ),
                  ),
                  verticalSpaceMedium,
                  InputWithLabel(
                    labelText: 'Email ID',
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  verticalSpaceTiny,
                  Visibility(
                    visible: viewModel.hasEmailValidationMessage,
                    child: Text(
                      '${viewModel.emailValidationMessage}',
                      style: const TextStyle(color: primaryColor),
                    ),
                  ),
                  verticalSpaceMedium,
                  InputWithLabel(
                    labelText: 'Mobile',
                    textInputAction: TextInputAction.done,
                    prefixIcon: SizedBox(
                      height: 30,
                      child: Row(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
                            child: Text(
                              '+ 91',
                              style: AppTextStyle().countryCodeTextStyle,
                            ),
                          ),
                          horizontalSpaceTiny,
                          Container(
                              width: 1,
                              height: 30,
                              color: FontColor().lightGrey),
                        ],
                      ),
                    ),
                    controller: mobileController,
                    keyboardType: TextInputType.number,
                    maxLength: 10,
                  ),
                  verticalSpaceTiny,
                  Visibility(
                    visible: viewModel.hasMobileValidationMessage,
                    child: Text(
                      '${viewModel.mobileValidationMessage}',
                      style: const TextStyle(color: primaryColor),
                    ),
                  ),
                  verticalSpaceMedium,
                  SizedBox(
                      child: SelectDropList(
                    designationOption,
                    viewModel.designationDropList,
                    (optionItem) {
                      viewModel.onDesignationChange(optionItem,
                          viewModel.designationDropList.indexOf(optionItem));
                    },
                    labelText: 'Designation',
                  )),
                  if (designationOption.title == '') ...[
                    verticalSpaceTiny,
                    const Text(
                      'Required',
                      style: TextStyle(color: primaryColor),
                    )
                  ],
                  if (isUserDstMember) ...[
                    verticalSpaceMedium,
                    SizedBox(
                        child: SelectDropList(
                      reportingOption,
                      viewModel.reportingDropListModel,
                      (optionItem) {
                        viewModel.onReportingChange(
                            optionItem,
                            viewModel.reportingDropListModel
                                .indexOf(optionItem));
                      },
                      labelText: 'Reporting to',
                    )),
                    if (reportingOption.title == '') ...[
                      verticalSpaceTiny,
                      const Text(
                        'Required',
                        style: TextStyle(color: primaryColor),
                      )
                    ],
                  ],
                  verticalSpaceMedium,
                  verticalSpaceTiny,
                  Button(
                      disabled: !viewModel.isFormValid(isUserDstMember),
                      onPressed: () {
                        HomeViewModel().sharedService.isDstUser!
                            ? viewModel.sendEmailAndMobileVerificationOtp(
                                email: emailController.text,
                                mobile: mobileController.text)
                            : viewModel.createUser(
                                email: emailController,
                                mobile: mobileController,
                                name: nameController,
                                profilePicture: userImagePath,
                                emailOtp: emailOtpController,
                                phoneOtp: phoneOtpController);
                      },
                      title: 'SUBMIT'),
                ],
              ),
            ),
          ),
          Positioned(
              right: 30,
              top: 120,
              child: InkWell(
                onTap: () {
                  viewModel.showImagePickerBottomSheet();
                },
                child: Column(
                  children: [
                    userImagePath.isNotEmpty
                        ? Container(
                            height: 85,
                            width: 85,
                            decoration: BoxDecoration(
                              border: Border.all(color: borderColor),
                              color: backgroundcolor,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.file(
                                File(userImagePath),
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                        : SvgPicture.asset(
                            Images().createUserCameraIcon,
                            height: 85,
                            width: 85,
                          ),
                    verticalSpaceTiny,
                    Text(
                      'Tap to upload',
                      style: AppTextStyle()
                          .tncTextStyle(textColor: FontColor().lightGrey),
                    )
                  ],
                ),
              )),
        ],
      ),
    );
  }

  @override
  CreateUserViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      CreateUserViewModel();

  @override
  void onDispose(CreateUserViewModel viewModel) {
    super.onDispose(viewModel);
    disposeForm();
  }

  @override
  void onViewModelReady(CreateUserViewModel viewModel) {
    syncFormWithViewModel(viewModel);
  }
}
