import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '/ui/views/channel_partner/channel_partner_view.form.dart';
import '/ui/common/index.dart';
import '../../common/widgets/index.dart';
import '/ui/views/channel_partner/channel_partner_viewmodel.dart';

int? index;

class AssignProjectCpSheet extends StackedView<ChannelPartnerViewModel>
    with $ChannelPartnerView {
  final Function(SheetResponse response)? completer;
  final SheetRequest request;
  const AssignProjectCpSheet(
      {Key? key, required this.completer, required this.request})
      : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    ChannelPartnerViewModel viewModel,
    Widget? child,
  ) {
    return viewModel.isBusy
        ? const Center(
            child: CircularProgressIndicator(color: primaryColor),
          )
        : Container(
            height: screenHeight(context) * 0.70,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: const BoxDecoration(
              color: backgroundcolor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15)),
            ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const BottomSheetHeader(
                    headerText: 'Assign Projects to\n Channel Partner',
                    showDrag: true,
                    closeIconPadding: 15,
                  ),

                  if(index!=null)...[
                    verticalSpaceSmall,
                    renderHeaderCard(context,
                        companyName: request.data[index]['channel_partner_name'],
                        leadsCount: request.data[index]['leads_count'].toString(),
                        location: request.data[index]['projectList'].length != 0
                            ? request.data[index]['projectList'][0]
                            : null,
                        userCount: request.data[index]['user_count'].toString(),
                        projectCounts:
                            (request.data[index]['projectList'].length - 1)
                                .toString()),
                  ],
                  verticalSpaceExtraSmall,
                  if (viewModel.cpAssignProjectList.isNotEmpty)
                    Text('Swipe a project towards left to assign',
                        style: AppTextStyle().resendOtpTextStyle(
                            textColor: FontColor().darkgrey)),
                  verticalSpaceMedium,
                  //details card
                  viewModel.isBusy
                      ? const Center(
                          child: CircularProgressIndicator(color: primaryColor),
                        )
                      : Expanded(
                          child: ListView.builder(
                              itemCount: viewModel.cpAssignProjectList.length,
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(
                                  decelerationRate:
                                      ScrollDecelerationRate.normal),
                              itemBuilder: (context, index) {
                                return Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: renderDetailsCard(
                                        context, viewModel, index));
                              }),
                        ),
                  if (viewModel.cpAssignProjectList.isEmpty) ...[
                      SizedBox(
                    height: screenHeight(context) / 2,
                    child: const Center(child: EmptyPlaceHolder())),
                  ],
                  verticalSpaceSmall,
                  Button(
                      onPressed: () {
                        viewModel.isClose?
                        viewModel.onCancel():null;
                      },
                      title: close),
                  verticalSpaceExtraSmall
                ]),
          );
  }

//render bank details card
  Container renderHeaderCard(BuildContext context,
      {String? companyName,
      String? location,
      String? leadsCount,
      String? userCount,
      String? projectCounts}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10, top: 5),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: borderColor),
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
          ListTile(
            contentPadding: EdgeInsets.zero,
            //company name
            title:
                Text(companyName!, style: AppTextStyle().inputLabelTextStyle()),
            //location name
            subtitle: location != null
                ? Row(
                    children: [
                      SvgPicture.asset(Images().buildingIcon,
                          height: 12, width: 15),
                      horizontalSpaceTiny,
                      Text(location,
                          style: Theme.of(context).textTheme.labelSmall),
                      horizontalSpaceTiny,
                      Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 2, vertical: 1),
                          decoration: BoxDecoration(
                              color: lightBgColor,
                              borderRadius: BorderRadius.circular(4)),
                          child: Text('+$projectCounts',
                              style: Theme.of(context).textTheme.bodyMedium))
                    ],
                  )
                : const Text(''),
            //circle container with leads count
            trailing: BadgeText.fromBadgeType(
              text: leadsCount!,
              badgeType: BadgeType.large,
            ),
          ),
          //users count
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  SvgPicture.asset(Images().personIcon, height: 12, width: 12),
                  horizontalSpaceExtraSmall,
                  Text('$userCount Users',
                      style: AppTextStyle()
                          .resendOtpTextStyle(textColor: FontColor().grey))
                ],
              ),
              Row(
                children: [
                  Text('Leads', style: Theme.of(context).textTheme.titleLarge),
                  horizontalSpaceExtraSmall
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

//render details
  renderDetailsCard(
      BuildContext context, ChannelPartnerViewModel viewModel, index) {
    return Container(
      decoration: BoxDecoration(
        color: secondaryColor,
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
      child: SlidableTile(
        valueKey: index,
        motion: const BehindMotion(),
        action: [
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: secondaryColor,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(8),
                    bottomRight: Radius.circular(8)),
              ),
              alignment: Alignment.center,
              child: InkWell(
                onTap: () {
                  viewModel.onAssignProject(context: context, index: index, projectId: viewModel.cpAssignProjectList[index]
                          ['project_id'],cpId: chId);

                },
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        Images().plusIcon,
                        height: 18,
                        width: 18,
                      ),
                      verticalSpaceTiny,
                      Text(
                        'Assign',
                        style: Theme.of(context).textTheme.headlineSmall,
                      )
                    ]),
              ),
            ),
          )
        ],
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.only(left: 15, right: 15),
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            horizontalTitleGap: 0,
            leading: SizedBox(
                height: double.infinity,
                child: SvgPicture.asset(Images().buildingIcon,
                    height: 26, width: 33)),
            title: Text(
                viewModel.cpAssignProjectList[index]
                    ['project_name'],
                style: AppTextStyle()
                    .inputLabelTextStyle(fontColor: FontColor().grey)),
            subtitle: Row(
              children: [
                SvgPicture.asset(Images().locationIcon, height: 13, width: 13),
                horizontalSpaceTiny,
                Text(
                    viewModel.cpAssignProjectList[index]
                        ['city'],
                    style: Theme.of(context).textTheme.labelSmall),
              ],
            ),
            //circle container with leads count
            trailing: Column(
              children: [
                BadgeText.fromBadgeType(
                  text: viewModel.cpAssignProjectList[index]
                          ['user_count']
                      .toString(),
                  badgeType: BadgeType.medium,
                ),
                verticalSpaceTiny,
                Text(users, style: Theme.of(context).textTheme.titleLarge)
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  ChannelPartnerViewModel viewModelBuilder(BuildContext context) =>
      ChannelPartnerViewModel()..getAssigProject(chId!);
}
