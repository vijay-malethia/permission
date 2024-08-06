import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stacked/stacked.dart';

import '/ui/common/index.dart';
import '/ui/widgets/common/scroll_screen/scroll_screen.dart';
import '/ui/common/widgets/index.dart';
import '/ui/views/channel_partner/channel_partner_view.form.dart';
import '/ui/views/channel_partner/channel_partner_viewmodel.dart';

// ignore: must_be_immutable
class ChannelpartnercarddetaisView extends StackedView<ChannelPartnerViewModel>
    with $ChannelPartnerView {
  bool showDeactive;
  int chId;
  ChannelpartnercarddetaisView(
      {required this.showDeactive, required this.chId, Key? key})
      : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    ChannelPartnerViewModel viewModel,
    Widget? child,
  ) {
    return ImageScrollBarHeader(
        bodyChild: viewModel.isBusy
            ? SizedBox(
              height: screenHeight(context)/2,
              child: const Center(child: CircularProgressIndicator(color: primaryColor)))
            : viewModel.cpDeatilsList != null
                ? _renderBody(context, viewModel)
                : Container(),
        onBackArrowTap: viewModel.goBack,
        headerTitle: channelPartner,
        horizontalPadding: 0);
  }

//render whitecard
  Container renderCard(
    Widget child,
  ) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: greyShade100,
            blurRadius: 1.0,
            spreadRadius: 1,
            offset: Offset(2, 2),
          )
        ],
      ),
      child: child,
    );
  }

//render app no. or users and leads count
  Container _renderApplicationNumber(ChannelPartnerViewModel viewModel) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: borderColor),
        boxShadow: const [
          BoxShadow(
            color: black12,
            blurRadius: 1.0,
            spreadRadius: 1,
            offset: Offset(0, 3),
          )
        ],
      ),
      child: showDeactive
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${viewModel.cpDeatilsList['user_count']} Users',
                  style: AppTextStyle().buttonTextStyle(borderColor),
                ),
                Container(
                    width: 2,
                    height: 15,
                    color: borderColor,
                    margin: const EdgeInsets.symmetric(horizontal: 10)),
                Text(
                  '${viewModel.cpDeatilsList['leads_count']} Leads',
                  style: AppTextStyle().buttonTextStyle(borderColor),
                )
              ],
            )
          : Text(
              'Application # : ${viewModel.cpDeatilsList['enrollment_no']}',
              style: AppTextStyle().buttonTextStyle(borderColor),
            ),
    );
  }

//render icon with text
  Row renderTextwithIcon({String? title, String? icon}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(icon!, width: 16, height: 14),
        horizontalSpaceTiny,
        Text(title!, style: AppTextStyle().mediumSmallText())
      ],
    );
  }

  Container renderActiveCard(
      {String? title,
      String? icon,
      double? height,
      double? width,
      String? count}) {
    return renderCard(Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SvgPicture.asset(icon!, height: height, width: width),
            horizontalSpaceExtraSmall,
            Text(title!, style: AppTextStyle().mediumSmallText()),
          ],
        ),
        Row(
          children: [
            BadgeText.fromBadgeType(text: count!, badgeType: BadgeType.small),
            horizontalSpaceTiny,
            SvgPicture.asset(Images().forwardArrowIcon, height: 20, width: 20),
          ],
        )
      ],
    ));
  }

//render body
  Stack _renderBody(BuildContext context, ChannelPartnerViewModel viewModel) {
    return Stack(
      children: [
        // if (viewModel.accept != true)
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: SvgPicture.asset(
            Images().buildingImg,
            color: black12,
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // drag handle
              // if (viewModel.accept != true)
              Container(
                height: 3,
                width: screenWidth(context) / 6,
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                    color: customLightGrey,
                    borderRadius: BorderRadius.circular(1.5)),
              ),
              //comapany name
              Text(
                viewModel.cpDeatilsList['channel_partner_name'] ?? '',
                style: AppTextStyle().sixteenPixel(textColor: primaryColor),
                textAlign: TextAlign.center,
              ),
              verticalSpaceExtraSmall,
              Text(viewModel.cpDeatilsList['website'] ?? '',
                  style: AppTextStyle().descriptionTextStyle()),
              verticalSpaceExtraSmall,
              //application number or users and leads count
              _renderApplicationNumber(viewModel),
              verticalSpaceSmall,
              //address card
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: const [
                    BoxShadow(
                      color: greyShade100,
                      blurRadius: 1.0,
                      spreadRadius: 1,
                      offset: Offset(2, 2),
                    )
                  ],
                ),
                child: Row(
                  children: [
                    SvgPicture.asset(Images().buildingLocationIcon,
                        height: 33, width: 34),
                    horizontalSpaceExtraSmall,
                    Expanded(
                      child: Text(
                        viewModel.generateAddressString(viewModel.cpDeatilsList),
                        style: AppTextStyle()
                            .resendOtpTextStyle(textColor: FontColor().grey),
                        textAlign: TextAlign.start,
                      ),
                    )
                  ],
                ),
              ),
              verticalSpaceSmall,
              //personal details card
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: const [
                    BoxShadow(
                      color: greyShade100,
                      blurRadius: 1.0,
                      spreadRadius: 1,
                      offset: Offset(2, 2),
                    )
                  ],
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: SvgPicture.asset(Images().circleUser),
                  title: Text(viewModel.cpDeatilsList['name'],
                      style: AppTextStyle()
                          .descriptionTextStyle(fontFamily: 'Nexa-Bold')),
                  subtitle: Text(
                      '${viewModel.cpDeatilsList['email_address']}\n${viewModel.cpDeatilsList['mobile_number']}',
                      style: AppTextStyle().tncTextStyle(height: 1.7)),
                  trailing: InkWell(
                    onTap: () {
                      viewModel.showCallDialog(viewModel.cpDeatilsList['name'],
                          viewModel.cpDeatilsList['mobile_number']);
                    },
                    child: SvgPicture.asset(Images().callIcon,
                        height: 20, width: 20, color: borderColor),
                  ),
                ),
              ),
              verticalSpaceSmall,
              //
              renderCard(Row(
                children: [
                  Expanded(
                    child: renderTextwithIcon(
                        icon:
                            viewModel.cpDeatilsList['rera_img_name'] != null &&
                                    viewModel.cpDeatilsList['rera_img_name']
                                        .isNotEmpty
                                ? Images().greenCircleCheck
                                : Images().cancelRedCircle,
                        title: 'RERA'),
                  ),
                  Container(
                    height: 15,
                    width: 2,
                    color: customLightGrey,
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                  ),
                  Expanded(
                    child: renderTextwithIcon(
                        icon: viewModel.cpDeatilsList['gst_img_name'] != null &&
                                viewModel
                                    .cpDeatilsList['gst_img_name'].isNotEmpty
                            ? Images().greenCircleCheck
                            : Images().cancelRedCircle,
                        title: 'GST'),
                  ),
                  Container(
                    height: 15,
                    width: 2,
                    color: customLightGrey,
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                  ),
                  Expanded(
                    child: renderTextwithIcon(
                        icon: viewModel.cpDeatilsList['pan_img_name'] != null &&
                                viewModel
                                    .cpDeatilsList['pan_img_name'].isNotEmpty
                            ? Images().greenCircleCheck
                            : Images().cancelRedCircle,
                        title: 'PAN'),
                  ),
                ],
              )),
              verticalSpaceSmall,
              //bank details card
              InkWell(
                onTap: () {
                  viewModel.showBankAccountDetails();
                },
                child: renderCard(Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(Images().bankIcon,
                            height: 24, width: 23),
                        horizontalSpaceExtraSmall,
                        Text('Bank Account Details',
                            style: AppTextStyle().mediumSmallText()),
                      ],
                    ),
                    SvgPicture.asset(Images().forwardArrowIcon,
                        height: 20, width: 20)
                  ],
                )),
              ),
              if (showDeactive) ...[
                verticalSpaceSmall,
                //render active users
                InkWell(
                  onTap: () {
                    viewModel.cpDeatilsList['user_count'] != 0
                        ? viewModel.showActiveUsersSheet(chId)
                        : null;
                    // viewModel.showActiveUsersSheet();
                  },
                  child: renderActiveCard(
                      count: viewModel.cpDeatilsList['user_count'].toString(),
                      height: 24,
                      icon: Images().userIcon,
                      title: 'Active Users',
                      width: 23),
                ),
                verticalSpaceSmall,
                //active leads
                renderActiveCard(
                    count: viewModel.cpDeatilsList['leads_count'].toString(),
                    title: 'Active Leads',
                    icon: Images().leadsPersonIcon,
                    height: 27,
                    width: 23),
                verticalSpaceSmall,
                //current project card
                InkWell(
                  onTap: () {
                    viewModel.cpDeatilsList['active_project_count'] != 0
                        ? viewModel.showCurrentProjectSheet(chId)
                        : null;
                  },
                  child: renderActiveCard(
                      count: viewModel.cpDeatilsList['active_project_count']
                          .toString(),
                      height: 20,
                      width: 26,
                      icon: Images().buildingIcon,
                      title: 'Current Projects'),
                )
              ],

              verticalSpaceMedium,
              if (showDeactive != true && viewModel.sharedService.isReviewCP!)
                Row(
                  children: [
                    //accept button
                    Expanded(
                        child: Button(
                            onPressed: () {
                              viewModel.onAcceptReject(
                                context,
                                  viewModel.cpDeatilsList['channel_partner_id'],
                                  true,
                                  searchController.text);
                            },
                            title: accept)),
                    horizontalSpaceMedium,
                    //reject button
                    Expanded(
                        child: Button(
                            onPressed: () {
                              viewModel.onAcceptReject(
                                context,
                                  viewModel.cpDeatilsList['channel_partner_id'],
                                  false,
                                  searchController.text);
                            },
                            title: reject,
                            borderColor: secondaryColor,
                            backgroundColor: secondaryColor))
                  ],
                ),
              if (showDeactive == true &&
                  viewModel.sharedService.isDeactivateCP!)
                Button(
                    onPressed: () {
                      viewModel.showDeactiveDialog(chId);
                    },
                    title: 'DEACTIVATE'),
              verticalSpaceMedium,
            ],
          ),
        ),
      ],
    );
  }

  @override
  ChannelPartnerViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      ChannelPartnerViewModel()..getCpDetails(chId);
}
