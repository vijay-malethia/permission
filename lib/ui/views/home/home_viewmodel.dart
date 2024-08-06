import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '/app/app.locator.dart';
import '/services/index.dart';
import '/app/app.router.dart';
import 'home_view.dart';
import 'pie_chart.dart';
import 'project_pie_chart.dart';

int currentIndex = 0;
Map dashBoardData = {};
List<LeadGridItem> leadList = [];
List<PichartData> pidata = [];
int highestLeadPointOnYAxis = 0;
double highestLeadPointOnXAxis = 0;

class HomeViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final SharedService sharedService = locator<SharedService>();
  ScrollController scrollController = ScrollController();
  bool isActionOPen = false;
  dynamic maxValue;
  dynamic interval;
  //Go to back page
  void goBack() {
    currentIndex = 0;
    notifyListeners();
    _navigationService.back();
    _navigationService.navigateWithTransition(const HomeView(pageIndex: 0),
        duration: Duration.zero);
  }

  navigateToCaptureLeadView() {
    openFloatingAction();
    _navigationService.navigateToCaptureLeadView();
  }

  navigateToDstCP() {
    openFloatingAction();
    _navigationService.navigateToCreateUserView(
        isUserDstMember: sharedService.isDstUser! ? true : false);
  }

  navigateToUserView() {
    _navigationService.navigateTo(Routes.allusersView);
  }

  navigateToProjectView() {
    _navigationService.navigateTo(Routes.allProjectView);
  }

  openFloatingAction() {
    isActionOPen = !isActionOPen;
    notifyListeners();
  }

//change bottom bar index
  changeIndex(tabindex) {
    openFloatingAction();
    currentIndex = tabindex;
    notifyListeners();
  }

  logout() async {
    try {
      var prefs = await SharedPreferences.getInstance();
      var response = await AuthService().logout();
      if (response.statusCode == 200) {
        await prefs.clear();
        _navigationService.clearStackAndShow(Routes.mobileNumberView);
      }
    } catch (error) {
      log('error: $error');
    }
  }

  void getHighestLeadCount() {
    List maxCount = [];
    var tempData = dashBoardData['data']['line_graph_for_past_days_leads']
        ['leads_count_for_past_days'];
    for (var i = 0; i < tempData.length; i++) {
      if (i < tempData.length - 1 &&
          highestLeadPointOnYAxis < tempData[i]['leads_count']) {
        highestLeadPointOnYAxis = tempData[i + 1]['leads_count'];
      }
      if (highestLeadPointOnYAxis < tempData[i]['leads_count']) {
        highestLeadPointOnXAxis = double.parse('$i');
        highestLeadPointOnYAxis = tempData[i]['leads_count'];
      }
    }
    if (highestLeadPointOnXAxis == (tempData.length - 1)) {
      highestLeadPointOnXAxis = highestLeadPointOnXAxis - 0.15;
    }
    for (var i = 0;
        i <
            dashBoardData['data']['line_graph_for_past_days_leads']
                    ['leads_count_for_past_days']
                .length;
        i++) {
      maxCount.add(dashBoardData['data']['line_graph_for_past_days_leads']
          ['leads_count_for_past_days'][i]['leads_count']);
    }
    maxValue = maxCount.reduce((currentMax, element) {
      var value = element > currentMax ? element : currentMax;
      return value;
    });
    interval = maxCount.reduce((currentMax, element) {
      var value = element > currentMax ? element : currentMax;
      if (value <= 1) {
        return value = 1;
      } else {
        if (value % 2 == 0) {
          return value;
        } else {
          return value + 1;
        }
      }
    });
    notifyListeners();
  }

  void addPieChartStages() {
    for (var i = 0;
        i < dashBoardData['data']['leads']['lead_by_stage'].length;
        i++) {
      leadList.add(LeadGridItem(
          bgColor: Color(int.parse(
              '0XFF${dashBoardData['data']['leads']['lead_by_stage'][i]['color_code_1'].toString().split('#').last}')),
          fgColor: Color(int.parse(
              '0XFF${dashBoardData['data']['leads']['lead_by_stage'][i]['color_code_2'].toString().split('#').last}')),
          leadName: dashBoardData['data']['leads']['lead_by_stage'][i]
                  ['lead_stage_name']
              .toString(),
          leadCount: dashBoardData['data']['leads']['lead_by_stage'][i]
                  ['leads_count']
              .toString()));
    }
  }

  void addPieChartData() {
    var leadByProject =
        dashBoardData['data']['leads_by_project_piechart']['lead_by_project'];

    if (leadByProject != null) {
      for (var project in leadByProject) {
        pidata.add(PichartData(
          name: project['project_name'],
          leadCount: project['leads_count'].toString(),
        ));
      }
      notifyListeners();
    }
  }

//get dashboard data
  final HomeService _homeService = locator<HomeService>();
  void getDashBoardV2() async {
    try {
      setBusy(true);
      var res = await _homeService.getDashBoardV2();

      dashBoardData.clear();
      leadList.clear();
      pidata.clear();
      dashBoardData = res.data;
      addPieChartStages();
      getHighestLeadCount();
      addPieChartData();
      notifyListeners();
    } on Error catch (e) {
      log('dashBoardV2 error = $e');
    } finally {
      setBusy(false);
    }
  }
}
