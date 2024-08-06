import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sales_lead/ui/views/home/home_viewmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:url_launcher/url_launcher.dart';

import '/app/app.dialogs.dart';
import '/api/api_error.dart';
import '/services/index.dart';
import '../home/home_view.dart';
import '/app/app.locator.dart';
import '/model/index.dart';
import '/ui/common/widgets/index.dart';
import '/app/app.bottomsheets.dart';
import '/ui/common/index.dart';
import '/ui/views/allusers/allusers_view.form.dart';

//Current user and user-type tab
String currentTabIndex = '';
int currentUserIndex = 0;

//User lists according to there type
List<dynamic> myTeamResponse = [];
List<dynamic> cpResponse = [];
List<dynamic> dstResponse = [];
List<dynamic> searchResponse = [];
List<dynamic> myTeamInactiveResponse = [];
List<dynamic> cpInactiveResponse = [];
List<dynamic> dstInactiveResponse = [];
List<dynamic> searchInactiveResponse = [];

//Pagination inital value
int myTeamCurrentPage = 1;
int cpCurrentPage = 1;
int dstCurrentPage = 1;
int myTeamInactiveCurrentPage = 1;
int cpInactiveCurrentPage = 1;
int dstInactiveCurrentPage = 1;

//User responses
dynamic res;
dynamic cpRes;
dynamic dstRes;
dynamic searchRes;
dynamic inactiveRes;
dynamic cpInactiveRes;
dynamic dstInactiveRes;
dynamic searchInactiveRes;

//Assigned project list
List<dynamic> assignedProjectSheetResponse = [];

//Reassign other user init value
OptionItem entityOption = OptionItem(title: "Abhijeet Das");

class AllusersViewModel extends FormViewModel {
  //Services
  final _bottomSheetService = locator<BottomSheetService>();
  final _navigationService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();
  final _allUserService = locator<AllUserService>();
  final sharedService = locator<SharedService>();

  //Controllers
  ScrollController scrollController = ScrollController();

  //Reassign type tab index
  int selectedIndex = 1;
  bool isShowDSTTab = false;
  bool isShowCPTab = false;
  bool isShowMyTeamTab = false;

  //Other user list
  List<OptionItem> entityDropListModel = [
    OptionItem(title: "Abhijeet Das"),
    OptionItem(title: "Abhishek Dubey"),
  ];

  //Navigate back to home
  goBack() {
    HomeViewModel().changeIndex(0);
    _navigationService.back();
    _navigationService.navigateWithTransition(const HomeView(pageIndex: 0),
        duration: Duration.zero);
  }

  //Assign to other user dropdown value change listner
  onEntityChange(OptionItem value, index) {
    for (var element in entityDropListModel) {
      if (element.title == entityDropListModel[index].title) {
        entityOption = entityDropListModel[index];
        notifyListeners();
      } else {}
    }
    notifyListeners();
  }

  //Set current user type tab
  updatecurrenttabIndex(index, {required BuildContext context}) {
    currentTabIndex = index;
    initAllUser(tabIndex: index, context: context, isInit: true);
    scrollController.animateTo(0,
        duration: const Duration(milliseconds: 250), curve: Curves.easeIn);
    notifyListeners();
  }

  //change selected container
  onSelect(index) {
    selectedIndex = index;
    notifyListeners();
  }

  //Active/Inactive toggle switch
  bool switchVal = true;
  toggleSwitch() {
    switchVal = !switchVal;

    scrollController.animateTo(0,
        duration: const Duration(milliseconds: 250), curve: Curves.easeIn);
    notifyListeners();
  }

  //Show all unassigned projects
  showbottomSheet(int userId, {required BuildContext context}) async {
    var res = await _bottomSheetService.showCustomSheet(
        variant: BottomSheetType.allUserAssignProject,
        isScrollControlled: true,
        title: userId.toString(),
        data: sharedService.isAssignUserToProject);
    if (res == null || res.confirmed == true || res.confirmed == false) {
      initAllUser(context: context, tabIndex: currentTabIndex);
    }
  }

  //Show assigned projects
  showAssignedProjectbottomSheet(int index, int userId, isSubodinateUser,
      {required BuildContext context}) async {
    currentUserIndex = index;
    bool isSubUser = isSubodinateUser == true ? true : false;
    var res = await _bottomSheetService.showCustomSheet(
        variant: BottomSheetType.assignedProjects,
        isScrollControlled: true,
        title: userId.toString(),
        data: isSubUser && sharedService.isRemoveUserToProject!);
    if (res == null || res.confirmed == true || res.confirmed == false) {
      initAllUser(context: context, tabIndex: currentTabIndex);
    }
  }

  //Show remove user confirmation card
  showRemoveFromProjectBottomSheet(
      int index, int userId, int projectId, bool hasLead) async {
        currentUserIndex = index;
    var result = await _bottomSheetService.showCustomSheet(
        exitBottomSheetDuration: Duration.zero,
        variant: BottomSheetType.removeFromProject,
        data: {
          'user_id': userId,
          'index': index,
          'project_id': projectId,
          'hasLead': hasLead
        },
        isScrollControlled: true);
    if (result != null && result.confirmed == true) {
      initAssignedProjectSheet(userId);
      notifyListeners();
    }
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

  void changeUserStatus(
      {required int userId, required bool status, context}) async {
    await _allUserService
        .changeUserStatus(status: status, userId: userId)
        .then((value) {
      updatecurrenttabIndex(currentTabIndex, context: context);
    });
  }

  //////////////////////////////////////////API WORK///////////////////////////////////////////////////
  //Pagination API call
  AllusersViewModel() {
    scrollController.addListener(() async {
      if ((scrollController.position.maxScrollExtent ==
              scrollController.offset) &&
          currentTabIndex == 'DST' &&
          searchValue == '') {
        switchVal
            ? initDstResponse(isInIt: true)
            : initInactiveDstResponse(isInIt: true);
      }
    });
    scrollController.addListener(() async {
      if ((scrollController.position.maxScrollExtent ==
              scrollController.offset) &&
          currentTabIndex == 'CP' &&
          searchValue == '') {
        switchVal
            ? initCpResponse(isInIt: true)
            : initInactiveCpResponse(isInIt: true);
      }
    });
    scrollController.addListener(() async {
      if ((scrollController.position.maxScrollExtent ==
              scrollController.offset) &&
          currentTabIndex == 'MyTeam' &&
          searchValue == '') {
        switchVal
            ? initMyTeamResponse(isInIt: true)
            : initInactiveMyTeamResponse(isInIt: true);
      }
    });
  }

  //Init All-User view
  initAllUser(
      {String? tabIndex,
      required BuildContext context,
      bool isInit = false}) async {
    if (isInit) {
      setBusy(true);
    }
    searchValue = '';
    isShowDSTTab = sharedService.userId == 1 && sharedService.isViewAllUser!;
    isShowCPTab = sharedService.userId == 1 && sharedService.isViewCPUser! ||
        sharedService.userId == 2 && sharedService.isViewAllUser!;
    isShowMyTeamTab = sharedService.isViewMyTeamUser!;
    if (tabIndex == null) {
      if (isShowDSTTab) {
        currentTabIndex = 'DST';
      } else if (isShowCPTab) {
        currentTabIndex = 'CP';
      } else if (isShowMyTeamTab) {
        currentTabIndex = 'MyTeam';
      }
    } else {
      currentTabIndex = tabIndex;
    }
    rebuildUi();
    if (isInit) {
      switchVal = true;
      cpRes = null;
      dstRes = null;
      res = null;
      cpInactiveRes = null;
      dstInactiveRes = null;
      inactiveRes = null;
      searchRes = null;
      myTeamResponse.clear();
      cpResponse.clear();
      dstResponse.clear();
      myTeamInactiveResponse.clear();
      cpInactiveResponse.clear();
      dstInactiveResponse.clear();
      searchResponse.clear();
    }
    myTeamCurrentPage = 1;
    cpCurrentPage = 1;
    dstCurrentPage = 1;
    myTeamInactiveCurrentPage = 1;
    cpInactiveCurrentPage = 1;
    dstInactiveCurrentPage = 1;

    dismissKeyboard(context);
    if (currentTabIndex == 'DST') {
      await initDstResponse(isInIt: isInit);
      await initInactiveDstResponse(isInIt: isInit);
    } else if (currentTabIndex == 'CP') {
      await initCpResponse(isInIt: isInit);
      await initInactiveCpResponse(isInIt: isInit);
    } else if (currentTabIndex == 'MyTeam') {
      await initMyTeamResponse(isInIt: isInit);
      await initInactiveMyTeamResponse(isInIt: isInit);
    }
    setBusy(false);
  }

  //Active CP Response
  initCpResponse({bool isInIt = false}) async {
    var prefs = await SharedPreferences.getInstance();
    int? cpId = prefs.getInt('channel_partner_id');
    if (sharedService.isCp!) {
      try {
        await _allUserService
            .getUserListByChannelPartnerId(
          cpId: cpId,
          isActive: 1,
          pageCount: cpCurrentPage,
        )
            .then((value) {
          if (value.data['data']['entity_list'] != null) {
            cpRes = value.data['data'];
            if (isInIt) {
              for (var el in (value.data['data']['entity_list'] as List)) {
                cpResponse.add(el);
              }
            } else {
              cpResponse = value.data['data']['entity_list'];
            }
          } else {
            cpResponse = [];
          }

          cpCurrentPage++;
          notifyListeners();
        });
      } on ApiError catch (e) {
        log('All User Error => $e');
      }
    } else {
      try {
        await _allUserService
            .getUserListByUserType(
          userId: 2,
          isActive: 1,
          pageCount: cpCurrentPage,
        )
            .then((value) {
          cpRes = value.data['data'];
          if (value.data['data']['user_list'] != null) {
            if (isInIt) {
              for (var el in (value.data['data']['user_list'] as List)) {
                cpResponse.add(el);
              }
            } else {
              cpResponse = value.data['data']['user_list'];
            }
          } else {
            cpResponse = [];
          }

          cpCurrentPage++;
          notifyListeners();
        });
      } on Error catch (e) {
        log('All User Error => $e');
      }
    }
  }

  //Inactive CP Response
  initInactiveCpResponse({bool isInIt = false}) async {
    var prefs = await SharedPreferences.getInstance();
    int? cpId = prefs.getInt('channel_partner_id');
    if (sharedService.isCp!) {
      try {
        await _allUserService
            .getUserListByChannelPartnerId(
          cpId: cpId,
          isActive: 0,
          pageCount: cpInactiveCurrentPage,
        )
            .then((value) {
          if (value.data['data']['entity_list'] != null) {
            cpInactiveRes = value.data['data'];
            if (isInIt) {
              for (var el in (value.data['data']['entity_list'] as List)) {
                cpInactiveResponse.add(el);
              }
            } else {
              cpInactiveResponse = value.data['data']['entity_list'];
            }
          } else {
            cpInactiveResponse = [];
          }

          cpInactiveCurrentPage++;
          notifyListeners();
        });
      } on ApiError catch (e) {
        log('All User Error => $e');
      }
    } else {
      try {
        await _allUserService
            .getUserListByUserType(
          userId: 2,
          isActive: 0,
          pageCount: cpInactiveCurrentPage,
        )
            .then((value) {
          cpInactiveRes = value.data['data'];
          if (value.data['data']['user_list'] != null) {
            if (isInIt) {
              for (var el in (value.data['data']['user_list'] as List)) {
                cpInactiveResponse.add(el);
              }
            } else {
              cpInactiveResponse = value.data['data']['user_list'];
            }
          } else {
            cpInactiveResponse = [];
          }

          cpInactiveCurrentPage++;
          notifyListeners();
        });
      } on Error catch (e) {
        log('All User Error => $e');
      }
    }
  }

  //Active DST Response
  initDstResponse({bool isInIt = false}) async {
    try {
      await _allUserService
          .getUserListByUserType(
        userId: 1,
        isActive: 1,
        pageCount: dstCurrentPage,
      )
          .then((value) {
        dstRes = value.data['data'];
        if (value.data['data']['user_list'] != null) {
          if (isInIt) {
            for (var el in (value.data['data']['user_list'] as List)) {
              dstResponse.add(el);
            }
          } else {
            dstResponse = value.data['data']['user_list'];
          }
        } else {
          dstResponse = [];
        }

        dstCurrentPage++;
        notifyListeners();
      });
    } on Error catch (e) {
      log('All User Error => $e');
    }
  }

  //Inactive DST Response
  initInactiveDstResponse({bool isInIt = false}) async {
    try {
      await _allUserService
          .getUserListByUserType(
        userId: 1,
        isActive: 0,
        pageCount: dstInactiveCurrentPage,
      )
          .then((value) {
        dstInactiveRes = value.data['data'];
        if (value.data['data']['user_list'] != null) {
          if (isInIt) {
            for (var el in (value.data['data']['user_list'] as List)) {
              dstInactiveResponse.add(el);
            }
          } else {
            dstInactiveResponse = value.data['data']['user_list'];
          }
        } else {
          dstInactiveResponse = [];
        }

        dstInactiveCurrentPage++;
        notifyListeners();
      });
    } on Error catch (e) {
      log('All User Error => $e');
    }
  }

  //Active Team Response
  initMyTeamResponse({bool isInIt = false}) async {
    try {
      await _allUserService
          .getAllTeamMembers(
        isActive: 1,
        pageCount: myTeamCurrentPage,
      )
          .then((value) {
        if (value.data['data']['user_list'] != null) {
          res = value.data['data'];
          if (isInIt) {
            for (var el in (value.data['data']['user_list'] as List)) {
              myTeamResponse.add(el);
            }
          } else {
            myTeamResponse = value.data['data']['user_list'];
          }
        } else {
          myTeamResponse = [];
        }
        myTeamCurrentPage++;

        notifyListeners();
      });
    } on Error catch (e) {
      log('All User Error => $e');
    }
  }

  //Inactive Team Response
  initInactiveMyTeamResponse({bool isInIt = false}) async {
    try {
      await _allUserService
          .getAllTeamMembers(
        isActive: 0,
        pageCount: myTeamInactiveCurrentPage,
      )
          .then((value) {
        if (value.data['data']['user_list'] != null) {
          inactiveRes = value.data['data'];
          if (isInIt) {
            for (var el in (value.data['data']['user_list'] as List)) {
              myTeamInactiveResponse.add(el);
            }
          } else {
            myTeamInactiveResponse = value.data['data']['user_list'];
          }
        } else {
          myTeamInactiveResponse = [];
        }
        myTeamInactiveCurrentPage++;

        notifyListeners();
      });
    } on Error catch (e) {
      log('All User Error => $e');
    }
  }

  //Search API
  initSearch({
    int? userId,
    int? isActive,
    String? search,
  }) async {
    var prefs = await SharedPreferences.getInstance();
    int? cpId = prefs.getInt('channel_partner_id');
    if (search!.length < 3) {
      searchRes = null;
      searchResponse.clear();
      notifyListeners();
    } else if (userId != null) {
      if (sharedService.isCp!) {
        try {
          _allUserService
              .getUserListByChannelPartnerId(
                  cpId: cpId, isActive: isActive, pageCount: 1, search: search)
              .then((value) {
            searchRes = value.data['data'];
            if (sharedService.isCp! &&
                value.data['data']['entity_list'] != null) {
              searchResponse = value.data['data']['entity_list'];
            } else if (!sharedService.isCp! &&
                value.data['data']['user_list'] != null) {
              searchResponse = value.data['data']['user_list'];
            } else {
              searchResponse.clear();
            }

            notifyListeners();
          });
        } on Error catch (e) {
          log('All User Error => $e');
        }
      } else {
        try {
          _allUserService
              .getUserListByUserType(
                  userId: userId,
                  isActive: isActive,
                  pageCount: 1,
                  search: search)
              .then((value) {
            searchRes = value.data['data'];
            if (value.data['data']['user_list'] != null) {
              searchResponse = value.data['data']['user_list'];
            } else {
              searchResponse.clear();
            }

            notifyListeners();
          });
        } on Error catch (e) {
          log('All User Error => $e');
        }
      }
    } else {
      try {
        _allUserService
            .getAllTeamMembers(isActive: isActive, pageCount: 1, search: search)
            .then((value) {
          searchRes = value.data['data'];
          if (value.data['data']['user_list'] != null) {
            searchResponse = value.data['data']['user_list'];
          } else {
            searchResponse.clear();
          }

          notifyListeners();
        });
      } on Error catch (e) {
        log('All User Error => $e');
      }
    }
  }

  //Init Unassigned projects
  List<dynamic> assignProjectSheetResponse = [];
  initAssignProjectSheet(int userId) async {
    assignedProjectSheetResponse.clear();
    try {
      setBusy(true);
      await _allUserService
          .getProjectsToAssignByUserId(
        userId: userId,
      )
          .then((value) {
        assignProjectSheetResponse =
            (value.data['data']['project_list'] as List);

        notifyListeners();
      });
    } on Error catch (e) {
      log('All User Error => $e');
    } finally {
      setBusy(false);
    }
  }

  //Init all assigned project to respective user
  initAssignedProjectSheet(int userId) async {
    try {
      setBusy(true);
      await _allUserService
          .getAssignedProjectsbyUserID(
        userId: userId,
      )
          .then((value) {
        assignedProjectSheetResponse =
            (value.data['data']['project_list'] as List);

        notifyListeners();
      });
    } on Error catch (e) {
      log('All User Error => $e');
    } finally {
      setBusy(false);
    }
  }

  // Temporary assigned project list storage so that use can undo if user wants
  List<dynamic> backupList = [];

  // assigned project index
  int previousIndex = 0;

  //Assign project to user/CP
  void onAssign({
    required BuildContext context,
    required int index,
    int? userId,
    int? cpId,
    required int projectId,
  }) async {
    try {
      backupList.add(assignProjectSheetResponse[index]);

      previousIndex = index;
      assignProjectSheetResponse.removeAt(index);
      notifyListeners();
      showCustomToast(context, 'Assigned Successfully', 'UNDO',
          toastDuration: 3, onTap: onUndo);
      Future.delayed(const Duration(seconds: 3)).then((value) {
        isUndone
            ? null
            : _allUserService
                .assignProjectToUser(projectId: projectId, userId: userId!)
                .then((value) {
                if (value.data['code'] == 200) {
                } else {
                  onUndo();
                }
              });
        isUndone = false;
      });

      notifyListeners();
    } on ApiError catch (e) {
      print(e.toString());
    } finally {}
  }

//Remove project froms user/CP
  Future<void> onRemove(
      {required BuildContext context,
      required int currentUserId,
      required int projectId,
      completer}) async {
    setBusy(true);

    try {
      _allUserService
          .removeProjectFromUser(
        currentUserId: currentUserId,
        projectId: projectId,
      )
          .then((value) {
        if (value.data['code'] == 200) {
          completer!.call(SheetResponse(confirmed: true));
          showCustomToast(context, 'User removed Successfully', '',
              onTap: null);
        } else {
          showCustomToast(context, value.data['message'], '', onTap: null);
        }
      });

      notifyListeners();
    } on ApiError catch (e) {
      print(e.toString());
    } finally {
      setBusy(false);
    }
  }

  // Undo assigned project
  bool isUndone = false;
  onUndo() {
    isUndone = true;
    assignProjectSheetResponse.insert(previousIndex, backupList.last);

    backupList.removeLast();
    FToast().removeCustomToast();
    notifyListeners();
  }
}
