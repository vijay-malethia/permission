import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '/ui/common/index.dart';
import '/ui/common/widgets/index.dart';
import 'registration_process_sheet_model.dart';

class RegistrationProcessSheet
    extends StackedView<RegistrationProcessSheetModel> {
  final Function(SheetResponse response)? completer;
  final SheetRequest request;
  const RegistrationProcessSheet({
    Key? key,
    required this.completer,
    required this.request,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    RegistrationProcessSheetModel viewModel,
    Widget? child,
  ) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: const BoxDecoration(
        color: backgroundcolor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      child: ListView(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        children: [
          BottomSheetHeader(imageUrl: Images().documentImg),
          verticalSpaceExtraSmall,
          Text(
              'Please keep the following ready for an seamless registration process.',
              textAlign: TextAlign.center,
              style: AppTextStyle().descriptionTextStyle()),
          verticalSpaceSmall,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              ...viewModel.certificateTypes.map((type) {
                return Text(type, style: AppTextStyle().descriptionTextStyle());
              }),
              verticalSpaceExtraSmall,
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: viewModel.onCheckBoxValueChange,
                    child: Container(
                      height: 20,
                      width: 15,
                      alignment: Alignment.centerLeft,
                      child: Container(
                        height: 12,
                        width: 12,
                        decoration: BoxDecoration(
                            color: viewModel.isAgree ? borderColor : whiteColor,
                            borderRadius: BorderRadius.circular(2),
                            border: Border.all(width: 1, color: borderColor)),
                        padding: EdgeInsets.zero,
                        alignment: Alignment.center,
                        child: viewModel.isAgree
                            ? const Icon(
                                Icons.check,
                                size: 9,
                                color: whiteColor,
                              )
                            : null,
                      ),
                    ),
                  ),
                  Expanded(
                    child: RichText(
                      softWrap: true,
                      text: TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              viewModel.onCheckBoxValueChange();
                            },
                          text: ' By Proceeding, I agree to the ',
                          style: AppTextStyle().tncTextStyle(),
                          children: [
                            TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    viewModel
                                        .goToCondtions('Terms & Conditions',context);
                                  },
                                text: 'Terms & Conditions',
                                style: AppTextStyle().tncTextStyle(
                                    textColor: borderColor,
                                    fontWeight: FontWeight.w600)),
                            TextSpan(
                                text: ' and ',
                                style: AppTextStyle().tncTextStyle()),
                            TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    viewModel.goToCondtions('Privacy Policy',context);
                                  },
                                text: 'Privacy Policy',
                                style: AppTextStyle().tncTextStyle(
                                    textColor: borderColor,
                                    fontWeight: FontWeight.w600)),
                          ]),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
              verticalSpaceExtraSmall,
            ]),
          ),
          verticalSpaceSmall,
          Button(
              onPressed: () => viewModel.goToPrimaryPersonDeatilPage(context),
              title: 'I\'M READY')
        ],
      ),
    );
  }

  @override
  RegistrationProcessSheetModel viewModelBuilder(BuildContext context) =>
      RegistrationProcessSheetModel();
}
