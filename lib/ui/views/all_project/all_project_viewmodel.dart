import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:easy_debounce/easy_debounce.dart';
import '/services/index.dart';
import '/ui/views/home/home_view.dart';
import '/ui/views/home/home_viewmodel.dart';
import '/app/app.router.dart';
import '/app/app.bottomsheets.dart';
import '/ui/common/widgets/index.dart';
import '/app/app.locator.dart';
import '/app/app.dialogs.dart';
import 'all_project_view.form.dart';
import '/api/api_error.dart';

// List<AllProjectModel> projectsList = [];
dynamic cpProjectsRes;
dynamic dstProjectsRes;
dynamic myProjectsRes;
dynamic searchProjectsRes;
List<dynamic> cpProjectsResponse = [];
List<dynamic> dstProjectsResponse = [];
List<dynamic> myProjectsResponse = [];
List<dynamic> searchProjectsResponse = [];
int currentProjectIndex = 0;
int currentTabIndex = 1;
int selectedIndex = -1;
String assigneeType = '';
List<dynamic> document = [];
List<dynamic> projectDetailResponseImages = [];

class AllProjectViewModel extends BaseViewModel with FormStateHelper {
  final _allProjectService = locator<AllProjectService>();
  final _bottomSheetService = locator<BottomSheetService>();
  final sharedService = locator<SharedService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final DialogService _dialogService = locator<DialogService>();
  final GlobalKey<SfPdfViewerState> pdfViewerKey = GlobalKey();
  ScrollController scrollController = ScrollController();

  bool showDSTTab = false;
  bool showChannelPartnerTab = false;
  bool showMyProjectTab = false;

  //Navigation methods
  //Go to back page
  void back() {
    _navigationService.back();
  }

  //cancel bottomsheet
  goBack() {
    HomeViewModel().changeIndex(0);
    _navigationService.back();
    _navigationService.navigateWithTransition(const HomeView(pageIndex: 0),
        duration: Duration.zero);
  }

  // go to project overview
  goToProjectOverview(int projectId, int index) {
    currentProjectIndex = index;
    notifyListeners();
    _navigationService.navigateTo(Routes.projectDetailView,
        arguments: ProjectDetailViewArguments(projectId: projectId));
  }

  //Project document bottomsheet
  void showProjectDocument() {
    _bottomSheetService.showCustomSheet(
        variant: BottomSheetType.projectDocument, isScrollControlled: true);
  }

  //Botttom sheet methods
  //change selected container
  onSelect(index, String userType,
      {required int projectId, searchController}) async {
    selectedIndex = index;
    assigneeType = userType;

    await _bottomSheetService
        .showCustomSheet(
            variant: BottomSheetType.addUserToProject,
            isScrollControlled: true,
            title: projectId.toString())
        .then((value) async {
      if (value == null ||
          value.confirmed == false ||
          value.confirmed == true) {
        await initAllProject(
            index: currentTabIndex, searchController: searchController);
      }
    });
  }

  //show assign user/Cp bottom sheed
  showAssignProjectToUserbottomSheet(int projectId, searchController) async {
    selectedIndex = -1;
    notifyListeners();
    await _bottomSheetService
        .showCustomSheet(
      variant: BottomSheetType.assignProjectToUser,
      title: projectId.toString(),
      isScrollControlled: true,
    )
        .then((value) async {
      if (value == null ||
          value.confirmed == false ||
          value.confirmed == true) {
        await initAllProject(
            index: currentTabIndex, searchController: searchController);
      }
    });
  }

  //show remove user/Cp bottom sheed
  showbottomSheetRemoveUserFromProject(int projectId, searchController) async {
    await _bottomSheetService
        .showCustomSheet(
            title: projectId.toString(),
            variant: BottomSheetType.removeUserFromProject,
            isScrollControlled: true)
        .then((value) async {
      if (value == null ||
          value.confirmed == false ||
          value.confirmed == true) {
        EasyDebounce.debounce(
            'my-throttler', // <-- An ID for this particular throttler
            Duration(seconds: 5), // <-- The throttle duration
            () async => await initAllProject(
                index: currentTabIndex,
                searchController: searchController) // <-- The target method
            // <-- Optional callback, called after the duration has passed
            );
        await initAllProject(
            index: currentTabIndex, searchController: searchController);
        // updatecurrenttabIndex(currentTabIndex, searchController);
      }
    });
  }

  // Convert bytes into ['KB','MB'] and return file size
  String fileSizeString({required int bytes, int decimals = 0}) {
    const suffixes = [
      "B",
      "KB",
      "MB",
    ];
    if (bytes == 0) return '0${suffixes[0]}';
    var i = (log(bytes) / log(1024)).floor();
    return '${(bytes / pow(1024, i)).toStringAsFixed(decimals)} ${suffixes[i]}';
  }

  //On tab bar tab click
  updatecurrenttabIndex(index, searchController) {
    initAllProject(
        index: index, searchController: searchController, isInit: true);
    scrollController.jumpTo(0);
    notifyListeners();
  }

  //On project tap index change
  onProjectSelect(index) {
    currentProjectIndex = index;
    notifyListeners();
  }

  //Swtich button
  bool switchVal = true;
  toggleSwitch() {
    switchVal = !switchVal;
    notifyListeners();
  }

  //Custom dialog methods
  void showPreviewDialog(name,
      {String? pdfUrl, String? pdfname, bool isPdf = false}) {
    _dialogService.showCustomDialog(
        variant: DialogType.imgePreview,
        hasImage: isPdf,
        title: pdfUrl,
        description: pdfname,
        data: projectDetailResponseImages);
  }

  // Undo assigned project
  bool isUndone = false;
  onUndo() {
    isUndone = true;
    selectedIndex == 0
        ? projectResponse['userListToAssignProjects']
            .insert(previousIndex, userRemovedList.last)
        : cpProjectResponse['cPListToAssignProjects']
            .insert(previousIndex, userRemovedList.last);

    userRemovedList.removeLast();
    FToast().removeCustomToast();
    notifyListeners();
  }

  ////////////////////////////////////////////////////////////////////////Api's Work/////////////////////////////////////////////////////
  //Pagination API call
  AllProjectViewModel() {
    scrollController.addListener(() async {
      if ((scrollController.position.maxScrollExtent ==
              scrollController.offset) &&
          currentTabIndex == 1 &&
          searchValue == '' &&
          dstProjectsRes['totalcount'] != dstProjectsResponse.length) {
        initDstResponse(isInit: true);
      }
    });
    scrollController.addListener(() async {
      if ((scrollController.position.maxScrollExtent ==
              scrollController.offset) &&
          currentTabIndex == 2 &&
          searchValue == '' &&
          cpProjectsRes['totalcount'] != cpProjectsResponse.length) {
        initCpResponse(isInit: true);
      }
    });
  }

  Map viewProjectsBySourceData = {};
  int dstCurrentPage = 1;
  int cpCurrentPage = 1;
  int myProjectCurrentPage = 1;
  int searchCurrentPage = 1;

  //Init Methods

  //init all projects of current login user
  initAllProject(
      {int? index,
      TextEditingController? searchController,
      bool isInit = false}) async {
    if (isInit) {
      setBusy(true);
    }
    if (searchController != null) {
      searchController.text = '';
      notifyListeners();
    }
    searchValue = '';
    cpCurrentPage = 1;
    dstCurrentPage = 1;
    myProjectCurrentPage = 1;
    showDSTTab = sharedService.userId == 1 && sharedService.isViewAllProject!;
    showChannelPartnerTab =
        sharedService.userId == 1 && sharedService.isViewCPProject! ||
            sharedService.userId == 2 && sharedService.isViewAllProject!;
    showMyProjectTab = sharedService.isViewMyProject!;
    if (index != null) {
      currentTabIndex = index;
    } else {
      if (showDSTTab) {
        currentTabIndex = 1;
      } else if (showChannelPartnerTab) {
        currentTabIndex = 2;
      } else if (showMyProjectTab) {
        currentTabIndex = 3;
      }
    }
    if (isInit) {
      dstProjectsRes = null;
      cpProjectsRes = null;
      myProjectsRes = null;
      dstProjectsResponse.clear();
      cpProjectsResponse.clear();
      myProjectsResponse.clear();
      searchProjectsResponse.clear();
    }
    if (searchController != null) {
      searchController.text = '';
    }

    notifyListeners();

    if (currentTabIndex == 1) {
      await initDstResponse(isInit: isInit);
    } else if (currentTabIndex == 2) {
      await initCpResponse(isInit: isInit);
    } else if (currentTabIndex == 3) {
      await initMyProjectResponse(isInit: isInit);
    }

    setBusy(false);
  }

  initDstResponse({bool isInit = false}) async {
    try {
      await _allProjectService
          .getProjectsListToAssign(
        userTypeId: 1,
        pageNo: dstCurrentPage,
      )
          .then((value) {
        if (value.data['data']! != null &&
            value.data['data']['project_list']! != null) {
          dstProjectsRes = value.data['data'];
          if (isInit) {
            for (var el in value.data['data']['project_list']) {
              dstProjectsResponse.add(el);
            }
          } else {
            dstProjectsResponse = value.data['data']['project_list'];
          }
        }

        dstCurrentPage++;
        notifyListeners();
      });
    } on Error catch (e) {
      print(e.toString());
    }
  }

  initCpResponse({bool isInit = false}) async {
    try {
      await _allProjectService
          .getProjectsListToAssign(
        userTypeId: 2,
        pageNo: cpCurrentPage,
      )
          .then((value) {
        if (value.data['data']! != null &&
            value.data['data']['project_list']! != null) {
          cpProjectsRes = value.data['data'];
          if (isInit) {
            for (var el in value.data['data']['project_list']) {
              cpProjectsResponse.add(el);
            }
          } else {
            cpProjectsResponse = value.data['data']['project_list'];
          }
        }

        cpCurrentPage++;
        notifyListeners();
      });
    } on Error catch (e) {
      print(e.toString());
    }
  }

  initMyProjectResponse({bool isInit = false}) async {
    int myProjectCount = 0;
    try {
      await _allProjectService.getMyProjectsList().then((value) async {
        if (value.data['data'] != null &&
            value.data['data']['project_list'] != null) {
          myProjectCount = value.data['data']['project_list'].length;
          notifyListeners();
        } else {
          myProjectCount = 0;
          notifyListeners();
        }
      });
    } on Error catch (e) {
      print(e.toString());
    }
    try {
      await _allProjectService
          .getProjectsListToAssign(
        userTypeId: sharedService.isCp! ? 2 : 1,
        pageNo: myProjectCurrentPage,
      )
          .then((value) {
        if (value.data['data']! != null &&
            value.data['data']['project_list']! != null) {
          myProjectsRes = value.data['data'];
          if (isInit) {
            for (var el in value.data['data']['project_list']) {
              if (el['isAssignedToMe'] == true) {
                myProjectsResponse.add(el);
              }
            }
          } else {
            myProjectsResponse = (value.data['data']['project_list'] as List)
                .where((element) => element['isAssignedToMe'] == true)
                .toList();
          }
        }
        myProjectCurrentPage++;
      });
    } on Error catch (e) {
      print(e.toString());
    } finally {
      if (myProjectsResponse.length < myProjectCount) {
        await initMyProjectResponse(isInit: true);
      }
      notifyListeners();
    }
  }

  initSearchResponse({String? search, int? userId}) async {
    if (search!.length < 3) {
      searchProjectsRes = null;
      searchProjectsResponse.clear();
      notifyListeners();
    } else if (currentTabIndex == 3) {
      try {
        _allProjectService
            .getProjectsListToAssign(
                userTypeId: userId, pageNo: searchCurrentPage, search: search)
            .then((value) {
          if (value.data['data']! != null &&
              value.data['data']['project_list']! != null) {
            searchProjectsRes = value.data['data'];

            searchProjectsResponse =
                (value.data['data']['project_list'] as List)
                    .where((element) => element['isAssignedToMe'] == true)
                    .toList();
          }

          notifyListeners();
        });
      } on Error catch (e) {
        print(e.toString());
      }
    } else {
      try {
        _allProjectService
            .getProjectsListToAssign(
                userTypeId: userId, pageNo: searchCurrentPage, search: search)
            .then((value) {
          if (value.data['data']! != null &&
              value.data['data']['project_list']! != null) {
            searchProjectsRes = value.data['data'];
            searchProjectsResponse = value.data['data']['project_list'];
          }

          notifyListeners();
        });
      } on Error catch (e) {
        print(e.toString());
      }
    }
  }

  // get project response to user/CP
  var projectResponse;
  var cpProjectResponse;
  //Init add user/CP to project sheet get all unassigned user/CP
  initAddProjectToUser(String projectId) async {
    setBusy(true);
    try {
      if (selectedIndex == 0) {
        var res = await _allProjectService.getUnassignedUsersByProjectId(
            projectId: int.parse(projectId));
        projectResponse = res.data['data'];
      } else {
        var cpRes = await _allProjectService.getUnassignedCPByProjectId(
            projectId: int.parse(projectId));
        cpProjectResponse = cpRes.data['data'];
      }
    } on ApiError catch (e) {
      print(e.toString());
    } finally {
      setBusy(false);
    }
  }

  //Init Remove user/CP form project sheet get all assigned user/CP
  initRemoveProjectFromUser(String projectId) async {
    setBusy(true);
    if (currentTabIndex == 1 || currentTabIndex == 3) {
      try {
        var res = await _allProjectService.getAssignedUsersByProjectId(
            projectId: int.parse(projectId));
        projectResponse = res.data['data'];
      } on ApiError catch (e) {
        print(e.toString());
      } finally {
        setBusy(false);
      }
    } else if (currentTabIndex == 2 && sharedService.isCp!) {
      try {
        var res = await _allProjectService.getAssignedUsersByProjectId(
            projectId: int.parse(projectId));
        projectResponse = res.data['data'];
      } on ApiError catch (e) {
        print(e.toString());
      } finally {
        setBusy(false);
      }
    } else {
      try {
        var res = await _allProjectService.getAssignedCPByProjectId(
            projectId: int.parse(projectId));
        cpProjectResponse = res.data['data'];
      } on ApiError catch (e) {
        print(e.toString());
      } finally {
        setBusy(false);
      }
    }
  }

  //project detail respomnse
  var projectDetailResponse;
  //Get current selected projects details by its id
  initProjectDetailView(int projectId) async {
    try {
      document.clear();
      projectDetailResponseImages.clear();
      setBusy(true);
      await _allProjectService.getProjectDetail(projectId).then((value) async {
        projectDetailResponse = value.data['data']['project_data'];

        if (value.data['data']['project_data']['project_collaterals'] != null) {
          for (var element in (value.data['data']['project_data']
              ['project_collaterals'] as List<dynamic>)) {
            if (element['mime_type_name'] != null &&
                element['mime_type_name'] != 'image/*' &&
                element['mime_type_name'].toString().split('/').first !=
                    'video') {
              document.add(element);
              notifyListeners();
            } else if (element['mime_type_name'] != null &&
                element['mime_type_name'] == 'image/*') {
              projectDetailResponseImages.add(element);

              notifyListeners();
            }
            notifyListeners();
          }
        }
      });

      notifyListeners();
    } on Exception catch (e) {
      print(e.toString());
    } finally {
      setBusy(false);
    }
  }

  // Temporary assigned project list storage so that use can undo if user wants
  List<dynamic> userRemovedList = [];
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
      if (selectedIndex == 0) {
        userRemovedList.add(projectResponse['userListToAssignProjects'][index]);

        previousIndex = index;
        (projectResponse['userListToAssignProjects'] as List).removeAt(index);
        showCustomToast(
            context,
            '${selectedIndex == 1 ? 'Cp' : 'User'} Assigned Successfully',
            'UNDO',
            toastDuration: 3,
            onTap: onUndo);
        Future.delayed(const Duration(seconds: 2)).then((value) async {
          isUndone
              ? null
              : await _allProjectService
                  .assignProjectToUser(
                      permissionID: 60, projectId: projectId, userId: userId)
                  .then((value) {
                  if (value.data['code'] == 200) {
                  } else {
                    onUndo();
                  }
                });
          isUndone = false;
        });
      } else {
        userRemovedList.add(cpProjectResponse['cPListToAssignProjects'][index]);
        previousIndex = index;
        (cpProjectResponse['cPListToAssignProjects'] as List).removeAt(index);
        showCustomToast(
            context,
            '${selectedIndex == 1 ? 'Cp' : 'User'} Assigned Successfully',
            'UNDO',
            toastDuration: 3,
            onTap: onUndo);
        Future.delayed(const Duration(seconds: 2)).then((value) async {
          isUndone
              ? null
              : await _allProjectService
                  .assignProjectToCP(
                      permissionID: 60, projectId: projectId, cpId: userId)
                  .then((value) {
                  if (value.data['code'] == 200) {
                  } else {
                    onUndo();
                  }
                });
          isUndone = false;
        });
      }
      notifyListeners();
    } on ApiError catch (e) {
      print(e.toString());
    } finally {}
  }

  //Remove project froms user/CP
  void onRemove({
    required BuildContext context,
    required int index,
    required int currentUserId,
    required int projectId,
  }) async {
    setBusy(true);

    if (currentTabIndex == 1 || currentTabIndex == 3) {
      try {
        await _allProjectService
            .removeProjectFromUser(
                currentUserId: currentUserId,
                projectId: projectId,
                permissionID: 51)
            .then((value) {
          if (value.data['code'] == 200) {
            initRemoveProjectFromUser(projectId.toString());
            showCustomToast(context, value.data['message'].toString(), '',
                onTap: null);
          } else {
            showCustomToast(context, value.data['message'], '', onTap: null);
          }
          setBusy(false);
        });
      } on Error catch (e) {
        print(e.toString());
      }
    } else if (currentTabIndex == 2 && sharedService.isCp!) {
      try {
        await _allProjectService
            .removeProjectFromUser(
                currentUserId: currentUserId,
                projectId: projectId,
                permissionID: 51)
            .then((value) {
          if (value.data['code'] == 200) {
            initRemoveProjectFromUser(projectId.toString());
            showCustomToast(context, value.data['message'].toString(), '',
                onTap: null);
          } else {
            showCustomToast(context, value.data['message'], '', onTap: null);
          }
          setBusy(false);
        });
      } on Error catch (e) {
        print(e.toString());
      }
    } else {
      try {
        await _allProjectService
            .removeProjectFromCP(
                currentUserId: currentUserId,
                projectId: projectId,
                permissionID: 51)
            .then((value) {
          if (value.data['code'] == 200) {
            initRemoveProjectFromUser(projectId.toString());
            showCustomToast(context, 'Cp removed Successfully', '',
                onTap: null);
          } else {
            showCustomToast(context, value.data['message'], '', onTap: null);
          }
          setBusy(false);
        });
      } on Error catch (e) {
        print(e.toString());
      }
    }
    notifyListeners();
  }
}
