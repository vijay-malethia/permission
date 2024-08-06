import 'dart:async';
import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sales_lead/enum/index.dart';
import 'package:sales_lead/services/index.dart';
import '/app/app.bottomsheets.dart';
import '/app/app.dialogs.dart';
import '/ui/common/images.dart';
import '/ui/views/home/home_viewmodel.dart';

import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '/app/app.locator.dart';

String fromDate = '';
String toDate = '';
bool isSelectingFromDate = true;
String selectedButton = '';

class IncomingCallViewModel extends FormViewModel {
  ScrollController scrollController = ScrollController();
  final NavigationService _navigationService = locator<NavigationService>();
  final SharedService sharedService = locator<SharedService>();

  final _bottomSheetService = locator<BottomSheetService>();
  final _dialogService = locator<DialogService>();
  DateTime selectedDate = DateTime.now();
  bool isDataLoading = false;


  int index = 0;
  //cancel bottomsheet
  onCancel() async {
    _navigationService.back();
  }

  setSelectingType(bool value) {
    isSelectingFromDate = value;
    notifyListeners();
  }

  void showDatePickerBottomSheet() async {
    var response = await _bottomSheetService.showCustomSheet(
        isScrollControlled: true,
        variant: BottomSheetType.datePicker,
        title: fromDate);
    if (response!.confirmed == true || response.confirmed == false) {
      notifyListeners();
    }
  }

//Select Button

  void selectButton(name) {
    selectedButton = name;
    notifyListeners();
  }

  void showBottomSheet(String searchText) async {
    var res = await _bottomSheetService.showCustomSheet(
        isScrollControlled: true,
        variant: BottomSheetType.filterBy,
        title: "assignTo");
    if (res!.confirmed == true) {
      callRecordList.clear();
      pageCount = 1;
      await getIncomingCallRecods(searchText);
    } else {
      fromDate = '';
      toDate = '';
      selectedButton = '';
      callRecordList.clear();
      pageCount = 1;
      await getIncomingCallRecods(searchText);
    }

    notifyListeners();
  }

  void showDisqualifiedDialog(int callId, String searchText) async {
    var res = await _dialogService.showCustomDialog(
        variant: DialogType.disqualified,
        title: 'Disqualified this \n lead?',
        mainButtonTitle: "CONFIRM",
        secondaryButtonTitle: "CANCEL",
        barrierDismissible: true,
        imageUrl: Images().infoAlert);
    if (res!.confirmed == true) {
      disposeCallById(callId).then((value) {
        callRecordList.clear();
        pageCount = 1;
        getIncomingCallRecods(searchText);
      });
    }
    notifyListeners();
  }

  //Go to back page
  void goBack() {
    currentIndex = 0;
    notifyListeners();
    _navigationService.back();
  }

//Select Tab
  String selectedTab = '';
  void selectTab(name, TextEditingController searchController) {
    selectedTab = name;
    searchController.clear();
    pageCount = 1;
    callRecordList.clear();
    getIncomingCallRecods(searchController.text,isBusy: true);
    notifyListeners();
  }

 
  //change Tab bar
  onChangeTab(TextEditingController searchController) {
    // tabIndex = index;
    searchController.clear();
    pageCount = 1;
    callRecordList.clear();
    getIncomingCallRecods(searchController.text);
    notifyListeners();
  }

  onChangeSearch(TextEditingController searchController) {
    pageCount = 1;
    callRecordList.clear();
    getIncomingCallRecods(searchController.text);

    notifyListeners();
  }

  //convert string to date time
  getTime(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    return DateFormat('h:mm a').format(dateTime);
  }

  // Replace with your call duration in seconds
  showCallDuration(callDuration) {
    int minutes = callDuration ~/ 60;
    int seconds = callDuration % 60;
    return '$minutes m $seconds s';
  }

  //play call record audio
  void showPlayAudio(String callRecord) {
    _bottomSheetService.showCustomSheet(
        variant: BottomSheetType.playCallRecord,
        isScrollControlled: true,
        data: callRecord);
  }

  AudioPlayer audioPlayer = AudioPlayer();
  //Play Audio Recording
  bool isPlaying = false;
  Future<void> playRecording(String? audioPath) async {
    try {
      if (isPlaying) {
        audioPlayer.stop();
        isPlaying = false;
      } else {
        Source urlSource = UrlSource(audioPath!);
        isPlaying = true;
        await audioPlayer.play(urlSource);
      }
    } catch (error) {
      log('Player Error $error');
    }
    notifyListeners();
  }

  stopPlaying() {
    audioPlayer.stop();
    isPlaying = false;
  }

  //Record Audio Wave values
  var value = [
    0.3,
    0.5,
    0.7,
    0.8,
    0.7,
    0.5,
    0.3,
    0.5,
    0.7,
    0.9,
    1.0,
    0.9,
    0.7,
    0.5,
    0.3,
    0.5,
    0.7,
    0.9,
    0.7,
    0.5
  ];

  //convert date format
  getDate(String date) {
    DateTime dateCreated = DateTime.parse(date);
    return DateFormat('dd MMM yyyy').format(dateCreated);
  }

  getFromAndToDateApi(String date) {
    DateTime dateTime = DateTime.parse(date);
    return DateFormat('MM-dd-yyyy').format(dateTime);
  }
//pagination
  void onReachEndPage(String searchText) {
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
              scrollController.offset
        ) {
        if (isDataLoading) return;
         if (pageCount < calculateTotalPages(totalRecord)) {
      pageCount++;
        getIncomingCallRecods(searchText);
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
  init(TextEditingController searchController) {
     if (sharedService.isViewAllIncomingCallRecords!) {
      selectedTab = 'All';
    } else if (sharedService.isViewIdentifyCallRecords!) {
      selectedTab = 'Identified';
    } else if (sharedService.isViewUnIdentifyCallRecords!) {
      selectedTab = 'Unidentified';
    }
    onReachEndPage(searchController.text);
    getIncomingCallRecods(searchController.text, isBusy: true);
    notifyListeners();
  }

///////////////////////////////////Api's work////////////////////////////////////////////
  final CallRecordService _callRecordService = locator<CallRecordService>();
  final _snackbarService = locator<SnackbarService>();

  int pageCount = 1;
  int totalRecord = 0;
  var result;
  List callRecordList = [];
  Future<void> getIncomingCallRecods(String searchText,
      {bool isBusy = false}) async {
    setBusy(isBusy);
    isDataLoading = true;
    try {
      List updatedList = [];
     

      var res = await _callRecordService.getIncomingCallRecods(
          pageCount: pageCount,
          callStatus: selectedTab == 'All'
              ? null
              : selectedTab == 'Identified'
                  ? '29'
                  : '30',
          callType: selectedButton.isNotEmpty
              ? selectedButton == 'Answered'
                  ? '31'
                  : '32'
              : null,
          searchString: searchText.isNotEmpty ? searchText : null,
          fromDate: fromDate.isNotEmpty ? getFromAndToDateApi(fromDate) : null,
          toDate: toDate.isNotEmpty ? getFromAndToDateApi(toDate) : null);

      if (res.data['status'] == 'Success') {
        result = res.data['data'];
        totalRecord = result['totalCount'];

       
        if (pageCount == 1) {
          updatedList.addAll(result['call_records']);
        } else {
          callRecordList.addAll(result['call_records']);
        }
      }
      if (pageCount == 1) {
        callRecordList = List.from(updatedList);
      }
      // pageCount++;

      notifyListeners();
    } on Error catch (e) {
      log('imcoming call records error = $e');
    } finally {
      setBusy(false);
      isDataLoading = false;
    }
  }

  //dispose call by id
  Future<void> disposeCallById(int callId) async {
    setBusy(true);
    try {
      var res = await _callRecordService.disposeCallById(callId);
      if (res.data['status'] == 'Success') {
        _snackbarService.showCustomSnackBar(
            message: res.data['message'], variant: SnackbarType.success);
      } else {
        _snackbarService.showCustomSnackBar(
            message: res.data['message'], variant: SnackbarType.error);
      }
      notifyListeners();
    } on Error catch (e) {
      log('incoming call records error = $e');
    } finally {
      setBusy(false);
    }
  }

  //call now
  void showCallDialog(
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
}
