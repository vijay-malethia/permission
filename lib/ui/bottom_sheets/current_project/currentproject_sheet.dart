import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:flutter_switch/flutter_switch.dart';

import '/ui/common/index.dart';
import '/ui/common/widgets/index.dart';
import '/ui/views/channel_partner/channel_partner_viewmodel.dart';

class CurrentProjectSheet extends StackedView<ChannelPartnerViewModel> {
  final Function(SheetResponse response)? completer;
  final SheetRequest request;
  const CurrentProjectSheet({
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
                    imageUrl: Images().buildingWithBg,
                    showDrag: true,
                    closeIconPadding: 10),
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
                          text: viewModel.cpCurrentProjectList != null
                              ? viewModel.cpCurrentProjectList.length
                                  .toString()
                              : '',
                          style: AppTextStyle()
                              .sixteenPixel(textColor: primaryColor),
                        ),
                        TextSpan(
                          text: ' Current Projects',
                          style: AppTextStyle()
                              .sixteenPixel(textColor: FontColor().grey),
                        ),
                      ])),
                      FlutterSwitch(
                        value: viewModel.currentProjectSwitch,
                        height: 20,
                        width: 40,
                        padding: 2,
                        inactiveColor: greyShade100,
                        activeColor: secondaryColor,
                        onToggle: (value) => viewModel.onToggleSwitch(),
                      )
                    ],
                  ),
                ),
                verticalSpaceSmall,
                if( viewModel.cpCurrentProjectList != null
                          && viewModel.cpCurrentProjectList.length !=0)
                  Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: viewModel.cpCurrentProjectList != null
                            ? viewModel.cpCurrentProjectList.length
                            : 0,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return renderDetailsCard(context, viewModel, index);
                        }),
                  ),
                if (viewModel.cpCurrentProjectList != null &&
                    viewModel.cpCurrentProjectList.length == 0) ...[
                     SizedBox(
                    height: screenHeight(context) / 2,
                    child: const Center(child: EmptyPlaceHolder())),

                ]
              ],
            ),
    );
  }

  @override
  ChannelPartnerViewModel viewModelBuilder(BuildContext context) =>
      ChannelPartnerViewModel()..getCpCurrentProjectList(chId!,true);
}

//render details
Container renderDetailsCard(
    BuildContext context, ChannelPartnerViewModel viewModel, index) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.only(left: 15, right: 15),
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
      horizontalTitleGap: 0,
      leading: SizedBox(
          height: double.infinity,
          child:
              SvgPicture.asset(Images().buildingIcon, height: 26, width: 33)),
      title: Text(viewModel.cpCurrentProjectList[index]['project_name'],
          style:
              AppTextStyle().inputLabelTextStyle(fontColor: FontColor().grey)),
      subtitle: Row(
        children: [
          SvgPicture.asset(Images().locationIcon, height: 13, width: 13),
          horizontalSpaceTiny,
          Text(viewModel.cpCurrentProjectList[index]['city'],
              style: Theme.of(context).textTheme.labelSmall),
        ],
      ),
      //circle container with leads count
      trailing: Column(
        children: [
          BadgeText.fromBadgeType(
            text:
                viewModel.cpCurrentProjectList[index]['lead_count'].toString(),
            badgeType: BadgeType.medium,
          ),
          verticalSpaceTiny,
          Text('Leads', style: Theme.of(context).textTheme.titleLarge)
        ],
      ),
    ),
  );
}
