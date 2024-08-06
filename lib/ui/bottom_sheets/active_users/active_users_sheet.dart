import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '/ui/common/widgets/index.dart';
import '/ui/common/index.dart';
import '/ui/views/channel_partner/channel_partner_viewmodel.dart';

class ActiveUsersSheet extends StackedView<ChannelPartnerViewModel> {
  final Function(SheetResponse response)? completer;
  final SheetRequest request;
  const ActiveUsersSheet({
    Key? key,
    required this.completer,
    required this.request,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    ChannelPartnerViewModel viewModel,
    Widget? child,
  ) {
    return Container(
      height: screenHeight(context)*0.70,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: const BoxDecoration(
          color: backgroundcolor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          )),
      child: viewModel.isBusy
          ? const Center(child: CircularProgressIndicator(color: primaryColor))
          : Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                  BottomSheetHeader(
                      imageUrl: Images().personsIcon, showDrag: true),
                  verticalSpaceSmall,
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(horizontal: 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                            text: TextSpan(text: '', children: [
                          TextSpan(
                            text: viewModel.cpActiveUserList != null
                                ? viewModel
                                    .cpActiveUserList['entity_list'].length
                                    .toString()
                                : '',
                            style: AppTextStyle()
                                .sixteenPixel(textColor: primaryColor),
                          ),
                          TextSpan(
                              text: ' Active Users',
                              style: AppTextStyle()
                                  .sixteenPixel(textColor: FontColor().grey)),
                        ])),
                        FlutterSwitch(
                          value: viewModel.activeUsersSwitch,
                          height: 20,
                          width: 40,
                          padding: 2,
                          inactiveColor: customGrey,
                          activeColor: secondaryColor,
                          onToggle: (value) =>
                              viewModel.onActiveUsersSwitch(),
                        )
                      ],
                    ),
                  ),
                  verticalSpaceSmall,
                  if(viewModel.cpActiveUserList != null
                            && viewModel.cpActiveUserList['entity_list'].length!=0)
                    Expanded(
                      child: ListView.builder(
                          itemCount: viewModel.cpActiveUserList != null
                              ? viewModel.cpActiveUserList['entity_list'].length
                              : 0,
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(
                              decelerationRate: ScrollDecelerationRate.normal),
                          itemBuilder: (context, index) {
                            return renderDetailsCard(context, index, viewModel);
                          }),
                    ),
                  if (viewModel.cpActiveUserList != null &&
                      viewModel.cpActiveUserList['entity_list'].length ==
                          0) ...[
                      SizedBox(
                    height: screenHeight(context) / 2,
                    child: const EmptyPlaceHolder()),
                  ]
                ]),
    );
  }

//render users card
  Container renderDetailsCard(
      BuildContext context, index, ChannelPartnerViewModel viewModel) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      margin: const EdgeInsets.only(bottom: 12),
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
        horizontalTitleGap: 8,
        leading: Stack(
          alignment: Alignment.topRight,
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: greyShade100,
              child: viewModel.cpActiveUserList['entity_list'][index]
                      ['profile_picture_url'] ??  SvgPicture.asset(
                    Images().leadPerson,
                  ),
            ),
            Positioned(
                top: 2,
                left: 28,
                child: CircleAvatar(
                  backgroundColor: defaultgreen,
                  radius: 6,
                  child: SvgPicture.asset('assets/images/check.svg'),
                ))
          ],
        ),
        title: Row(
          children: [
            Text(viewModel.cpActiveUserList['entity_list'][index]['name'],
                style: AppTextStyle()
                    .inputLabelTextStyle(fontColor: FontColor().grey)),
            horizontalSpaceExtraSmall,
            InkWell(
              onTap: (){
                viewModel.showCallDialog(viewModel.cpActiveUserList['entity_list'][index]['name'],viewModel.cpActiveUserList['entity_list'][index]['mobile_number']);
              },
              child: SvgPicture.asset(
                Images().callIcon,
                height: 12,
                width: 12,
                color: borderColor,
              ),
            )
          ],
        ),
        //circle container with leads count
        trailing: Column(
          children: [
            BadgeText.fromBadgeType(
              text: viewModel.cpActiveUserList['entity_list'][index]
                      ['leads_count']
                  .toString(),
              badgeType: BadgeType.medium,
            ),
            verticalSpaceTiny,
            Text('Leads', style: Theme.of(context).textTheme.titleLarge)
          ],
        ),
      ),
    );
  }

  @override
  ChannelPartnerViewModel viewModelBuilder(BuildContext context) =>
      ChannelPartnerViewModel()..getCpActiveUsers(chId!,true);
}
