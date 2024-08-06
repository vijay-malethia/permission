import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stacked/stacked.dart';

import '/ui/views/primary_person_detail/registration_viewmodel.dart';
import '/ui/common/index.dart';
import '/ui/common/widgets/index.dart';

class ApplicationSuccessView extends StackedView<RegistrationViewModel> {
  final String name;
  final String channelPartnerName;
  final String enrollmentNo;
  final int channelPartnerId;
  final int userId;
  const ApplicationSuccessView(
      {required this.channelPartnerName,
      required this.channelPartnerId,
      required this.enrollmentNo,
      required this.name,
      required this.userId,
      Key? key})
      : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    RegistrationViewModel viewModel,
    Widget? child,
  ) {
    return Screen(
      horizontalPadding: 0,
      bodyChild: Stack(
        children: [
          Positioned(
            top: screenHeight(context) / 4,
            left: 0,
            right: 0,
            child: SvgPicture.asset(
              Images().buildingImg,
              color: black12,
              height: 250,
              width: screenWidth(context),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ListView(
              shrinkWrap: true,
              children: [
                Center(
                    child: SvgPicture.asset(
                  Images().checked,
                  height: 75,
                  width: 75,
                )),
                verticalSpaceSmall,
                Text(
                  name,
                  textAlign: TextAlign.center,
                  style: AppTextStyle().loadingLabelTextStyle,
                ),
                verticalSpaceTiny,
                Text(
                  channelPartnerName,
                  textAlign: TextAlign.center,
                  style: AppTextStyle().partnerComapnyTextStyle(),
                ),
                verticalSpaceSmall,
                Text(
                  'Your empanelment\napplication number is ',
                  textAlign: TextAlign.center,
                  style: AppTextStyle().successDescriptionLargeTextStyle(),
                ),
                verticalSpaceTiny,
                Text(
                  enrollmentNo,
                  textAlign: TextAlign.center,
                  style: AppTextStyle().applicaitonNumberTextStyle,
                ),
                verticalSpaceTiny,
                Text(
                  'Your application has been forwarded to the concerned Team for review ',
                  textAlign: TextAlign.center,
                  style: AppTextStyle().descriptionTextStyle(),
                ),
                verticalSpaceSmall,
                Text(
                  'You will be notified soon via email',
                  textAlign: TextAlign.center,
                  style: AppTextStyle().descriptionTextStyle(),
                ),
                verticalSpaceMedium,
                Button(onPressed: viewModel.goToHome, title: 'OK'),
                verticalSpaceSmall,
              ],
            ),
          ),
        ],
      ),
      headerChild: Padding(
        padding: const EdgeInsets.only(left: 50.0, bottom: 45),
        child: Text(
          'Application submitted!',
          style: AppTextStyle().agreementTitleTextStyle(),
        ),
      ),
    );
  }

  @override
  RegistrationViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      RegistrationViewModel();
}
