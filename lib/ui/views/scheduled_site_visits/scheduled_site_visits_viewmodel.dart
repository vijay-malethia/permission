import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';
import 'package:sales_lead/ui/common/widgets/table_calendar-3.0.9/lib/table_calendar.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '/app/app.dialogs.dart';
import '/enum/index.dart';
import '/services/scheduled_site_visits_service.dart';
import '/ui/common/index.dart';
import '/app/app.bottomsheets.dart';
import '/app/app.locator.dart';

class ScheduledSiteVisitsViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final BottomSheetService _bottomSheetService = locator<BottomSheetService>();
  ScrollController scrollController = ScrollController();
  bool isDataLoading = false;

  showConfirmSiteVisitBottomSheet(int index) async {
    var res = await _bottomSheetService.showCustomSheet(
        variant: BottomSheetType.confirmSiteVisit,
        isScrollControlled: true,
        data: scheduleSiteVisitsList[index]);
    if (res!.confirmed == true) {
      pageCount = 1;
      scheduleSiteVisitsList.clear();
      await getScheduledSiteVisits(
          date: DateFormat("MM-dd-yyyy").format(selectedDay).toString());
    }
    notifyListeners();
  }

  goBack() {
    _navigationService.back();
  }

  PageController pageController = PageController();

  DateTime selectedDate = DateTime.now();
  CalendarFormat calendarFormat = CalendarFormat.week;
  bool isDragging = false;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  void onFormatChanged(CalendarFormat format) {
    if (calendarFormat != format) {
      calendarFormat = format;
      notifyListeners();
    }
  }

// check isToday
  bool isToday(String date) {
    DateTime displayedDate = DateTime.parse(date);
    DateTime currentDate = DateTime.now();
    return displayedDate.year == currentDate.year &&
        displayedDate.month == currentDate.month &&
        displayedDate.day == currentDate.day;
  }

  void selectedDayColorsChange(DateTime selectDay, DateTime focusDay) {
    selectedDay = selectDay;
    focusedDay = focusDay;
    pageCount = 1;
    scheduleSiteVisitsList.clear();
    notifyListeners();
    getScheduledSiteVisits(
        date: DateFormat("MM-dd-yyyy").format(selectedDay).toString());
  }

  //fromat date
  String formatDate(String date) {
    DateTime inputDate = DateTime.parse(date);
    return DateFormat("dd MMM yyyy").format(inputDate);
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
    for (int i = 0; i < scheduleSiteCount.length; i++) {
      if (scheduleSiteCount[i]['followup_date'].split("T").first ==
          day.toString().split(" ").first) {
        return true;
      }
    }
    return false;
  }

  //init
  ScheduledSiteVisitsViewModel() {
    getScheduledSiteVisits(
        date: DateFormat("MM-dd-yyyy").format(selectedDay).toString());
    getScheduleSiteVisitCount(
        DateFormat("MM-yyyy").format(selectedDay).toString());
  }

//pagination
  void onReachEndPage() {
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        if (isDataLoading) return;
        if (pageCount < calculateTotalPages(totalRecord)) {
          pageCount++;
          getScheduledSiteVisits(
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
    getScheduledSiteVisits(
        date: DateFormat("MM-dd-yyyy").format(selectedDay).toString());
    getScheduleSiteVisitCount(
        DateFormat("MM-yyyy").format(selectedDay).toString());
    notifyListeners();
  }

  /////////////////Api call //////////////////////
  final ScheduledSiteVisitsService _scheduledSiteVisitsService =
      locator<ScheduledSiteVisitsService>();
  final snackBarService = locator<SnackbarService>();
  final _dialogService = locator<DialogService>();

  int pageCount = 1;
  int totalRecord = 0;

  List scheduleSiteVisitsList = [];
  Future<void> getScheduledSiteVisits({String? date}) async {
    setBusy(true);
    try {
      var res = await _scheduledSiteVisitsService.getScheduledSiteVisit(
          date, pageCount);

      if (res.data['status'] == 'Success') {
        var result = res.data['data'];
        totalRecord = result['totalCount'];

        scheduleSiteVisitsList.addAll(result['sheduled_sitevisit']);
        // pageCount++;
      }
      notifyListeners();
    } on Error catch (e) {
      log('schedule site vists error = $e');
    } finally {
      setBusy(false);
    }
  }

  Future<void> getSiteVisitCode(int id) async {
    setBusy(true);
    try {
      var res = await _scheduledSiteVisitsService.getSiteVisitCode(id);
      if (res.data['status'] == 'Success') {
        snackBarService.showCustomSnackBar(
            variant: SnackbarType.success,
            message: res.data['message'].toString(),
            duration: const Duration(seconds: 2));
      }
      notifyListeners();
    } on Error catch (e) {
      log('schedule site vists error = $e');
    } finally {
      setBusy(false);
    }
  }

//completesite visit api
  Map completeResult = {};
  Future<void> completeSiteVisit(
      {int? followUpId, int? leadCode, int? userCode}) async {
    setBusy(true);
    try {
      var res = await _scheduledSiteVisitsService.completeSiteVisit(
          followUpId: followUpId, leadCode: leadCode, userCode: userCode);
      completeResult = res.data;
      if (res.data['status'] == 'Success') {
        snackBarService.showCustomSnackBar(
            variant: SnackbarType.success,
            message: res.data['message'].toString(),
            duration: const Duration(seconds: 2));
      } else {
        _dialogService.showCustomDialog(
            variant: DialogType.deactive,
            title: 'Sales Lead',
            description: res.data['message'],
            mainButtonTitle: "OK",
            secondaryButtonTitle: '',
            barrierDismissible: true,
            imageUrl: Images().infoAlert);
      }
      notifyListeners();
    } on Error catch (e) {
      log('schedule site vists error = $e');
    } finally {
      setBusy(false);
    }
  }

  //get count
  List scheduleSiteCount = [];
  Future<void> getScheduleSiteVisitCount(String date) async {
    setBusy(true);
    try {
      var res =
          await _scheduledSiteVisitsService.getScheduleSiteVisitCount(date);

      if (res.data['status'] == 'Success') {
        var result = res.data['data'];
        scheduleSiteCount = result['sitevisitlist'];
      }
      notifyListeners();
    } on Error catch (e) {
      log('schedule site vists error = $e');
    } finally {
      setBusy(false);
    }
  }
}
