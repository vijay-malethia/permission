import 'dart:async';
import 'dart:developer';
import 'package:audioplayers/audioplayers.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sales_lead/app/app.dialogs.dart';
import 'package:sales_lead/enum/snackbar_type.dart';
import 'package:sales_lead/services/index.dart';
import 'package:sales_lead/ui/common/app_colors.dart';
import 'package:sales_lead/ui/common/images.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '/app/app.router.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:record/record.dart';

import '/app/app.bottomsheets.dart';
import '/app/app.locator.dart';
import '../../../../model/index.dart';
import '/ui/views/home/home_viewmodel.dart';
import 'all_leads_view.form.dart';

List userList = [];
List projectList = [];
List channelPartnersList = [];

List selectedProjectList = [];
List selectedCpIdsList = [];
List selectedUserList = [];
String isAssigned = '';
List followUpTypelist = [];
int tabIndex = 0;

class AllLeadsViewModel extends BaseViewModel with FormStateHelper {
  final NavigationService _navigationService = locator<NavigationService>();
  final DialogService _dialogService = locator<DialogService>();
  ScrollController scrollController = ScrollController();
  final sharedService = locator<SharedService>();
  final _snackBarService = locator<SnackbarService>();
  final searchCtrl = TextEditingController();

  int currentFollowUpTab = 0;
  onTabTap(int value) {
    currentFollowUpTab = value;
    currentPage = 1;
    notifyListeners();
  }

  //Go to back page
  void goBack() {
    currentIndex = 0;
    notifyListeners();
    _navigationService.back();
  }

  //Show assign lead bottom sheet
  final _bottomSheetService = locator<BottomSheetService>();
  void assignLeadSheet() async {
    var res = await _bottomSheetService.showCustomSheet(
        variant: BottomSheetType.history, isScrollControlled: true);
    if (res != null) {
      notifyListeners();
    }
  }

  //Change Assign to person
  OptionItem entityOption = OptionItem(title: '');
  List<OptionItem> assignToUserList = [];
  int assignToLeadId = -1;
  onEntityChange(OptionItem value, index) {
    assignToLeadId = assignToIdList[index];
    entityOption = assignToUserList[index];
    notifyListeners();
  }

  OptionItem initLeadStage = OptionItem(title: '');
  List<OptionItem> changeLeadStatus = [];
  void changeLeadStage(OptionItem value, index) {
    initLeadStage = changeLeadStatus[index];
    assignToLeadId = filterCategoryList[index + 1].leadStageId;
    notifyListeners();
  }

  //Convert Speech To Text
  SpeechToText speechToText = SpeechToText();
  String speech = '';
  bool isListening = false;
  void startSpeechToText() async {
    isListening = true;
    var connected = await speechToText.initialize();
    if (connected) {
      speechToText.listen(onResult: (result) {
        isListening = !result.finalResult;
        speech = result.recognizedWords;
        remarkValue = speech;
        if (!isListening) {
          stopSpeechToText();
        }
      });
    }
    notifyListeners();
  }

  //Stop converting speech  to text
  void stopSpeechToText() {
    isListening = false;
    speechToText.stop();
    notifyListeners();
  }

  //Record audio, puase, resume and stop
  Record audioRecord = Record();
  AudioPlayer audioPlayer = AudioPlayer();
  bool isStartRecording = false;
  bool isRecording = false;
  bool isPause = false;
  String? audioPath;

  Future<void> startRecording() async {
    try {
      if (await audioRecord.hasPermission() && !isRecording) {
        audioRecord.start();
        startTimer();
        isRecording = true;
        isStartRecording = true;
      }
    } catch (erro) {
      log('Start Recording Error$error');
    }
    notifyListeners();
  }

  Future<void> stopRecording() async {
    try {
      audioPath = await audioRecord.stop();
      resetTimer();
      isRecording = false;
      isStartRecording = false;
    } catch (erro) {
      log('Stop Recording Error$error');
    }
    notifyListeners();
  }

  Future<void> pauseRecording() async {
    try {
      await audioRecord.pause();
      stopTimer();
      isPause = true;
    } catch (erro) {
      log('Pause Recording Error$error');
    }
    notifyListeners();
  }

  Future<void> resumeRecording() async {
    try {
      await audioRecord.resume();
      startTimer();
      isPause = false;
    } catch (erro) {
      log('Resume Recording Error$error');
    }
    notifyListeners();
  }

//Play Audio Recording
  bool isPlaying = false;
  Future<void> playRecording() async {
    try {
      if (isPlaying) {
        audioPlayer.stop();
        isPlaying = false;
      } else {
        Source urlSource = UrlSource(audioPath!);
        await audioPlayer.play(urlSource);
        isPlaying = true;
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

  //Show audio record bottom sheet
  void showRecordAudioSheet() async {
    var res = await _bottomSheetService.showCustomSheet(
      variant: BottomSheetType.recordAudio,
    );
    if (res != null) {
      audioPath = res.data;
      notifyListeners();
    }
  }

  Timer? timer;
  int secondsElapsed = 0;
  bool isRunning = false;

  void startTimer() {
    if (timer == null || !timer!.isActive) {
      timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        secondsElapsed++;
        notifyListeners();
      });
      isRunning = true;
    }
    notifyListeners();
  }

  void stopTimer() {
    if (timer != null && timer!.isActive) {
      timer!.cancel();
      isRunning = false;
    }
    notifyListeners();
  }

  void resetTimer() {
    stopTimer();
    secondsElapsed = 0;
    notifyListeners();
  }

  //Format Record Time
  String get timerText {
    int hours = (secondsElapsed / 3600).floor();
    int minutes = ((secondsElapsed % 3600) / 60).floor();
    int seconds = secondsElapsed % 60;
    return "${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
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

  //Change Filter
  String choosedFiter = 'All';
  onFilterCategoryTap(String filter, index) {
    leadsList.clear();
    assignedLeadsList.clear();
    viewLeadsBySourceData.clear();
    assignedLeadsMap.clear();
    currentPage = 1;
    leadStageId = filterCategoryList[index].leadStageId;
    tabIndex == 2
        ? getAssignedLeads(
            isbusy: true,
            leadStageId: leadStageId,
            search: searchCtrl.text.isEmpty ? null : searchCtrl.text,
            projectId:
                projectIdStringArray.isEmpty ? null : projectIdStringArray)
        : getViewLeadsBySource(
            isBusy: true,
            leadId: leadStageId,
            isUnassigned: isAssigned == ''
                ? null
                : isAssigned == 'Assigned'
                    ? 0
                    : 1,
            search: searchCtrl.text.isEmpty ? null : searchCtrl.text,
            cpIds: cpIdStringArray.isEmpty ? null : cpIdStringArray,
            userTypeId: tabIndex == 0 ? 1 : 2,
            userId: userIdStringArray.isEmpty ? null : userIdStringArray,
            projectId:
                projectIdStringArray.isEmpty ? null : projectIdStringArray);
    choosedFiter = filter;
    notifyListeners();
  }

  //Show FILTER Bottomsheet
  void showFilterBottomSheet() async {
    await _bottomSheetService.showCustomSheet(
        variant: BottomSheetType.filter, isScrollControlled: true);
  }

  //Go to schedule follow up screen
  void goToScheduleScreen(int index, {bool forEdit = false}) {
    _navigationService.navigateToScheduleView(
        userInfo: tabIndex == 2 ? assignedLeadsList[index] : leadsList[index]);
  }

  //Go to schedule follow up screen
  void goToFollowUpScreen(leadId) {
    _navigationService.navigateToFollowUpDetailView(leadId: leadId);
  }

  //Show Change lead Bottomsheet
  void showChangeLeadBottomSheet({leadId, status}) async {
    var res = await _bottomSheetService.showCustomSheet(
        variant: BottomSheetType.changeLeadStage,
        isScrollControlled: true,
        data: {'leadId': leadId, 'status': status});
    if (res != null) {
      apiCallByIndex();
    }
  }

  //Show assign lead Bottomsheet
  showAssignLeadBottomSheet({leadId, assignedTo}) async {
    var res = await _bottomSheetService.showCustomSheet(
        variant: BottomSheetType.assignLead,
        isScrollControlled: true,
        data: {'leadId': leadId, 'assignTo': assignedTo});
    if (res != null) {
      apiCallByIndex();
    }
  }

  //Date picker bottomsheet
  String date = DateFormat('yyyy-MM-dd').format(DateTime.now());
  void showDatePickerBottomSheet({isEdit = false}) async {
    var res = await _bottomSheetService.showCustomSheet(
        isScrollControlled: true,
        variant: BottomSheetType.datePicker,
        title: date,
        description: isEdit ? null : 'true');
    if (res?.data != null) {
      date = res!.data;
    }
    notifyListeners();
  }

  //Time picker bottom sheet
  String fromTime = DateFormat("h:mma").format(DateTime.now());
  String toTime = DateFormat("h:mma")
      .format(DateTime.now().add(const Duration(minutes: 30)));
  void showTimePickerBottomSheet(isFrom, {isEdit}) async {
    var res = await _bottomSheetService.showCustomSheet(
        isScrollControlled: true,
        variant: BottomSheetType.timePicker,
        title: isFrom ? fromTime.split(':').first : toTime.split(':').first,
        description: isFrom
            ? isEdit
                ? fromTime.split(':').last
                : fromTime.split(':').last.substring(0, 2)
            : isEdit
                ? toTime.split(':').last
                : toTime.split(':').last.substring(0, 2));
    if (res?.data != null) {
      isFrom
          ? fromTime = DateFormat("hh:mm a").format(
              DateFormat("HH:mm").parse(res!.data.toString().substring(0, 4)))
          : toTime = DateFormat("hh:mm a").format(
              DateFormat("HH:mm").parse(res!.data.toString().substring(0, 4)));
    }
    notifyListeners();
  }

  //Change notify
  bool notifyMe = true;
  bool notifyClient = true;
  void changeNotify(name) {
    name == 'Notify Me' ? notifyMe = !notifyMe : notifyClient = !notifyClient;
    notifyListeners();
  }

  //Increment or decrement counter
  int notifyMeCounter = 15;
  int notifyClientCounter = 30;
  void changeCounterValue(String name, bool isIncrement) {
    isIncrement
        ? name == 'Notify Me'
            ? notifyMeCounter = ++notifyMeCounter
            : notifyClientCounter = ++notifyClientCounter
        : name == 'Notify Me'
            ? notifyMeCounter > 0
                ? notifyMeCounter = --notifyMeCounter
                : notifyMeCounter = notifyMeCounter
            : notifyClientCounter > 0
                ? notifyClientCounter = --notifyClientCounter
                : notifyClientCounter = notifyClientCounter;
    notifyListeners();
  }

  //Select Tab
  String selectedTab = 'All';
  String callRecordSelectedTab = 'All';
  void selectTab(name, index, leadId) {
    currentPage = 1;
    followUpStatusId = index;
    if (index != -1) {
      followUpStatusId =
          followupStatusForSearchList[index]['followup_status_id'];
    }
    getFollowupsByLeadId(leadId,
        isBusy: true, followStatuId: index == -1 ? null : followUpStatusId);
    followUpList.clear();
    selectedTab = name;
    notifyListeners();
  }

  void callRecordSelectTab(name, leadId) {
    leadDetailsList.clear();
    callRecordSelectedTab = name;
    currentPage = 1;
    name == 'All'
        ? getListOfCallRecordsByFollowUpId(leadId: leadId)
        : getListOfCallRecordsByFollowUpId(leadId: leadId, search: name);
    notifyListeners();
  }

  //Show FOLLOW UP FILTER Bottomsheet
  void showFollowUpFilter(leadId) async {
    var res = await _bottomSheetService.showCustomSheet(
        variant: BottomSheetType.followUpFilter,
        isScrollControlled: true,
        data: leadId);
    if (res != null) {
      currentPage = 1;
      followUpList.clear();
      followUpTypeSearchIds = followUpTypelist
          .where((element) => element['isSelected'] == true)
          .map((e) => e['id'])
          .toList()
          .join(',');
      if (res.confirmed == true) {
        getFollowupsByLeadId(res.data,
            isBusy: true,
            followTypeSearch: followUpTypeSearchIds,
            followStatuId: followUpStatusId == -1 ? null : followUpStatusId);
      } else {
        getFollowupsByLeadId(res.data, isBusy: false);
      }
    }
    notifyListeners();
  }

  //Show ALL LEADS FILTER Bottomsheet
  String projectIdStringArray = '';
  String userIdStringArray = '';
  String cpIdStringArray = '';
  void showAllLeadsFilter() async {
    var res = await _bottomSheetService.showCustomSheet(
        variant: BottomSheetType.filter,
        isScrollControlled: true,
        data: {
          'selectedUser': selectedUserList,
          'selectedProject': selectedProjectList,
          'tabIndex': tabIndex,
          'userType': sharedService.isCp
        });
    if (res != null) {
      if (res.confirmed == false) {
        clearFilter();
        return;
      }
      userIdStringArray =
          res.data['userList'].map((item) => item['id']).toList().join(",");
      projectIdStringArray =
          res.data['projectList'].map((item) => item['id']).toList().join(",");
      isAssigned = res.data['assigned'].toString();
      cpIdStringArray =
          res.data['cpList'].map((item) => item['id']).toList().join(",");
      if (tabIndex != 2) {
        leadsList.clear();
        viewLeadsBySourceData.clear();
        getViewLeadsBySource(
            isBusy: true,
            isUnassigned: isAssigned == ''
                ? null
                : isAssigned == 'Assigned'
                    ? 0
                    : 1,
            pageIndex: 1,
            userTypeId: tabIndex == 1 ? 2 : 1,
            leadId: leadStageId,
            projectId: projectIdStringArray == '' ? null : projectIdStringArray,
            userId: userIdStringArray == '' && tabIndex == 1
                ? null
                : userIdStringArray,
            cpIds: sharedService.isCp == false && tabIndex == 1
                ? cpIdStringArray
                : null);
      } else {
        assignedLeadsMap.clear();
        assignedLeadsList.clear();
        getAssignedLeads(
            isbusy: true,
            pageNo: 1,
            leadStageId: 0,
            projectId:
                projectIdStringArray.isNotEmpty ? projectIdStringArray : null);
      }
    }
    notifyListeners();
  }

  //Show FOLLOW UP FILTER Bottomsheet
  void showHistory() {
    _bottomSheetService.showCustomSheet(
        variant: BottomSheetType.history, isScrollControlled: true);
  }

  //Show normal call icon
  showNormalCallIcon() {
    if (sharedService.userId == 1) {
      return tabIndex == 1
          ? false
          : tabIndex == 0
              ? sharedService.isShowNormalCallForDST
              : sharedService.isShowNormalCallForMyLead;
    } else if (sharedService.userId == 2) {
      return sharedService.isShowNormalCallForMyLead;
    }
  }

  //Show normal call icon
  showCloudCallIcon() {
    if (sharedService.userId == 1) {
      return tabIndex == 1
          ? false
          : tabIndex == 0
              ? sharedService.isShowCloudCallForDST
              : sharedService.isShowCloudCallDSTForMyLead;
    } else {
      return false;
    }
  }

  isEditable(index) {
    return !['Lost', 'Sold'].contains((searchValue == null || searchValue == '')
            ? tabIndex == 2
                ? assignedLeadsList[index].status
                : leadsList[index].status
            : tabIndex == 2
                ? assignedLeadsMap['entity_list'][index]['lead_stage_name']
                : viewLeadsBySourceData['entity_list'][index]
                    ['lead_stage_name'])
        ? showEditLeadStageIcon() &&
            ![
              'Lost',
              'Sold'
            ].contains((searchValue == null || searchValue == '')
                ? tabIndex == 2
                    ? assignedLeadsList[index].status
                    : leadsList[index].status
                : tabIndex == 2
                    ? assignedLeadsMap['entity_list'][index]['lead_stage_name']
                    : viewLeadsBySourceData['entity_list'][index]
                        ['lead_stage_name']) &&
            ((searchValue == null || searchValue == '')
                    ? tabIndex == 2
                        ? assignedLeadsList[index].assignedTo
                        : leadsList[index].assignedTo
                    : tabIndex == 2
                        ? assignedLeadsMap['entity_list'][index]['assigned_to']
                        : viewLeadsBySourceData['entity_list'][index]
                            ['assigned_to']) !=
                0
        : showEditLeadStageIconForLostSold();
  }

  showEditLeadStageIcon() {
    if (tabIndex == 1) {
      return false;
    } else {
      if (sharedService.isEditLeadStageForDST!) {
        return sharedService.isEditLeadStageForDST;
      }
    }
  }

  showEditLeadStageIconForLostSold() {
    if (tabIndex == 1) {
      return false;
    } else {
      if (tabIndex == 2) {
        return sharedService.isEditLeadStageForSoldLost;
      } else {
        return sharedService.isEditLeadStageForSoldLost;
      }
    }
  }

  //Select or Unselect in  follow up filter bottomsheet
  void chooseAndClearFollowUpFilter({index, isClear, leadId}) {
    if (index != null) {
      followUpTypelist[index]['isSelected'] =
          !followUpTypelist[index]['isSelected'];
    }
    if (isClear != null) {
      for (var item in followUpTypelist) {
        item['isSelected'] = false;
      }
      selectedTab = 'All';
      followUpStatusId = -1;
      currentPage = 1;
      followUpTypeSearchIds = '';
      getFollowupsByLeadId(leadId);
    }
    notifyListeners();
  }

  //count selected buttons
  int countSelected() {
    return followUpTypelist
        .where((value) => value['isSelected'] == true)
        .length;
  }

  //Show UPDATE FOLLOW UP bottom sheet
  void updateFollowUpBottomSheet(int followUpId) {
    _bottomSheetService.showCustomSheet(
        variant: BottomSheetType.updateFollowUp,
        isScrollControlled: true,
        data: followUpId);
  }

  String selectedOutcome = '';
  void selectOutcome(value) {
    selectedOutcome = value;
    notifyListeners();
  }

  onNotifyMeValueChange(String value) {
    notifyMeValue = value;
    notifyListeners();
  }

  onNotifyClientValueChange(String value) {
    notifyClientValue = value;
    notifyListeners();
  }

  initialLead() async {
    if (sharedService.isShowDSTTab!) {
      tabIndex = 0;
    } else if (sharedService.isShowCPTab! ||
        sharedService.isShowCPTabForCPUser!) {
      tabIndex = 1;
    } else if (sharedService.isShowMyLeads!) {
      tabIndex = 2;
    }
    onReachEndPage();
    if (sharedService.userId == 2) {
      await getCpId();
    }
    getUserListForLeadFilter();
    // tabIndex = 0;
    selectedProjectList.clear();
    selectedUserList.clear();
    selectedCpIdsList.clear();
    isAssigned = '';
    projectIdStringArray = '';
    userIdStringArray = '';
    cpIdStringArray = '';
    getViewLeadsBySource(isBusy: true);
    getLeadCurrentStages();
    activeChannelPartnersList();
    projectList.clear();
    userList.clear();
    channelPartnersList.clear();
    notifyListeners();
  }

  int cpId = 0;
  Future<void> getCpId() async {
    cpId = await SharedPreferences.getInstance()
        .then((value) => value.getInt('channel_partner_id')!);
  }

  String formatDate(date) {
    final inputFormat = DateFormat("yyyy-MM-ddTHH:mm:ss");
    final outputFormat = DateFormat("d MMM y");
    final parsedDate = inputFormat.parse(date);
    return outputFormat.format(parsedDate);
  }

  void onChangeTab(index) {
    for (int i = 0; i < selectedUserList.length; i++) {
      userList.insert(selectedUserList[i]['index'], selectedUserList[i]);
    }
    for (int i = 0; i < selectedCpIdsList.length; i++) {
      channelPartnersList.insert(
          selectedCpIdsList[i]['index'], selectedCpIdsList[i]);
    }
    for (int i = 0; i < selectedProjectList.length; i++) {
      projectList.insert(
          selectedProjectList[i]['index'], selectedProjectList[i]);
    }
    for (int i = 0; i < selectedProjectList.length; i++) {
      projectList[selectedProjectList[i]['index']] = selectedProjectList[i];
    }
    currentPage = 1;
    leadStageId = 0;
    searchValue = null;
    searchCtrl.clear();
    choosedFiter = 'All';
    leadsList.clear();
    viewLeadsBySourceData.clear();
    userIdStringArray = '';
    isAssigned = '';
    projectIdStringArray = '';
    cpIdStringArray = '';
    selectedCpIdsList.clear();
    selectedProjectList.clear();
    selectedUserList.clear();
    assignedLeadsList.clear();
    assignedLeadsMap.clear();
    selectedProjectList.clear();
    if (sharedService.userId == 2) {
      tabIndex = index + 1;
    } else {
      tabIndex = index;
    }
    if (sharedService.userId == 2) {
      index == 0
          ? getViewLeadsBySource(
              userTypeId: cpId,
              pageIndex: 1,
              leadId: 0,
              isBusy: true,
              projectId:
                  projectIdStringArray.isNotEmpty ? projectIdStringArray : null,
              userId: userIdStringArray.isNotEmpty ? userIdStringArray : null)
          : getAssignedLeads(
              isbusy: true,
              pageNo: 1,
              projectId: projectIdStringArray.isNotEmpty
                  ? projectIdStringArray
                  : null);
    } else {
      tabIndex == 0
          ? getViewLeadsBySource(
              userTypeId: 1,
              pageIndex: 1,
              leadId: 0,
              isBusy: true,
              projectId:
                  projectIdStringArray.isNotEmpty ? projectIdStringArray : null,
              userId: userIdStringArray.isNotEmpty ? userIdStringArray : null)
          : tabIndex == 1
              ? getViewLeadsBySource(
                  userTypeId: 2,
                  pageIndex: 1,
                  isBusy: true,
                  leadId: 0,
                  projectId: projectIdStringArray.isNotEmpty
                      ? projectIdStringArray
                      : null,
                  userId:
                      userIdStringArray.isNotEmpty ? userIdStringArray : null)
              : getAssignedLeads(
                  pageNo: 1,
                  isbusy: true,
                  leadStageId: 0,
                  projectId: projectIdStringArray.isNotEmpty
                      ? projectIdStringArray
                      : null);
    }
    notifyListeners();
  }

  Future<void> apiCallByIndex() async {
    leadsList.clear();
    searchValue = null;
    viewLeadsBySourceData.clear();
    assignedLeadsList.clear();
    searchCtrl.clear();
    assignedLeadsMap.clear();
    currentPage = 1;
    tabIndex == 0
        ? getViewLeadsBySource(
            userTypeId: 1, leadId: 0, pageIndex: 1, isBusy: true)
        : tabIndex == 1
            ? getViewLeadsBySource(
                userTypeId: 2, leadId: 0, pageIndex: 1, isBusy: true)
            : getAssignedLeads(leadStageId: 0, pageNo: 1, isbusy: true);
    notifyListeners();
  }

  bool isUserListHide = true;
  bool isProjectListHide = true;
  void showHideLis(isUserList) {
    if (isUserList) {
      isUserListHide = !isUserListHide;
      isProjectListHide = true;
    } else {
      isProjectListHide = !isProjectListHide;
      isUserListHide = true;
    }
    notifyListeners();
  }

  void addUserToList(index, isUserList) {
    if (isUserList) {
      if (tabIndex == 1) {
        selectedCpIdsList.add(channelPartnersList[index]);
        channelPartnersList.removeAt(index);
      } else {
        selectedUserList.add(userList[index]);
        userList.removeAt(index);
      }
      isUserListHide = true;
    } else {
      selectedProjectList.add(projectList[index]);
      projectList.removeAt(index);
      isProjectListHide = true;
    }
    notifyListeners();
  }

  void removeFromSelectedList(index, isUserList) {
    if (isUserList) {
      if (!sharedService.isCp!) {
        channelPartnersList.insert(
            selectedCpIdsList[index]['index'], selectedCpIdsList[index]);
        selectedCpIdsList.removeAt(index);
      } else {
        userList.insert(
            selectedUserList[index]['index'], selectedUserList[index]);
        selectedUserList.removeAt(index);
      }
    } else {
      projectList.insert(
          selectedProjectList[index]['index'], selectedProjectList[index]);
      selectedProjectList.removeAt(index);
    }
    isUserListHide = true;
    isProjectListHide = true;
    notifyListeners();
  }

  void changeStatus(value) {
    isAssigned = value;
    notifyListeners();
  }

  void clearFilter() {
    for (int i = 0; i < selectedProjectList.length; i++) {
      projectList.insert(
          selectedProjectList[i]['index'], selectedProjectList[i]);
    }
    for (int i = 0; i < selectedUserList.length; i++) {
      userList.insert(selectedUserList[i]['index'], selectedUserList[i]);
    }
    for (int i = 0; i < selectedCpIdsList.length; i++) {
      channelPartnersList.insert(
          selectedCpIdsList[i]['index'], selectedCpIdsList[i]);
    }
    choosedFiter = 'All';
    selectedProjectList.clear();
    selectedUserList.clear();
    selectedCpIdsList.clear();
    leadsList.clear();
    viewLeadsBySourceData.clear();
    assignedLeadsMap.clear();
    assignedLeadsList.clear();
    isAssigned = '';
    projectIdStringArray = '';
    userIdStringArray = '';
    cpIdStringArray = '';
    apiCallByIndex();
    notifyListeners();
  }

  void onCallCloudIconTap({name, leadId, phoneNumber}) async {
    var res = await _dialogService.showCustomDialog(
        variant: DialogType.confirm,
        title: name,
        data: {'leadId': leadId, 'phoneNumber': phoneNumber});
    if (res != null) {
      if (res.confirmed) {
        if (res.data['leadId'] == null) {
          onCallIcontap(phoneNumber: res.data['phoneNumber']);
        } else {
          connectToCloudCall(
              leadId: res.data['leadId'], phoneNumber: res.data['phoneNumber']);
        }
      }
    }
  }

  void goToSchedulePageForUpdate(index) {
    _navigationService.navigateToScheduleView(
        userInfo: LeadsModel(
            backgroundColor: Color(int.parse(
                '0XFF${followUpMap['lead_info']['color_code_1'].toString().split('#').last}')),
            borderColor: Color(int.parse(
                '0XFF${followUpMap['lead_info']['color_code_2'].toString().split('#').last}')),
            date: followUpMap['lead_info']['createdts'],
            location: List.generate(
                    followUpMap['lead_info']['project_name'].length,
                    (index) => followUpMap['lead_info']['project_name'][index])
                .join(',')
                .toString(),
            personName: followUpMap['lead_info']['lead_name'] ?? '',
            followUpId: followUpMap['lead_info']['followupDetails'][index]
                ['followup_id'],
            assignedToName: '',
            status: followUpMap['lead_info']['lead_stage_name']));
  }

  void onCallIcontap({phoneNumber}) async {
    Uri url = Uri(scheme: "tel", path: phoneNumber.toString());
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      log("Can't open dial pad.");
    }
  }

  void onReachEndPage() {
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
              scrollController.offset &&
          searchValue == null &&
          searchCtrl.text.isEmpty) {
        if (isDataLoading) return;
        if (tabIndex == 2) {
          getAssignedLeads();
        } else {
          getViewLeadsBySource(
              userTypeId: tabIndex == 1 ? 2 : 1,
              leadId: leadStageId,
              userId: userIdStringArray.isEmpty ? null : userIdStringArray,
              projectId:
                  projectIdStringArray.isEmpty ? null : projectIdStringArray);
        }
      }
    });
    notifyListeners();
  }

  void resetSchedule() {
    selectedFollowTypeIndex = -1;
    date = DateFormat('yyyy-MM-dd').format(DateTime.now());
    fromTime = DateFormat("h:mma").format(DateTime.now());
    toTime = DateFormat("h:mma")
        .format(DateTime.now().add(const Duration(minutes: 30)));
    notifyMe = true;
    notifyClient = true;
    notifyMeValue = '';
    notifyClientValue = '';
    remarkScheduleValue = '';
    notifyListeners();
  }

  bool isFilterApplied() {
    if (userIdStringArray.isEmpty &&
        isAssigned.isEmpty &&
        projectIdStringArray.isEmpty &&
        cpIdStringArray.isEmpty) {
      return false;
    }
    return true;
  }

  bool canUpdate(time) {
    if (DateTime.parse(time).isBefore(DateTime.now())) {
      return false;
    }
    return true;
  }

  void sendMail({emailId}) async {
    final Uri emailLaunchUri = Uri(scheme: 'mailto', path: emailId);
    if (await canLaunchUrl(emailLaunchUri)) {
      await launchUrl(emailLaunchUri);
    } else {
      log("Can't launch mail");
    }
  }

  bool isFollupUpFilterApplied() {
    if (followUpTypeSearchIds.isNotEmpty) {
      return true;
    }
    return false;
  }

  //////////////////////////////////////////////////////////////////////////////////////Api's Work////////////////////////////////////////////////////////////////////////////////////////////
  final _leadService = locator<LeadService>();
  final snackBarService = locator<SnackbarService>();

  Map viewLeadsBySourceData = {};
  int currentPage = 1;
  int leadStageId = 0;
  List<LeadsModel> leadsList = [];
  bool isDataLoading = false;

  Future<void> getViewLeadsBySource(
      {userTypeId,
      pageIndex,
      leadId,
      search,
      isUnassigned,
      projectId,
      userId,
      isBusy = false,
      cpIds}) async {
    isDataLoading = true;
    setBusy(isBusy);
    try {
      var res = await _leadService.getViewLeadsBySource(
          userTypeId: sharedService.userId == 2 ? cpId : userTypeId ?? 1,
          pageNo: pageIndex ?? currentPage,
          leadStageId: leadId ?? leadStageId,
          search: search,
          isUnassigned: isUnassigned,
          projectId: projectId,
          userId: userId,
          cpId: cpIds);
      viewLeadsBySourceData = res.data['data'];
      for (var i = 0; i < viewLeadsBySourceData['entity_list'].length; i++) {
        leadsList.add(LeadsModel(
            cpName: viewLeadsBySourceData['entity_list'][i]
                ['channel_partner_name'],
            assignedTo: viewLeadsBySourceData['entity_list'][i]['assigned_to'],
            leadId: viewLeadsBySourceData['entity_list'][i]['lead_id'] ?? 0,
            backgroundColor: Color(int.parse(
                '0XFF${viewLeadsBySourceData['entity_list'][i]['color_code_1'].toString().split('#').last != 'null' ? viewLeadsBySourceData['entity_list'][i]['color_code_1'].toString().split('#').last : 'FFFFFF'}')),
            borderColor: Color(int.parse(
                '0XFF${viewLeadsBySourceData['entity_list'][i]['color_code_2'].toString().split('#').last != 'null' ? viewLeadsBySourceData['entity_list'][i]['color_code_2'].toString().split('#').last : '000000'}')),
            assignedToName: viewLeadsBySourceData['entity_list'][i]
                    ['assigned_to_name'] ??
                '',
            date: formatDate(viewLeadsBySourceData['entity_list'][i]
                    ['stage_updated_ts'] ??
                DateTime.now()),
            location: viewLeadsBySourceData['entity_list'][i]['project_name'][0] ??
                '',
            clientVisitDate: viewLeadsBySourceData['entity_list'][i]
                    ['immediate_followup'] ??
                '',
            visitDate: viewLeadsBySourceData['entity_list'][i]['siteVisited'] ??
                'Site not yet visited',
            personName: viewLeadsBySourceData['entity_list'][i]['lead_name'] ?? '',
            phoneNumber: viewLeadsBySourceData['entity_list'][i]['mobile_number'] ?? '',
            leadAge: viewLeadsBySourceData['entity_list'][i]['lead_age'].toString(),
            nextFollowUp: viewLeadsBySourceData['entity_list'][i]['immediate_followup'],
            isEditable: true,
            status: viewLeadsBySourceData['entity_list'][i]['lead_stage_name'] ?? '',
            isLockIconShow: viewLeadsBySourceData['entity_list'][i]['is_disqualified'] == false && viewLeadsBySourceData['entity_list'][i]['lock_status'] == true ? true : false,
            isHandLockIconShow: viewLeadsBySourceData['entity_list'][i]['is_disqualified'] == true && viewLeadsBySourceData['entity_list'][i]['lock_status'] == false ? true : false));
      }
      currentPage++;
      notifyListeners();
    } on Error catch (e) {
      log('viewLeadsBySource error = $e');
    } finally {
      setBusy(false);
      isDataLoading = false;
    }
  }

  List<FilterModel> filterCategoryList = [
    FilterModel(
        leadStageId: 0,
        color: allBorderColor,
        selectedColor: allSelected,
        textColor: siteVisitCount,
        title: 'All'),
  ];
  void getLeadCurrentStages() async {
    try {
      var res = await _leadService.getLeadCurrentStages();
      for (var i = 0; i < res.data['data']['entity_list'].length; i++) {
        changeLeadStatus.add(OptionItem(
            title:
                res.data['data']['entity_list'][i]['lead_stage_name'] ?? ''));
        filterCategoryList.add(FilterModel(
            leadStageId: res.data['data']['entity_list'][i]
                ['lead_stage_lookup_id'],
            color: Color(int.parse(
                '0XFF${res.data['data']['entity_list'][i]['color_code_2'].toString().split('#').last}')),
            selectedColor: Color(int.parse(
                '0XFF${res.data['data']['entity_list'][i]['color_code_1'].toString().split('#').last}')),
            textColor: Color(int.parse(
                '0XFF${res.data['data']['entity_list'][i]['color_code_2'].toString().split('#').last}')),
            title: res.data['data']['entity_list'][i]['lead_stage_name']));
      }
      notifyListeners();
    } on Error catch (e) {
      log('GetLeadCurrentStages Error $e');
    }
  }

  Map assignedLeadsMap = {};
  List<LeadsModel> assignedLeadsList = [];
  Future<void> getAssignedLeads(
      {leadStageId, pageNo, search, projectId, isbusy = false}) async {
    try {
      setBusy(isbusy);
      var res = await _leadService.getAssignedLeads(
          leadStageId: leadStageId,
          pageNo: pageNo ?? currentPage,
          search: search,
          projectId: projectId);
      assignedLeadsMap = res.data['data'];
      for (var i = 0; i < assignedLeadsMap['entity_list'].length; i++) {
        assignedLeadsList.add(LeadsModel(
            assignedTo: assignedLeadsMap['entity_list'][i]['assigned_to'],
            leadId: assignedLeadsMap['entity_list'][i]['lead_id'] ?? 0,
            backgroundColor: Color(int.parse(
                '0XFF${assignedLeadsMap['entity_list'][i]['color_code_1'].toString().split('#').last}')),
            borderColor: Color(int.parse(
                '0XFF${assignedLeadsMap['entity_list'][i]['color_code_2'].toString().split('#').last}')),
            assignedToName:
                assignedLeadsMap['entity_list'][i]['assigned_to_name'] ?? '',
            date: formatDate(assignedLeadsMap['entity_list'][i]['stage_updated_ts'] ??
                DateTime.now()),
            location:
                assignedLeadsMap['entity_list'][i]['project_name'][0] ?? '',
            clientVisitDate:
                assignedLeadsMap['entity_list'][i]['immediate_followup'] ?? '',
            visitDate: assignedLeadsMap['entity_list'][i]['siteVisited'] ??
                'Site not yet visited',
            personName: assignedLeadsMap['entity_list'][i]['lead_name'] ?? '',
            isEditable: true,
            phoneNumber:
                assignedLeadsMap['entity_list'][i]['mobile_number'] ?? 0,
            isLockIconShow: assignedLeadsMap['entity_list'][i]['is_disqualified'] == false &&
                    assignedLeadsMap['entity_list'][i]['lock_status'] == true
                ? true
                : false,
            isHandLockIconShow: assignedLeadsMap['entity_list'][i]['is_disqualified'] == true && assignedLeadsMap['entity_list'][i]['lock_status'] == false ? true : false,
            status: assignedLeadsMap['entity_list'][i]['lead_stage_name'] ?? ''));
      }
      currentPage++;
      notifyListeners();
    } on Error catch (e) {
      log('GetAssignedLeads error = $e');
    } finally {
      setBusy(false);
    }
  }

  Map assignLeadData = {};
  List assignToIdList = [];
  void getActiveDSTListByLeadId(leadId) async {
    setBusy(true);
    try {
      var res = await _leadService.getActiveDSTListByLeadId(leadId);
      assignLeadData = res.data['data'];
      for (var i = 0; i < assignLeadData['userDetails'].length; i++) {
        assignToIdList.add(assignLeadData['userDetails'][i]['user_id']);
        assignToUserList
            .add(OptionItem(title: assignLeadData['userDetails'][i]['name']));
      }
      notifyListeners();
    } on Error catch (e) {
      log('getActiveDSTListByLeadId error=$e');
    } finally {
      setBusy(false);
    }
  }

  Future<void> assignLead({leadId, assignToId, remark}) async {
    FormData formData = FormData.fromMap({
      'lead_id': leadId,
      'assigned_to_id': assignToId,
      'lead_assignment_remarks': remark
    });
    try {
      await _leadService
          .leadAssignment(formData)
          .then((value) => log('${value.data['message']}'));
    } on Error catch (e) {
      log('leadAssignment error=$e');
    }
  }

  Future<void> leadStageUpdate({leadId, assignToId, remark}) async {
    FormData formData = FormData.fromMap(
        {'lead_id': leadId, 'lead_stage_id': assignToId, 'remarks': remark});
    try {
      await _leadService
          .leadStageUpdate(formData)
          .then((value) => log('${value.data['message']}'));
    } on Error catch (e) {
      log('leadAssignment error=$e');
    }
  }

  void getUserListForLeadFilter() async {
    getActiveProjectsForFilter();
    setBusy(true);
    try {
      var res = await _leadService.getUserListForLeadFilter();
      for (var i = 0; i < res.data['data'].length; i++) {
        userList.add({
          'id': res.data['data'][i]['user_id'] ?? 0,
          'name': res.data['data'][i]['name'] ?? '',
          'index': i
        });
        notifyListeners();
      }
    } on Error catch (e) {
      log('getUserListForLeadFilterr=$e');
    } finally {
      setBusy(false);
    }
  }

  void getActiveProjectsForFilter() async {
    try {
      var res = await _leadService.getActiveProjectsForFilter();
      for (var i = 0; i < res.data['data']['project_list'].length; i++) {
        projectList.add({
          'id': res.data['data']['project_list'][i]['project_id'] ?? 0,
          'name': res.data['data']['project_list'][i]['project_name'] ?? '',
          'index': i
        });
        notifyListeners();
      }
    } on Error catch (e) {
      log('getUserListForLeadFilterr=$e');
    }
  }

  void activeChannelPartnersList() async {
    try {
      var res = await _leadService.activeChannelPartnersList();
      for (var i = 0; i < res.data['data'].length; i++) {
        channelPartnersList.add({
          'id': res.data['data'][i]['channel_partner_id'] ?? 0,
          'name': res.data['data'][i]['channel_partner_name'] ?? '',
          'index': i
        });
        notifyListeners();
      }
    } on Error catch (e) {
      log('activeChannelPartnersList=$e');
    }
  }

  final _allRecordService = locator<CallRecordService>();
  void connectToCloudCall({leadId, phoneNumber}) async {
    try {
      await _allRecordService
          .connectToCloudCall(leadId: leadId, toNumber: phoneNumber)
          .then((value) {
        if (!value.data['data']['isSuccess']) {
          _dialogService.showCustomDialog(
              variant: DialogType.deactive,
              title: 'Sales Lead',
              description: value.data['message'],
              mainButtonTitle: "OK",
              secondaryButtonTitle: '',
              barrierDismissible: true,
              imageUrl: Images().infoAlert);
        }
      });
    } on Error catch (e) {
      log('connectToCloudCall error =$e');
    }
  }

  ///////////////////////////////////////////////////////////////////////////////////Schedule Api's////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  initSchedule(followUpId) async {
    followUpTypelist.clear();
    await getFollowupTypes();
    if (followUpId != null) {
      getFollowupById(followUpId: followUpId);
    }
    notifyListeners();
  }

  void selectFollowUpType(index) {
    selectedFollowTypeIndex = index;
    notifyListeners();
  }

  int selectedFollowTypeIndex = -1;
  String notifyMeValue = '';
  String notifyClientValue = '';
  List<String> notifyValueList = [];
  Future<void> getFollowupTypes() async {
    setBusy(true);
    try {
      var res = await _leadService.getFollowupTypes();
      var response = await _leadService.getFollowupTimeUnits();
      for (int i = 0; i < res.data['data']['followup_types'].length; i++) {
        followUpTypelist.add({
          'id': res.data['data']['followup_types'][i]['followup_type_id'] ?? '',
          'name':
              res.data['data']['followup_types'][i]['followup_type_name'] ?? '',
          'isSelected': false
        });
      }
      for (int i = 0; i < response.data['data']['time_units'].length; i++) {
        notifyMeValue = response.data['data']['time_units'][0]
                ['followups_time_units_name'] ??
            '';
        notifyClientValue = response.data['data']['time_units'][0]
                ['followups_time_units_name'] ??
            '';
        notifyValueList.add(response.data['data']['time_units'][i]
                ['followups_time_units_name'] ??
            '');
      }
      notifyListeners();
    } on Error catch (e) {
      log('getFollowupTypes=$e');
    } finally {
      setBusy(false);
    }
  }

  void scheduleFollowup({leadId, remark}) async {
    FormData formData = FormData.fromMap({
      'lead_id': leadId,
      'followup_type_id': selectedFollowTypeIndex == -1
          ? null
          : followUpTypelist[selectedFollowTypeIndex]['id'],
      'followup_date': date,
      'followup_time_from':
          DateFormat("hh:mm a").format(DateFormat("HH:mm").parse(fromTime)),
      'followup_time_to':
          DateFormat("hh:mm a").format(DateFormat("HH:mm").parse(toTime)),
      'notify_me_flag': notifyMe ? 1 : 0,
      'notify_me_duration': notifyMeCounter,
      'notify_me_time_type': notifyMeValue == 'Minutes before'
          ? 1
          : notifyMeValue == 'Hours before'
              ? 2
              : 3,
      'notify_client_flag': notifyClient ? 1 : 0,
      'notify_client_duration': notifyClientCounter,
      'notify_client_time_type': notifyClientValue == 'Minutes before'
          ? 1
          : notifyClientValue == 'Hours before'
              ? 2
              : 3,
      'created_remarks': remark,
      'created_remarks_audio_file': null
    });
    try {
      await _leadService.scheduleFollowup(formData).then((value) {
        if (value.data['code'] == 200) {
          _navigationService.back();
          _snackBarService.showCustomSnackBar(
              variant: SnackbarType.success,
              message: value.data['message'].toString(),
              duration: const Duration(seconds: 1));
        } else if (value.data['status'] == 'Error') {
          _dialogService.showCustomDialog(
              title: value.data['status'],
              variant: DialogType.infoAlert,
              data: value.data['message'].toString());
        }
      });
    } on Error catch (e) {
      log('scheduleFollowup=$e');
    }
  }

  void getFollowupById({followUpId}) async {
    setBusy(true);
    try {
      var res = await _leadService.getFollowupById(followUpId);
      var data = res.data['data']['followup_detail'];
      selectedFollowTypeIndex = int.parse(data['followup_type_id']) - 1;
      date = data['followup_date'].toString().split('T').first;
      fromTime = data['followup_time_from'].toString().split(' ').first;
      toTime = data['followup_time_to'].toString().split(' ').first;
      notifyMe = data['notify_me_flag'] == 1;
      notifyClient = data['notify_client_flag'] == 1;
      notifyMeValue = notifyValueList[data['notify_me_time_type'] - 1];
      notifyClientValue = notifyValueList[data['notify_client_time_type'] - 1];
      notifyMeCounter = data['notify_me_duration'];
      notifyClientCounter = data['notify_client_duration'];
      remarkScheduleValue = data['created_remarks'] ?? '';
      notifyListeners();
    } on Error catch (e) {
      log('getFollowupById error= $e');
    } finally {
      setBusy(false);
    }
  }

  void editFollowUp({followUpId, leadId, remark}) async {
    FormData formData = FormData.fromMap({
      'followup_id': followUpId,
      'lead_id': leadId,
      'followup_type_id': selectedFollowTypeIndex == -1
          ? null
          : followUpTypelist[selectedFollowTypeIndex]['id'],
      'followup_date': date,
      'followup_time_from':
          DateFormat("hh:mm a").format(DateFormat("HH:mm").parse(fromTime)),
      'followup_time_to':
          DateFormat("hh:mm a").format(DateFormat("HH:mm").parse(toTime)),
      'notify_me_flag': notifyMe ? 1 : 0,
      'notify_me_duration': notifyMeCounter,
      'notify_me_time_type': notifyMeValue == 'Minutes before'
          ? 1
          : notifyMeValue == 'Hours before'
              ? 2
              : 3,
      'notify_client_flag': notifyClient ? 1 : 0,
      'notify_client_duration': notifyClientCounter,
      'notify_client_time_type': notifyClientValue == 'Minutes before'
          ? 1
          : notifyClientValue == 'Hours before'
              ? 2
              : 3,
      'created_remarks': remark,
      'created_remarks_audio_file': '',
      'is_audio_deleted': '',
    });
    try {
      await _leadService.editFollowUp(formData).then((value) {
        _navigationService.back();
        if (value.data['code'] == 200) {
          _snackBarService.showCustomSnackBar(
              variant: SnackbarType.success,
              message: value.data['message'].toString(),
              duration: const Duration(seconds: 1));
        } else if (value.data['status'] == 'Error') {
          _dialogService.showCustomDialog(
              variant: DialogType.infoAlert,
              data: value.data['message'].toString());
        }
      });
    } on Error catch (e) {
      log('editFollowUp error = $e');
    }
  }

  /////////////////////////////////////////////////////////////////Follow Up api's//////////////////////////////////////////////////////////////////////////////////////////////////////////

  initFollowUp(leadId) {
    // isDataLoading = false;
    followUpTypelist.clear();
    getFollowupStatusForSearch();
    getFollowupsByLeadId(leadId, isBusy: true);
    getListOfCallRecordsByFollowUpId(leadId: leadId);
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        if (isDataLoading) return;
        getFollowupsByLeadId(leadId);
      }
    });
    currentPage = 1;
    notifyListeners();
  }

  int followUpStatusId = -1;
  String followUpTypeSearchIds = '';
  Future<void> pullToRefreshFollowUp(leadId) async {
    await getFollowupsByLeadId(leadId,
        isRefresh: true,
        isBusy: true,
        followStatuId: followUpStatusId == -1 ? null : followUpStatusId,
        followTypeSearch:
            followUpTypeSearchIds.isEmpty ? null : followUpTypeSearchIds);
    notifyListeners();
  }

  void addSchedule() {
    _navigationService.navigateToScheduleView(
        userInfo: LeadsModel(
            backgroundColor: Color(int.parse(
                '0XFF${followUpMap['lead_info']['color_code_1'].toString().split('#').last}')),
            borderColor: Color(int.parse(
                '0XFF${followUpMap['lead_info']['color_code_2'].toString().split('#').last}')),
            leadId: followUpMap['lead_info']['lead_id'],
            personName: followUpMap['lead_info']['lead_name'],
            status: followUpMap['lead_info']['lead_stage_name'],
            location: followUpMap['lead_info']['project_name'][0],
            date: followUpMap['lead_info']['createdts'],
            assignedToName: ''));
  }

  List followUpList = [];
  Map followUpMap = {};
  bool isLoading = false;
  getFollowupsByLeadId(leadId,
      {followStatuId,
      isBusy = false,
      followTypeSearch,
      isRefresh = false}) async {
    setBusy(isBusy);
    try {
      var res = await _leadService.getFollowupsByLeadId(
          leadId: leadId,
          pageNo: currentPage,
          followUpStatusId: followStatuId,
          followUpTypeSearch: followTypeSearch);
      followUpMap = res.data['data'];
      for (int i = 0;
          i < followUpMap['lead_info']['followupDetails'].length;
          i++) {
        followUpList.add(followUpMap['lead_info']['followupDetails'][i]);
      }
      currentPage++;
      if (!isRefresh) {
        getFollowupTypes();
      }
      notifyListeners();
    } on Error catch (e) {
      log('getFollowupsByLeadId=$e');
    } finally {
      setBusy(false);
    }
  }

  List followupStatusForSearchList = [];
  void getFollowupStatusForSearch() async {
    try {
      var res = await _leadService.getFollowupStatusForSearch();
      followupStatusForSearchList = res.data['data']['followup_status'];
      notifyListeners();
    } on Error catch (e) {
      log('getFollowupStatusForSearch=$e');
    }
  }

  void updateFollowUpStatus(
      {required int followUpId,
      followupOutcome,
      String? followupRemark,
      String? followUpClientFeedBack,
      String? followUpRamarkAudio}) async {
    FormData formData = FormData.fromMap({
      'followup_id': followUpId,
      'followup_outcome': followupOutcome,
      'followup_remarks': followupRemark,
      'followup_remarks_audio_file': null,
      'followup_client_feedback': followUpClientFeedBack
    });
    try {
      await _leadService.updateFollowUpStatus(formData);
    } on Error catch (e) {
      log('updateFollowUpStatus error = $e');
    }
  }

  List leadDetailsList = [];
  Map callRecordMap = {};
  bool isCallLoading = false;
  void getListOfCallRecordsByFollowUpId({leadId, search}) async {
    isCallLoading = true;
    try {
      var res = await _leadService.getListOfCallRecordsByLeadId(
          leadId: leadId, search: search, pageNo: currentPage);
      var data = res.data['data']['lead_info']['callrecorddetails'];
      callRecordMap = res.data['data'];
      leadDetailsList.addAll(data);
      currentPage++;
      notifyListeners();
    } on Error catch (e) {
      log('getListOfCallRecordsByLeadId error = $e');
    } finally {
      isCallLoading = false;
    }
  }
}
