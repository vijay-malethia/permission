import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '/ui/common/index.dart';
import '/ui/common/widgets/index.dart';
import '/ui/views/channel_partner/channel_partner_viewmodel.dart';

String userName = '';

class RemoveProjectSheet extends StackedView<ChannelPartnerViewModel> {
  final Function(SheetResponse response)? completer;
  final SheetRequest request;
  const RemoveProjectSheet({
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
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15))),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const BottomSheetHeader(
                headerText: 'Remove from Project', closeIconPadding: 0),
            verticalSpaceSmall,
            renderDetailCard(context),
            if (request.data['lead_count'] != 0) ...[
              Text('Assign existing leads to',
                  style: AppTextStyle()
                      .inputLabelTextStyle(fontColor: blackColor)),
              verticalSpaceSmall,
              Row(
                children: [
                  renderSelectContainer(viewModel, 'Someone Else', 0, () {
                    viewModel.onSelect(0);
                    viewModel
                        .getUserToReassignCPLead(request.data['project_id']);
                  }),
                  horizontalSpaceSmall,
                  renderSelectContainer(viewModel, 'No One', 1, () {
                    viewModel.onSelect(1);
                  }),
                ],
              ),
              verticalSpaceSmall,
              viewModel.selectedIndex == 0
                  ? SizedBox(
                      child: SelectDropList(
                      viewModel.entityUser,
                      viewModel.entityLeadsUSerList,
                      (optionItem) {
                        viewModel.onLeadsUSerChange(optionItem,
                            viewModel.entityLeadsUSerList.indexOf(optionItem));
                      },
                    ))
                  : verticalSpaceExtraSmall,
            ],
            verticalSpaceSmall,
            SizedBox(
              height: 50,
              child: Button(
                  onPressed: () {
                    viewModel
                        .removeProjectFromCp(
                            context: context,
                            chId: request.data['channel_partner_id'],
                            projectId: request.data['project_id'])
                        .then((value) =>
                            completer!.call(SheetResponse(confirmed: true)));
                  },
                  title: 'REMOVE'),
            )
          ],
        ),
      ),
    );
  }

// project details
  Container renderDetailCard(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: borderColor,
        boxShadow: const [
          BoxShadow(
            color: greyShade100,
            blurRadius: 1.0,
            spreadRadius: 1,
            offset: Offset(2, 2),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            clipBehavior: Clip.hardEdge,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: whiteColor,
              border: Border.all(color: whiteColor),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      SvgPicture.asset(Images().handShakeIcon,
                          color: borderColor,
                          height: 45,
                          width: 30,
                          alignment: Alignment.center),
                      Positioned(
                          left: 38,
                          child: CircleAvatar(
                            backgroundColor: defaultgreen,
                            radius: 6,
                            child: SvgPicture.asset('assets/images/check.svg'),
                          ))
                    ],
                  ),
                  //company name
                  title: Text(
                    request.data['channel_partner_name'],
                    style: AppTextStyle().sixteenPixel(textColor: primaryColor),
                  ),
                  //location name
                  subtitle: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(Images().buildingIcon,
                          height: 12, width: 15),
                      horizontalSpaceTiny,
                      Text(request.data['project_name'],
                          style: Theme.of(context).textTheme.labelSmall),
                    ],
                  ),
                  //circle container with leads count
                  trailing: Column(children: [
                    verticalSpaceTiny,
                    BadgeText.fromBadgeType(
                      text: request.data['lead_count'].toString(),
                      badgeType: BadgeType.medium,
                    ),
                    Text('Leads',
                        style: Theme.of(context).textTheme.titleLarge),
                  ]),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 7.0, horizontal: 15),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset(Images().person),
                horizontalSpaceTiny,
                Text(
                  userName,
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

//Select container widget
  renderSelectContainer(ChannelPartnerViewModel viewModel, String? title,
      int index, void Function()? onTap) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 45,
          padding: const EdgeInsets.symmetric(vertical: 10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: index == viewModel.selectedIndex ? lightpink : whiteColor,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                  color: index == viewModel.selectedIndex
                      ? primaryColor
                      : FontColor().brown),
              boxShadow: const [
                BoxShadow(
                    color: lightpink,
                    blurRadius: 10.0,
                    offset: Offset(7.0, 8.0))
              ]),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title!,
                style: AppTextStyle().buttonTextStyle(
                    index == viewModel.selectedIndex
                        ? primaryColor
                        : FontColor().grey2),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  ChannelPartnerViewModel viewModelBuilder(BuildContext context) =>
      ChannelPartnerViewModel();
}
