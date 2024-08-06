import 'package:flutter/material.dart';
import 'package:floating_draggable_widget/floating_draggable_widget.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:sales_lead/ui/common/widgets/empty_placeholder.dart';
import 'package:stacked/stacked.dart';

import '/ui/common/index.dart';
import '/ui/common/widgets/screen.dart';
import '/ui/common/widgets/slidable_tile.dart';
import '/ui/common/widgets/customtile.dart';
import '../all_leads/all_leads_viewmodel.dart';
import 'lead_details_card.dart';

class FollowUpDetailView extends StackedView<AllLeadsViewModel> {
  final int leadId;
  const FollowUpDetailView({required this.leadId, Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    AllLeadsViewModel viewModel,
    Widget? child,
  ) {
    return FloatingDraggableWidget(
        mainScreenWidget: _renderBackgroundScreen(context, viewModel),
        floatingWidget: _renderFloatingActionButton(context, viewModel),
        floatingWidgetWidth: screenDimension(context) / 25,
        floatingWidgetHeight: screenDimension(context) / 25);
  }

// Background Screen
  _renderBackgroundScreen(BuildContext context, AllLeadsViewModel viewModel) {
    return viewModel.isBusy
        ? const Center(child: CircularProgressIndicator(color: primaryColor))
        : Stack(
            children: [
              Screen(
                height: MediaQuery.sizeOf(context).height * 0.275,
                isRadiusColor: false,
                isFollowUpView: true,
                verticalPadding: viewModel.currentFollowUpTab == 0 ? 10 : 0,
                horizontalPadding: viewModel.currentFollowUpTab == 0 ? 10 : 0,
                headerChild: _renderHeader(viewModel, context),
                bodyChild: viewModel.currentFollowUpTab == 0
                    ? _renderBody(viewModel, context)
                    : _renderCallRecordsBody(viewModel, leadId),
              ),
            ],
          );
  }

// Draggable floating action button
  _renderFloatingActionButton(
      BuildContext context, AllLeadsViewModel viewModel) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          boxShadow: const [
            BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.25),
                blurRadius: 4,
                spreadRadius: 0,
                offset: Offset(0, 4))
          ]),
      child: FloatingActionButton(
          backgroundColor: secondaryColor,
          onPressed: viewModel.addSchedule,
          child: SvgPicture.asset(
            Images().addIcon,
            height: screenDimension(context) / 52,
          )),
    );
  }

  _renderBody(AllLeadsViewModel viewModel, context) {
    return RefreshIndicator(
      color: primaryColor,
      onRefresh: () => viewModel.pullToRefreshFollowUp(leadId),
      child: Column(
        children: [
          renderSelectBar(viewModel),
          verticalSpaceSmall,
          _recordCount(viewModel.followUpMap['totalCount']),
          verticalSpaceExtraSmall,
          Expanded(
            child: ListView.builder(
                controller: viewModel.scrollController,
                padding: const EdgeInsets.all(0),
                itemCount: viewModel.followUpList.length + 1,
                itemBuilder: (ctx, index) {
                  return viewModel.followUpList.isEmpty
                      ? SizedBox(
                          height: screenHeight(context) * .4,
                          child: const EmptyPlaceHolder(msg: ''))
                      : index < viewModel.followUpList.length
                          ? _userInfoCard(
                              index, viewModel, viewModel.followUpList)
                          : index == viewModel.followUpMap['totalCount']
                              ? const SizedBox()
                              : const Center(
                                  child: CircularProgressIndicator(
                                      color: primaryColor));
                }),
          )
        ],
      ),
    );
  }

  @override
  AllLeadsViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      AllLeadsViewModel()..initFollowUp(leadId);

  //Header
  _renderHeader(AllLeadsViewModel viewModel, BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                  onTap: viewModel.goBack,
                  child: const Icon(Icons.arrow_back, color: whiteColor)),
              horizontalSpaceTiny,
              Text('${viewModel.followUpMap['lead_info']['lead_name'] ?? ''}',
                  style: AppTextStyle().sixteenPixel()),
              Row(children: [
                SvgPicture.asset(Images().buildingIcon, color: whiteColor),
                horizontalSpaceTiny,
                Text(
                    '${viewModel.followUpMap['lead_info']['project_name'].join(',')}',
                    style: AppTextStyle()
                        .tncTextStyle(textColor: FontColor().orange2)),
                const Spacer(),
                Stack(
                  alignment: Alignment.centerRight,
                  children: [
                    Container(
                        height: 18,
                        width: 75,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Color(int.parse(
                                '0xff${viewModel.followUpMap['lead_info']['color_code_1'].toString().split('#').last}')),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                                color: Color(int.parse(
                                    '0xff${viewModel.followUpMap['lead_info']['color_code_2'].toString().split('#').last}')))),
                        child: Text(
                            viewModel.followUpMap['lead_info']
                                    ['lead_stage_name'] ??
                                '',
                            style: AppTextStyle()
                                .ninePixel(fontColor: FontColor().black2))),
                    // Positioned(
                    //   right: 8,
                    //   child: SvgPicture.asset(Images().editPen),
                    // )
                  ],
                )
              ]),
              if (viewModel
                  .followUpMap['lead_info']['assigned_to_name'].isNotEmpty)
                Row(children: [
                  SvgPicture.asset(Images().handShakeIcon, color: whiteColor),
                  horizontalSpaceTiny,
                  Text(
                      viewModel.followUpMap['lead_info']['assigned_to_name'] ??
                          '',
                      style: AppTextStyle()
                          .tncTextStyle(textColor: FontColor().orange2))
                ]),
              Row(children: [
                SvgPicture.asset(Images().calenderBook, color: whiteColor),
                horizontalSpaceExtraSmall,
                Text(
                    'Lead Age: ${viewModel.followUpMap['lead_info']['lead_age']} Days',
                    style: AppTextStyle()
                        .textButtonTextStyle(textColor: lightYellow))
              ]),
              verticalSpaceTiny,
              Text(
                  'Days since Last Follow up : ${viewModel.followUpMap['lead_info']['last_followup_days'] ?? 0} | Next Follow up :${viewModel.followUpMap['lead_info']['next_followup']}',
                  style: AppTextStyle().smallText(
                      fontFamily: 'Nexa-Bold', fontColor: FontColor().white)),
            ],
          ),
        ),
        Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () => viewModel.onTabTap(0),
                child: Container(
                  height: 30,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                      color: backgroundcolor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      )),
                  child: Text('Follow Ups',
                      style: AppTextStyle()
                          .toastMessageTextStyle(fontColor: FontColor().black)),
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  viewModel.onTabTap(1);
                  // viewModel.getListOfCallRecordsByFollowUpId(leadId: leadId);
                },
                child: Container(
                    height: 30,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                        color: callRecordBgColor,
                        boxShadow: [
                          BoxShadow(
                              color: greyShade100,
                              blurRadius: 3.0,
                              spreadRadius: 5.0,
                              offset: Offset(5.0, 15.0))
                        ],
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        )),
                    child: Text('Call Records',
                        style: AppTextStyle().toastMessageTextStyle(
                            fontColor: FontColor().darkRed))),
              ),
            ),
          ],
        )
      ],
    );
  }

//Render Select Bar
  Widget renderSelectBar(AllLeadsViewModel viewModel) {
    return Row(
      children: [
        Expanded(
          flex: 5,
          child: Container(
            height: 23,
            decoration: BoxDecoration(
                color: tabBg, borderRadius: BorderRadius.circular(25)),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                    viewModel.followupStatusForSearchList.length + 1,
                    (index) => renderTab(
                        viewModel,
                        index == 0
                            ? 'All'
                            : viewModel.followupStatusForSearchList[index - 1]
                                ['followup_status_name'],
                        index - 1))),
          ),
        ),
        horizontalSpaceTiny,
        InkWell(
          onTap: () => viewModel.showFollowUpFilter(leadId),
          child: Container(
              height: 23,
              width: 30,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: grey9, borderRadius: BorderRadius.circular(15)),
              child: SvgPicture.asset(
                viewModel.isFollupUpFilterApplied()
                    ? Images().checkMenu
                    : Images().menuIcon,
                height: 13,
                width: 13,
              )),
        )
      ],
    );
  }

  GestureDetector renderTab(AllLeadsViewModel viewModel, name, index) {
    return GestureDetector(
      onTap: () {
        viewModel.selectTab(name, index, leadId);
      },
      child: Container(
        alignment: Alignment.center,
        height: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            color: viewModel.selectedTab == name ? orange : transparent,
            borderRadius: BorderRadius.circular(25)),
        child: Text(
          name,
          style: AppTextStyle().selectBar(
              viewModel.selectedTab == name ? whiteColor : blackColor),
        ),
      ),
    );
  }

  //User info Card
  _userInfoCard(index, AllLeadsViewModel viewModel, list) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          color:
              viewModel.canUpdate(viewModel.followUpList[index]['stopupdate'])
                  ? secondaryColor
                  : FontColor().lightGrey,
          borderRadius: BorderRadius.circular(10)),
      child: SlidableTile(
          motion: const BehindMotion(),
          valueKey: index,
          action: [
            Expanded(
              child: InkWell(
                onTap: () {
                  if (viewModel
                      .canUpdate(viewModel.followUpList[index]['stopupdate'])) {
                    viewModel.updateFollowUpBottomSheet(
                        list[index]['followup_id'] ?? 0);
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: viewModel.canUpdate(
                              viewModel.followUpList[index]['stopupdate'])
                          ? secondaryColor
                          : FontColor().lightGrey,
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10))),
                  alignment: Alignment.center,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(Images().updateIcon),
                        verticalSpaceTiny,
                        Text('Update',
                            style:
                                AppTextStyle().ninePixel(fontColor: whiteColor))
                      ]),
                ),
              ),
            ),
          ],
          child: CustomTile(
            bgColor: lightBlue2,
            slideCard: (list[index]['created_remarks'] != null ||
                    list[index]['followup_remarks'] != null ||
                    list[index]['created_remarks_audio'] != null ||
                    list[index]['followup_client_feedback'] != null ||
                    list[index]['followup_remarks_audio'] != null)
                ? Container(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        renderAudio(note: list[index]['created_remarks'] ?? ""),
                        if (list[index]['followup_remarks'] != null ||
                            list[index]['created_remarks_audio'] != null) ...[
                          verticalSpaceExtraSmall,
                          renderAudio(
                              header: 'Follow Up Remark',
                              note: list[index]['followup_remarks'],
                              audio: list[index]['created_remarks_audio'])
                        ],
                        if (list[index]['followup_client_feedback'] != null ||
                            list[index]['followup_remarks_audio'] != null) ...[
                          verticalSpaceExtraSmall,
                          renderAudio(
                              header: 'Clientt FeedBack',
                              note: list[index]['followup_client_feedback'],
                              audio: list[index]['followup_remarks_audio'])
                        ]
                      ],
                    ))
                : const SizedBox(),
            childCard: Container(
              padding: const EdgeInsets.only(
                  left: 15, right: 15, top: 10, bottom: 5),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: whiteColor,
                  boxShadow: const [
                    BoxShadow(
                        offset: Offset(0, 5),
                        color: greyShade300,
                        blurRadius: 5,
                        spreadRadius: -5)
                  ],
                  borderRadius: BorderRadius.circular(8)),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(children: [
                      Text(list[index]['followup_type_name'] ?? '',
                          style: AppTextStyle().toastMessageTextStyle(
                              fontColor: FontColor().grey)),
                      horizontalSpaceExtraSmall,
                      if (list[index]['followup_type_name'] == 'Call') ...[
                        InkWell(
                            onTap: () {
                              viewModel.onCallCloudIconTap(
                                  name: viewModel.followUpList[index]
                                      ['lead_name'],
                                  phoneNumber: viewModel.followUpList[index]
                                      ['mobile_number']);
                            },
                            child: SvgPicture.asset(Images().phoneIcon)),
                        horizontalSpaceExtraSmall,
                        InkWell(
                            onTap: () {
                              viewModel.onCallCloudIconTap(
                                  name: viewModel.followUpList[index]
                                      ['lead_name'],
                                  phoneNumber: viewModel.followUpList[index]
                                      ['mobile_number'],
                                  leadId: viewModel.followUpList[index]
                                      ['lead_id']);
                            },
                            child: SvgPicture.asset(Images().phoneCloudIcon))
                      ],
                      if (list[index]['followup_type_name'] == 'Email')
                        InkWell(
                            onTap: () => viewModel.sendMail(
                                emailId: viewModel.followUpList[index]
                                    ['email_address']),
                            child: InkWell(
                                child: SvgPicture.asset(Images().mailIcon))),
                      const Spacer(),
                      list[index]['followup_outcome'] != 'Upcoming'
                          ? Container(
                              height: 18,
                              alignment: Alignment.center,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                  color: list[index]['followup_outcome'] ==
                                          'Completed'
                                      ? lightGreen
                                      : callRecordBgColor,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Text(list[index]['followup_outcome'],
                                  style: AppTextStyle().textButtonTextStyle(
                                      textColor: list[index]
                                                  ['followup_outcome'] ==
                                              'Completed'
                                          ? green
                                          : borderColor)),
                            )
                          : InkWell(
                              onTap: () =>
                                  viewModel.goToSchedulePageForUpdate(index),
                              child: SvgPicture.asset(Images().editIcon))
                    ]),
                    // verticalSpaceTiny,
                    Row(children: [
                      SvgPicture.asset(Images().calenderIcon,
                          color: borderColor),
                      horizontalSpaceTiny,
                      Text(
                          DateFormat("dd MMM y")
                              .format(
                                  DateTime.parse(list[index]['followup_date']))
                              .toString(),
                          style: AppTextStyle().ninePixel()),
                      horizontalSpaceTiny,
                      SvgPicture.asset(Images().clockIcon),
                      horizontalSpaceTiny,
                      Text(list[index]['followup_time'] ?? '',
                          style: AppTextStyle().ninePixel()),
                      const Spacer(),
                    ]),
                    verticalSpaceTiny,
                    Container(height: 1, color: greyShade200),
                    verticalSpaceTiny,
                    Row(
                      children: [
                        Text(
                            'Created on ${DateFormat("dd MMM y").format(DateTime.parse(list[index]['followup_date']))}',
                            style: AppTextStyle().ligthEightPixel()),
                        const Spacer(),
                        Column(children: [
                          Text('Created by',
                              style: AppTextStyle().ligthEightPixel()),
                          Text(list[index]['createdby'] ?? '',
                              style: AppTextStyle().ninePixel(
                                  fontColor: FontColor().black,
                                  fontFamily: 'nexa-regular'))
                        ]),
                        horizontalSpaceTiny,
                        list[index]['profile_picture_url'] == null ||
                                list[index]['profile_picture_url'] == ''
                            ? SvgPicture.asset(Images().leadPerson)
                            : SizedBox(
                                height: 25,
                                width: 25,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.network(
                                      list[index]['profile_picture_url'],
                                      fit: BoxFit.fill, errorBuilder:
                                          (ctx, exception, stackTrace) {
                                    return SvgPicture.asset(
                                        Images().leadPerson);
                                  }, loadingBuilder: ((context, child,
                                          ImageChunkEvent? loadingProgress) {
                                    if (loadingProgress == null) {
                                      return child;
                                    }
                                    return const CircularProgressIndicator(
                                        color: primaryColor);
                                  })),
                                ),
                              )
                      ],
                    )
                  ]),
            ),
          )),
    );
  }

  renderAudio({note, header, audio}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (header != null && note != null) ...[
          Text(
            header,
            style: AppTextStyle().ninePixel(fontColor: blueColor2),
          ),
          verticalSpaceTiny
        ],
        Row(
          children: [
            Expanded(
              child: Text(note ?? '',
                  style: AppTextStyle().smallText(fontColor: FontColor().grey)),
            ),
            if (audio != null) SvgPicture.asset(Images().playIcon)
          ],
        ),
      ],
    );
  }
}

//Render Select Bar
Widget renderCallRecordsSelectBar(AllLeadsViewModel viewModel, leadId) {
  return Row(
    children: [
      Expanded(
        // flex: 5,
        child: Container(
          height: 25,
          decoration: BoxDecoration(
              color: pink, borderRadius: BorderRadius.circular(25)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              renderCallRecordsTab(viewModel, 'All', leadId),
              renderCallRecordsTab(viewModel, 'Incoming', leadId),
              renderCallRecordsTab(viewModel, 'Outgoing', leadId),
            ],
          ),
        ),
      ),
      horizontalSpaceTiny,
      // InkWell(
      //   onTap: () {},
      //   child: Container(
      //     padding: const EdgeInsets.symmetric(horizontal: 5),
      //     height: 25,
      //     decoration: BoxDecoration(
      //         color: lightPinkColor, borderRadius: BorderRadius.circular(25)),
      //     child: Row(
      //       crossAxisAlignment: CrossAxisAlignment.center,
      //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //       children: [
      //         Container(
      //           padding: const EdgeInsets.only(left: 5),
      //           alignment: Alignment.center,
      //           child: SvgPicture.asset(
      //             Images().checkMenu,
      //             height: 15,
      //             width: 15,
      //           ),
      //         ),
      //         const Icon(
      //           Icons.arrow_drop_down,
      //           color: greyShade400,
      //           size: 20,
      //         )
      //       ],
      //     ),
      //   ),
      // )
    ],
  );
}

GestureDetector renderCallRecordsTab(
    AllLeadsViewModel viewModel, name, leadId) {
  return GestureDetector(
    onTap: () {
      viewModel.callRecordSelectTab(name, leadId);
    },
    child: Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          color:
              viewModel.callRecordSelectedTab == name ? darkPink : transparent,
          borderRadius: BorderRadius.circular(15)),
      child: Text(
        name,
        style: AppTextStyle().selectBar(
            viewModel.callRecordSelectedTab == name ? whiteColor : blackColor),
      ),
    ),
  );
}

Container _recordCount(count) {
  return Container(
    alignment: Alignment.centerLeft,
    padding: const EdgeInsets.symmetric(horizontal: 8),
    child: RichText(
        text: TextSpan(
            text: 'Showing ',
            style: AppTextStyle().smallLarge(fontColor: FontColor().grey),
            children: [
          TextSpan(
              text: '${count ?? 0}',
              style: AppTextStyle().numberStyle(fontColor: FontColor().black)),
          TextSpan(
              text: count <= 1 ? ' record' : ' records',
              style: AppTextStyle().smallLarge(fontColor: FontColor().grey))
        ])),
  );
}

_renderCallRecordsBody(AllLeadsViewModel viewModel, leadId) {
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: const BoxDecoration(
      color: callRecordBgColor,
    ),
    child: Column(
      children: [
        renderCallRecordsSelectBar(viewModel, leadId),
        verticalSpaceSmall,
        _recordCount(viewModel.callRecordMap['totalCount']),
        verticalSpaceTiny,
        Expanded(
          child: Stack(
            children: [
              viewModel.isCallLoading
                  ? Container(
                      height: 200,
                      color: Colors.transparent,
                      child: const Center(
                          child:
                              CircularProgressIndicator(color: primaryColor)))
                  : ListView.builder(
                      padding: const EdgeInsets.all(0),
                      itemCount: viewModel.leadDetailsList.length,
                      itemBuilder: (ctx, index) {
                        if (index + 1 < viewModel.callRecordMap['totalCount'] &&
                            index + 1 == viewModel.leadDetailsList.length) {
                          viewModel.getListOfCallRecordsByFollowUpId(
                              leadId: leadId);
                          return const Center(
                              child: CircularProgressIndicator(
                                  color: primaryColor));
                        }
                        return LeadDetailsCard(
                          callDuration: viewModel.leadDetailsList[index]
                                  ['duration']
                              .toString(),
                          personName: viewModel.leadDetailsList[index]
                                  ['user_name'] ??
                              '',
                          visitDate: DateFormat('dd MMM y').format(
                              DateTime.parse(viewModel.leadDetailsList[index]
                                  ['startTime'])),
                          visitTime: DateFormat('hh.mm a')
                              .format(DateTime.parse(viewModel
                                  .leadDetailsList[index]['startTime']))
                              .toLowerCase(),
                          recordingUrl: viewModel.leadDetailsList[index]
                                  ['recordingUrl'] ??
                              '',
                        );
                      }),
            ],
          ),
        )
      ],
    ),
  );
}
