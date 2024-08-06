import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:sales_lead/ui/common/widgets/index.dart';

import '/ui/views/all_project/all_project_viewmodel.dart';
import '/ui/views/all_project/all_project_view.form.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '/ui/common/index.dart';

class RemoveUserFromProjectSheet extends StackedView<AllProjectViewModel>
    with $AllProjectView {
  final Function(SheetResponse response)? completer;
  final SheetRequest request;
  const RemoveUserFromProjectSheet({
    Key? key,
    required this.completer,
    required this.request,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    AllProjectViewModel viewModel,
    Widget? child,
  ) {
    return Container(
      height: screenHeight(context) * 0.7,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      margin: const EdgeInsets.only(top: 40),
      constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height -
              (MediaQuery.of(context).size.height / 100) * 10),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15)),
          color: backgroundcolor),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          verticalSpaceExtraSmall,
          BottomSheetHeader(
              headerText: currentTabIndex == 1
                  ? 'Assigned Users'
                  : 'Assigned Channel Partners',
              showDrag: true,
              ontap: () {
                completer!.call(SheetResponse(confirmed: true));
              },
              closeIconPadding: 20),
          verticalSpaceExtraSmall,
          Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              margin: const EdgeInsets.symmetric(vertical: 5),
              decoration: BoxDecoration(
                color: whiteColor,
                border: Border.all(color: borderColor),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    Images().buildingIcon,
                    height: 30,
                    width: 25,
                  ),
                  horizontalSpaceTiny,
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          capitalizeFirstLetter((searchController.text.length >
                                      2
                                  ? searchProjectsResponse[currentProjectIndex]
                                      ['project_name']
                                  : (currentTabIndex == 1
                                      ? dstProjectsResponse[currentProjectIndex]
                                          ['project_name']
                                      : currentTabIndex == 2
                                          ? cpProjectsResponse[
                                                  currentProjectIndex]
                                              ['project_name']
                                          : myProjectsResponse[
                                                  currentProjectIndex]
                                              ['project_name']))
                              .toString()),
                          style: AppTextStyle().personName,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SvgPicture.asset(
                              Images().locationIcon,
                            ),
                            horizontalSpaceTiny,
                            Text(
                              capitalizeFirstLetter(
                                  (searchController.text.length > 2
                                          ? searchProjectsResponse[
                                              currentProjectIndex]['city']
                                          : (currentTabIndex == 1
                                              ? dstProjectsResponse[
                                                  currentProjectIndex]['city']
                                              : currentTabIndex == 2
                                                  ? cpProjectsResponse[
                                                          currentProjectIndex]
                                                      ['city']
                                                  : myProjectsResponse[
                                                          currentProjectIndex]
                                                      ['city']))
                                      .toString()),
                              style: AppTextStyle().subTitle,
                            ),
                          ],
                        ),
                        if ((searchController.text.length > 2
                                ? searchProjectsResponse[currentProjectIndex]
                                        ['lastsaledate'] ??
                                    ''
                                : (currentTabIndex == 1
                                    ? dstProjectsResponse[currentProjectIndex]
                                            ['lastsaledate'] ??
                                        ''
                                    : currentTabIndex == 2
                                        ? cpProjectsResponse[
                                                    currentProjectIndex]
                                                ['lastsaledate'] ??
                                            ''
                                        : myProjectsResponse[
                                                    currentProjectIndex]
                                                ['lastsaledate'] ??
                                            '')) !=
                            '') ...[
                          Row(
                            children: [
                              Text(
                                'Last Sale ',
                                style: AppTextStyle().ninePixel(
                                    fontColor: FontColor().black,
                                    fontFamily: 'nexa-regular'),
                              ),
                              Text(
                                DateFormat('dd-MMM-yyyy').format(DateTime.parse(
                                    (searchController.text.length > 2
                                        ? searchProjectsResponse[
                                            currentProjectIndex]['lastsaledate']
                                        : (currentTabIndex == 1
                                            ? dstProjectsResponse[
                                                    currentProjectIndex]
                                                ['lastsaledate']
                                            : currentTabIndex == 2
                                                ? cpProjectsResponse[
                                                        currentProjectIndex]
                                                    ['lastsaledate']
                                                : myProjectsResponse[
                                                        currentProjectIndex]
                                                    ['lastsaledate'])))),
                                style: AppTextStyle().ninePixel(
                                    fontColor: FontColor().grey,
                                    fontFamily: 'nexa-regular'),
                              ),
                            ],
                          )
                        ],
                      ]),
                  const Spacer(),
                  Column(
                    children: [
                      CircleAvatar(
                          radius: 22,
                          backgroundColor: lightBgColor,
                          child: Center(
                              child: Text(
                            (searchController.text.length > 2
                                    ? searchProjectsResponse[
                                        currentProjectIndex]['leadscount']
                                    : (currentTabIndex == 1
                                        ? dstProjectsResponse[
                                            currentProjectIndex]['leadscount']
                                        : currentTabIndex == 2
                                            ? cpProjectsResponse[
                                                    currentProjectIndex]
                                                ['leadscount']
                                            : myProjectsResponse[
                                                    currentProjectIndex]
                                                ['leadscount']))
                                .toString(),
                            style: AppTextStyle().circleText(fontSize: 17),
                          ))),
                      Text(
                        'Leads',
                        style: AppTextStyle().textTitleStyle,
                      ),
                    ],
                  ),
                ],
              )),
          verticalSpaceTiny,
          Text(
            'Swipe a ${currentTabIndex == 1 ? 'Users' : 'Channel Partner'} towards left to remove',
            style: AppTextStyle().loadingDescriptionTextStyle,
          ),
          verticalSpaceExtraSmall,
          if (viewModel.isBusy) ...[
            const Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: CircularProgressIndicator(
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
            )
          ] else ...[
            Expanded(
              child: ListView.builder(
                  itemCount: currentTabIndex == 1||currentTabIndex == 3
                      ? (viewModel.projectResponse[
                                  'userListToAssignedProjects'] ==
                              null
                          ? 0
                          : viewModel
                              .projectResponse['userListToAssignedProjects']
                              .length)
                      : currentTabIndex == 2 && viewModel.sharedService.isCp!
                          ? (viewModel.projectResponse[
                                      'userListToAssignedProjects'] ==
                                  null
                              ? 0
                              : viewModel
                                  .projectResponse['userListToAssignedProjects']
                                  .length)
                          : (viewModel.cpProjectResponse[
                                      'assignedCPListToProjects'] ==
                                  null
                              ? 0
                              : viewModel
                                  .cpProjectResponse['assignedCPListToProjects']
                                  .length),
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(
                      decelerationRate: ScrollDecelerationRate.normal),
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        color: secondaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      margin: const EdgeInsets.only(
                        bottom: 10,
                      ),
                      child: SlidableTile(
                        valueKey: index,
                        motion: const BehindMotion(),
                        action: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                viewModel.onRemove(
                                    context: context,
                                    index: index,
                                    currentUserId: currentTabIndex == 1||currentTabIndex == 3
                                        ? viewModel.projectResponse[
                                                'userListToAssignedProjects']
                                            [index]['user_id']
                                        : currentTabIndex == 2 &&
                                                viewModel.sharedService.isCp!
                                            ? viewModel.projectResponse[
                                                    'userListToAssignedProjects']
                                                [index]['user_id']
                                            : viewModel.cpProjectResponse[
                                                    'assignedCPListToProjects']
                                                [index]['channel_partner_id'],
                                    projectId: int.parse(request.title!));
                              },
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: secondaryColor,
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(10),
                                      bottomRight: Radius.circular(10)),
                                ),
                                alignment: Alignment.center,
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        Images().removeIcon,
                                        height: 20,
                                        width: 20,
                                      ),
                                      verticalSpaceTiny,
                                      Text(
                                        'Remove',
                                        style: AppTextStyle().ninePixel(
                                            fontColor: FontColor().white),
                                      )
                                    ]),
                              ),
                            ),
                          ),
                        ],
                        child: Container(
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.only(
                                top: 10, bottom: 5, left: 15, right: 15),
                            decoration: BoxDecoration(
                              color: whiteColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                currentTabIndex == 1||currentTabIndex == 3
                                    ? Stack(
                                        alignment: Alignment.topRight,
                                        children: [
                                          ClipOval(
                                            child: CircleAvatar(
                                              radius: 20,
                                              backgroundColor: greyShade100,
                                              child: Image.network(
                                                (currentTabIndex == 1||currentTabIndex == 3
                                                        ? (viewModel.projectResponse['userListToAssignedProjects'][index]['profile_picture_url'] !=
                                                                null &&
                                                            viewModel.projectResponse['userListToAssignedProjects'][index]['profile_picture_url'] !=
                                                                '')
                                                        : (viewModel.cpProjectResponse['assignedCPListToProjects'][index]['profile_picture_url'] !=
                                                                null &&
                                                            viewModel.cpProjectResponse['assignedCPListToProjects'][index]['profile_picture_url'] !=
                                                                ''))
                                                    ? (currentTabIndex == 1||currentTabIndex == 3
                                                        ? viewModel.projectResponse['userListToAssignedProjects'][index]['profile_picture_url']
                                                            .toString()
                                                        : currentTabIndex == 2 &&
                                                                viewModel
                                                                    .sharedService
                                                                    .isCp!
                                                            ? viewModel.projectResponse['userListToAssignedProjects'][index]['profile_picture_url']
                                                                .toString()
                                                            : viewModel.cpProjectResponse['assignedCPListToProjects']
                                                                    [index]
                                                                    ['profile_picture_url']
                                                                .toString())
                                                    : 'https://cdn-icons-png.flaticon.com/512/847/847969.png',
                                                height: 45,
                                                width: 45,
                                                fit: BoxFit.cover,
                                                errorBuilder: (context, error,
                                                        stackTrace) =>
                                                    Image.network(
                                                        'https://cdn-icons-png.flaticon.com/512/847/847969.png'),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                              top: 2,
                                              left: 28,
                                              child: CircleAvatar(
                                                backgroundColor: defaultgreen,
                                                radius: 6,
                                                child: SvgPicture.asset(
                                                  Images().checkicon,
                                                ),
                                              ))
                                        ],
                                      )
                                    : (viewModel.sharedService.isCp! &&
                                            currentTabIndex == 2)
                                        ? Stack(
                                            alignment: Alignment.topRight,
                                            children: [
                                              ClipOval(
                                                child: CircleAvatar(
                                                  radius: 20,
                                                  backgroundColor: greyShade100,
                                                  child: Image.network(
                                                    (viewModel.projectResponse['userListToAssignedProjects']
                                                                        [index][
                                                                    'profile_picture_url'] !=
                                                                null &&
                                                            viewModel.projectResponse[
                                                                            'userListToAssignedProjects']
                                                                        [index][
                                                                    'profile_picture_url'] !=
                                                                '')
                                                        ? (viewModel
                                                            .projectResponse[
                                                                'userListToAssignedProjects']
                                                                [index][
                                                                'profile_picture_url']
                                                            .toString())
                                                        : 'https://cdn-icons-png.flaticon.com/512/847/847969.png',
                                                    height: 45,
                                                    width: 45,
                                                    fit: BoxFit.cover,
                                                    errorBuilder: (context,
                                                            error,
                                                            stackTrace) =>
                                                        Image.network(
                                                            'https://cdn-icons-png.flaticon.com/512/847/847969.png'),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                  top: 2,
                                                  left: 28,
                                                  child: CircleAvatar(
                                                    backgroundColor:
                                                        defaultgreen,
                                                    radius: 6,
                                                    child: SvgPicture.asset(
                                                      Images().checkicon,
                                                    ),
                                                  ))
                                            ],
                                          )
                                        : SvgPicture.asset(
                                            Images().handshakeLarge),
                                horizontalSpaceTiny,
                                Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: screenWidth(context) / 2,
                                        child: Row(
                                          children: [
                                            Flexible(
                                              child: Text(
                                                capitalizeFirstLetter(currentTabIndex ==
                                                        1||currentTabIndex == 3
                                                    ? viewModel
                                                        .projectResponse['userListToAssignedProjects']
                                                            [index]['name']
                                                        .toString()
                                                    : currentTabIndex == 2 &&
                                                            viewModel
                                                                .sharedService
                                                                .isCp!
                                                        ? viewModel
                                                            .projectResponse['userListToAssignedProjects']
                                                                [index]['name']
                                                            .toString()
                                                        : viewModel
                                                            .cpProjectResponse[
                                                                'assignedCPListToProjects']
                                                                [index]
                                                                ['channel_partner_name']
                                                            .toString()),
                                                softWrap: true,
                                                style:
                                                    AppTextStyle().personName,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SvgPicture.asset(
                                            Images().buildingIcon,
                                            height: 15,
                                            width: 15,
                                          ),
                                          horizontalSpaceTiny,
                                          Text(
                                            capitalizeFirstLetter((currentTabIndex ==
                                                        1||currentTabIndex == 3
                                                    ? (viewModel.projectResponse['userListToAssignedProjects'][index]['projectList'] == null ||
                                                        viewModel.projectResponse['userListToAssignedProjects'][index]['projectList'] ==
                                                            [])
                                                    : currentTabIndex == 2 &&
                                                            viewModel
                                                                .sharedService
                                                                .isCp!
                                                        ? (viewModel.projectResponse['userListToAssignedProjects'][index]['projectList'] == null ||
                                                            viewModel.projectResponse['userListToAssignedProjects'][index]['projectList'] ==
                                                                [])
                                                        : (viewModel.cpProjectResponse['assignedCPListToProjects'][index]['projectList'] == null ||
                                                            viewModel.cpProjectResponse['assignedCPListToProjects'][index]['projectList'] ==
                                                                []))
                                                ? ''
                                                : (currentTabIndex == 1||currentTabIndex == 3
                                                    ? viewModel.projectResponse['userListToAssignedProjects']
                                                            [index]['projectList']
                                                        [0]['project_name']
                                                    : currentTabIndex == 2 &&
                                                            viewModel.sharedService.isCp!
                                                        ? viewModel.projectResponse['userListToAssignedProjects'][index]['projectList'][0]['project_name'].toString()
                                                        : viewModel.cpProjectResponse['assignedCPListToProjects'][index]['projectList'][0]['project_name'])),
                                            style: AppTextStyle().subTitle,
                                          ),
                                          horizontalSpaceTiny,
                                          Container(
                                            height: 15,
                                            width: 20,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(3),
                                                color: lightOrange1),
                                            child: Center(
                                              child: Text(
                                                  (currentTabIndex == 1||currentTabIndex == 3
                                                          ? (viewModel.projectResponse['userListToAssignedProjects'][index]['projectList'] ==
                                                                  null ||
                                                              viewModel.projectResponse['userListToAssignedProjects']
                                                                          [index][
                                                                      'projectList'] ==
                                                                  [])
                                                          : currentTabIndex == 2 &&
                                                                  viewModel
                                                                      .sharedService
                                                                      .isCp!
                                                              ? (viewModel.projectResponse['userListToAssignedProjects'][index]['projectList'] ==
                                                                      null ||
                                                                  viewModel.projectResponse['userListToAssignedProjects'][index]['projectList'] ==
                                                                      [])
                                                              : (viewModel.cpProjectResponse['assignedCPListToProjects'][index]
                                                                          ['projectList'] ==
                                                                      null ||
                                                                  viewModel.cpProjectResponse['assignedCPListToProjects'][index]['projectList'] == []))
                                                      ? ''
                                                      : '+${(currentTabIndex == 1||currentTabIndex == 3 ? viewModel.projectResponse['userListToAssignedProjects'][index]['projectList'].length : currentTabIndex == 2 && viewModel.sharedService.isCp! ? viewModel.projectResponse['userListToAssignedProjects'][index]['projectList'].length : viewModel.cpProjectResponse['assignedCPListToProjects'][index]['projectList'].length) - 1}',
                                                  style: AppTextStyle().titletext1),
                                            ),
                                          )
                                        ],
                                      )
                                    ]),
                                const Spacer(),
                                Column(
                                  children: [
                                    CircleAvatar(
                                        radius: 18,
                                        backgroundColor: lightBgColor,
                                        child: Center(
                                            child: Text(
                                          capitalizeFirstLetter(currentTabIndex ==
                                                  1||currentTabIndex == 3
                                              ? viewModel.projectResponse[
                                                      'userListToAssignedProjects']
                                                      [index]['leadscount']
                                                  .toString()
                                              : currentTabIndex == 2 &&
                                                      viewModel
                                                          .sharedService.isCp!
                                                  ? viewModel
                                                      .projectResponse['userListToAssignedProjects']
                                                          [index]['leadscount']
                                                      .toString()
                                                  : viewModel.cpProjectResponse[
                                                          'assignedCPListToProjects']
                                                          [index]
                                                          ['leadcountbyproject']
                                                      .toString()),
                                          style: AppTextStyle()
                                              .circleText(fontSize: 17),
                                        ))),
                                    Text(
                                      'Leads',
                                      style: AppTextStyle().textTitleStyle,
                                    ),
                                  ],
                                ),
                              ],
                            )),
                      ),
                    );
                  }),
            )
          ],
          verticalSpaceSmall,
        ],
      ),
    );
  }

  @override
  AllProjectViewModel viewModelBuilder(BuildContext context) =>
      AllProjectViewModel()..initRemoveProjectFromUser(request.title!);
}
