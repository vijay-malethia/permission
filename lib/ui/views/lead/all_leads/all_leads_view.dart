import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import '/ui/views/home/home_viewmodel.dart';
import '/ui/common/index.dart';
import '/ui/common/widgets/index.dart';
import 'all_leads_viewmodel.dart';
import 'all_leads_view.form.dart';

@FormView(fields: [
  FormTextField(name: 'search'),
  FormTextField(name: 'remark'),
  FormTextField(name: 'remarkStage'),
  FormTextField(name: 'followUpRemark'),
  FormTextField(name: 'followUpClientFeedback'),
  FormTextField(name: 'remarkSchedule'),
])
class AllLeadsView extends StackedView<AllLeadsViewModel> with $AllLeadsView {
  const AllLeadsView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    AllLeadsViewModel viewModel,
    Widget? child,
  ) {
    return Screen(
        height: screenHeight(context) * 0.15,
        headerChild: _renderHeader(viewModel, context),
        bodyChild: _renderBody(context, viewModel));
  }

  @override
  AllLeadsViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      AllLeadsViewModel()..initialLead();

  @override
  void onDispose(AllLeadsViewModel viewModel) {
    super.onDispose(viewModel);
    disposeForm();
  }

//Header
  _renderHeader(AllLeadsViewModel viewModel, BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: InkWell(
          onTap: HomeViewModel().goBack,
          child: Row(children: [
            const Icon(Icons.arrow_back, color: whiteColor),
            horizontalSpaceTiny,
            Text('All Leads', style: Theme.of(context).textTheme.displayLarge)
          ]),
        ));
  }

//Body
  DefaultTabController _renderBody(
      BuildContext context, AllLeadsViewModel viewModel) {
    return DefaultTabController(
      length: viewModel.sharedService.userId == 2 ? 2 : 3,
      initialIndex: 0,
      child: RefreshIndicator(
        onRefresh: viewModel.apiCallByIndex,
        child: Column(children: [
          Container(
              width: 50,
              height: 3,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: customLightGrey)),
          verticalSpaceMedium,
          _renderToolBar(context, viewModel),
          verticalSpaceMedium,
          Row(
            children: [
              Expanded(
                  flex: 6,
                  child: SearchInput(
                      onCancel: () {
                        searchController.clear();
                        searchFocusNode.unfocus();
                        viewModel.apiCallByIndex();
                        // tabIndex == 0
                        //     ? viewModel.getViewLeadsBySource()
                        //     : viewModel.getAssignedLeads();
                      },
                      onChanged: (value) {
                        viewModel.searchCtrl.text = value;
                        viewModel.notifyListeners();
                        if (value.length > 2 || value.isEmpty) {
                          viewModel.currentPage = 1;
                          tabIndex == 2
                              ? viewModel.getAssignedLeads(search: value)
                              : viewModel.getViewLeadsBySource(
                                  userTypeId: tabIndex == 0 ? 1 : 2,
                                  search: value,
                                  pageIndex: 1);
                        }
                      },
                      controller: searchController,
                      focusNode: searchFocusNode)),
              horizontalSpaceExtraSmall,
              Expanded(
                  flex: 1,
                  child: InkWell(
                    onTap: () {
                      viewModel.showAllLeadsFilter();
                    },
                    child: Container(
                      height: 44,
                      decoration: BoxDecoration(
                          color: grey9, borderRadius: BorderRadius.circular(5)),
                      child: Center(
                          child: SvgPicture.asset(viewModel.isFilterApplied()
                              ? Images().checkMenu
                              : Images().menuIcon)),
                    ),
                  ))
            ],
          ),
          verticalSpaceSmall,
          _renderFilter(viewModel),
          verticalSpaceSmall,
          if (viewModel.isBusy) ...[
            const Center(child: CircularProgressIndicator(color: primaryColor))
          ] else ...[
            if ((tabIndex == 2
                    ? viewModel.assignedLeadsMap['total_count'] ?? 0
                    : viewModel.viewLeadsBySourceData['total_count'] ?? 0) !=
                0)
              _recordCount(viewModel),
            verticalSpaceTiny,
            Expanded(
              child: ListView.builder(
                controller: viewModel.scrollController,
                itemCount: searchController.text.isEmpty
                    ? tabIndex == 2
                        ? viewModel.assignedLeadsList.length + 1
                        : viewModel.leadsList.length + 1
                    : tabIndex == 2
                        ? viewModel.assignedLeadsMap['entity_list'].length
                        : viewModel.viewLeadsBySourceData['entity_list'].length,
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                padding: const EdgeInsets.all(0),
                itemBuilder: (context, index) {
                  return (tabIndex == 2
                              ? viewModel.assignedLeadsMap['total_count'] ?? 0
                              : viewModel
                                      .viewLeadsBySourceData['total_count'] ??
                                  0) ==
                          0
                      ? SizedBox(
                          height: screenHeight(context) * .4,
                          child: const EmptyPlaceHolder(msg: ''))
                      : index <
                              (searchController.text.isEmpty
                                  ? tabIndex == 2
                                      ? viewModel.assignedLeadsList.length
                                      : viewModel.leadsList.length
                                  : tabIndex == 2
                                      ? viewModel
                                          .assignedLeadsMap['total_count']
                                      : viewModel
                                          .viewLeadsBySourceData['total_count'])
                          ? _renderSlidebleCard(index, viewModel)
                          : index ==
                                  (tabIndex == 2
                                      ? viewModel
                                          .assignedLeadsMap['total_count']
                                      : viewModel
                                          .viewLeadsBySourceData['total_count'])
                              ? const SizedBox()
                              : const Center(
                                  child: CircularProgressIndicator(
                                      color: primaryColor));
                },
              ),
            ),
          ],
        ]),
      ),
    );
  }

//Slideble Card
  Container _renderSlidebleCard(int index, AllLeadsViewModel viewModel) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: FontColor().orange),
      margin: const EdgeInsets.only(bottom: 15),
      child: SlidableTile(
        motion: const BehindMotion(),
        action: [
          Expanded(
            child: InkWell(
              onTap: () => viewModel.goToScheduleScreen(index),
              child: Container(
                decoration: BoxDecoration(
                    color: FontColor().orange,
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10))),
                alignment: Alignment.center,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.add_circle, size: 18, color: whiteColor),
                      Text('Follow Up', style: AppTextStyle().textheading)
                    ]),
              ),
            ),
          ),
        ],
        valueKey: index,
        child: CustomTile(
          isShowLeadHistory: viewModel.sharedService.isShowLeadHistory!,
          isShowNormalCall: viewModel.showNormalCallIcon(),
          isShowCloudCall: viewModel.showCloudCallIcon(),
          cpName: tabIndex == 1
              ? searchController.text.isEmpty
                  ? viewModel.leadsList[index].cpName
                  : viewModel.viewLeadsBySourceData['entity_list'][index]
                      ['channel_partner_name']
              : '',
          companyName: searchController.text.isEmpty
              ? tabIndex == 2
                  ? viewModel.assignedLeadsList[index].assignedToName
                  : viewModel.leadsList[index].assignedToName
              : tabIndex == 2
                  ? viewModel.assignedLeadsMap['entity_list'][index]
                          ['assigned_to_name'] ??
                      ''
                  : viewModel.viewLeadsBySourceData['entity_list'][index]
                          ['assigned_to_name'] ??
                      '',
          onCompanyTap: () => viewModel.showAssignLeadBottomSheet(
              leadId: searchController.text.isEmpty
                  ? tabIndex == 2
                      ? viewModel.assignedLeadsList[index].leadId
                      : viewModel.leadsList[index].leadId
                  : tabIndex == 2
                      ? viewModel.assignedLeadsMap['entity_list'][index]
                              ['lead_id'] ??
                          ''
                      : viewModel.viewLeadsBySourceData['entity_list'][index]
                              ['lead_id'] ??
                          '',
              assignedTo: searchController.text.isEmpty
                  ? tabIndex == 2
                      ? viewModel.assignedLeadsList[index].assignedToName
                      : viewModel.leadsList[index].assignedToName
                  : tabIndex == 2
                      ? viewModel.assignedLeadsMap['entity_list'][index]
                              ['assigned_to_name'] ??
                          ''
                      : viewModel.viewLeadsBySourceData['entity_list'][index]
                              ['assigned_to_name'] ??
                          ''),
          date: searchController.text.isEmpty
              ? tabIndex == 2
                  ? viewModel.assignedLeadsList[index].date
                  : viewModel.leadsList[index].date
              : tabIndex == 2
                  ? viewModel.formatDate(
                      viewModel.assignedLeadsMap['entity_list'][index]
                              ['stage_updated_ts'] ??
                          DateTime.now())
                  : viewModel.formatDate(
                      viewModel.viewLeadsBySourceData['entity_list'][index]
                              ['stage_updated_ts'] ??
                          DateTime.now()),
          location: searchController.text.isEmpty
              ? tabIndex == 2
                  ? viewModel.assignedLeadsList[index].location
                  : viewModel.leadsList[index].location
              : tabIndex == 2
                  ? viewModel.assignedLeadsMap['entity_list'][index]
                          ['project_name'][0] ??
                      ''
                  : viewModel.viewLeadsBySourceData['entity_list'][index]
                          ['project_name'][0] ??
                      '',
          personName: searchController.text.isEmpty
              ? tabIndex == 2
                  ? viewModel.assignedLeadsList[index].personName[0]
                          .toUpperCase() +
                      viewModel.assignedLeadsList[index].personName.substring(1)
                  : viewModel.leadsList[index].personName[0].toUpperCase() +
                      viewModel.leadsList[index].personName.substring(1)
              : tabIndex == 2
                  ? viewModel.assignedLeadsMap['entity_list'][index]
                                  ['lead_name'][0]
                              .toUpperCase() +
                          viewModel.assignedLeadsMap['entity_list'][index]
                                  ['lead_name']
                              .substring(1) ??
                      ''
                  : viewModel.viewLeadsBySourceData['entity_list'][index]
                                  ['lead_name'][0]
                              .toUpperCase() +
                          viewModel.viewLeadsBySourceData['entity_list'][index]
                                  ['lead_name']
                              .substring(1) ??
                      '',
          clientVistDate: searchController.text.isEmpty
              ? tabIndex == 2
                  ? viewModel.assignedLeadsList[index].clientVisitDate
                  : viewModel.leadsList[index].clientVisitDate
              : tabIndex == 2
                  ? viewModel.assignedLeadsMap['entity_list'][index]
                          ['immediate_followup'] ??
                      ''
                  : viewModel.viewLeadsBySourceData['entity_list'][index]
                          ['immediate_followup'] ??
                      '',
          statusBorderColor: searchController.text.isEmpty
              ? tabIndex == 2
                  ? viewModel.assignedLeadsList[index].borderColor
                  : viewModel.leadsList[index].borderColor
              : tabIndex == 2
                  ? Color(int.parse(
                      '0XFF${viewModel.assignedLeadsMap['entity_list'][index]['color_code_2'].toString().split('#').last}'))
                  : Color(int.parse(
                      '0XFF${viewModel.viewLeadsBySourceData['entity_list'][index]['color_code_2'].toString().split('#').last}')),
          statusColor: searchController.text.isEmpty
              ? tabIndex == 2
                  ? viewModel.assignedLeadsList[index].backgroundColor
                  : viewModel.leadsList[index].backgroundColor
              : tabIndex == 2
                  ? Color(int.parse(
                      '0XFF${viewModel.assignedLeadsMap['entity_list'][index]['color_code_1'].toString().split('#').last}'))
                  : Color(int.parse(
                      '0XFF${viewModel.viewLeadsBySourceData['entity_list'][index]['color_code_1'].toString().split('#').last}')),
          status: searchController.text.isEmpty
              ? tabIndex == 2
                  ? viewModel.assignedLeadsList[index].status
                  : viewModel.leadsList[index].status
              : tabIndex == 2
                  ? viewModel.assignedLeadsMap['entity_list'][index]
                          ['lead_stage_name'] ??
                      ''
                  : viewModel.viewLeadsBySourceData['entity_list'][index]
                          ['lead_stage_name'] ??
                      '',
          visitDate: searchController.text.isEmpty
              ? tabIndex == 2
                  ? viewModel.assignedLeadsList[index].visitDate
                  : viewModel.leadsList[index].visitDate
              : tabIndex == 2
                  ? viewModel.assignedLeadsMap['entity_list'][index]
                          ['siteVisited'] ??
                      'Site not yet visited'
                  : viewModel.viewLeadsBySourceData['entity_list'][index]
                          ['siteVisited'] ??
                      'Site not yet visited',
          isEditable: viewModel.isEditable(index),
          onStatusTap: () => viewModel.showChangeLeadBottomSheet(
              leadId: searchController.text.isEmpty
                  ? tabIndex == 2
                      ? viewModel.assignedLeadsList[index].leadId
                      : viewModel.leadsList[index].leadId
                  : tabIndex == 2
                      ? viewModel.assignedLeadsMap['entity_list'][index]
                              ['lead_id'] ??
                          ''
                      : viewModel.viewLeadsBySourceData['entity_list'][index]
                              ['lead_id'] ??
                          '',
              status: searchController.text.isEmpty
                  ? tabIndex == 2
                      ? viewModel.assignedLeadsList[index].status
                      : viewModel.leadsList[index].status
                  : tabIndex == 2
                      ? viewModel.assignedLeadsMap['entity_list'][index]
                              ['lead_stage_name'] ??
                          ''
                      : viewModel.viewLeadsBySourceData['entity_list'][index]
                              ['lead_stage_name'] ??
                          ''),
          onFollowUpTap: () => viewModel.goToScheduleScreen(index),
          onHistoryTap: () => viewModel.showHistory(),
          onViewTap: () => viewModel.goToFollowUpScreen(
              searchController.text.isEmpty
                  ? tabIndex == 2
                      ? viewModel.assignedLeadsList[index].leadId
                      : viewModel.leadsList[index].leadId
                  : tabIndex == 2
                      ? viewModel.assignedLeadsMap['entity_list'][index]
                              ['lead_id'] ??
                          ''
                      : viewModel.viewLeadsBySourceData['entity_list'][index]
                              ['lead_id'] ??
                          ''),
          isLockIconShow: searchController.text.isEmpty
              ? tabIndex == 2
                  ? viewModel.assignedLeadsList[index].isLockIconShow
                  : viewModel.leadsList[index].isLockIconShow
              : tabIndex == 2
                  ? viewModel.assignedLeadsMap['entity_list'][index]
                                  ['is_disqualified'] ==
                              false &&
                          viewModel.assignedLeadsMap['entity_list'][index]
                                  ['lock_status'] ==
                              true
                      ? true
                      : false
                  : viewModel.viewLeadsBySourceData['entity_list'][index]
                                  ['is_disqualified'] ==
                              false &&
                          viewModel.viewLeadsBySourceData['entity_list'][index]
                                  ['lock_status'] ==
                              true
                      ? true
                      : false,
          isHandLockIconShow: searchController.text.isEmpty
              ? tabIndex == 2
                  ? viewModel.assignedLeadsList[index].isHandLockIconShow
                  : viewModel.leadsList[index].isHandLockIconShow
              : tabIndex == 2
                  ? viewModel.assignedLeadsMap['entity_list'][index]
                                  ['is_disqualified'] ==
                              true &&
                          viewModel.assignedLeadsMap['entity_list'][index]
                                  ['lock_status'] ==
                              false
                      ? true
                      : false
                  : viewModel.viewLeadsBySourceData['entity_list'][index]
                                  ['is_disqualified'] ==
                              true &&
                          viewModel.viewLeadsBySourceData['entity_list'][index]
                                  ['lock_status'] ==
                              false
                      ? true
                      : false,
          onCallCloudTap: () => viewModel.onCallCloudIconTap(
              leadId: searchController.text.isEmpty
                  ? tabIndex == 2
                      ? viewModel.assignedLeadsList[index].leadId
                      : viewModel.leadsList[index].leadId
                  : tabIndex == 2
                      ? viewModel.assignedLeadsMap['entity_list'][index]['lead_id'] ??
                          ''
                      : viewModel.viewLeadsBySourceData['entity_list'][index]['lead_id'] ??
                          '',
              phoneNumber: searchController.text.isEmpty
                  ? tabIndex == 2
                      ? viewModel.assignedLeadsList[index].phoneNumber
                      : viewModel.leadsList[index].phoneNumber
                  : tabIndex == 2
                      ? viewModel.assignedLeadsMap['entity_list'][index]
                              ['mobile_number'] ??
                          ''
                      : viewModel.viewLeadsBySourceData['entity_list'][index]
                              ['mobile_number'] ??
                          '',
              name: searchController.text.isEmpty
                  ? tabIndex == 2
                      ? viewModel.assignedLeadsList[index].personName[0].toUpperCase() +
                          viewModel.assignedLeadsList[index].personName
                              .substring(1)
                      : viewModel.leadsList[index].personName[0].toUpperCase() +
                          viewModel.leadsList[index].personName.substring(1)
                  : tabIndex == 2
                      ? viewModel.assignedLeadsMap['entity_list'][index]['lead_name'][0].toUpperCase() +
                              viewModel.assignedLeadsMap['entity_list'][index]['lead_name']
                                  .substring(1) ??
                          ''
                      : viewModel.viewLeadsBySourceData['entity_list'][index]['lead_name'][0].toUpperCase() +
                              viewModel.viewLeadsBySourceData['entity_list'][index]['lead_name'].substring(1) ??
                          ''),
          onCallIconTap: () => viewModel.onCallCloudIconTap(
              name: searchController.text.isEmpty
                  ? tabIndex == 2
                      ? viewModel.assignedLeadsList[index].personName[0].toUpperCase() +
                          viewModel.assignedLeadsList[index].personName
                              .substring(1)
                      : viewModel.leadsList[index].personName[0].toUpperCase() +
                          viewModel.leadsList[index].personName.substring(1)
                  : tabIndex == 2
                      ? viewModel.assignedLeadsMap['entity_list'][index]
                                      ['lead_name'][0]
                                  .toUpperCase() +
                              viewModel.assignedLeadsMap['entity_list'][index]
                                      ['lead_name']
                                  .substring(1) ??
                          ''
                      : viewModel.viewLeadsBySourceData['entity_list'][index]
                                      ['lead_name'][0]
                                  .toUpperCase() +
                              viewModel.viewLeadsBySourceData['entity_list']
                                      [index]['lead_name']
                                  .substring(1) ??
                          '',
              phoneNumber: searchController.text.isEmpty
                  ? tabIndex == 2
                      ? viewModel.assignedLeadsList[index].phoneNumber
                      : viewModel.leadsList[index].phoneNumber
                  : tabIndex == 2
                      ? viewModel.assignedLeadsMap['entity_list'][index]['mobile_number'] ?? ''
                      : viewModel.viewLeadsBySourceData['entity_list'][index]['mobile_number'] ?? ''),
        ),
      ),
    );
  }

//Card coutn
  Container _recordCount(AllLeadsViewModel viewModel) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: RichText(
          text: TextSpan(
              text: 'Showing ',
              style: AppTextStyle().smallLarge(fontColor: FontColor().grey),
              children: [
            TextSpan(
              text:
                  '${tabIndex == 2 ? viewModel.assignedLeadsMap['total_count'] ?? '0' : viewModel.viewLeadsBySourceData['total_count'] ?? '0'}',
              style: AppTextStyle().numberStyle(fontColor: FontColor().black),
            ),
            TextSpan(
              text: tabIndex == 2
                  ? viewModel.assignedLeadsMap.isNotEmpty
                      ? viewModel.assignedLeadsMap['total_count'] <= 1
                          ? ' record'
                          : ' records'
                      : ' record'
                  : viewModel.viewLeadsBySourceData.isNotEmpty
                      ? viewModel.viewLeadsBySourceData['total_count'] <= 1
                          ? ' record'
                          : ' records'
                      : ' record',
              style: AppTextStyle().smallLarge(fontColor: FontColor().grey),
            )
          ])),
    );
  }

//Filters
  SizedBox _renderFilter(AllLeadsViewModel viewModel) {
    return SizedBox(
      height: 32,
      child: viewModel.filterCategoryList.length == 1
          ? const SizedBox()
          : ListView.builder(
              itemCount: viewModel.filterCategoryList.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => viewModel.onFilterCategoryTap(
                      viewModel.filterCategoryList[index].title, index),
                  child: Container(
                    margin: const EdgeInsets.only(right: 5, top: 5, bottom: 5),
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        boxShadow: viewModel.choosedFiter ==
                                viewModel.filterCategoryList[index].title
                            ? [
                                const BoxShadow(
                                    offset: Offset(0, 5),
                                    color: blackColor,
                                    blurRadius: 5,
                                    spreadRadius: -5)
                              ]
                            : [],
                        border: Border.all(
                            width: 1,
                            color: viewModel.filterCategoryList[index].color),
                        color: viewModel.choosedFiter ==
                                viewModel.filterCategoryList[index].title
                            ? viewModel.filterCategoryList[index].selectedColor
                            : whiteColor,
                        borderRadius: BorderRadius.circular(20)),
                    child: Text(viewModel.filterCategoryList[index].title,
                        style: AppTextStyle().dateText(
                            fontColor:
                                viewModel.filterCategoryList[index].textColor)),
                  ),
                );
              },
            ),
    );
  }

//Render Tool Bar
  TabBar _renderToolBar(BuildContext context, AllLeadsViewModel viewModel) {
    return TabBar(
        indicatorSize: TabBarIndicatorSize.tab,
        padding: EdgeInsets.zero,
        labelPadding: EdgeInsets.zero,
        tabs: [
          if (viewModel.sharedService.isShowDSTTab!) ...[
            SizedBox(
                height: 20,
                child: Text('DST',
                    style: AppTextStyle()
                        .toastMessageTextStyle(fontColor: FontColor().black)))
          ],
          if (viewModel.sharedService.isShowCPTab! ||
              viewModel.sharedService.isShowCPTabForCPUser!) ...[
            SizedBox(
                height: 20,
                child: Text('Channel Partner',
                    style: AppTextStyle()
                        .toastMessageTextStyle(fontColor: FontColor().black))),
          ],
          if (viewModel.sharedService.isShowMyLeads!)
            SizedBox(
                height: 20,
                child: Text('My Leads',
                    style: AppTextStyle()
                        .toastMessageTextStyle(fontColor: FontColor().black)))
        ],
        indicatorWeight: 2,
        indicatorColor: primaryColor,
        labelColor: blackColor,
        onTap: viewModel.onChangeTab);
  }
}
