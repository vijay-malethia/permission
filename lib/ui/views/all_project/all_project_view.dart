import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import '/ui/common/index.dart';
import '/ui/common/widgets/index.dart';
import '/ui/views/all_project/all_project_view.form.dart';
import 'all_project_viewmodel.dart';

@FormView(fields: [
  FormTextField(name: 'search', initialValue: ''),
])
class AllProjectView extends StackedView<AllProjectViewModel>
    with $AllProjectView {
  const AllProjectView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    AllProjectViewModel viewModel,
    Widget? child,
  ) {
    return Stack(
      children: [
        Screen(
          height: screenHeight(context) * 0.15,
          headerChild: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: InkWell(
                onTap: viewModel.goBack,
                child: Row(children: [
                  const Icon(Icons.arrow_back, color: whiteColor),
                  horizontalSpaceTiny,
                  Text('All Projects',
                      style: Theme.of(context).textTheme.displayLarge)
                ]),
              )),
          bodyChild: RefreshIndicator(
            onRefresh: () async {
              viewModel.initAllProject(
                  index: currentTabIndex, searchController: searchController);
            },
            child: Column(children: [
              Container(
                width: 60,
                height: 4,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: customLightGrey),
              ),
              verticalSpaceSmall,
              _renderTabBar(viewModel, context),
              verticalSpaceMedium,
              _renderSearchbar(viewModel, context),
              verticalSpaceExtraSmall,
              if (currentTabIndex == 1) ...[
                _renderRecords(viewModel),
                verticalSpaceExtraSmall,
                Expanded(
                  child: ListView.builder(
                    controller: viewModel.scrollController,
                    itemCount: searchController.text.trim().length > 2
                        ? (searchProjectsResponse.length)
                        : (dstProjectsResponse.length) + 1,
                    physics: const ScrollPhysics(),
                    padding: const EdgeInsets.all(0),
                    itemBuilder: (context, index) {
                      if (dstProjectsRes != null &&
                          index < (dstProjectsResponse.length)) {
                        return Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: secondaryColor),
                          margin: const EdgeInsets.only(bottom: 15),
                          child: ProjectCard(
                            cpLength: ((searchController.text.trim().length > 2
                                    ? searchProjectsResponse[index]['managers']
                                    : dstProjectsResponse[index]['managers'])
                                .length),
                            cpName: ((searchController.text.trim().length > 2
                                    ? searchProjectsResponse[index]['managers']
                                    : dstProjectsResponse[index]['managers'])
                                .first['name']),
                            onTap: () => viewModel.goToProjectOverview(
                                (searchController.text.trim().length > 2
                                    ? searchProjectsResponse[index]
                                        ['project_id']
                                    : dstProjectsResponse[index]['project_id']),
                                index),
                            path: Images().person,
                            path2: Images().personAdd,
                            leads: 'Leads',
                            cityName: (searchController.text.trim().length > 2
                                    ? searchProjectsResponse[index]['city']
                                    : dstProjectsResponse[index]['city']) ??
                                '',
                            lastSale: (searchController.text.trim().length > 2
                                    ? searchProjectsResponse[index]
                                        ['lastsaledate']
                                    : dstProjectsResponse[index]
                                        ['lastsaledate']) ??
                                '',
                            projectName: searchController.text.trim().length > 2
                                ? (searchProjectsResponse[index]
                                        ['project_name'] ??
                                    '')
                                : (dstProjectsResponse[index]['project_name'] ??
                                    ''),
                            leadCount: (searchController.text.trim().length > 2
                                    ? searchProjectsResponse[index]
                                        ['leadscount']
                                    : dstProjectsResponse[index]
                                        ['leadscount']) ??
                                0,
                            actionUnavailable: currentTabIndex == 2,
                            onAssignedUserTap: () {
                              viewModel.onProjectSelect(index);
                              viewModel.showbottomSheetRemoveUserFromProject(
                                  searchController.text.trim().length > 2
                                      ? searchProjectsResponse[index]
                                          ['project_id']
                                      : dstProjectsResponse[index]
                                          ['project_id'],
                                  searchController);
                            },
                            onIconTap: () {
                              currentProjectIndex = index;
                              if (viewModel.showDSTTab &&
                                  viewModel.showChannelPartnerTab) {
                                viewModel.showAssignProjectToUserbottomSheet(
                                    searchController.text.trim().length > 2
                                        ? searchProjectsResponse[index]
                                            ['project_id']
                                        : dstProjectsResponse[index]
                                            ['project_id'],
                                    searchController);
                              } else if (viewModel.showDSTTab) {
                                viewModel.onSelect(0, '1',
                                    projectId:
                                        searchController.text.trim().length > 2
                                            ? searchProjectsResponse[index]
                                                ['project_id']
                                            : dstProjectsResponse[index]
                                                ['project_id']);
                              } else if (viewModel.showChannelPartnerTab) {
                                viewModel.onSelect(1, '2',
                                    projectId:
                                        searchController.text.trim().length > 2
                                            ? searchProjectsResponse[index]
                                                ['project_id']
                                            : dstProjectsResponse[index]
                                                ['project_id']);
                              }
                            },
                          ),
                        );
                      } else if (dstProjectsResponse.length >=
                          (dstProjectsRes == null
                              ? 0
                              : (dstProjectsRes['totalcount'] ?? 0))) {
                        return const SizedBox();
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(color: primaryColor),
                        );
                      }
                    },
                  ),
                ),
              ] else if (currentTabIndex == 2) ...[
                _renderRecords(viewModel),
                verticalSpaceExtraSmall,
                Expanded(
                  child: ListView.builder(
                    controller: viewModel.scrollController,
                    itemCount: searchController.text.trim().length > 2
                        ? (searchProjectsResponse.length)
                        : (cpProjectsResponse.length) + 1,
                    physics: const ScrollPhysics(),
                    padding: const EdgeInsets.all(0),
                    itemBuilder: (context, index) {
                      if (cpProjectsRes != null &&
                          index < (cpProjectsResponse.length)) {
                        return Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: secondaryColor),
                          margin: const EdgeInsets.only(bottom: 15),
                          child: ProjectCard(
                            cpLength: viewModel.sharedService.userId == 2
                                ? (searchController.text.trim().length > 2
                                        ? searchProjectsResponse[index]
                                            ['cp_users']
                                        : cpProjectsResponse[index]['cp_users'])
                                    .length
                                : (searchController.text.trim().length > 2
                                        ? searchProjectsResponse[index]
                                            ['channelPartnerList']
                                        : cpProjectsResponse[index]
                                            ['channelPartnerList'])
                                    .length,
                            cpName: viewModel.sharedService.userId == 2
                                ? ((searchController.text.trim().length > 2
                                        ? searchProjectsResponse
                                        : cpProjectsResponse)[index]['cp_users']
                                    [0]['name'])
                                : ((searchController.text.trim().length > 2
                                            ? searchProjectsResponse
                                            : cpProjectsResponse)[index]
                                        ['channelPartnerList'][0]
                                    ['channel_partner_name']),
                            onTap: () {
                              viewModel.goToProjectOverview(
                                  (searchController.text.trim().length > 2
                                      ? searchProjectsResponse[index]
                                          ['project_id']
                                      : cpProjectsResponse[index]
                                          ['project_id']),
                                  index);
                            },
                            path: Images().handShakeIcon,
                            path2: Images().handShakeAddIcon,
                            leads: 'Leads',
                            cityName: (searchController.text.trim().length > 2
                                    ? searchProjectsResponse[index]['city']
                                    : cpProjectsResponse[index]['city']) ??
                                '',
                            lastSale: (searchController.text.trim().length > 2
                                    ? searchProjectsResponse[index]
                                        ['lastsaledate']
                                    : cpProjectsResponse[index]
                                        ['lastsaledate']) ??
                                '',
                            projectName:
                                (searchController.text.trim().length > 2
                                        ? searchProjectsResponse[index]
                                            ['project_name']
                                        : cpProjectsResponse[index]
                                            ['project_name']) ??
                                    '',
                            leadCount: (searchController.text.trim().length > 2
                                    ? searchProjectsResponse[index]
                                        ['leadscount']
                                    : cpProjectsResponse[index]
                                        ['leadscount']) ??
                                0,
                            actionUnavailable:
                                viewModel.sharedService.userId == 1,
                            onAssignedUserTap: () {
                              viewModel.onProjectSelect(index);
                              viewModel.showbottomSheetRemoveUserFromProject(
                                  searchController.text.trim().length > 2
                                      ? searchProjectsResponse[index]
                                          ['project_id']
                                      : cpProjectsResponse[index]['project_id'],
                                  searchController);
                            },
                            onIconTap: () {
                              currentProjectIndex = index;

                              if (viewModel.sharedService.userId == 2 &&
                                  viewModel.sharedService.isViewAllProject!) {
                                viewModel.onSelect(0, '1',
                                    projectId:
                                        searchController.text.trim().length > 2
                                            ? searchProjectsResponse[index]
                                                ['project_id']
                                            : cpProjectsResponse[index]
                                                ['project_id']);
                              }
                            },
                          ),
                        );
                      } else if (cpProjectsResponse.length >=
                          (cpProjectsRes == null
                              ? 0
                              : (cpProjectsRes['totalcount'] ?? 0))) {
                        return const SizedBox();
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(color: primaryColor),
                        );
                      }
                    },
                  ),
                ),
              ] else if (currentTabIndex == 3) ...[
                _renderRecords(viewModel),
                verticalSpaceExtraSmall,
                Expanded(
                  child: ListView.builder(
                    controller: viewModel.scrollController,
                    itemCount: searchController.text.trim().length > 2
                        ? (searchProjectsResponse.length)
                        : (myProjectsResponse.length),
                    physics: const ScrollPhysics(),
                    padding: const EdgeInsets.all(0),
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: secondaryColor),
                        margin: const EdgeInsets.only(bottom: 15),
                        child: ProjectCard(
                          cpLength: viewModel.sharedService.userId == 2
                              ? (searchController.text.trim().length > 2
                                      ? searchProjectsResponse[index]
                                          ['cp_users']
                                      : myProjectsResponse[index]['cp_users'])
                                  .length
                              : (searchController.text.trim().length > 2
                                      ? searchProjectsResponse[index]
                                          ['managers']
                                      : myProjectsResponse[index]['managers'])
                                  .length,
                          cpName: viewModel.sharedService.userId == 2
                              ? ((searchController.text.trim().length > 2
                                      ? searchProjectsResponse
                                      : myProjectsResponse)[index]['cp_users']
                                  [0]['name'])
                              : ((searchController.text.trim().length > 2
                                      ? searchProjectsResponse[index]
                                          ['managers']
                                      : myProjectsResponse[index]['managers'])
                                  .first['name']),
                          onTap: () => viewModel.goToProjectOverview(
                              (searchController.text.trim().length > 2
                                  ? searchProjectsResponse[index]['project_id']
                                  : myProjectsResponse[index]['project_id']),
                              index),
                          path: viewModel.sharedService.userId == 2
                              ? Images().handShakeIcon
                              : Images().person,
                          path2: viewModel.sharedService.userId == 2
                              ? Images().handShakeAddIcon
                              : Images().personAdd,
                          leads: 'Leads',
                          cityName: (searchController.text.trim().length > 2
                                  ? searchProjectsResponse[index]['city']
                                  : myProjectsResponse[index]['city']) ??
                              '',
                          lastSale: (searchController.text.trim().length > 2
                                  ? searchProjectsResponse[index]
                                      ['lastsaledate']
                                  : myProjectsResponse[index]
                                      ['lastsaledate']) ??
                              '',
                          projectName: searchController.text.trim().length > 2
                              ? (searchProjectsResponse[index]
                                      ['project_name'] ??
                                  '')
                              : (myProjectsResponse[index]['project_name'] ??
                                  ''),
                          leadCount: (searchController.text.trim().length > 2
                                  ? searchProjectsResponse[index]['leadscount']
                                  : myProjectsResponse[index]['leadscount']) ??
                              0,
                          actionUnavailable: currentTabIndex == 2,
                          onAssignedUserTap: () {
                            viewModel.onProjectSelect(index);
                            viewModel.showbottomSheetRemoveUserFromProject(
                                searchController.text.trim().length > 2
                                    ? searchProjectsResponse[index]
                                        ['project_id']
                                    : myProjectsResponse[index]['project_id'],
                                searchController);
                          },
                          onIconTap: viewModel.sharedService.isCp!
                              ? () {
                                  currentProjectIndex = index;

                                  if (viewModel.sharedService.userId == 2 &&
                                      viewModel
                                          .sharedService.isViewAllProject!) {
                                    viewModel.onSelect(0, '1',
                                        projectId: searchController.text
                                                    .trim()
                                                    .length >
                                                2
                                            ? searchProjectsResponse[index]
                                                ['project_id']
                                            : myProjectsResponse[index]
                                                ['project_id']);
                                  }
                                }
                              : () {
                                  currentProjectIndex = index;
                                  if (viewModel.showDSTTab &&
                                      viewModel.showChannelPartnerTab) {
                                    viewModel
                                        .showAssignProjectToUserbottomSheet(
                                            searchController.text
                                                        .trim()
                                                        .length >
                                                    2
                                                ? searchProjectsResponse[index]
                                                    ['project_id']
                                                : myProjectsResponse[index]
                                                    ['project_id'],
                                            searchController);
                                  } else if (viewModel.showDSTTab) {
                                    viewModel.onSelect(0, '1',
                                        projectId: searchController.text
                                                    .trim()
                                                    .length >
                                                2
                                            ? searchProjectsResponse[index]
                                                ['project_id']
                                            : myProjectsResponse[index]
                                                ['project_id']);
                                  } else if (viewModel.showChannelPartnerTab) {
                                    viewModel.onSelect(1, '2',
                                        projectId: searchController.text
                                                    .trim()
                                                    .length >
                                                2
                                            ? searchProjectsResponse[index]
                                                ['project_id']
                                            : myProjectsResponse[index]
                                                ['project_id']);
                                  }
                                },
                        ),
                      );
                    },
                  ),
                ),
              ]
            ]),
          ),
        ),
        if (viewModel.isBusy) const Loader(),
      ],
    );
  }

  @override
  AllProjectViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      AllProjectViewModel()
        ..initAllProject(searchController: searchController, isInit: true);

  //Render Tab Bar
  Widget _renderTabBar(AllProjectViewModel viewModel, context) {
    return Row(
      children: [
        if (viewModel.showDSTTab) ...[
          Expanded(
            child: InkWell(
              onTap: () {
                searchController.text = '';
                viewModel.updatecurrenttabIndex(1, searchController);
              },
              child: Container(
                alignment: Alignment.center,
                child: Container(
                  padding: const EdgeInsets.only(bottom: 5),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              width: 2,
                              color: currentTabIndex == 1
                                  ? primaryColor
                                  : transparent))),
                  child: Text('DST',
                      style: AppTextStyle()
                          .toastMessageTextStyle(fontColor: FontColor().black)),
                ),
              ),
            ),
          )
        ],
        if (viewModel.showChannelPartnerTab) ...[
          Expanded(
            child: InkWell(
              onTap: () {
                searchController.text = '';
                viewModel.updatecurrenttabIndex(2, searchController);
              },
              child: Container(
                alignment: Alignment.center,
                child: Container(
                  padding: const EdgeInsets.only(bottom: 5),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              width: 2,
                              color: currentTabIndex == 2
                                  ? primaryColor
                                  : transparent))),
                  child: Text('Channel Partner',
                      style: AppTextStyle()
                          .toastMessageTextStyle(fontColor: FontColor().black)),
                ),
              ),
            ),
          )
        ],
        if (viewModel.showMyProjectTab) ...[
          Expanded(
            child: InkWell(
              onTap: () {
                searchController.text = '';
                viewModel.updatecurrenttabIndex(3, searchController);
              },
              child: Container(
                alignment: Alignment.center,
                child: Container(
                  padding: const EdgeInsets.only(bottom: 5),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              width: 2,
                              color: currentTabIndex == 3
                                  ? primaryColor
                                  : transparent))),
                  child: Text('My Project',
                      style: AppTextStyle()
                          .toastMessageTextStyle(fontColor: FontColor().black)),
                ),
              ),
            ),
          )
        ],
        if (!viewModel.showDSTTab ||
            !viewModel.showChannelPartnerTab ||
            !viewModel.showMyProjectTab) ...[const Spacer()],
      ],
    );
  }

//search Bar
  _renderSearchbar(AllProjectViewModel viewModel, BuildContext context) {
    return SizedBox(
      height: 45,
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: SearchInput(
              controller: searchController,
              focusNode: searchFocusNode,
              onCancel: () async {
                searchController.text = '';
                viewModel.notifyListeners();
              },
              onChanged: (value) {
                viewModel.initSearchResponse(
                  userId: currentTabIndex,
                  search: searchController.text.trim(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

//All user records
  _renderRecords(AllProjectViewModel viewModel) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RichText(
              text: TextSpan(
                  text: 'Showing ',
                  style: AppTextStyle().tncTextStyle(),
                  children: [
                TextSpan(
                  text: capitalizeFirstLetter(
                      (searchController.text.trim().length > 2
                              ? (searchProjectsRes == null
                                  ? '0'
                                  : (currentTabIndex != 3
                                      ? searchProjectsRes['totalcount']
                                      : searchProjectsResponse.length))
                              : (currentTabIndex == 2
                                  ? cpProjectsRes == null
                                      ? '0'
                                      : cpProjectsRes['totalcount']
                                  : currentTabIndex == 3
                                      ? myProjectsResponse.length.toString()
                                      : (dstProjectsRes == null
                                          ? '0'
                                          : dstProjectsRes['totalcount'])))
                          .toString()),
                  style: AppTextStyle()
                      .textButtonTextStyle(textColor: FontColor().blue1),
                ),
                TextSpan(
                  text: ' records',
                  style: AppTextStyle().tncTextStyle(),
                ),
              ])),
        ],
      ),
    );
  }
}
