import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../views/all_project/all_project_view.form.dart';
import '../../views/all_project/all_project_viewmodel.dart';
import '/ui/common/widgets/index.dart';
import '../../common/index.dart';

class AddUserToProjectSheet extends StackedView<AllProjectViewModel>
    with $AllProjectView {
  final Function(SheetResponse response)? completer;
  final SheetRequest request;
  const AddUserToProjectSheet({
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
              showDrag: true,
              closeIconPadding: 20,
              ontap: () {
                completer!.call(SheetResponse(confirmed: true));
              },
              headerText:
                  'Assign ${selectedIndex == 0 ? 'Users' : 'Channel Partner'} To Project'),
          verticalSpaceSmall,
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
                          radius: 18,
                          backgroundColor: lightBgColor,
                          child: Center(
                              child: Text(
                            capitalizeFirstLetter((searchController
                                            .text.length >
                                        2
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
                                .toString()),
                            style: AppTextStyle().circleText(fontSize: 17),
                          ))),
                      verticalSpaceTiny,
                      Text(
                        'Leads',
                        style: AppTextStyle().textTitleStyle,
                      ),
                    ],
                  ),
                ],
              )),
          verticalSpaceTiny,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              'Swipe a ${selectedIndex == 0 ? 'Users' : 'Channel Partner'} towards left to Assign',
              textAlign: TextAlign.center,
              style: AppTextStyle().loadingDescriptionTextStyle,
            ),
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
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  itemCount: selectedIndex == 0
                      ? (viewModel.projectResponse[
                                  'userListToAssignProjects'] ==
                              null
                          ? 0
                          : viewModel
                              .projectResponse['userListToAssignProjects']
                              .length)
                      : (viewModel.cpProjectResponse[
                                  'cPListToAssignProjects'] ==
                              null
                          ? 0
                          : viewModel
                              .cpProjectResponse['cPListToAssignProjects']
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
                      margin: const EdgeInsets.only(bottom: 13),
                      child: SlidableTile(
                        valueKey: index,
                        motion: const BehindMotion(),
                        action: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                viewModel.onAssign(
                                  context: context,
                                  index: index,
                                  projectId: int.parse(request.title!),
                                  userId: selectedIndex == 0
                                      ? viewModel.projectResponse[
                                              'userListToAssignProjects'][index]
                                          ['user_id']
                                      : viewModel.cpProjectResponse[
                                              'cPListToAssignProjects'][index]
                                          ['channel_partner_id'],
                                );
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.arrow_back,
                                        size: 20,
                                        color: whiteColor,
                                      ),
                                      Text(
                                        'Swipe left\nto assign',
                                        style: AppTextStyle().ninePixel(
                                            fontColor: FontColor().white),
                                        textAlign: TextAlign.center,
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
                                selectedIndex == 0
                                    ? Stack(
                                        alignment: Alignment.topRight,
                                        children: [
                                          ClipOval(
                                            child: CircleAvatar(
                                                radius: 20,
                                                backgroundColor: greyShade100,
                                                child: Image.network(
                                                  viewModel.projectResponse[
                                                                          'userListToAssignProjects']
                                                                      [index][
                                                                  'profile_picture_url'] !=
                                                              null &&
                                                          viewModel.projectResponse[
                                                                          'userListToAssignProjects']
                                                                      [index][
                                                                  'profile_picture_url'] !=
                                                              ''
                                                      ? viewModel.projectResponse[
                                                                  'userListToAssignProjects']
                                                              [index]
                                                          ['profile_picture_url']
                                                      : 'https://cdn-icons-png.flaticon.com/512/847/847969.png',
                                                  height: 45,
                                                  width: 45,
                                                  fit: BoxFit.cover,
                                                  errorBuilder: (context, error,
                                                          stackTrace) =>
                                                      Image.network(
                                                          'https://cdn-icons-png.flaticon.com/512/847/847969.png'),
                                                )),
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
                                    : SvgPicture.asset(Images().handshakeLarge),
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
                                                capitalizeFirstLetter(selectedIndex == 0
                                                    ? viewModel.projectResponse[
                                                            'userListToAssignProjects']
                                                        [index]['name']
                                                    : viewModel.cpProjectResponse[
                                                                'cPListToAssignProjects']
                                                            [index][
                                                        'channel_partner_name']),
                                                softWrap: true,
                                                style:
                                                    AppTextStyle().personName,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      if (selectedIndex == 0) ...[
                                        if (viewModel.projectResponse[
                                                        'userListToAssignProjects']
                                                    [index]['projectList'] !=
                                                null &&
                                            viewModel
                                                .projectResponse[
                                                    'userListToAssignProjects']
                                                    [index]['projectList']
                                                .isNotEmpty) ...[
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              SvgPicture.asset(
                                                Images().buildingIcon,
                                                height: 12,
                                                width: 15,
                                              ),
                                              horizontalSpaceTiny,
                                              Container(
                                                constraints: BoxConstraints(
                                                    maxWidth:
                                                        screenWidth(context) *
                                                            0.3),
                                                child: Text(
                                                  capitalizeFirstLetter(viewModel
                                                      .projectResponse[
                                                          'userListToAssignProjects']
                                                          [index]['projectList']
                                                      .first['project_name']),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style:
                                                      AppTextStyle().subTitle,
                                                ),
                                              ),
                                              horizontalSpaceTiny,
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(2),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            3),
                                                    color: lightOrange1),
                                                child: Center(
                                                  child: Text(
                                                      '+${viewModel.projectResponse['userListToAssignProjects'][index]['projectList'].length - 1}',
                                                      style: AppTextStyle()
                                                          .titletext1),
                                                ),
                                              )
                                            ],
                                          )
                                        ]
                                      ] else ...[
                                        if (viewModel.cpProjectResponse[
                                                        'cPListToAssignProjects']
                                                    [index]['projectList'] !=
                                                null &&
                                            viewModel
                                                .cpProjectResponse[
                                                    'cPListToAssignProjects']
                                                    [index]['projectList']
                                                .isNotEmpty) ...[
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              SvgPicture.asset(
                                                Images().buildingIcon,
                                                height: 12,
                                                width: 15,
                                              ),
                                              horizontalSpaceTiny,
                                              Container(
                                                constraints: BoxConstraints(
                                                    maxWidth:
                                                        screenWidth(context) *
                                                            0.3),
                                                child: Text(
                                                  capitalizeFirstLetter(viewModel
                                                      .cpProjectResponse[
                                                          'cPListToAssignProjects']
                                                          [index]['projectList']
                                                      .first['project_name']),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style:
                                                      AppTextStyle().subTitle,
                                                ),
                                              ),
                                              horizontalSpaceTiny,
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(2),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            3),
                                                    color: lightOrange1),
                                                child: Center(
                                                  child: Text(
                                                      '+${viewModel.cpProjectResponse['cPListToAssignProjects'][index]['projectList'].length - 1}',
                                                      style: AppTextStyle()
                                                          .titletext1),
                                                ),
                                              )
                                            ],
                                          )
                                        ]
                                      ]
                                    ]),
                                const Spacer(),
                                Column(
                                  children: [
                                    CircleAvatar(
                                        radius: 18,
                                        backgroundColor: lightBgColor,
                                        child: Center(
                                            child: Text(
                                          selectedIndex == 0
                                              ? viewModel.projectResponse[
                                                      'userListToAssignProjects']
                                                      [index]['leadscount']
                                                  .toString()
                                              : viewModel.cpProjectResponse[
                                                      'cPListToAssignProjects']
                                                      [index]['usercount']
                                                  .toString(),
                                          style: AppTextStyle()
                                              .circleText(fontSize: 17),
                                        ))),
                                    Text(
                                      selectedIndex == 0 ? 'Leads' : 'Users',
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
        ],
      ),
    );
  }

  @override
  AllProjectViewModel viewModelBuilder(BuildContext context) =>
      AllProjectViewModel()..initAddProjectToUser(request.title!);
}
