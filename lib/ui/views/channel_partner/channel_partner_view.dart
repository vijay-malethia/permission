import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import '/ui/views/home/home_viewmodel.dart';
import '/ui/common/widgets/index.dart';
import '/ui/views/channel_partner/approved_card.dart';
import '/ui/views/channel_partner/channel_partner_card.dart';
import '/ui/views/channel_partner/channel_partner_view.form.dart';
import '/ui/common/index.dart';
import 'channel_partner_viewmodel.dart';

@FormView(fields: [
  FormTextField(name: 'search', initialValue: ''),
])
class ChannelPartnerView extends StackedView<ChannelPartnerViewModel>
    with $ChannelPartnerView {
  const ChannelPartnerView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    ChannelPartnerViewModel viewModel,
    Widget? child,
  ) {
    return Stack(
      children: [
        Screen(
            height: screenHeight(context) * 0.15,
            headerChild: _renderHeader(viewModel, context),
            bodyChild: _renderBody(viewModel, context)),
        if (viewModel.isBusy) const Loader()
      ],
    );
  }

//render body
  _renderBody(ChannelPartnerViewModel viewModel, BuildContext context) {
    return DefaultTabController(
      length: 4,
      initialIndex: tabIndex,
      child: RefreshIndicator(
          onRefresh: () =>
              viewModel.getCpApprovedList(searchController.text, tabIndex),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //drag handle
              Center(
                child: Container(
                  height: 3,
                  width: screenWidth(context) / 6,
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                      color: customLightGrey,
                      borderRadius: BorderRadius.circular(1.5)),
                ),
              ),
              TabBar(
                indicatorSize: TabBarIndicatorSize.tab,
                padding: EdgeInsets.zero,
                labelPadding: EdgeInsets.zero,
                onTap: (value) {
                  viewModel.onChangeTab(value, searchController);
                  // viewModel.showresult(value, searchController.text);
                },
                tabs: [
                  if (viewModel.sharedService.isViewChannelPartner!)
                    SizedBox(
                      height: 20,
                      child: Text('Approved',
                          style: AppTextStyle().selectBar(black26Dark)),
                    ),
                  SizedBox(
                    height: 20,
                    child: Text('Pending',
                        style: AppTextStyle().selectBar(black26Dark)),
                  ),
                  SizedBox(
                    height: 20,
                    child: Text('Rejected',
                        style: AppTextStyle().selectBar(black26Dark)),
                  ),
                  SizedBox(
                    height: 20,
                    child: Text('Deactivated',
                        style: AppTextStyle().selectBar(black26Dark)),
                  )
                ],
                indicatorWeight: 2,
                indicatorColor: primaryColor,
                labelColor: blackColor,
                labelStyle:
                    AppTextStyle().inputLabelTextStyle(fontColor: whiteColor),
              ),
              verticalSpaceSmall,
              SearchInput(
                controller: searchController,
                focusNode: searchFocusNode,
                onCancel: () {
                  searchController.clear();
                  searchFocusNode.unfocus();
                  viewModel.onClear( searchController);
                },
                onChanged: (p0) {
                  viewModel.onChangeSearch(searchController);
                },
              ),
              verticalSpaceSmall,
              if (viewModel.isBusy == false) ...[
                if (viewModel.result) ...[
                  RichText(
                      text: TextSpan(
                          text: ' Showing ',
                          style: AppTextStyle()
                              .smallLarge(fontColor: FontColor().grey),
                          children: [
                        TextSpan(
                          text: viewModel.totalRecord.toString(),
                          style: AppTextStyle()
                              .smallLarge(fontColor: FontColor().black),
                        ),
                        TextSpan(
                          text: viewModel.totalRecord <= 1
                              ? ' record'
                              : ' records',
                          style: AppTextStyle()
                              .smallLarge(fontColor: FontColor().grey),
                        )
                      ])),
                  verticalSpaceExtraSmall,
                  Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        controller: viewModel.scrollController,
                        physics: const BouncingScrollPhysics(),
                        itemCount: viewModel.cpList.length + 1,
                        itemBuilder: (context, index) => index <
                                viewModel.cpList.length
                            ? tabIndex == 0

                                //render approved cards
                                ? InkWell(
                                    onTap: () {
                                      if (viewModel
                                          .sharedService.isViewCPDetail!) {
                                        viewModel.goToDetails(
                                          viewModel.cpList[index]
                                              ['channel_partner_id'],
                                        );
                                      }
                                    },
                                    child: ApprovedCard(
                                      showProjectAssignIcon: viewModel
                                              .sharedService
                                              .isAssignChannelPartnerToProjects ==
                                          true,
                                      comapanyName: viewModel.cpList[index]
                                          ['channel_partner_name'],
                                      leadsCount: viewModel.cpList[index]
                                              ['leads_count']
                                          .toString(),
                                      userCount: viewModel.cpList[index]
                                              ['user_count']
                                          .toString(),
                                      userName: viewModel.cpList[index]['name'],
                                      projectList: viewModel
                                                  .cpList[index]['projectList']
                                                  .length !=
                                              0
                                          ? viewModel.cpList[index]
                                              ['projectList'][0]
                                          : null,
                                      projectListCount: (viewModel
                                                  .cpList[index]['projectList']
                                                  .length -
                                              1)
                                          .toString(),
                                      onTapBuilding: () {
                                        viewModel.showAssignProjectSheet(
                                            viewModel.cpList[index]
                                                ['channel_partner_id'],
                                            searchController.text,
                                            index);
                                      },
                                      onTapCall: () {
                                        viewModel.showCallDialog(
                                            viewModel.cpList[index]['name'],
                                            viewModel.cpList[index]
                                                ['mobile_number']);
                                      },
                                      onTapProject: () {
                                        viewModel.showRemoveProjectSheet(
                                            viewModel.cpList[index]
                                                ['channel_partner_id'],   viewModel.cpList[index]
                                                ['name'],searchController.text
                                                );
                                      },
                                    ),
                                  )
                                : InkWell(
                                    onTap: () {
                                      if (tabIndex == 1) {
                                        viewModel.goToDetails(
                                          viewModel.cpList[index]
                                              ['channel_partner_id'],
                                        );
                                      }
                                    },
                                    child: ChannelPartnerCard(
                                      appNumber: viewModel.cpList[index]
                                              ['enrollment_no'] ??
                                          '000000',
                                      comapanyName: viewModel.cpList[index]
                                              ['channel_partner_name'] ??
                                          '',
                                      userName:
                                          viewModel.cpList[index]['name'] ?? '',
                                      onTapCall: () {
                                        viewModel.showCallDialog(
                                            viewModel.cpList[index]['name'],
                                            viewModel.cpList[index]
                                                ['mobile_number']);
                                      },
                                    ),
                                  )
                             : index == viewModel.totalRecord 
                                        ? const SizedBox()
                                        :index==0?const SizedBox(): const Center(
                                        child: CircularProgressIndicator(
                                        color: primaryColor))
                                      ),
                  ),
                ],
                if (viewModel.result == false) ...[
                  SizedBox(
                    height: screenHeight(context) / 2,
                    child: const Center(child: EmptyPlaceHolder())),
                ]
              ],
              //     if (viewModel.isBusy)
              //      Center(
              // child: LoadingAnimationWidget.threeRotatingDots(color: primaryColor, size: 50))
              // const Center(
              //     child: CircularProgressIndicator(color: primaryColor))
            ],
          )),
    );
  }

  @override
  ChannelPartnerViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      ChannelPartnerViewModel()..init(searchController);
}

//Render Header
_renderHeader(ChannelPartnerViewModel viewModel, BuildContext context) {
  return Padding(
      padding: const EdgeInsets.only(left: 15),
      child: InkWell(
        onTap: HomeViewModel().goBack,
        child: Row(children: [
          const Icon(Icons.arrow_back, color: whiteColor),
          horizontalSpaceTiny,
          Text('View Channel Partner',
              style: Theme.of(context).textTheme.displayLarge)
        ]),
      ));
}
