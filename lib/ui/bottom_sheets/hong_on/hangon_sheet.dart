import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sales_lead/ui/views/primary_person_detail/registration_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '/ui/common/index.dart';

class HangOnSheet extends StackedView<RegistrationViewModel> {
  final Function(SheetResponse response)? completer;
  final SheetRequest request;
  const HangOnSheet({
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
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: const BoxDecoration(
          color: backgroundcolor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 3,
                  width: screenWidth(context) / 5,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: secondaryColor),
                ),
                Container(
                  height: 3,
                  width: screenWidth(context) / 5,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: customLightGrey),
                ),
                Container(
                  height: 3,
                  width: screenWidth(context) / 5,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: customLightGrey),
                ),
                Container(
                  height: 3,
                  width: screenWidth(context) / 5,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: customLightGrey),
                ),
              ],
            ),
            verticalSpaceLarge,
            Center(child: SvgPicture.asset(Images().validateBankAcIcon)),
            verticalSpaceExtraSmall,
            Text('Hang On!', style: AppTextStyle().loadingLabelTextStyle),
            verticalSpaceTiny,
            Text(
              'Extracting & Validating your information.\nThanks for your patience!',
              style: AppTextStyle().descriptionTextStyle(),
              textAlign: TextAlign.center,
              softWrap: true,
            ),
            verticalSpaceSmall,
          ],
        ),
      ),
    );
  }

  @override
  RegistrationViewModel viewModelBuilder(BuildContext context) =>
      RegistrationViewModel();
}
