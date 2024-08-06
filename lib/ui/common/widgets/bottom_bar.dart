import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '/ui/common/index.dart';
import '/ui/views/home/home_view.dart';
import '/ui/views/home/home_viewmodel.dart';
import '/app/app.locator.dart';

class BottomBar extends StackedView<HomeViewModel> {
  const BottomBar({Key? key}) : super(key: key);
  @override
  Widget builder(BuildContext context, HomeViewModel viewModel, Widget? child) {
    NavigationService navigationService = locator<NavigationService>();
    return BottomAppBar(
      color: transparent,
      child: Container(
          height: screenDimension(context) / 21,
          clipBehavior: Clip.hardEdge,
          alignment: Alignment.bottomCenter,
          decoration: const BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10))),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            SizedBox(height: screenDimension(context) * 0.0035),
            Row(children: [
              Expanded(
                  // Home page
                  child: InkWell(
                      radius: 0,
                      onTap: currentIndex != 0
                          ? () {
                              viewModel.changeIndex(0);
                              navigationService.back();
                              navigationService.navigateWithTransition(
                                  const HomeView(pageIndex: 0),
                                  duration: Duration.zero);
                            }
                          : () {},
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(Images().homeIcon,
                                height: screenDimension(context) / 50,
                                width: screenDimension(context) / 50,
                                color: currentIndex == 0
                                    ? FontColor().brown
                                    : FontColor().grey),
                            Text(home,
                                style: AppTextStyle().dateText(
                                    fontColor: currentIndex == 0
                                        ? FontColor().brown
                                        : FontColor().grey))
                          ]))),
              if (viewModel.sharedService.isViewChannelPartner!)
                Expanded(
                    // CP Page
                    child: InkWell(
                        radius: 0,
                        onTap: currentIndex != 1
                            ? () {
                                viewModel.changeIndex(1);
                                navigationService.back();
                                navigationService.navigateWithTransition(
                                    const HomeView(pageIndex: 5),
                                    duration: Duration.zero);
                              }
                            : () {},
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(Images().handShakeIcon,
                                  height: screenDimension(context) / 50,
                                  width: screenDimension(context) / 50,
                                  color: currentIndex == 1
                                      ? FontColor().brown
                                      : FontColor().grey),
                              SizedBox(
                                  height: screenDimension(context) * 0.0018),
                              Text('CP',
                                  style: AppTextStyle().dateText(
                                      fontColor: currentIndex == 1
                                          ? FontColor().brown
                                          : FontColor().grey))
                            ]))),
              if (viewModel.sharedService.isCp!)
                Expanded(
                    // Users Page
                    child: InkWell(
                        radius: 0,
                        onTap: currentIndex != 1
                            ? () {
                                viewModel.changeIndex(1);
                                navigationService.back();

                                navigationService.navigateWithTransition(
                                    const HomeView(pageIndex: 1),
                                    duration: Duration.zero);
                              }
                            : () {},
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(Images().usersIcon,
                                  height: screenDimension(context) / 50,
                                  width: screenDimension(context) / 50,
                                  color: currentIndex == 1
                                      ? FontColor().brown
                                      : FontColor().grey),
                              SizedBox(
                                  height: screenDimension(context) * 0.0018),
                              Text(users.toUpperCase(),
                                  style: AppTextStyle().dateText(
                                      fontColor: currentIndex == 1
                                          ? FontColor().brown
                                          : FontColor().grey))
                            ]))),
              if (viewModel.sharedService.isLeads!) ...[
                Expanded(
                    // Leads page
                    child: InkWell(
                        radius: 0,
                        onTap: currentIndex != 2
                            ? () {
                                viewModel.changeIndex(2);
                                navigationService.back();
                                navigationService.navigateWithTransition(
                                    const HomeView(pageIndex: 2),
                                    duration: Duration.zero);
                              }
                            : () {},
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(Images().leadIcon,
                                  height: screenDimension(context) / 50,
                                  width: screenDimension(context) / 50,
                                  color: currentIndex == 2
                                      ? FontColor().brown
                                      : FontColor().grey),
                              Text(leads,
                                  style: AppTextStyle().dateText(
                                      fontColor: currentIndex == 2
                                          ? FontColor().brown
                                          : FontColor().grey))
                            ])))
              ],
              if (viewModel.sharedService.isCallRecording!) ...[
                Expanded(
                    // Call Records page
                    child: InkWell(
                        radius: 0,
                        onTap: currentIndex != 3
                            ? () {
                                viewModel.changeIndex(3);
                                navigationService.back();
                                navigationService.navigateWithTransition(
                                    const HomeView(pageIndex: 3),
                                    duration: Duration.zero);
                              }
                            : () {},
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(Images().cloudCallIcon,
                                  height: screenDimension(context) / 50,
                                  width: screenDimension(context) / 50,
                                  color: currentIndex == 3
                                      ? FontColor().brown
                                      : FontColor().grey),
                              Text(callRecords,
                                  style: AppTextStyle().dateText(
                                      fontColor: currentIndex == 3
                                          ? FontColor().brown
                                          : FontColor().grey))
                            ])))
              ],
              if (viewModel.sharedService.isProjects!) ...[
                Expanded(
                    // Call Records page
                    child: InkWell(
                        radius: 0,
                        onTap: currentIndex != 4
                            ? () {
                                viewModel.changeIndex(4);
                                navigationService.back();
                                navigationService.navigateWithTransition(
                                    const HomeView(pageIndex: 4),
                                    duration: Duration.zero);
                              }
                            : () {},
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(Images().buildingIcon,
                                  height: screenDimension(context) / 50,
                                  width: screenDimension(context) / 50,
                                  color: currentIndex == 4
                                      ? FontColor().brown
                                      : FontColor().grey),
                              Text(projects,
                                  style: AppTextStyle().dateText(
                                      fontColor: currentIndex == 4
                                          ? FontColor().brown
                                          : FontColor().grey))
                            ])))
              ],
              const Expanded(child: SizedBox())
            ])
          ])),
    );
  }

  @override
  HomeViewModel viewModelBuilder(BuildContext context) => HomeViewModel();
}
