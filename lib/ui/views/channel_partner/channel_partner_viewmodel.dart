import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sales_lead/api/api_error.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:url_launcher/url_launcher.dart';

import '/model/index.dart';
import '/services/shared_service.dart';
import '/services/cp_service.dart';
import '/ui/common/widgets/index.dart';
import '/app/app.bottomsheets.dart';
import '/app/app.locator.dart';
import '/app/app.router.dart';
import '/app/app.dialogs.dart';
import '/ui/common/index.dart';
import '/ui/bottom_sheets/remove_project/remove_project_sheet.dart';
import '/ui/bottom_sheets/assign_project_cp/assign_project_cp_sheet.dart';
import 'package:permission_handler/permission_handler.dart';

int tabIndex = 0; //tab current index
int? chId;

class ChannelPartnerViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final BottomSheetService _bottomSheetService = locator<BottomSheetService>();
  final DialogService _dialogService = locator<DialogService>();
  final SharedService sharedService = locator<SharedService>();
  // final _snackBarService = locator<SnackbarService>();
  ScrollController scrollController = ScrollController();
  bool isDataLoading = false;

  // bool accept = false; //btn value
  int getCurrentIndex() {
    return sharedService.isViewChannelPartner! ? tabIndex : tabIndex + 1;
  }

  //change Tab bar
  onChangeTab(index, TextEditingController searchController) {
    tabIndex = index;
    searchController.clear();
    currentPage = 1;
    cpList.clear();
    getCpApprovedList(searchController.text, getCurrentIndex(), isBusy: true);
    notifyListeners();
  }

//clear search values
  onClear(TextEditingController searchController) {
    searchController.clear();
    currentPage = 1;
    cpList.clear();
    getCpApprovedList(searchController.text, getCurrentIndex());
    notifyListeners();
  }

  //Go to back page
  void goBack() {
    _navigationService.back();
  }

  //card details
  void goToDetails(int chId) {
    _navigationService.navigateToChannelpartnercarddetaisView(
        showDeactive: tabIndex == 0 ? true : false, chId: chId);
  }

//channel partner approved dialog
  void channelPartnerApproved({String? searchText, int? id}) async {
    var res = await _dialogService.showCustomDialog(
        variant: DialogType.userCreate,
        title: 'Channel Partner\nSuccessfully Approved',
        description: cpDeatilsList['channel_partner_name'],
        mainButtonTitle: "ASSIGN PROJECTS",
        data: cpDeatilsList['name'],
        secondaryButtonTitle: "NOT NOW",
        barrierDismissible: true,
        imageUrl: Images().checked);
    if (res!.confirmed == true) {
      showAssignProjectSheet(id!, searchText!, null);
    }
  }

  void showDeactiveDialog(int cpId) async {
    var response = await _dialogService.showCustomDialog(
        variant: DialogType.deactive,
        title: 'Deactivate',
        description:
            'Are you sure to deactivate?\nAll leads will be allocated to \n< primary user >',
        mainButtonTitle: "Deactivate",
        secondaryButtonTitle: 'Cancel',
        barrierDismissible: true,
        imageUrl: Images().infoAlert);
    if (response!.confirmed == true) {
      onDeactive(cpId);
    }
  }

  //call now dialog
  void showCallDialog(String userName, String number) async {
    var status = await Permission.phone.request();
    if (status == PermissionStatus.granted) {
      await Permission.phone.request();
      var res = await _dialogService.showCustomDialog(
          variant: DialogType.confirm, title: userName);
      if (res!.confirmed == true) {
        onCallIcontap(phoneNumber: number);
      }
    } else {
      var res = await _dialogService.showCustomDialog(
          variant: DialogType.deactive,
          title: 'Unable to get Call access',
          description:
              'You have denied the permission for getting Call access. Please go to the App Settings and allow permission',
          mainButtonTitle: "Go to Settings",
          secondaryButtonTitle: 'Cancel',
          barrierDismissible: true,
          imageUrl: Images().infoAlert);
      if (res!.confirmed == true) {
        openAppSettings();
      }
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

  //cancel bottomsheet
  onCancel() async {
    _navigationService.back();
  }

//backdetails account bottomsheet
  void showBankAccountDetails() {
    _bottomSheetService.showCustomSheet(
        variant: BottomSheetType.showBankAccountDetails,
        isScrollControlled: true,
        data: cpDeatilsList['bankdetails']);
  }

  //backdetails account bottomsheet
  void showCurrentProjectSheet(int id) {
    chId = id;
    _bottomSheetService.showCustomSheet(
        variant: BottomSheetType.currentProject, isScrollControlled: true);
    notifyListeners();
  }

//activeusers bottomsheet
  void showActiveUsersSheet(int cpId) {
    chId = cpId;
    _bottomSheetService.showCustomSheet(
      variant: BottomSheetType.activeUsers,
      isScrollControlled: true,
      // data: cpActiveUserList
    );
  }

  //assign projects bottomsheet
  void showAssignProjectSheet(int id, String searchController, cpIndex) async {
    chId = id;
    index = cpIndex;
    var res = await _bottomSheetService.showCustomSheet(
        variant: BottomSheetType.assignProjectCp,
        isScrollControlled: true,
        data: cpList);
    if (res == null) {
      cpList.clear();
      currentPage = 1;
      await getCpApprovedList(searchController, getCurrentIndex(),
          isBusy: true);
    }

    notifyListeners();
  }

  //show remove project bottomsheet
  void showRemoveProjectSheet(int id, String user, String searchText) async {
    Map<String, dynamic> data = {
      'id': id,
      'isRemoveChannelPartner': sharedService.isRemoveChannelPartnerFromProject,
    };
    userName = user;
    chId = id;
    await _bottomSheetService.showCustomSheet(
        variant: BottomSheetType.removeProjectCp,
        isScrollControlled: true,
        data: data);
    cpList.clear();
    currentPage = 1;
    getCpApprovedList(searchText, getCurrentIndex());
    notifyListeners();
  }

  //show remove from  project bottomsheet
  void showRemoveProjectDetails(BuildContext context, int index) async {
    var res = await _bottomSheetService.showCustomSheet(
        variant: BottomSheetType.removeProject,
        isScrollControlled: true,
        data: projectListForRemove[index]);
    if (res!.confirmed == true) {
      await getProjectsForRemove(chId!);
    }
    notifyListeners();
  }

////Remove from project bottomsheet buttons////////
  //selected index
  int selectedIndex = 2;
  //change selected container
  onSelect(index) {
    selectedIndex = index;
    notifyListeners();
  }

//user initial value
  OptionItem entityUser = OptionItem(title: "Select a user");
  //leads user list
  List<OptionItem> entityLeadsUSerList = [];
// leads user dropdown value change notifier
  onLeadsUSerChange(OptionItem value, index) {
    entityUser = entityLeadsUSerList[index];
    notifyListeners();
  }

  //toggle current projects
  bool currentProjectSwitch = true;
  onToggleSwitch() {
    currentProjectSwitch = !currentProjectSwitch;
    getCpCurrentProjectList(chId!, false);
    notifyListeners();
  }

  //toggle active users
  bool activeUsersSwitch = true;
  onActiveUsersSwitch() async {
    activeUsersSwitch = !activeUsersSwitch;
    await getCpActiveUsers(chId!, false);
    notifyListeners();
  }

//on change search controller
  onChangeSearch(TextEditingController searchController) {
    if (searchController.text.length > 2 || searchController.text.isEmpty) {
      cpList.clear();
      currentPage = 1;
      getCpApprovedList(searchController.text, getCurrentIndex());
      notifyListeners();
    }
  }

  //pagination
  void onReachEndPage(TextEditingController searchController) {
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        if (isDataLoading) return;
        if (currentPage < calculateTotalPages(totalRecord)) {
          currentPage++;

          getCpApprovedList(searchController.text, getCurrentIndex());
        }
      }
    });
    notifyListeners();
  }

  int calculateTotalPages(int totalRecords, {int itemsPerPage = 25}) {
    return (totalRecords / itemsPerPage).ceil();
  }

//address details
  String generateAddressString(Map<String, dynamic> details) {
    List<String> addressParts = [
      details['address1'].toString(),
      details['address2'].toString(),
      details['city'].toString(),
      details['state'].toString(),
      details['zipcode'].toString(),
    ];

    // Filter out null or empty values
    List<String> nonEmptyParts = addressParts
        .where((part) => part != 'null' && part.toString().isNotEmpty)
        .toList();

    // Join the non-empty parts with commas
    String addressString = nonEmptyParts.join(', ');
    return addressString;
  }

  //////////////////////////////////////////////////////API WORK/////////////////////////////////////////////////////////////////////
//init function
  init(TextEditingController searchController) {
    onReachEndPage(searchController);
    getCpApprovedList(searchController.text, getCurrentIndex(), isBusy: true);
    notifyListeners();
  }

  int currentPage = 1; //pagination pge no
  bool result = true; //if record is not null
  int totalRecord = 0; //total count

  final CPService _cpService = locator<CPService>();

  var cpResult;
  List cpList = [];
  Future<void> getCpApprovedList(String searchText, int currentIndex,
      {bool isBusy = false}) async {
    setBusy(isBusy);
    isDataLoading = true;
    try {
      List updatedList = [];
      if (searchText.isNotEmpty) {
        var res = await _cpService.getCpSearchList(
            currentIndex == 0
                ? '17'
                : currentIndex == 1
                    ? '16'
                    : currentIndex == 2
                        ? '18'
                        : '19',
            currentPage,
            searchText);
        if (res.data['status'] == 'Success') {
          cpResult = res.data['data'];
          totalRecord = cpResult['totalCount'];
          result = totalRecord != 0 ? true : false;
          if (currentPage == 1) {
            updatedList.addAll(cpResult['entity_list']);
          } else {
            cpList.addAll(cpResult['entity_list']);

            //  updatedList = List.from(cpResult['entity_list']);
            // cpList.addAll(updatedList);
          }
        }
      } else {
        var res = await _cpService.getCpList(
            currentIndex == 0
                ? '17'
                : currentIndex == 1
                    ? '16'
                    : currentIndex == 2
                        ? '18'
                        : '19',
            currentPage);
        if (res.data['status'] == 'Success') {
          cpResult = res.data['data'];
          totalRecord = cpResult['totalCount'];
          result = totalRecord != 0 ? true : false;
          if (currentPage == 1) {
            updatedList.addAll(cpResult['entity_list']);
          } else {
            cpList.addAll(cpResult['entity_list']);
          }
        }
      }
      if (currentPage == 1) {
        cpList = List.from(updatedList);
      }
      notifyListeners();
    } on Error catch (e) {
      log('cp error = $e');
    } finally {
      setBusy(false);
      isDataLoading = false;
    }
  }

/////////////cp details Api/////////////////

// cp details
  var cpDeatilsList;
  void getCpDetails(int chId) async {
    setBusy(true);
    try {
      var res = await _cpService.getCpDetails(chId);
      if (res.data['status'] == 'Success') {
        cpDeatilsList = res.data['data']['channel_partner_detail'];
      }
      notifyListeners();
    } on Error catch (e) {
      log('cp error = $e');
    } finally {
      setBusy(false);
    }
  }

  // cp get active users list
  var cpActiveUserList;
  Future<void> getCpActiveUsers(int chId, bool isBusy) async {
    setBusy(isBusy);
    try {
      var res = await _cpService.getCpActiveUsers(chId, activeUsersSwitch);
      if (res.data['status'] == 'Success') {
        cpActiveUserList = res.data['data'];
      }
      notifyListeners();
    } on Error catch (e) {
      log('cp error = $e');
    } finally {
      setBusy(false);
    }
  }

  // cp current project list
  var cpCurrentProjectList;
  void getCpCurrentProjectList(int chId, bool isBusy) async {
    setBusy(isBusy);
    try {
      var res = await _cpService.getCpCurrentProject(
          chId, currentProjectSwitch == true ? 1 : 0);
      if (res.data['status'] == 'Success') {
        cpCurrentProjectList = res.data['data']['project_list'];
      }
      notifyListeners();
    } on Error catch (e) {
      log('cp error = $e');
    } finally {
      setBusy(false);
    }
  }

  //accept or reject
  void onAcceptReject(
    BuildContext context,
    int cpId,
    bool isAccept,
    String searchText,
  ) async {
    setBusy(true);
    try {
      var res = await _cpService.cpAcceptReject(cpId, isAccept);
      if (res.data['status'] == 'Success') {
        _navigationService
            .navigateToChannelPartnerView()
            .then((value) => getCpApprovedList(searchText, getCurrentIndex()));
        if (res.data['message'] == 'Channel Partner Approved successfully') {
          channelPartnerApproved(id: cpId, searchText: searchText);
        } else if (res.data['message'] ==
            'Channel Partner Rejected successfully') {
          showCustomToast(context, res.data['message'].toString(), '',
              onTap: null, toastDuration: 2);
        }
      } else {
        _dialogService.showCustomDialog(
            variant: DialogType.deactive,
            title: 'Deactivate',
            description: res.data['message'],
            mainButtonTitle: "OK",
            secondaryButtonTitle: '',
            barrierDismissible: true,
            imageUrl: Images().infoAlert);
      }
      notifyListeners();
    } on Error catch (e) {
      log('cp error = $e');
    } finally {
      setBusy(false);
    }
  }

// deactive approved record
  void onDeactive(int cpId) async {
    setBusy(true);
    try {
      var res = await _cpService.cpDeactive(cpId);
      if (res.data['status'] == 'Success') {
        _navigationService.navigateToChannelPartnerView();
      } else {
        _dialogService.showCustomDialog(
            variant: DialogType.deactive,
            title: 'Deactivate',
            description: res.data['message'],
            mainButtonTitle: "OK",
            secondaryButtonTitle: '',
            barrierDismissible: true,
            imageUrl: Images().infoAlert);
      }
      notifyListeners();
    } on Error catch (e) {
      log('cp error = $e');
    } finally {
      setBusy(false);
    }
  }

  ///////assign projects to cp bottomsheet///////////////////
  // cp get projec list
  List<dynamic> cpAssignProjectList = [];
  Future<void> getAssigProject(int chId) async {
    setBusy(true);
    try {
      var res = await _cpService.getCpAssignProjectList(chId);
      if (res.data['status'] == 'Success') {
        cpAssignProjectList = res.data['data']['project_list'];
      }
      notifyListeners();
    } on Error catch (e) {
      log('cp error = $e');
    } finally {
      setBusy(false);
    }
  }

  ///////////////////Remove cp project////////////
  //get assigned project list
  var projectListForRemove;
  Future<void> getProjectsForRemove(int chId) async {
    setBusy(true);
    try {
      var res = await _cpService.getCpProjectForRemove(chId);
      if (res.data['status'] == 'Success') {
        projectListForRemove = res.data['data']['project_list'];
      }
      notifyListeners();
    } on Error catch (e) {
      log('cp error = $e');
    } finally {
      setBusy(false);
    }
  }

  //get user to reassign
  Map leadsUSerData = {};
  Future<void> getUserToReassignCPLead(int projectId) async {
    setBusy(true);
    try {
      var res = await _cpService.getUserToReassignCPLead(projectId, null);
      if (res.data['code'] == 200) {
        leadsUSerData = res.data['data'];
        for (var i = 0;
            i < leadsUSerData['userListToAssignProjects'].length;
            i++) {
          entityLeadsUSerList.add(OptionItem(
              title: capitalizeFirstLetter(
                  leadsUSerData['userListToAssignProjects'][i]['name'])));
        }
      }
      notifyListeners();
    } on Error catch (e) {
      log('cp error = $e');
    } finally {
      setBusy(false);
    }
  }

  //remove project from cp
  Future<void> removeProjectFromCp(
      {required BuildContext context,
      required int chId,
      int? projectId,
      int? assignToUserId,
      int? reassignTypeId}) async {
    setBusy(true);
    try {
      var res = await _cpService.removeProjectFromCp(
          chId: chId,
          projectId: projectId,
          assignToUserId: assignToUserId,
          reassignTypeId: reassignTypeId);
      if (res.data['code'] == 200) {
        showCustomToast(context, res.data['message'], '',
            onTap: null, toastDuration: 3);
      }
      notifyListeners();
    } on Error catch (e) {
      log('cp error = $e');
    } finally {
      setBusy(false);
    }
  }

//////////////////// Temporary assigned project list storage so that use can undo if user wants
  List<dynamic> backupList = [];

  // assigned project index
  int previousIndex = 0;
  bool isClose = true; //set bottom sheet not closed under api call
  //Assign project to CP user
  void onAssignProject({
    required BuildContext context,
    required int index,
    int? userId,
    int? cpId,
    required int projectId,
  }) async {
    try {
      isClose = false;
      backupList.add(cpAssignProjectList[index]);
      previousIndex = index;
      cpAssignProjectList.removeAt(index);
      notifyListeners();
      showCustomToast(context, 'Assigned Successfully', 'UNDO',
          toastDuration: 3, onTap: onUndo);
      Future.delayed(const Duration(seconds: 3)).then((value) {
        isUndone
            ? null
            : _cpService.cpAssignProject(cpId!, projectId).then((value) {
                if (value.data['code'] == 200) {
                } else {
                  onUndo();
                }
              });
        isUndone = false;
        isClose = true;
      });

      notifyListeners();
    } on ApiError catch (e) {
      print(e.toString());
    } finally {
      print(isClose);
      // isClose=true;
      print(isClose);
    }
  }

  // Undo assigned project
  bool isUndone = false;
  onUndo() {
    isUndone = true;
    cpAssignProjectList.insert(previousIndex, backupList.last);
    backupList.removeLast();
    FToast().removeCustomToast();
    notifyListeners();
  }
}
