import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import '/ui/views/home/home_viewmodel.dart';
import '/ui/common/widgets/index.dart';
import '/ui/common/index.dart';
import '/ui/views/incoming_call/call_detail_card.dart';
import '/ui/views/incoming_call/incoming_call_view.form.dart';
import 'incoming_call_viewmodel.dart';

@FormView(fields: [
  FormTextField(name: 'search', initialValue: ''),
  FormTextField(name: 'fromDate', initialValue: ''),
  FormTextField(name: 'toDate', initialValue: ''),
])
class IncomingCallView extends StackedView<IncomingCallViewModel>
    with $IncomingCallView {
  const IncomingCallView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    IncomingCallViewModel viewModel,
    Widget? child,
  ) {
    return Stack(
      children: [
        Screen(
          height: screenHeight(context) * 0.15,
          headerChild: renderHeader(viewModel, context),
          bodyChild: RefreshIndicator(
            onRefresh: () =>
                viewModel.getIncomingCallRecods(searchController.text),
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                        color: backgroundcolor,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20))),
                    child: Column(children: [
                      renderSelectBar(viewModel), //Select Bar

                      verticalSpaceMedium,

                      SearchInput(
                        controller: searchController,
                        focusNode: searchFocusNode,
                        onCancel: () {
                          searchFocusNode.unfocus();
                          viewModel.onChangeTab(searchController);
                        },
                        onChanged: (p0) {
                          if (searchController.text.length > 2 ||
                              searchController.text.isEmpty) {
                            viewModel.onChangeSearch(searchController);
                          }
                        },
                      ), //Search

                      verticalSpaceSmall,

                      if (viewModel.isBusy == false) ...[
                        if (viewModel.totalRecord == 0)
                        SizedBox(
                          height: screenHeight(context)/2,
                          child: const EmptyPlaceHolder()),
                        if (viewModel.totalRecord != 0) ...[
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: RichText(
                                text: TextSpan(
                                    text: 'Showing ',
                                    style: AppTextStyle().smallLarge(
                                        fontColor: FontColor().grey),
                                    children: [
                                  TextSpan(
                                    text: viewModel.totalRecord.toString(),
                                    style: AppTextStyle().smallLarge(
                                        fontColor: FontColor().black,
                                        fontFamily: 'Nexa-Bold'),
                                  ),
                                  TextSpan(
                                    text: viewModel.totalRecord <= 1
                                        ? ' record'
                                        : ' records',
                                    style: AppTextStyle().smallLarge(
                                        fontColor: FontColor().grey),
                                  ),
                                ])),
                          ),
                          Expanded(
                            child: ListView.builder(
                                itemCount: viewModel.callRecordList.length + 1,
                                controller: viewModel.scrollController,
                                shrinkWrap: true,
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (context, index) => index <
                                        viewModel.callRecordList.length
                                    ? Container(
                                        clipBehavior: Clip.hardEdge,
                                        margin:
                                            const EdgeInsets.only(bottom: 15),
                                        decoration: BoxDecoration(
                                          color: primaryColor,
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),
                                        child: viewModel.callRecordList[index]
                                                    ['callStatus'] ==
                                                'UnIdentified'
                                            ? SlidableTile(
                                                motion: const ScrollMotion(),
                                                action: [
                                                  Expanded(
                                                      child: Container(
                                                    decoration:
                                                        const BoxDecoration(
                                                      color: primaryColor,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topRight:
                                                            Radius.circular(10),
                                                        bottomRight:
                                                            Radius.circular(10),
                                                        topLeft:
                                                            Radius.circular(10),
                                                        bottomLeft:
                                                            Radius.circular(10),
                                                      ),
                                                    ),
                                                    child: Container(
                                                      color: secondaryColor,
                                                      child: Container(
                                                        decoration:
                                                            const BoxDecoration(
                                                          color: primaryColor,
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            topRight:
                                                                Radius.circular(
                                                                    10),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    10),
                                                          ),
                                                        ),
                                                        alignment:
                                                            Alignment.center,
                                                        child: InkWell(
                                                          onTap: () {
                                                            viewModel.showDisqualifiedDialog(
                                                                viewModel.callRecordList[
                                                                        index][
                                                                    'calls_detail_id'],
                                                                searchController
                                                                    .text);
                                                          },
                                                          child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                SvgPicture
                                                                    .asset(
                                                                  Images()
                                                                      .discard,
                                                                  height: 20,
                                                                ),
                                                                verticalSpaceTiny,
                                                                Text(
                                                                  'Disqualify',
                                                                  style: AppTextStyle()
                                                                      .ninePixel(
                                                                          fontColor:
                                                                              FontColor().white),
                                                                )
                                                              ]),
                                                        ),
                                                      ),
                                                    ),
                                                  )),
                                                  Expanded(
                                                      child: Container(
                                                    decoration:
                                                        const BoxDecoration(
                                                      color: secondaryColor,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topRight:
                                                            Radius.circular(10),
                                                        bottomRight:
                                                            Radius.circular(10),
                                                      ),
                                                    ),
                                                    alignment: Alignment.center,
                                                    child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          SvgPicture.asset(
                                                            Images()
                                                                .checkedIcon,
                                                            height: 20,
                                                          ),
                                                          verticalSpaceTiny,
                                                          Text(
                                                            'Create\nProspect',
                                                            style: AppTextStyle()
                                                                .ninePixel(
                                                                    fontColor:
                                                                        FontColor()
                                                                            .white),
                                                            textAlign: TextAlign
                                                                .center,
                                                          )
                                                        ]),
                                                  )),
                                                ],
                                                valueKey: index,
                                                child: CallDetailCard(
                                                  callDuration: viewModel
                                                      .showCallDuration(viewModel
                                                              .callRecordList[
                                                          index]['duration']),
                                                  personName: capitalizeFirstLetter(
                                                      viewModel.callRecordList[
                                                                  index]
                                                              ['lead_name'] ??
                                                          'UnKnown'),
                                                  visitTime: viewModel
                                                          .callRecordList[index]
                                                              ['dateCreated']
                                                          .isNotEmpty
                                                      ? viewModel.getTime(viewModel
                                                              .callRecordList[
                                                          index]['dateCreated'])
                                                      : '',
                                                  visitDate: viewModel.getDate(
                                                      viewModel.callRecordList[
                                                              index]
                                                          ['dateCreated']),
                                                  status:
                                                      viewModel.callRecordList[
                                                                      index][
                                                                  'duration'] !=
                                                              0
                                                          ? 'Received by Unknown'
                                                          : 'Unanswered',
                                                  projectName: viewModel
                                                          .callRecordList[index]
                                                      ['project_name'],
                                                  showPlayAudio:
                                                      viewModel.callRecordList[
                                                                  index][
                                                              'recordingUrl'] !=
                                                          null,
                                                  onTapPlay: () {
                                                    viewModel.showPlayAudio(
                                                        viewModel.callRecordList[
                                                                index]
                                                            ['recordingUrl']);
                                                  },
                                                  onTapCall: () {
                                                    viewModel.showCallDialog(
                                                        viewModel.callRecordList[
                                                                    index]
                                                                ['lead_name'] ??
                                                            'UnKnown',
                                                        viewModel.callRecordList[
                                                            index]['to_mobile'],
                                                        viewModel.callRecordList[
                                                            index]['lead_id'],
                                                        viewModel.callRecordList[
                                                                index]
                                                            ['followup_id']);
                                                  },
                                                ),
                                              )
                                            : CallDetailCard(
                                                callDuration: viewModel
                                                    .showCallDuration(viewModel
                                                            .callRecordList[
                                                        index]['duration']),
                                                personName:
                                                    capitalizeFirstLetter(
                                                        viewModel.callRecordList[
                                                                    index]
                                                                ['lead_name'] ??
                                                            'UnKnown'),
                                                visitTime: viewModel
                                                        .callRecordList[index]
                                                            ['dateCreated']
                                                        .isNotEmpty
                                                    ? viewModel.getTime(viewModel
                                                            .callRecordList[
                                                        index]['dateCreated'])
                                                    : '',
                                                visitDate: viewModel.getDate(
                                                    viewModel.callRecordList[
                                                        index]['dateCreated']),
                                                status:
                                                    viewModel.callRecordList[
                                                                    index]
                                                                ['duration'] !=
                                                            0
                                                        ? 'Received by Unknown'
                                                        : 'Unanswered',
                                                projectName: viewModel
                                                        .callRecordList[index]
                                                    ['project_name'],
                                                onTapPlay: () {
                                                  viewModel.showPlayAudio(
                                                      viewModel.callRecordList[
                                                              index]
                                                          ['recordingUrl']);
                                                },
                                                showPlayAudio:
                                                    viewModel.callRecordList[
                                                                index]
                                                            ['recordingUrl'] !=
                                                        null,
                                                onTapCall: () {
                                                  viewModel.showCallDialog(
                                                      viewModel.callRecordList[
                                                                  index]
                                                              ['lead_name'] ??
                                                          'UnKnown',
                                                      viewModel.callRecordList[
                                                          index]['to_mobile'],
                                                      viewModel.callRecordList[
                                                          index]['lead_id'],
                                                      viewModel.callRecordList[
                                                              index]
                                                          ['followup_id']);
                                                },
                                              ))
                                    : index == viewModel.totalRecord 
                                        ? const SizedBox()
                                        :index==0?const SizedBox(): const Center(
                                        child: CircularProgressIndicator(
                                        color: primaryColor))
                                      ),
                          ),
                        ]
                      ]
                    ]),
                  ),
                )
              ],
            ),
          ),
        ),
        if (viewModel.isBusy) const Loader()
      ],
    );
  }

  // render header
  renderHeader(IncomingCallViewModel viewModel, BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 15),
        child: InkWell(
          onTap: () => HomeViewModel().goBack(),
          child: Row(children: [
            const Icon(Icons.arrow_back, color: whiteColor),
            horizontalSpaceTiny,
            Text("Incoming Call Records",
                style: Theme.of(context).textTheme.displayLarge)
          ]),
        ));
  }

//Render Select Bar
  Widget renderSelectBar(IncomingCallViewModel viewModel) {
    return Row(
      children: [
        Expanded(
          flex: 5,
          child: Container(
            height: 30,
            decoration: BoxDecoration(
                color: tabBg, borderRadius: BorderRadius.circular(25)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (viewModel.sharedService.isViewAllIncomingCallRecords!)
                  GestureDetector(
                    onTap: () {
                      viewModel.selectTab('All', searchController);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      decoration: BoxDecoration(
                          color: viewModel.selectedTab == 'All'
                              ? orange
                              : transparent,
                          borderRadius: BorderRadius.circular(25)),
                      child: Text(
                        'All',
                        style: AppTextStyle().selectBar(
                          viewModel.selectedTab == 'All'
                              ? whiteColor
                              : blackColor,
                        ),
                      ),
                    ),
                  ),
                if (viewModel.sharedService.isViewIdentifyCallRecords!)
                  GestureDetector(
                    onTap: () {
                      viewModel.selectTab(
                        'Identified',
                        searchController,
                      );
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          color: viewModel.selectedTab == 'Identified'
                              ? orange
                              : transparent,
                          borderRadius: BorderRadius.circular(25)),
                      child: Text('Identified',
                          style: AppTextStyle().selectBar(
                            viewModel.selectedTab == 'Identified'
                                ? whiteColor
                                : blackColor,
                          )),
                    ),
                  ),
                if (viewModel.sharedService.isViewUnIdentifyCallRecords!)
                  GestureDetector(
                    onTap: () {
                      viewModel.selectTab('Unidentified', searchController);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                          color: viewModel.selectedTab == 'Unidentified'
                              ? orange
                              : transparent,
                          borderRadius: BorderRadius.circular(25)),
                      child: Text(
                        'Unidentified',
                        style: AppTextStyle().selectBar(
                          viewModel.selectedTab == 'Unidentified'
                              ? whiteColor
                              : blackColor,
                        ),
                      ),
                    ),
                  )
              ],
            ),
          ),
        ),
        horizontalSpaceTiny,
        Expanded(
            flex: 1,
            child: InkWell(
              onTap: () {
                viewModel.showBottomSheet(searchController.text);
              },
              child: Container(
                height: 30,
                decoration: BoxDecoration(
                    color: greyShade100,
                    borderRadius: BorderRadius.circular(25)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(Images().menuIcon),
                    selectedButton.isEmpty
                        ? const Icon(Icons.arrow_drop_down, color: black26)
                        : const Icon(Icons.check_circle,
                            color: Colors.black45, size: 15)
                  ],
                ),
              ),
            ))
      ],
    );
  }

  @override
  IncomingCallViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      IncomingCallViewModel()..init(searchController);
}
