import 'package:flutter_switch/flutter_switch.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import '/ui/common/widgets/index.dart';
import '/ui/common/index.dart';
import '/ui/views/allusers/allusers_view.form.dart';
import 'allusers_viewmodel.dart';

@FormView(fields: [
  FormTextField(name: 'search', initialValue: ''),
])
class AllusersView extends StackedView<AllusersViewModel> with $AllusersView {
  const AllusersView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    AllusersViewModel viewModel,
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
                    Text('All Users',
                        style: Theme.of(context).textTheme.displayLarge)
                  ]),
                )),
            bodyChild: Container(
                decoration: const BoxDecoration(
                    color: backgroundcolor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                child: RefreshIndicator(
                  onRefresh: () async {
                    viewModel.initAllUser(
                        context: context,
                        isInit: true,
                        tabIndex: currentTabIndex);
                  },
                  child: Column(
                    children: [
                      Container(
                        width: 50,
                        height: 3,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: customLightGrey),
                      ),
                      verticalSpaceSmall,
                      _renderTabBar(viewModel, context),
                      verticalSpaceSmall,
                      _renderSearchbar(viewModel, context),
                      verticalSpaceExtraSmall,
                      if (currentTabIndex == 'DST') ...[
                        _renderRecords(viewModel),
                        verticalSpaceExtraSmall,
                        Expanded(
                          child: ListView.builder(
                              controller: viewModel.scrollController,
                              itemCount: searchController.text.length > 2
                                  ? searchResponse.length
                                  : (viewModel.switchVal
                                          ? dstResponse.length
                                          : dstInactiveResponse.length) +
                                      1,
                              scrollDirection: Axis.vertical,
                              physics: const ScrollPhysics(),
                              padding: const EdgeInsets.only(top: 0, bottom: 0),
                              itemBuilder: (context, index) {
                                if (index <
                                    (viewModel.switchVal
                                        ? dstResponse.length
                                        : dstInactiveResponse.length)) {
                                  return Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: secondaryColor),
                                      margin: const EdgeInsets.only(bottom: 15),
                                      child: UserRecords(
                                        callIconAvailable:
                                            searchController.text.length > 2
                                                ? searchResponse[index]
                                                        ['mobile_number'] !=
                                                    null
                                                : (viewModel.switchVal
                                                    ? dstResponse[index]
                                                            ['mobile_number'] !=
                                                        null
                                                    : dstInactiveResponse[index]
                                                            ['mobile_number'] !=
                                                        null),
                                        showActivateUserIcon: viewModel
                                                .sharedService
                                                .isActivateUser! &&
                                            !viewModel.switchVal,
                                        showDeactivateUserIcon: viewModel
                                                .sharedService
                                                .isDeactivateUser! &&
                                            viewModel.switchVal,
                                        userStatus:
                                            searchController.text.length > 2
                                                ? searchResponse[index]
                                                        ['user_status'] ==
                                                    true
                                                : (viewModel.switchVal
                                                    ? dstResponse[index]
                                                            ['user_status'] ==
                                                        true
                                                    : dstInactiveResponse[index]
                                                            ['user_status'] ==
                                                        true),
                                        actionUnavailable: searchController
                                                    .text.length >
                                                2
                                            ? searchResponse[index]
                                                    ['isSubodinateUser'] ==
                                                true
                                            : (viewModel.switchVal
                                                ? dstResponse[index]
                                                        ['isSubodinateUser'] ==
                                                    true
                                                : dstInactiveResponse[index]
                                                        ['isSubodinateUser'] ==
                                                    true),
                                        path: Images().person,
                                        projectCount: searchController.text.length > 2
                                            ? (searchResponse[index]['project_name'] != null &&
                                                    (searchResponse[index]['project_name'] as List)
                                                        .isNotEmpty
                                                ? searchResponse[index]['project_name'].length -
                                                    1
                                                : 0)
                                            : (viewModel.switchVal
                                                ? (dstResponse[index]['project_name'] != null &&
                                                        (dstResponse[index]['project_name'] as List)
                                                            .isNotEmpty
                                                    ? dstResponse[index]['project_name'].length -
                                                        1
                                                    : 0)
                                                : (dstInactiveResponse[index]['project_name'] != null &&
                                                        (dstInactiveResponse[index]
                                                                ['project_name'] as List)
                                                            .isNotEmpty
                                                    ? dstInactiveResponse[index]['project_name'].length - 1
                                                    : 0)),
                                        imageUrl: searchController.text.length >
                                                2
                                            ? searchResponse[index]
                                                    ['profile_picture_url']
                                                .toString()
                                            : (viewModel.switchVal
                                                ? dstResponse[index]
                                                        ['profile_picture_url']
                                                    .toString()
                                                : dstInactiveResponse[index]
                                                        ['profile_picture_url']
                                                    .toString()),
                                        designation:
                                            searchController.text.length > 2
                                                ? searchResponse[index]
                                                        ['designation_name']
                                                    .toString()
                                                : (viewModel.switchVal
                                                    ? dstResponse[index]
                                                            ['designation_name']
                                                        .toString()
                                                    : dstInactiveResponse[index]
                                                            ['designation_name']
                                                        .toString()),
                                        companyName: searchController
                                                    .text.length >
                                                2
                                            ? searchResponse[index]
                                                    ['reporting_to_name']
                                                .toString()
                                            : (viewModel.switchVal
                                                ? dstResponse[index]
                                                        ['reporting_to_name']
                                                    .toString()
                                                : dstInactiveResponse[index]
                                                        ['reporting_to_name']
                                                    .toString()),
                                        leads: 'Leads',
                                        leadsCount: searchController
                                                    .text.length >
                                                2
                                            ? searchResponse[index]
                                                    ['leads_count']
                                                .toString()
                                            : (viewModel.switchVal
                                                ? dstResponse[index]
                                                        ['leads_count']
                                                    .toString()
                                                : dstInactiveResponse[index]
                                                        ['leads_count']
                                                    .toString()),
                                        location: searchController.text.length > 2
                                            ? (searchResponse[index]['project_name'] != null &&
                                                    (searchResponse[index]['project_name'] as List)
                                                        .isNotEmpty
                                                ? searchResponse[index]['project_name'][0]
                                                    .toString()
                                                : '')
                                            : (viewModel.switchVal
                                                ? (dstResponse[index]['project_name'] != null &&
                                                        (dstResponse[index]['project_name'] as List)
                                                            .isNotEmpty
                                                    ? dstResponse[index]
                                                            ['project_name'][0]
                                                        .toString()
                                                    : '')
                                                : (dstInactiveResponse[index]['project_name'] != null &&
                                                        (dstInactiveResponse[index]['project_name'] as List).isNotEmpty
                                                    ? dstInactiveResponse[index]['project_name'][0].toString()
                                                    : '')),
                                        personName: capitalizeFirstLetter(
                                            searchController.text.length > 2
                                                ? searchResponse[index]
                                                        ['user_name']
                                                    .toString()
                                                : (viewModel.switchVal
                                                    ? dstResponse[index]
                                                            ['user_name']
                                                        .toString()
                                                    : dstInactiveResponse[index]
                                                            ['user_name']
                                                        .toString())),
                                        onCallIconTap: () => viewModel.showCallDialog(
                                            searchController.text.length > 2
                                                ? searchResponse[index]
                                                        ['user_name']
                                                    .toString()
                                                : (viewModel.switchVal
                                                    ? dstResponse[index]
                                                            ['user_name']
                                                        .toString()
                                                    : cpInactiveResponse[index]
                                                            ['user_name']
                                                        .toString()),
                                            (searchController.text.length > 2
                                                    ? searchResponse[index]
                                                        ['mobile_number']
                                                    : (viewModel.switchVal
                                                        ? (dstResponse[index]
                                                            ['mobile_number'])
                                                        : (dstInactiveResponse[
                                                                index]
                                                            ['mobile_number'])))
                                                .toString()),
                                        onTap: () => viewModel
                                            .showAssignedProjectbottomSheet(
                                                index,
                                                searchController.text.length > 2
                                                    ? searchResponse[index]
                                                        ['user_id']
                                                    : (viewModel.switchVal
                                                        ? dstResponse[index]
                                                            ['user_id']
                                                        : dstInactiveResponse[
                                                            index]['user_id']),
                                                searchController.text.length > 2
                                                    ? searchResponse[index]
                                                        ['isSubodinateUser']
                                                    : (viewModel.switchVal
                                                        ? dstResponse[index]
                                                            ['isSubodinateUser']
                                                        : dstInactiveResponse[
                                                                index][
                                                            'isSubodinateUser']),
                                                context: context),
                                        onTapBuilding: () =>
                                            viewModel.showbottomSheet(
                                                searchController.text.length > 2
                                                    ? searchResponse[index]
                                                        ['user_id']
                                                    : (viewModel.switchVal
                                                        ? dstResponse[index]
                                                            ['user_id']
                                                        : dstInactiveResponse[
                                                            index]['user_id']),
                                                context: context),
                                        onTapRemove: () {
                                          viewModel.changeUserStatus(
                                              userId: searchController
                                                          .text.length >
                                                      2
                                                  ? searchResponse[index]
                                                      ['user_id']
                                                  : (viewModel.switchVal
                                                      ? dstResponse[index]
                                                          ['user_id']
                                                      : dstInactiveResponse[
                                                          index]['user_id']),
                                              status: !viewModel.switchVal,
                                              context: context);
                                        },
                                      ));
                                } else if (viewModel.switchVal
                                    ? (dstResponse.length >=
                                        (dstRes == null
                                            ? 0
                                            : (dstRes['totalCount'] ?? 0)))
                                    : (dstInactiveResponse.length >=
                                        (dstInactiveRes == null
                                            ? 0
                                            : (dstInactiveRes['totalCount'] ??
                                                0)))) {
                                  return const SizedBox();
                                } else {
                                  return const Center(
                                    child: CircularProgressIndicator(
                                      color: primaryColor,
                                    ),
                                  );
                                }
                              }),
                        )
                      ] else if (currentTabIndex == 'CP') ...[
                        _renderRecords(viewModel),
                        verticalSpaceExtraSmall,
                        Expanded(
                          child: ListView.builder(
                              controller: viewModel.scrollController,
                              itemCount: searchController.text.length > 2
                                  ? searchResponse.length
                                  : (viewModel.switchVal
                                          ? cpResponse.length
                                          : cpInactiveResponse.length) +
                                      1,
                              scrollDirection: Axis.vertical,
                              physics: const ScrollPhysics(),
                              padding: const EdgeInsets.only(top: 0, bottom: 0),
                              itemBuilder: (context, index) {
                                if (index <
                                    (viewModel.switchVal
                                        ? cpResponse.length
                                        : cpInactiveResponse.length)) {
                                  return Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: secondaryColor),
                                      margin: const EdgeInsets.only(bottom: 15),
                                      child: UserRecords(
                                        showActivateUserIcon:
                                            viewModel.sharedService.userId == 1
                                                ? false
                                                : viewModel.sharedService
                                                        .isActivateUser! &&
                                                    !viewModel.switchVal,
                                        showDeactivateUserIcon:
                                            viewModel.sharedService.userId == 1
                                                ? false
                                                : viewModel.sharedService
                                                        .isDeactivateUser! &&
                                                    viewModel.switchVal,
                                        actionUnavailable:
                                            viewModel.sharedService.userId == 1
                                                ? false
                                                : viewModel.sharedService
                                                    .isAssignUserToProject,
                                        callIconAvailable:
                                            searchController.text.length > 2
                                                ? searchResponse[index]
                                                        ['mobile_number'] !=
                                                    null
                                                : (viewModel.switchVal
                                                    ? cpResponse[index]
                                                            ['mobile_number'] !=
                                                        null
                                                    : cpInactiveResponse[index]
                                                            ['mobile_number'] !=
                                                        null),
                                        userStatus: searchController
                                                    .text.length >
                                                2
                                            ? searchResponse[index]
                                                        ['user_status'] ==
                                                    true ||
                                                searchResponse[index]
                                                        ['isactive'] ==
                                                    true
                                            : (viewModel.switchVal
                                                ? cpResponse[index]
                                                            ['user_status'] ==
                                                        true ||
                                                    cpResponse[index]
                                                            ['isactive'] ==
                                                        true
                                                : cpInactiveResponse[index]
                                                            ['user_status'] ==
                                                        true ||
                                                    cpInactiveResponse[index]
                                                            ['isactive'] ==
                                                        true),
                                        path: Images().handShakeIcon,
                                        projectCount: searchController.text.length > 2
                                            ? (searchResponse[index]['project_name'] != null &&
                                                    (searchResponse[index]['project_name'] as List)
                                                        .isNotEmpty
                                                ? searchResponse[index]['project_name'].length -
                                                    1
                                                : 0)
                                            : (viewModel.switchVal
                                                ? (cpResponse[index]['project_name'] != null &&
                                                        (cpResponse[index]['project_name'] as List)
                                                            .isNotEmpty
                                                    ? cpResponse[index]['project_name'].length -
                                                        1
                                                    : 0)
                                                : (cpInactiveResponse[index]['project_name'] != null &&
                                                        (cpInactiveResponse[index]
                                                                ['project_name'] as List)
                                                            .isNotEmpty
                                                    ? cpInactiveResponse[index]['project_name'].length - 1
                                                    : 0)),
                                        imageUrl: searchController.text.length >
                                                2
                                            ? searchResponse[index]
                                                    ['profile_picture_url']
                                                .toString()
                                            : (viewModel.switchVal
                                                ? cpResponse[index]
                                                        ['profile_picture_url']
                                                    .toString()
                                                : cpInactiveResponse[index]
                                                        ['profile_picture_url']
                                                    .toString()),
                                        designation:
                                            searchController.text.length > 2
                                                ? searchResponse[index]
                                                        ['designation_name']
                                                    .toString()
                                                : (viewModel.switchVal
                                                    ? cpResponse[index]
                                                            ['designation_name']
                                                        .toString()
                                                    : cpInactiveResponse[index]
                                                            ['designation_name']
                                                        .toString()),
                                        companyName: searchController
                                                    .text.length >
                                                2
                                            ? searchResponse[index]
                                                    ['channel_partner_name']
                                                .toString()
                                            : (viewModel.switchVal
                                                ? cpResponse[index]
                                                        ['channel_partner_name']
                                                    .toString()
                                                : cpInactiveResponse[index]
                                                        ['channel_partner_name']
                                                    .toString()),
                                        leads: 'Leads',
                                        leadsCount: searchController
                                                    .text.length >
                                                2
                                            ? searchResponse[index]
                                                    ['leads_count']
                                                .toString()
                                            : (viewModel.switchVal
                                                ? cpResponse[index]
                                                        ['leads_count']
                                                    .toString()
                                                : cpInactiveResponse[index]
                                                        ['leads_count']
                                                    .toString()),
                                        location: searchController.text.length > 2
                                            ? (searchResponse[index]['project_name'] != null &&
                                                    (searchResponse[index]['project_name'] as List)
                                                        .isNotEmpty
                                                ? searchResponse[index]['project_name'][0]
                                                    .toString()
                                                : '')
                                            : (viewModel.switchVal
                                                ? (cpResponse[index]['project_name'] != null &&
                                                        (cpResponse[index]['project_name'] as List)
                                                            .isNotEmpty
                                                    ? cpResponse[index]
                                                            ['project_name'][0]
                                                        .toString()
                                                    : '')
                                                : (cpInactiveResponse[index]['project_name'] != null &&
                                                        (cpInactiveResponse[index]['project_name'] as List).isNotEmpty
                                                    ? cpInactiveResponse[index]['project_name'][0].toString()
                                                    : '')),
                                        personName: capitalizeFirstLetter(searchController.text.length > 2
                                            ? (viewModel.sharedService.isCp! &&
                                                        currentTabIndex == 'CP'
                                                    ? searchResponse[index]
                                                        ['name']
                                                    : searchResponse[index]
                                                        ['user_name'])
                                                .toString()
                                            : (viewModel.switchVal
                                                ? (viewModel.sharedService.isCp! && currentTabIndex == 'CP'
                                                        ? cpResponse[index]
                                                            ['name']
                                                        : cpResponse[index]
                                                            ['user_name'])
                                                    .toString()
                                                : (viewModel.sharedService.isCp! &&
                                                            currentTabIndex ==
                                                                'CP'
                                                        ? cpInactiveResponse[index]
                                                            ['name']
                                                        : cpInactiveResponse[index]['user_name'])
                                                    .toString())),
                                        onCallIconTap: () => viewModel.showCallDialog(
                                            searchController.text.length > 2
                                                ? (viewModel.sharedService.isCp! && currentTabIndex == 'CP'
                                                        ? searchResponse[index]
                                                            ['name']
                                                        : searchResponse[index]
                                                            ['user_name'])
                                                    .toString()
                                                : (viewModel.switchVal
                                                    ? (viewModel.sharedService.isCp! && currentTabIndex == 'CP' ? cpResponse[index]['name'] : cpResponse[index]['user_name'])
                                                        .toString()
                                                    : (viewModel.sharedService.isCp! && currentTabIndex == "CP"
                                                            ? cpInactiveResponse[index]
                                                                ['name']
                                                            : cpInactiveResponse[index]
                                                                ['user_name'])
                                                        .toString()),
                                            (searchController.text.length > 2
                                                    ? searchResponse[index]
                                                        ['mobile_number']
                                                    : (viewModel.switchVal
                                                        ? (cpResponse[index]
                                                            ['mobile_number'])
                                                        : (cpInactiveResponse[index]['mobile_number'])))
                                                .toString()),
                                        onTap: () => viewModel
                                            .showAssignedProjectbottomSheet(
                                                index,
                                                searchController.text.length > 2
                                                    ? searchResponse[index]
                                                        ['user_id']
                                                    : (viewModel.switchVal
                                                        ? cpResponse[index]
                                                            ['user_id']
                                                        : cpInactiveResponse[
                                                            index]['user_id']),
                                                false,
                                                context: context),
                                        onTapBuilding: () =>
                                            viewModel.showbottomSheet(
                                                searchController.text.length > 2
                                                    ? searchResponse[index]
                                                        ['user_id']
                                                    : (viewModel.switchVal
                                                        ? cpResponse[index]
                                                            ['user_id']
                                                        : cpInactiveResponse[
                                                            index]['user_id']),
                                                context: context),
                                        onTapRemove: () {
                                          viewModel.changeUserStatus(
                                              userId: searchController
                                                          .text.length >
                                                      2
                                                  ? searchResponse[index]
                                                      ['user_id']
                                                  : (viewModel.switchVal
                                                      ? cpResponse[index]
                                                          ['user_id']
                                                      : cpInactiveResponse[
                                                          index]['user_id']),
                                              status: !viewModel.switchVal,
                                              context: context);
                                        },
                                      ));
                                } else if (viewModel.switchVal
                                    ? (cpResponse.length >=
                                        (viewModel.sharedService.isCp! &&
                                                currentTabIndex == 'CP'
                                            ? (cpRes == null
                                                ? 0
                                                : (cpRes['total_count'] ?? 0))
                                            : (cpRes == null
                                                ? 0
                                                : (cpRes['totalCount'] ?? 0))))
                                    : (cpInactiveResponse.length >=
                                        (viewModel.sharedService.isCp! &&
                                                currentTabIndex == 'CP'
                                            ? (cpInactiveRes == null
                                                ? 0
                                                : (cpInactiveRes[
                                                        'total_count'] ??
                                                    0))
                                            : (cpInactiveRes == null
                                                ? 0
                                                : (cpInactiveRes[
                                                        'totalCount'] ??
                                                    0))))) {
                                  return const SizedBox();
                                } else {
                                  return const Center(
                                    child: CircularProgressIndicator(
                                      color: primaryColor,
                                    ),
                                  );
                                }
                              }),
                        )
                      ] else if (currentTabIndex == 'MyTeam') ...[
                        _renderRecords(viewModel),
                        verticalSpaceExtraSmall,
                        Expanded(
                          child: ListView.builder(
                              controller: viewModel.scrollController,
                              itemCount: searchController.text.length > 2
                                  ? searchResponse.length
                                  : (viewModel.switchVal
                                          ? myTeamResponse.length
                                          : myTeamInactiveResponse.length) +
                                      1,
                              scrollDirection: Axis.vertical,
                              physics: const ScrollPhysics(),
                              padding: const EdgeInsets.only(top: 0, bottom: 0),
                              itemBuilder: (context, index) {
                                if (index <
                                    (viewModel.switchVal
                                        ? myTeamResponse.length
                                        : myTeamInactiveResponse.length)) {
                                  return Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: secondaryColor),
                                      margin: const EdgeInsets.only(bottom: 15),
                                      child: UserRecords(
                                        callIconAvailable: searchController
                                                    .text.length >
                                                2
                                            ? searchResponse[index]
                                                    ['mobile_number'] !=
                                                null
                                            : (viewModel.switchVal
                                                ? myTeamResponse[index]
                                                        ['mobile_number'] !=
                                                    null
                                                : myTeamInactiveResponse[index]
                                                        ['mobile_number'] !=
                                                    null),
                                        showActivateUserIcon: viewModel
                                                .sharedService
                                                .isActivateUser! &&
                                            !viewModel.switchVal,
                                        showDeactivateUserIcon: viewModel
                                                .sharedService
                                                .isDeactivateUser! &&
                                            viewModel.switchVal,
                                        userStatus: searchController
                                                    .text.length >
                                                2
                                            ? searchResponse[index]
                                                    ['user_status'] ==
                                                true
                                            : (viewModel.switchVal
                                                ? myTeamResponse[index]
                                                        ['user_status'] ==
                                                    true
                                                : myTeamInactiveResponse[index]
                                                        ['user_status'] ==
                                                    true),
                                        actionUnavailable: searchController
                                                    .text.length >
                                                2
                                            ? searchResponse[index]
                                                    ['isSubodinateUser'] ==
                                                true
                                            : (viewModel.switchVal
                                                ? myTeamResponse[index]
                                                        ['isSubodinateUser'] ==
                                                    true
                                                : myTeamInactiveResponse[index]
                                                        ['isSubodinateUser'] ==
                                                    true),
                                        path: Images().person,
                                        projectCount: searchController.text.length > 2
                                            ? (searchResponse[index]['project_name'] != null &&
                                                    (searchResponse[index]['project_name'] as List)
                                                        .isNotEmpty
                                                ? searchResponse[index]['project_name'].length -
                                                    1
                                                : 0)
                                            : (viewModel.switchVal
                                                ? (myTeamResponse[index]['project_name'] != null &&
                                                        (myTeamResponse[index]['project_name'] as List)
                                                            .isNotEmpty
                                                    ? myTeamResponse[index]['project_name'].length -
                                                        1
                                                    : 0)
                                                : (myTeamInactiveResponse[index]['project_name'] != null &&
                                                        (myTeamInactiveResponse[index]
                                                                ['project_name'] as List)
                                                            .isNotEmpty
                                                    ? myTeamInactiveResponse[index]['project_name'].length - 1
                                                    : 0)),
                                        imageUrl: searchController.text.length >
                                                2
                                            ? searchResponse[index]
                                                    ['profile_picture_url']
                                                .toString()
                                            : (viewModel.switchVal
                                                ? myTeamResponse[index]
                                                        ['profile_picture_url']
                                                    .toString()
                                                : myTeamInactiveResponse[index]
                                                        ['profile_picture_url']
                                                    .toString()),
                                        designation: searchController
                                                    .text.length >
                                                2
                                            ? searchResponse[index]
                                                    ['designation_name']
                                                .toString()
                                            : (viewModel.switchVal
                                                ? myTeamResponse[index]
                                                        ['designation_name']
                                                    .toString()
                                                : myTeamInactiveResponse[index]
                                                        ['designation_name']
                                                    .toString()),
                                        companyName: searchController
                                                    .text.length >
                                                2
                                            ? searchResponse[index]
                                                    ['reporting_to_name']
                                                .toString()
                                            : (viewModel.switchVal
                                                ? myTeamResponse[index]
                                                        ['reporting_to_name']
                                                    .toString()
                                                : myTeamInactiveResponse[index]
                                                        ['reporting_to_name']
                                                    .toString()),
                                        leads: 'Leads',
                                        leadsCount: searchController
                                                    .text.length >
                                                2
                                            ? searchResponse[index]
                                                    ['leads_count']
                                                .toString()
                                            : (viewModel.switchVal
                                                ? myTeamResponse[index]
                                                        ['leads_count']
                                                    .toString()
                                                : myTeamInactiveResponse[index]
                                                        ['leads_count']
                                                    .toString()),
                                        location: searchController.text.length > 2
                                            ? (searchResponse[index]['project_name'] != null &&
                                                    (searchResponse[index]['project_name'] as List)
                                                        .isNotEmpty
                                                ? searchResponse[index]['project_name'][0]
                                                    .toString()
                                                : '')
                                            : (viewModel.switchVal
                                                ? (myTeamResponse[index]['project_name'] != null &&
                                                        (myTeamResponse[index]['project_name'] as List)
                                                            .isNotEmpty
                                                    ? myTeamResponse[index]
                                                            ['project_name'][0]
                                                        .toString()
                                                    : '')
                                                : (myTeamInactiveResponse[index]['project_name'] != null &&
                                                        (myTeamInactiveResponse[index]['project_name'] as List).isNotEmpty
                                                    ? myTeamInactiveResponse[index]['project_name'][0].toString()
                                                    : '')),
                                        personName: capitalizeFirstLetter(
                                            searchController.text.length > 2
                                                ? searchResponse[index]
                                                        ['user_name']
                                                    .toString()
                                                : (viewModel.switchVal
                                                    ? myTeamResponse[index]
                                                            ['user_name']
                                                        .toString()
                                                    : myTeamInactiveResponse[
                                                            index]['user_name']
                                                        .toString())),
                                        onCallIconTap: () => viewModel.showCallDialog(
                                            searchController.text.length > 2
                                                ? searchResponse[index]
                                                        ['user_name']
                                                    .toString()
                                                : (viewModel.switchVal
                                                    ? myTeamResponse[index]
                                                            ['user_name']
                                                        .toString()
                                                    : myTeamInactiveResponse[
                                                            index]['user_name']
                                                        .toString()),
                                            (searchController.text.length > 2
                                                    ? searchResponse[index]
                                                        ['mobile_number']
                                                    : (viewModel.switchVal
                                                        ? (myTeamResponse[index]
                                                            ['mobile_number'])
                                                        : (myTeamInactiveResponse[
                                                                index]
                                                            ['mobile_number'])))
                                                .toString()),
                                        onTap: () => viewModel
                                            .showAssignedProjectbottomSheet(
                                                index,
                                                searchController.text.length > 2
                                                    ? searchResponse[index]
                                                        ['user_id']
                                                    : (viewModel.switchVal
                                                        ? myTeamResponse[index]
                                                            ['user_id']
                                                        : myTeamInactiveResponse[
                                                            index]['user_id']),
                                                searchController.text.length > 2
                                                    ? searchResponse[index]
                                                        ['isSubodinateUser']
                                                    : (viewModel.switchVal
                                                        ? myTeamResponse[index]
                                                            ['isSubodinateUser']
                                                        : myTeamInactiveResponse[
                                                                index][
                                                            'isSubodinateUser']),
                                                context: context),
                                        onTapBuilding: () =>
                                            viewModel.showbottomSheet(
                                                searchController.text.length > 2
                                                    ? searchResponse[index]
                                                        ['user_id']
                                                    : (viewModel.switchVal
                                                        ? myTeamResponse[index]
                                                            ['user_id']
                                                        : myTeamInactiveResponse[
                                                            index]['user_id']),
                                                context: context),
                                        onTapRemove: () {
                                          viewModel.changeUserStatus(
                                              userId: searchController
                                                          .text.length >
                                                      2
                                                  ? searchResponse[index]
                                                      ['user_id']
                                                  : (viewModel.switchVal
                                                      ? myTeamResponse[index]
                                                          ['user_id']
                                                      : myTeamInactiveResponse[
                                                          index]['user_id']),
                                              status: !viewModel.switchVal,
                                              context: context);
                                        },
                                      ));
                                } else if (viewModel.switchVal
                                    ? (myTeamResponse.length >=
                                        (res == null
                                            ? 0
                                            : (res['totalCount'] ?? 0)))
                                    : (myTeamInactiveResponse.length >=
                                        (inactiveRes == null
                                            ? 0
                                            : (inactiveRes['totalCount'] ??
                                                0)))) {
                                  return const SizedBox();
                                } else {
                                  return const Center(
                                    child: CircularProgressIndicator(
                                      color: primaryColor,
                                    ),
                                  );
                                }
                              }),
                        )
                      ],
                    ],
                  ),
                ))),
        if (viewModel.isBusy) const Loader()
      ],
    );
  }

  @override
  AllusersViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      AllusersViewModel()..initAllUser(context: context, isInit: true);

  //Render Tab Bar
  Widget _renderTabBar(AllusersViewModel viewModel, context) {
    return Row(
      children: [
        if (viewModel.isShowDSTTab) ...[
          Expanded(
            child: InkWell(
              onTap: () {
                viewModel.updatecurrenttabIndex('DST', context: context);
              },
              child: Container(
                alignment: Alignment.center,
                child: Container(
                  padding: const EdgeInsets.only(bottom: 5),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              width: 2,
                              color: currentTabIndex == 'DST'
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
        if (viewModel.isShowCPTab)
          Expanded(
            child: InkWell(
              onTap: () {
                viewModel.updatecurrenttabIndex('CP', context: context);
              },
              child: Container(
                alignment: Alignment.center,
                child: Container(
                  padding: const EdgeInsets.only(bottom: 5),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              width: 2,
                              color: currentTabIndex == 'CP'
                                  ? primaryColor
                                  : transparent))),
                  child: Text('Channel Partner',
                      style: AppTextStyle()
                          .toastMessageTextStyle(fontColor: FontColor().black)),
                ),
              ),
            ),
          ),
        if (viewModel.isShowMyTeamTab)
          Expanded(
            child: InkWell(
              onTap: () {
                viewModel.updatecurrenttabIndex('MyTeam', context: context);
              },
              child: Container(
                alignment: Alignment.center,
                child: Container(
                  padding: const EdgeInsets.only(bottom: 5),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              width: 2,
                              color: currentTabIndex == 'MyTeam'
                                  ? primaryColor
                                  : transparent))),
                  child: Text('My Team',
                      style: AppTextStyle()
                          .toastMessageTextStyle(fontColor: FontColor().black)),
                ),
              ),
            ),
          ),
        // if (!viewModel.sharedService.isDstUser!) ...[const Spacer()]
      ],
    );
  }

//search Bar
  _renderSearchbar(AllusersViewModel viewModel, BuildContext context) {
    return SizedBox(
      height: 45,
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: SearchInput(
              controller: searchController,
              focusNode: searchFocusNode,
              onChanged: (p0) {
                viewModel.initSearch(
                    userId: currentTabIndex == 'DST'
                        ? 1
                        : currentTabIndex == 'CP'
                            ? 2
                            : null,
                    isActive: viewModel.switchVal ? 1 : 0,
                    search: searchController.text);
              },
              onCancel: () {
                searchController.clear();
                searchFocusNode.unfocus();
                searchRes = null;
                searchResponse.clear();
                viewModel.notifyListeners();
              },
            ),
          ),
        ],
      ),
    );
  }

//All user records
  _renderRecords(AllusersViewModel viewModel) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RichText(
              text: TextSpan(
                  text: 'Showing ',
                  style: AppTextStyle().tncTextStyle(),
                  children: [
                TextSpan(
                  text: searchRes != null
                      ? (viewModel.sharedService.isCp! &&
                                  currentTabIndex == 'CP'
                              ? searchRes['total_count']
                              : searchRes['totalCount'])
                          .toString()
                      : (currentTabIndex == 'DST'
                          ? (viewModel.switchVal
                                  ? (dstRes == null ? 0 : dstRes['totalCount'])
                                  : (dstInactiveRes == null
                                      ? 0
                                      : dstInactiveRes['totalCount']))
                              .toString()
                          : currentTabIndex == 'CP'
                              ? (viewModel.switchVal
                                      ? (viewModel.sharedService.isCp! &&
                                              currentTabIndex == 'CP'
                                          ? (cpRes == null
                                              ? 0
                                              : cpRes['total_count'])
                                          : (cpRes == null
                                              ? 0
                                              : cpRes['totalCount']))
                                      : (viewModel.sharedService).isCp!
                                          ? (cpInactiveRes == null
                                              ? 0
                                              : cpInactiveRes['total_count'])
                                          : (cpInactiveRes == null
                                              ? 0
                                              : cpInactiveRes['totalCount']))
                                  .toString()
                              : (viewModel.switchVal
                                      ? (res == null ? 0 : res['totalCount'])
                                      : (inactiveRes == null
                                          ? 0
                                          : inactiveRes['totalCount']))
                                  .toString()),
                  style: AppTextStyle()
                      .textButtonTextStyle(textColor: FontColor().black),
                ),
                TextSpan(
                  text: ' records',
                  style: AppTextStyle().tncTextStyle(),
                ),
              ])),
          FlutterSwitch(
            value: viewModel.switchVal,
            height: 20,
            width: 40,
            toggleSize: 18,
            padding: 2.5,
            inactiveColor: customGrey,
            activeColor: secondaryColor,
            onToggle: (value) => viewModel.toggleSwitch(),
          )
        ],
      ),
    );
  }
}
