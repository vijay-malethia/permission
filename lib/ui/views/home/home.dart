import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';
import '/app/app.router.dart';
import '/ui/views/home/card.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/services.dart';

import '/ui/common/index.dart';
import '/ui/views/home/graph.dart';
import '/ui/views/home/home_viewmodel.dart';
import 'pie_chart.dart';
import 'project_pie_chart.dart';

class Home extends StackedView<HomeViewModel> {
  const Home({super.key});

  @override
  Widget builder(
    BuildContext context,
    HomeViewModel viewModel,
    Widget? child,
  ) {
    var topPadding = MediaQuery.of(context).viewPadding.top;
    var sizer = screenDimension(context);
    var spacer = SizedBox(height: sizer / 81);
    bool modelbusy = viewModel.isBusy;
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(Images().homeBg), fit: BoxFit.fill)),
        child: Column(children: [
          SizedBox(height: topPadding),
          Container(
              color:
                  modelbusy ? blackColor.withOpacity(0.4) : Colors.transparent,
              child: renderCustomAppBar(viewModel)),
          Expanded(
              child: modelbusy
                  ? const Loader()
                  : Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                          color: transparent,
                          borderRadius: BorderRadius.circular(10)),
                      margin: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                      child: ListView(
                        padding: const EdgeInsets.all(0),
                        children: [
                          //Render Line Graph
                          if (dashBoardData['data']
                              ['line_graph_for_past_days_leads']['is_visible'])
                            Graph(viewModel: viewModel),
                          spacer,
                          if (viewModel.sharedService.userId == 1 &&
                              dashBoardData['data']['channel_partner']
                                  ['is_visible']) ...[
                            MyCard(
                                buttonTitle: viewAll,
                                leadsName: 'Channel Partner',
                                child: Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      renderCircleWithIcon(
                                          circleBgColor: lightBgColor,
                                          icon: Images().filesearchIcon,
                                          textColor: dstCount),
                                      RichText(
                                          textAlign: TextAlign.center,
                                          text: TextSpan(
                                              text: dashBoardData['data'][
                                                              'channel_partner']
                                                          ['cp_status_Count'][0]
                                                      ['count']
                                                  .toString(),
                                              style: AppTextStyle().numberTitle(
                                                  textColor: redBrown),
                                              children: [
                                                const WidgetSpan(
                                                    child: verticalSpaceMedium),
                                                TextSpan(
                                                  text: "\nPending",
                                                  style: AppTextStyle()
                                                      .toastMessageTextStyle(
                                                          fontColor: FontColor()
                                                              .grey2),
                                                )
                                              ])),
                                      renderCircleWithIcon(
                                          circleBgColor: dstCircle,
                                          icon: Images().userverifiedIcon,
                                          textColor: dstCount),
                                      RichText(
                                          textAlign: TextAlign.center,
                                          text: TextSpan(
                                              text: dashBoardData['data'][
                                                              'channel_partner']
                                                          ['cp_status_Count'][1]
                                                      ['count']
                                                  .toString(),
                                              style: AppTextStyle().numberTitle(
                                                  textColor: FontColor().green),
                                              children: [
                                                const WidgetSpan(
                                                    child: verticalSpaceMedium),
                                                TextSpan(
                                                  text: "\nApproved",
                                                  style: AppTextStyle()
                                                      .toastMessageTextStyle(
                                                          fontColor: FontColor()
                                                              .grey2),
                                                )
                                              ])),
                                    ],
                                  ),
                                ))
                          ],
                          if (viewModel.sharedService.userId == 2) ...[
                            Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: whiteColor,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Row(
                                    children: [
                                      horizontalSpaceSmall,
                                      Container(
                                          width: 55,
                                          height: 55,
                                          decoration: const BoxDecoration(
                                              color: lightBgColor,
                                              shape: BoxShape.circle),
                                          child: Center(
                                              child: SvgPicture.asset(
                                            Images().handShakeIcon,
                                            height: 30,
                                            width: 30,
                                            color: orange,
                                          ))),
                                      horizontalSpaceSmall,
                                      Text(
                                          dashBoardData['data']['cp_details']
                                              ['cp_name'],
                                          style: AppTextStyle()
                                              .toastMessageTextStyle(
                                                  fontColor: FontColor().red)),
                                    ],
                                  ),
                                ))
                          ],
                          verticalSpaceSmall,
                          //Render Pie Chart
                          if (dashBoardData['data']['leads_by_project_piechart']
                              ['is_visible']) ...[
                            MyCard(
                                buttonTitle: viewAll,
                                leadsName: leadsByProject,
                                onTap: viewModel.navigateToProjectView,
                                child: FlipCard(
                                    direction: FlipDirection.HORIZONTAL,
                                    flipOnTouch: true,
                                    speed: 1000,
                                    front: ProjectPieChartPage(project: pidata),
                                    back: LeadBackSide(leadItem: leadList))),
                            spacer
                          ],
                          // if (dashBoardData['data']['leads']['is_visible']) ...[
                          //   MyCard(
                          //       buttonTitle: viewAll,
                          //       leadsName: leadsByStages,
                          //       child: FlipCard(
                          //           direction: FlipDirection.HORIZONTAL,
                          //           flipOnTouch: true,
                          //           speed: 1000,
                          //           front: const PieChartPage(),
                          //           back: LeadBackSide(leadItem: leadList))),
                          //   spacer
                          // ],
                          //Users card
                          MyCard(
                              buttonTitle: viewAll,
                              onTap: viewModel.navigateToUserView,
                              leadsName: users.toUpperCase(),
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: Row(
                                  children: [
                                    if (dashBoardData['data']['users']
                                        ['is_dst_visible'])
                                      Row(
                                        children: [
                                          renderCircleWithText(
                                              circleBgColor: dstCircle,
                                              text: dashBoardData['data']
                                                              ['users']
                                                          ['user_count_by_type']
                                                      [0]['user_count']
                                                  .toString(),
                                              textColor: dstCount),
                                          const SizedBox(width: 10),
                                          RichText(
                                              textAlign: TextAlign.center,
                                              text: TextSpan(
                                                  text: dashBoardData['data']
                                                                  ['users'][
                                                              'user_count_by_type']
                                                          [0]['user_type']
                                                      .toString(),
                                                  style: AppTextStyle()
                                                      .toastMessageTextStyle(
                                                          fontColor: FontColor()
                                                              .grey2),
                                                  children: [
                                                    TextSpan(
                                                        text: "\n$users",
                                                        style: AppTextStyle()
                                                            .ninePixel(
                                                                fontColor:
                                                                    FontColor()
                                                                        .grey2))
                                                  ])),
                                        ],
                                      ),
                                    if (dashBoardData['data']['users']
                                        ['is_dst_visible'])
                                      const Spacer(),
                                    if (dashBoardData['data']['users']
                                        ['is_cp_visible'])
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          renderCircleWithText(
                                              circleBgColor:
                                                  channelPartnerCountCircle,
                                              text: dashBoardData['data']
                                                              ['users']
                                                          ['user_count_by_type']
                                                      [1]['user_count']
                                                  .toString(),
                                              textColor: channelPartnerCount),
                                          const SizedBox(width: 10),
                                          RichText(
                                              textAlign: TextAlign.center,
                                              text: TextSpan(
                                                  text: dashBoardData['data']
                                                                  ['users'][
                                                              'user_count_by_type']
                                                          [1]['user_type']
                                                      .toString(),
                                                  style: AppTextStyle()
                                                      .toastMessageTextStyle(
                                                          fontColor: FontColor()
                                                              .grey2),
                                                  children: [
                                                    TextSpan(
                                                        text: "\n$users",
                                                        style: AppTextStyle()
                                                            .ninePixel(
                                                                fontColor:
                                                                    FontColor()
                                                                        .grey2))
                                                  ])),
                                        ],
                                      ),
                                  ],
                                ),
                              )),
                          spacer,
                          //Scheduled and Follow Up Card
                          Row(
                            children: [
                              if (dashBoardData['data']['site_visit'] != null &&
                                  dashBoardData['data']['site_visit']
                                      ['is_visible'])
                                Expanded(
                                    child: GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(context,
                                        Routes.scheduledSiteVisitsView);
                                  },
                                  child: MyCard(
                                      buttonTitle: viewScheduled,
                                      leadsName: '',
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Row(children: [
                                          renderCircleWithText(
                                              circleBgColor:
                                                  siteVisitCountCircle,
                                              textColor: siteVisitCount,
                                              text: dashBoardData['data']
                                                          ['site_visit'] ==
                                                      null
                                                  ? '0'
                                                  : dashBoardData['data']
                                                              ['site_visit'][
                                                          'today_site_visit_count']
                                                      .toString()),
                                          const SizedBox(width: 10),
                                          Text(siteVisitsScheduled,
                                              style: AppTextStyle()
                                                  .toastMessageTextStyle(
                                                fontColor: FontColor().grey2,
                                              ))
                                        ]),
                                      )),
                                )),
                              horizontalSpaceTiny,
                              if (dashBoardData['data']['upcoming_folowup']
                                  ['is_visible'])
                                Expanded(
                                    child: GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, Routes.upcomingFollowUpsView);
                                  },
                                  child: MyCard(
                                      buttonTitle: viewFollowUps,
                                      leadsName: '',
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Row(children: [
                                          renderCircleWithText(
                                              circleBgColor:
                                                  upcomingFollowUpCountCircle,
                                              textColor: upcomingFollowUpCount,
                                              text: dashBoardData['data']
                                                          ['upcoming_folowup'][
                                                      'upcoming_followup_count']
                                                  .toString()),
                                          const SizedBox(width: 10),
                                          Text(upComingFollowUps,
                                              style: AppTextStyle()
                                                  .toastMessageTextStyle(
                                                fontColor: FontColor().grey2,
                                              ))
                                        ]),
                                      )),
                                ))
                            ],
                          ),
                          verticalSpaceSmall,
                          verticalSpaceTiny,
                          //My Team Card
                          if (dashBoardData['data']['my_team_users']
                              ['is_visible'])
                            MyCard(
                                buttonTitle: viewAll,
                                leadsName: myTeam,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height:
                                                screenDimension(context) / 20,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2,
                                            child: Stack(
                                                alignment: Alignment.centerLeft,
                                                children: dashBoardData['data']['my_team_users']['my_team_users'].length ==
                                                        0
                                                    ? [
                                                        Row(
                                                          children: [
                                                            ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          30),
                                                              child: SvgPicture
                                                                  .asset(Images()
                                                                      .leadPerson),
                                                            ),
                                                            horizontalSpaceSmall,
                                                            Text('No One Yet !',
                                                                style: AppTextStyle()
                                                                    .toastMessageTextStyle(
                                                                        fontColor:
                                                                            FontColor().grey2))
                                                          ],
                                                        )
                                                      ]
                                                    : List.generate(
                                                        dashBoardData['data']['my_team_users']['my_team_users'].length > 5
                                                            ? 5
                                                            : dashBoardData['data']['my_team_users']['my_team_users'].length +
                                                                1,
                                                        (index) => Positioned(
                                                            left: index == 0
                                                                ? 0
                                                                : (index + index) *
                                                                    13,
                                                            child:
                                                                renderContainerWithImage(
                                                                    screenDimension(
                                                                        context),
                                                                    child: dashBoardData['data']['my_team_users']['my_team_users'].length !=
                                                                            index
                                                                        ? Container(
                                                                            decoration:
                                                                                const BoxDecoration(shape: BoxShape.circle, color: Colors.red),
                                                                            padding:
                                                                                const EdgeInsets.all(2),
                                                                            child: dashBoardData['data']['my_team_users']['my_team_users'][index]['profile_image_url'] == null
                                                                                ? ClipRRect(borderRadius: BorderRadius.circular(30), child: SvgPicture.asset(Images().leadPerson))
                                                                                : ClipRRect(
                                                                                    borderRadius: BorderRadius.circular(30),
                                                                                    child: Image.network(
                                                                                      dashBoardData['data']['my_team_users']['my_team_users'][index]['profile_image_url'],
                                                                                      errorBuilder: (context, error, stackTrace) {
                                                                                        return ClipRRect(
                                                                                          borderRadius: BorderRadius.circular(30),
                                                                                          child: SvgPicture.asset(Images().leadPerson),
                                                                                        );
                                                                                      },
                                                                                      loadingBuilder: (context, child, ImageChunkEvent? loadingProgress) {
                                                                                        if (loadingProgress == null) {
                                                                                          return child;
                                                                                        }
                                                                                        return const CircularProgressIndicator(
                                                                                          color: primaryColor,
                                                                                          strokeWidth: 3,
                                                                                        );
                                                                                      },
                                                                                      fit: BoxFit.cover,
                                                                                    ),
                                                                                  ),
                                                                          )
                                                                        : Container(
                                                                            alignment:
                                                                                Alignment.center,
                                                                            decoration: BoxDecoration(shape: BoxShape.circle, color: secondaryColor, border: Border.all(color: whiteColor, width: 2)),
                                                                            child: Text('+${dashBoardData['data']['my_team_users']['my_team_users_count'] - 5}', textAlign: TextAlign.center, style: AppTextStyle().agreementSubtitleTextStyle())))))),
                                          ),
                                        ],
                                      ),
                                      renderCircleWithText(
                                          circleBgColor:
                                              upcomingFollowUpCountCircle,
                                          textColor: upcomingFollowUpCount,
                                          text: dashBoardData['data']
                                                      ['my_team_users']
                                                  ['my_team_users_count']
                                              .toString())
                                    ],
                                  ),
                                )),
                          spacer
                        ],
                      ),
                    ))
        ]));
  }

  @override
  HomeViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      HomeViewModel()..getDashBoardV2();
}

//app bar
renderCustomAppBar(HomeViewModel viewModel) {
  return Column(
    children: [
      ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
        horizontalTitleGap: 3,
        title: Text(welcome,
            style: AppTextStyle().buttonTextStyle(FontColor().white)),
        subtitle: Text(capitalizeFirstLetter(viewModel.sharedService.userName),
            style: AppTextStyle().userNameTextStyle(
                textColor: FontColor().white, lineHeight: 0.1)),
        leading: ClipRRect(
            borderRadius:
                BorderRadius.circular(30), // backgroundColor: transparent,
            child: viewModel.sharedService.userProfile.isNotEmpty
                ? Image.network(viewModel.sharedService.userProfile,
                    height: 35,
                    width: 35,
                    errorBuilder: (context, error, stackTrace) =>
                        SvgPicture.asset(Images().leadPerson),
                    loadingBuilder:
                        ((context, child, ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      }
                      return const CircularProgressIndicator(
                        color: primaryColor,
                        strokeWidth: 3,
                      );
                    }),
                    fit: BoxFit.cover)
                : SvgPicture.asset(Images().leadPerson, height: 35, width: 35)),
        trailing: SizedBox(
          width: 75,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InkWell(
                onTap: () => viewModel.logout(),
                child: const Icon(Icons.power_settings_new_outlined,
                    size: 25, color: whiteColor),
              ),
              horizontalSpaceTiny,
              InkWell(
                onTap: () {
                  SystemNavigator.pop().then((value) async {
                    try {
                      bool isInstalled = await DeviceApps.isAppInstalled(
                          'com.example.sales_lead');
                      if (isInstalled) {
                        DeviceApps.openApp("com.example.sales_lead");
                      }
                    } catch (e) {
                      print(e);
                    }
                  });
                },
                child: SizedBox(
                    width: 40,
                    child: Stack(
                        alignment: Alignment.centerLeft,
                        children: <Widget>[
                          const Icon(Icons.notifications,
                              size: 25, color: whiteColor),
                          Positioned(
                              top: 2,
                              right: 2,
                              child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 4, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: secondaryColor,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text("100",
                                      textAlign: TextAlign.center,
                                      style: AppTextStyle().ninePixel(
                                          fontColor: FontColor().white))))
                        ])),
              )
            ],
          ),
        ),
      ),
    ],
  );
}

//circle container with image
renderContainerWithImage(screenRation, {Widget? child}) {
  return SizedBox(height: 40, width: 40, child: child);
}

//circle with number text
Container renderCircleWithText(
    {Color? circleBgColor, Color? textColor, String? text}) {
  return Container(
      width: 55,
      height: 55,
      decoration: BoxDecoration(color: circleBgColor, shape: BoxShape.circle),
      child: Center(
          child: Text(text!,
              style: AppTextStyle()
                  .agreementTitleTextStyle(fontColor: textColor))));
}

//circle with icon
Container renderCircleWithIcon({
  Color? circleBgColor,
  Color? textColor,
  String? icon,
}) {
  return Container(
      width: 55,
      height: 55,
      decoration: BoxDecoration(color: circleBgColor, shape: BoxShape.circle),
      child: Center(child: SvgPicture.asset(icon!, height: 30, width: 30)));
}
