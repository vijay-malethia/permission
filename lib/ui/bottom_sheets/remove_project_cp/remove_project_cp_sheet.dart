import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sales_lead/ui/common/index.dart';
import 'package:sales_lead/ui/common/widgets/index.dart';
import 'package:sales_lead/ui/views/channel_partner/channel_partner_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class RemoveProjectCpSheet extends StackedView<ChannelPartnerViewModel> {
  final Function(SheetResponse response)? completer;
  final SheetRequest request;
  const RemoveProjectCpSheet({
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
                    headerText: 'Remove Channel Partner From Project',
                    showDrag: true,
                    closeIconPadding: 15,
                  ),

                  Text(
                    'Showing your projects only',
                    style: AppTextStyle().smallText(),
                  ),
                  verticalSpaceExtraSmall,
                  if (viewModel.projectListForRemove != null &&
                      viewModel.projectListForRemove.length != 0)
                    Text('Swipe a project towards left to remove',
                        style: AppTextStyle()
                            .resendOtpTextStyle(textColor: FontColor().grey)),
                  verticalSpaceMedium,
                  //details card
                  viewModel.isBusy
                      ? const Center(
                          child: CircularProgressIndicator(color: primaryColor),
                        )
                      : Expanded(
                          child: ListView.builder(
                              itemCount: viewModel.projectListForRemove != null
                                  ? viewModel.projectListForRemove.length
                                  : 0,
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
                  if (viewModel.projectListForRemove != null &&
                      viewModel.projectListForRemove.length == 0) ...[
                    SizedBox(
                    height: screenHeight(context) / 2,
                    child: const Center(child: EmptyPlaceHolder())),
                  ],
                  verticalSpaceSmall,
                  Button(
                      onPressed: () {
                        viewModel.onCancel();
                      },
                      title: close),
                  verticalSpaceExtraSmall
                ]),
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
        action: request.data['isRemoveChannelPartner']?[
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
                  viewModel.showRemoveProjectDetails(context,index);
                 
                },
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        Images().removeIcon,
                        height: 18,
                        width: 18,
                      ),
                      verticalSpaceTiny,
                      Text(
                        'Remove',
                        style: Theme.of(context).textTheme.headlineSmall,
                      )
                    ]),
              ),
            ),
          )
        ]:[],
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
            title: Text(viewModel.projectListForRemove[index]['project_name'],
                style: AppTextStyle()
                    .inputLabelTextStyle(fontColor: FontColor().grey)),
            subtitle: Row(
              children: [
                SvgPicture.asset(Images().locationIcon, height: 13, width: 13),
                horizontalSpaceTiny,
                Text(viewModel.projectListForRemove[index]['city'],
                    style: Theme.of(context).textTheme.labelSmall),
              ],
            ),
            //circle container with leads count
            trailing: Column(
              children: [
                BadgeText.fromBadgeType(
                  text: viewModel.projectListForRemove[index]['lead_count']
                      .toString(),
                  badgeType: BadgeType.medium,
                ),
                verticalSpaceTiny,
                Text('Lead', style: Theme.of(context).textTheme.titleLarge)
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  ChannelPartnerViewModel viewModelBuilder(BuildContext context) =>
      ChannelPartnerViewModel()..getProjectsForRemove(request.data['id']);
}
