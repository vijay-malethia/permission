import 'dart:developer';

import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

import '/app/app.dialogs.dart';
import '/app/app.locator.dart';
import '/services/call_record_service.dart';
import '/services/upcoming_follow_ups_service.dart';
import '/ui/common/index.dart';

class UpcomingFollowUpsViewModel extends FormViewModel {
  final _dialogService = locator<DialogService>();
  PageController pageController = PageController();
  ScrollController scrollController = ScrollController();
  bool isDataLoading = false;

  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();

  goBack(context) {
    Navigator.pop(context);
  }

//Select Tab
  String selectedTab = 'All';
  void selectTab(name) {
    selectedTab = name;
    pageCount = 1;
    upcomingFollowUpsLsit.clear();
    getUpComingFollowUps(
        date: DateFormat("MM-dd-yyyy").format(selectedDay).toString(),
        followUpType: selectedTab == 'Call'
            ? '1'
            : selectedTab == 'Site Visit'
                ? '4'
                : selectedTab == 'Email'
                    ? '2'
                    : selectedTab == 'Client Visit'
                        ? '3'
                        : null);
    notifyListeners();
  }

  bool isToday(DateTime displayedDate) {
    DateTime currentDate = DateTime.now();
    return displayedDate.year == currentDate.year &&
        displayedDate.month == currentDate.month &&
        displayedDate.day == currentDate.day;
  }

//change selected date
  void selectedDayColorsChange(DateTime selectDay, DateTime focusDay) {
    selectedDay = selectDay;
    focusedDay = focusDay;
    pageCount = 1;
    upcomingFollowUpsLsit.clear();
    notifyListeners();
    getUpComingFollowUps(
        date: DateFormat("MM-dd-yyyy").format(selectedDay).toString(),
        followUpType: selectedTab == 'Call'
            ? '1'
            : selectedTab == 'Site Visit'
                ? '4'
                : selectedTab == 'Email'
                    ? '2'
                    : selectedTab == 'Client Visit'
                        ? '3'
                        : null);
  }

  //fromat date
  String formatDate(String date) {
    DateTime inputDate = DateTime.parse(date);
    return DateFormat("dd MMMM yyyy").format(inputDate);
  }

  //call now dialog
  void showCallDialog(String userName, String number) async {
    var res = await _dialogService.showCustomDialog(
        variant: DialogType.confirm, title: userName);
    if (res!.confirmed == true) {
      onCallIcontap(phoneNumber: number);
    }
  }

  void onCallIcontap({phoneNumber}) async {
    Uri url = Uri(scheme: "tel", path: phoneNumber);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      log("Can't open dial pad.");
    }
  }

//check date has record
  bool checkRecord(DateTime day) {
    for (int i = 0; i < followupCount.length; i++) {
      if (followupCount[i]['followup_date'].split("T").first ==
          day.toString().split(" ").first) {
        return true;
      }
    }
    return false;
  }



//pagination
  void onReachEndPage() {
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        if (isDataLoading) return;
        if (pageCount < calculateTotalPages(totalRecord)) {
          pageCount++;
          getUpComingFollowUps(
              date: DateFormat("MM-dd-yyyy").format(selectedDay).toString());
        }
      }
    });
    notifyListeners();
  }

//calulate total pagecount
  int calculateTotalPages(int totalRecords, {int itemsPerPage = 25}) {
    return (totalRecords / itemsPerPage).ceil();
  }

  //init function
  init() {
    onReachEndPage();
    getUpcomingFollowUpsCount(
        DateFormat("MM-yyyy").format(selectedDay).toString());
    getUpComingFollowUps(
        date: DateFormat("MM-dd-yyyy").format(selectedDay).toString());
    notifyListeners();
  }

  //send mail
    void sendMail({emailId}) async {
    final Uri emailLaunchUri = Uri(scheme: 'mailto', path: emailId);
    if (await canLaunchUrl(emailLaunchUri)) {
      await launchUrl(emailLaunchUri);
    } else {
      log("Can't launch mail");
    }
  }

  ///////////////////////////Api work//////////////////////////////
  final UpcomingFollowUpServices _upcomingFollowUpServices =
      locator<UpcomingFollowUpServices>();
  final CallRecordService _callRecordService = locator<CallRecordService>();

  int pageCount = 1;
  int totalRecord = 0;

  List upcomingFollowUpsLsit = [];
  Future<void> getUpComingFollowUps(
      {String? date, String? followUpType}) async {
    setBusy(true);
    try {
      var res = await _upcomingFollowUpServices.getUpComingFollowUps(
          pageNo: pageCount, date: date, followUpType: followUpType);

      if (res.data['status'] == 'Success') {
        var result = res.data['data'];
        totalRecord = result['totalCount'];

        upcomingFollowUpsLsit.addAll(result['followups']);
        // pageCount++;
      }
      notifyListeners();
    } on Error catch (e) {
      log('Upcoming follow ups error = $e');
    } finally {
      setBusy(false);
    }
  }

  //cloud call
  void showCloudCall(
      String userName, String number, int? leadId, int? followUPId) async {
    var res = await _dialogService.showCustomDialog(
        variant: DialogType.confirm, title: userName);
    if (res!.confirmed == true) {
      try {
        setBusy(true);
        var res = await _callRecordService.connectToCloudCall(
            toNumber: number, leadId: leadId, followUpId: followUPId);
        _dialogService.showCustomDialog(
            variant: DialogType.deactive,
            title: 'Sales Lead',
            description: res.data['message'],
            mainButtonTitle: "OK",
            secondaryButtonTitle: '',
            barrierDismissible: true,
            imageUrl: Images().infoAlert);
      } on Error catch (e) {
        log('incoming call records error = $e');
      } finally {
        setBusy(false);
      }
    }
  }

  //show count
  List followupCount = [];
  Future<void> getUpcomingFollowUpsCount(String date) async {
    setBusy(true);
    try {
      var res = await _upcomingFollowUpServices.getUpcomingFollowUpsCount(date);

      if (res.data['status'] == 'Success') {
        var result = res.data['data'];
        followupCount = result['followup_count'];
      }
      notifyListeners();
    } on Error catch (e) {
      log('schedule site vists error = $e');
    } finally {
      setBusy(false);
    }
  }
}
