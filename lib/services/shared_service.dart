import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

import '/api/api_error.dart';

class SharedService with ListenableServiceMixin {
  // List of permission and its getter
  final ReactiveValue<List<String>?> _permission = ReactiveValue(null);
  List<String>? get permission => _permission.value;
  // User id and its getter
  final ReactiveValue<int?> _userId = ReactiveValue(null);
  int? get userId => _userId.value;
  // If DST login, The CP tab will be visible
  final ReactiveValue<bool?> _isDstUser = ReactiveValue(null);
  bool? get isDstUser => _isDstUser.value;
  // If CP login, The users tab will be visible
  final ReactiveValue<bool?> _isCp = ReactiveValue(null);
  bool? get isCp => _isCp.value;
  // The leads tab will be visible if the permissions exist
  final ReactiveValue<bool?> _isLeads = ReactiveValue(null);
  bool? get isLeads => _isLeads.value;
  // The call recording tab will be visible if the permissions exist
  final ReactiveValue<bool?> _isCallRecording = ReactiveValue(null);
  bool? get isCallRecording => _isCallRecording.value;
  // The projects tab will be visible if the permissions exist
  final ReactiveValue<bool?> _isProjects = ReactiveValue(null);
  bool? get isProjects => _isProjects.value;
  // Does user have permission to watch projects and its getter
  final ReactiveValue<bool?> _isDstProjects = ReactiveValue(null);
  bool? get isDstProjects => _isDstProjects.value;
  // Does user have permission to watch projects and its getter
  final ReactiveValue<bool?> _isCpProjects = ReactiveValue(null);
  bool? get isCpProjects => _isCpProjects.value;
  // Does user have permission to watch projects and its getter
  final ReactiveValue<bool?> _isExcludeProjects = ReactiveValue(null);
  bool? get isExcludeProjects => _isExcludeProjects.value;
  // Allow the users to update lead stage for only for leads assigned to them
  final ReactiveValue<bool?> _isEditLeadStageForMyLeads = ReactiveValue(null);
  bool? get isEditLeadStageForMyLeads => _isEditLeadStageForMyLeads.value;
  // Allow user to update the lead stage of any leads for their projects
  final ReactiveValue<bool?> _isEditLeadStageForDST = ReactiveValue(null);
  bool? get isEditLeadStageForDST => _isEditLeadStageForDST.value;
  // Allow users to view all CP and DST leads of all projects
  // Allows users to view Channel Partner leads associated for their projects
  final ReactiveValue<bool?> _isShowCPTab = ReactiveValue(null);
  bool? get isShowCPTab => _isShowCPTab.value;
  // Allow users to view all CP and DST leads of all projects
  // Allows the users to view all leads for their projects
  final ReactiveValue<bool?> _isShowDSTTab = ReactiveValue(null);
  bool? get isShowDSTTab => _isShowDSTTab.value;
  // Allows the users to view all leads for their projects
  final ReactiveValue<bool?> _isShowCPTabForCPUser = ReactiveValue(null);
  bool? get isShowCPTabForCPUser => _isShowCPTabForCPUser.value;
  // Allows to view leads history of the particular lead
  final ReactiveValue<bool?> _isShowLeadHistory = ReactiveValue(null);
  bool? get isShowLeadHistory => _isShowLeadHistory.value;
  // Allows users to view their leads only
  final ReactiveValue<bool?> _isShowMyLeads = ReactiveValue(null);
  bool? get isShowMyLeads => _isShowMyLeads.value;
  // Allows the user to call any lead which he can view through cloud call.
  final ReactiveValue<bool?> _isShowNormalCallForDST = ReactiveValue(null);
  bool? get isShowNormalCallForDST => _isShowNormalCallForDST.value;
  // Allows the user to call any lead which he can view through cloud call
  final ReactiveValue<bool?> _isShowCloudCallForDST = ReactiveValue(null);
  bool? get isShowCloudCallForDST => _isShowCloudCallForDST.value;
  // Allow the user to call only their assigned leads through normal call
  final ReactiveValue<bool?> _isShowNormalCallForMyLead = ReactiveValue(null);
  bool? get isShowNormalCallForMyLead => _isShowNormalCallForMyLead.value;
  // Allow the user to call only their assigned leads through cloud call
  final ReactiveValue<bool?> _isShowCloudCallDSTForMyLead = ReactiveValue(null);
  bool? get isShowCloudCallDSTForMyLead => _isShowCloudCallDSTForMyLead.value;
  // Allows to archive any lead that a user can view
  final ReactiveValue<bool?> _isEnableArchive = ReactiveValue(null);
  bool? get isEnableArchive => _isEnableArchive.value;
  // Allows to create followups for any leads that a user can view
  final ReactiveValue<bool?> _isEnableFollowUp = ReactiveValue(null);
  bool? get isEnableFollowUp => _isEnableFollowUp.value;
  // Allow to view followups for any leads that a user can view and the scheduled followups for assigned leads from dashboard
  final ReactiveValue<bool?> _isEnableView = ReactiveValue(null);
  bool? get isEnableView => _isEnableView.value;
  // Allow creation of DST User
  final ReactiveValue<bool?> _isCreateDSTUser = ReactiveValue(null);
  bool? get isCreateDSTUser => _isCreateDSTUser.value;
  // Allow approval or rejection of Channel Partner registration application
  final ReactiveValue<bool?> _isReviewCP = ReactiveValue(null);
  bool? get isReviewCP => _isReviewCP.value;
  // Allow approval or rejection of Channel Partner registration application
  final ReactiveValue<bool?> _isCreateCPUser = ReactiveValue(null);
  bool? get isCreateCPUser => _isCreateCPUser.value;
  // Allow capture of leads for projects assigned to a user
  final ReactiveValue<bool?> _isCaptureLead = ReactiveValue(null);
  bool? get isCaptureLead => _isCaptureLead.value;
  // Allow deactivating a channel partner. All users associated with the channel partner will be automatically deactivated
  final ReactiveValue<bool?> _isDeactivateCP = ReactiveValue(null);
  bool? get isDeactivateCP => _isDeactivateCP.value;
  // Allows a DST user to view the approved channel partner list
  final ReactiveValue<bool?> _isViewChannelPartner = ReactiveValue(null);
  bool? get isViewChannelPartner => _isViewChannelPartner.value;
  // Allows a DST user to view the channel partner detail screen
  final ReactiveValue<bool?> _isViewCPDetail = ReactiveValue(null);
  bool? get isViewCPDetail => _isViewCPDetail.value;
  // Allows the users to assign their project to Channel Partners from Channel Partner List
  final ReactiveValue<bool?> _isAssignChannelPartnerToProjects =
      ReactiveValue(null);
  bool? get isAssignChannelPartnerToProjects =>
      _isAssignChannelPartnerToProjects.value;
  // Allows users to remove Channel Partners from their projects from the project list
  final ReactiveValue<bool?> _isRemoveChannelPartnerFromProject =
      ReactiveValue(null);
  bool? get isRemoveChannelPartnerFromProject =>
      _isRemoveChannelPartnerFromProject.value;
  // Allows users to remove Channel Partners from their projects from the project list
  final ReactiveValue<bool?> _isViewAllIncomingCallRecords =
      ReactiveValue(null);
  bool? get isViewAllIncomingCallRecords => _isViewAllIncomingCallRecords.value;
  // This permission allows the user to view unidentified incoming calls for assgined projects
  final ReactiveValue<bool?> _isViewUnIdentifyCallRecords = ReactiveValue(null);
  bool? get isViewUnIdentifyCallRecords => _isViewUnIdentifyCallRecords.value;
  // This permission allows the user to view identified incoming calls assigned projects
  final ReactiveValue<bool?> _isViewIdentifyCallRecords = ReactiveValue(null);
  bool? get isViewIdentifyCallRecords => _isViewIdentifyCallRecords.value;
  // Allow to view all the upcoming site visits that are scheduled for projects assigned to the user
  final ReactiveValue<bool?> _isViewSiteVisit = ReactiveValue(null);
  bool? get isViewSiteVisit => _isViewSiteVisit.value;
  // Allows to edit follow up details for any lead that a user can view
  final ReactiveValue<bool?> _isEditFollowUp = ReactiveValue(null);
  bool? get isEditFollowUp => _isEditFollowUp.value;
  // Allow reassigning of leads that are assigned to the user, his subordinates and unassigned leads
  final ReactiveValue<bool?> _isReassignLead = ReactiveValue(null);
  bool? get isReassignLead => _isReassignLead.value;
  // Allow user to update the lead stage of any leads for their projects
  final ReactiveValue<bool?> _isUpdateLeadStage = ReactiveValue(null);
  bool? get isUpdateLeadStage => _isUpdateLeadStage.value;
  // Allow the users to view all the call records in lead details screen
  final ReactiveValue<bool?> _isAccessCallRecording = ReactiveValue(null);
  bool? get isAccessCallRecording => _isAccessCallRecording.value;
  // Allow the users to view all the call records in lead details screen
  final ReactiveValue<bool?> _isEditFollowUpMyLeads = ReactiveValue(null);
  bool? get isEditFollowUpMyLeads => _isEditFollowUpMyLeads.value;
  // Allow the user to update the followup outcome for all the leads that a user can view
  final ReactiveValue<bool?> _isUpdateFollowUp = ReactiveValue(null);
  bool? get isUpdateFollowUp => _isUpdateFollowUp.value;
  // Allow the user to update the followup outcome for assigned leads only
  final ReactiveValue<bool?> _isUpdateFollowUpMyLead = ReactiveValue(null);
  bool? get isUpdateFollowUpMyLead => _isUpdateFollowUpMyLead.value;
  // Allow the user to create followup for their assigned leads
  final ReactiveValue<bool?> _isCreateFollowUpMyLead = ReactiveValue(null);
  bool? get isCreateFollowUpMyLead => _isCreateFollowUpMyLead.value;
  // Allow the users to reassign only leads assigned that are assigned to them
  final ReactiveValue<bool?> _isShowAssignIconForMyLead = ReactiveValue(null);
  bool? get isShowAssignIconForMyLead => _isShowAssignIconForMyLead.value;
  // Allow the user to update status for any Lost or Sold leads that a user can view
  final ReactiveValue<bool?> _isEditLeadStageForSoldLost = ReactiveValue(null);
  bool? get isEditLeadStageForSoldLost => _isEditLeadStageForSoldLost.value;
  // Allows to activate an already deactivated user either by DST user or by a Channel Partner User as the case may be.
  final ReactiveValue<bool?> _isActivateUser = ReactiveValue(null);
  bool? get isActivateUser => _isActivateUser.value;
  // Allow to deactivate a user either by DST user or by a Channel Partner User as the case may be.
  final ReactiveValue<bool?> _isDeactivateUser = ReactiveValue(null);
  bool? get isDeactivateUser => _isDeactivateUser.value;
  // Allows the users to assign their subordinates to assigned project
  final ReactiveValue<bool?> _isAssignUserToProject = ReactiveValue(null);
  bool? get isAssignUserToProject => _isAssignUserToProject.value;
  // Allows the user to remove their subordinate users from their projects
  final ReactiveValue<bool?> _isRemoveUserToProject = ReactiveValue(null);
  bool? get isRemoveUserToProject => _isRemoveUserToProject.value;
  // Allow a DST user to see Channel Partner users list
  final ReactiveValue<bool?> _isViewCPUser = ReactiveValue(null);
  bool? get isViewCPUser => _isViewCPUser.value;
  // This permission allows to view the list of users -if DST any user - able to see all DST users -if CP any user - able to see the all the user of their organization
  final ReactiveValue<bool?> _isViewAllUser = ReactiveValue(null);
  bool? get isViewAllUser => _isViewAllUser.value;
  // Allows DST users to view their subordinate users only
  final ReactiveValue<bool?> _isViewMyTeamUser = ReactiveValue(null);
  bool? get isViewMyTeamUser => _isViewMyTeamUser.value;
  //
  final ReactiveValue<bool?> _isAssignMyProjectToCP = ReactiveValue(null);
  bool? get isAssignMyProjectToCP => _isAssignMyProjectToCP.value;
  //
  final ReactiveValue<bool?> _isAssignMyProjectToUser = ReactiveValue(null);
  bool? get isAssignMyProjectToUser => _isAssignMyProjectToUser.value;
  //
  final ReactiveValue<bool?> _isAssignProjectToCP = ReactiveValue(null);
  bool? get isAssignProjectToCP => _isAssignProjectToCP.value;
  //
  final ReactiveValue<bool?> _isRemoveMyProjectToCP = ReactiveValue(null);
  bool? get isRemoveMyProjectToCP => _isRemoveMyProjectToCP.value;
  //
  final ReactiveValue<bool?> _isRemoveMyProjectToUser = ReactiveValue(null);
  bool? get isRemoveMyProjectToUser => _isRemoveMyProjectToUser.value;
  //
  final ReactiveValue<bool?> _isRemoveProjectToCP = ReactiveValue(null);
  bool? get isRemoveProjectToCP => _isRemoveProjectToCP.value;
  // Allows to view list and details of all projects
  final ReactiveValue<bool?> _isViewAllProject = ReactiveValue(null);
  bool? get isViewAllProject => _isViewAllProject.value;
  //
  final ReactiveValue<bool?> _isViewCPProject = ReactiveValue(null);
  bool? get isViewCPProject => _isViewCPProject.value;
  //
  final ReactiveValue<bool?> _isViewMyProject = ReactiveValue(null);
  bool? get isViewMyProject => _isViewMyProject.value;
  final ReactiveValue<String> _userProfile = ReactiveValue('');
  String get userProfile => _userProfile.value;
  final ReactiveValue<String> _userName = ReactiveValue('');
  String get userName => _userName.value;
  SharedService() {
    listenToReactiveValues([
      _isCallRecording,
      _isCp,
      _isDstUser,
      _isLeads,
      _isProjects,
      _permission,
      _userId,
      _isEditLeadStageForMyLeads,
      _isEditLeadStageForDST,
      _isShowCPTab,
      _isShowDSTTab,
      _isShowCPTabForCPUser,
      _isShowLeadHistory,
      _isShowCloudCallDSTForMyLead,
      _isShowNormalCallForMyLead,
      _isShowCloudCallForDST,
      _isShowNormalCallForDST,
      _isEnableArchive,
      _isEnableFollowUp,
      _isEnableView,
      _isCreateDSTUser,
      _isReviewCP,
      _isCreateCPUser,
      _isCaptureLead,
      _isDeactivateCP,
      _isViewChannelPartner,
      _isViewCPDetail,
      _isAssignChannelPartnerToProjects,
      _isRemoveChannelPartnerFromProject,
      _isViewAllIncomingCallRecords,
      _isViewIdentifyCallRecords,
      _isViewUnIdentifyCallRecords,
      _isViewSiteVisit,
      _isEditFollowUp,
      _isReassignLead,
      _isUpdateLeadStage,
      _isAccessCallRecording,
      _isEditFollowUpMyLeads,
      _isUpdateFollowUp,
      _isUpdateFollowUpMyLead,
      _isCreateFollowUpMyLead,
      _isShowMyLeads,
      _isShowAssignIconForMyLead,
      _isEditLeadStageForSoldLost,
      _isActivateUser,
      _isDeactivateUser,
      _isAssignUserToProject,
      _isRemoveUserToProject,
      _isViewCPUser,
      _isViewMyTeamUser,
      _isViewAllUser,
      _isAssignMyProjectToCP,
      _isAssignMyProjectToUser,
      _isAssignProjectToCP,
      _isRemoveMyProjectToCP,
      _isRemoveMyProjectToUser,
      _isRemoveProjectToCP,
      _isViewAllProject,
      _isViewCPProject,
      _isViewMyProject,
      _userProfile,
      _userName
    ]);
  }

  // This method prepare permission details of user and provide the globaly through the app
  Future<bool> prepareUserPermission() async {
    var prefs = await SharedPreferences.getInstance();
    var permissionString = prefs.getStringList('permissions_array');
    // var permissionString = ['57', '3','65','66'];
    var projectList = prefs.getString('project_list');
    var userID = prefs.getInt('user_type_id');
    var name = prefs.getString('user_name');
    var profile = prefs.getString('user_profile');
    _userName.value = name!;
    _userProfile.value = profile!;
    _userId.value = userID;
    _isLeads.value = isPermissionAvailable(permissionString!,
        filterPermissions: ['10', '69', '72', '76']);
    // _isCallRecording.value = isPermissionAvailable(permissionString,
    //     filterPermissions: ['43', '44'], requiredPermissions: ['33']);
    _isCallRecording.value =
        isPermissionAvailable(permissionString, filterPermissions: ['33']);
    _isProjects.value = isPermissionAvailable(permissionString,
        filterPermissions: ['54', '56', '57']);
    _isCpProjects.value = isPermissionAvailable(
      permissionString,
      filterPermissions: ['57'],
    );
    _isExcludeProjects.value = isPermissionAvailable(permissionString,
        filterPermissions: ['50'],
        requiredPermissions: ['55'],
        excludePermissions: ['49']);
    _isDstProjects.value = isPermissionAvailable(permissionString,
        filterPermissions: ['54'], requiredPermissions: ['56']);
    _isDstUser.value = isAccountTypePermissionAvailable(
        permissionString, ['3', '65'],
        userTypeId: 1, currentUserId: userID!);
    _isCp.value = isAccountTypePermissionAvailable(permissionString, ['13'],
        userTypeId: 2, currentUserId: userID);

    _isEditLeadStageForMyLeads.value = isPermissionAvailable(
      permissionString,
      filterPermissions: ['31'],
    );
    _isEditLeadStageForDST.value = isPermissionAvailable(
      permissionString,
      filterPermissions: ['7'],
    );
    _isEditLeadStageForSoldLost.value = isPermissionAvailable(
      permissionString,
      filterPermissions: ['58'],
    );
    _isShowDSTTab.value = isAccountTypePermissionAvailable(
        permissionString, ['10', '69'],
        userTypeId: 1, currentUserId: userID);
    _isShowCPTab.value = isAccountTypePermissionAvailable(
        permissionString, ['10', '72'],
        userTypeId: 1, currentUserId: userID);
    _isShowCPTabForCPUser.value = isAccountTypePermissionAvailable(
        permissionString, ['69'],
        userTypeId: 2, currentUserId: userID);
    _isShowMyLeads.value = isPermissionAvailable(
      permissionString,
      filterPermissions: ['76'],
    );
    _isShowLeadHistory.value = isPermissionAvailable(
      permissionString,
      filterPermissions: ['12'],
    );
    _isShowNormalCallForDST.value = isPermissionAvailable(
      permissionString,
      filterPermissions: ['20'],
    );
    _isShowCloudCallForDST.value = isAccountTypePermissionAvailable(
        permissionString, ['18'],
        userTypeId: 1, currentUserId: userID);
    _isShowNormalCallForMyLead.value = isPermissionAvailable(
      permissionString,
      filterPermissions: ['27'],
    );
    _isShowCloudCallDSTForMyLead.value = isAccountTypePermissionAvailable(
        permissionString, ['28'],
        userTypeId: 1, currentUserId: userID);
    _isEnableArchive.value = isPermissionAvailable(
      permissionString,
      filterPermissions: ['23'],
    );
    _isEnableFollowUp.value = isPermissionAvailable(
      permissionString,
      filterPermissions: ['24'],
    );
    _isEnableView.value = isPermissionAvailable(
      permissionString,
      filterPermissions: ['25'],
    );
    _isEditFollowUp.value = isPermissionAvailable(
      permissionString,
      filterPermissions: ['26'],
    );
    _isCreateDSTUser.value = isAccountTypePermissionAvailable(
        permissionString, ['1'],
        userTypeId: 1, currentUserId: userID);
    _isReviewCP.value = isAccountTypePermissionAvailable(
        permissionString, ['3'],
        userTypeId: 1, currentUserId: userID);
    _isCreateCPUser.value = isAccountTypePermissionAvailable(
        permissionString, ['4'],
        userTypeId: 2, currentUserId: userID);
    _isCaptureLead.value = isPermissionAvailable(
          permissionString,
          filterPermissions: ['5'],
        ) &&
        projectList!.contains('project_id');
    _isDeactivateCP.value = isAccountTypePermissionAvailable(
        permissionString, ['8'],
        userTypeId: 1, currentUserId: userID);
    _isAssignChannelPartnerToProjects.value = isAccountTypePermissionAvailable(
        permissionString, ['62'],
        userTypeId: 1, currentUserId: userID);
    _isRemoveChannelPartnerFromProject.value = isAccountTypePermissionAvailable(
        permissionString, ['63'],
        userTypeId: 1, currentUserId: userID);
    _isViewChannelPartner.value = isAccountTypePermissionAvailable(
        permissionString, ['65'],
        userTypeId: 1, currentUserId: userID);
    _isViewCPDetail.value = isAccountTypePermissionAvailable(
        permissionString, ['66'],
        userTypeId: 1, currentUserId: userID);
    _isViewAllIncomingCallRecords.value = isAccountTypePermissionAvailable(
        permissionString, ['46'],
        userTypeId: 1, currentUserId: userID);
    _isViewIdentifyCallRecords.value = isAccountTypePermissionAvailable(
        permissionString, ['43'],
        userTypeId: 1, currentUserId: userID);
    _isViewUnIdentifyCallRecords.value = isAccountTypePermissionAvailable(
        permissionString, ['44'],
        userTypeId: 1, currentUserId: userID);
    _isViewSiteVisit.value = isAccountTypePermissionAvailable(
        permissionString, ['19'],
        userTypeId: 1, currentUserId: userID);
    _isReassignLead.value = isAccountTypePermissionAvailable(
        permissionString, ['6'],
        userTypeId: 1, currentUserId: userID);
    _isUpdateLeadStage.value = isAccountTypePermissionAvailable(
        permissionString, ['7'],
        userTypeId: 1, currentUserId: userID);
    _isAccessCallRecording.value = isAccountTypePermissionAvailable(
        permissionString, ['21'],
        userTypeId: 1, currentUserId: userID);
    _isEditFollowUpMyLeads.value = isPermissionAvailable(
      permissionString,
      filterPermissions: ['30'],
    );
    _isUpdateFollowUp.value = isPermissionAvailable(
      permissionString,
      filterPermissions: ['34'],
    );
    _isUpdateFollowUpMyLead.value = isPermissionAvailable(
      permissionString,
      filterPermissions: ['35'],
    );
    _isCreateFollowUpMyLead.value = isPermissionAvailable(
      permissionString,
      filterPermissions: ['37'],
    );
    _isShowAssignIconForMyLead.value = isPermissionAvailable(
      permissionString,
      filterPermissions: ['32'],
    );
    _isActivateUser.value = isPermissionAvailable(
      permissionString,
      filterPermissions: ['17'],
    );
    _isDeactivateUser.value = isPermissionAvailable(
      permissionString,
      filterPermissions: ['9'],
    );
    _isAssignUserToProject.value = isPermissionAvailable(
      permissionString,
      filterPermissions: ['60'],
    );
    _isRemoveUserToProject.value = isPermissionAvailable(
      permissionString,
      filterPermissions: ['61'],
    );
    _isViewCPUser.value = isAccountTypePermissionAvailable(
        permissionString, ['74'],
        userTypeId: 1, currentUserId: userID);
    _isViewMyTeamUser.value = isPermissionAvailable(
      permissionString,
      filterPermissions: ['73'],
    );
    _isViewAllUser.value = isPermissionAvailable(
      permissionString,
      filterPermissions: ['13'],
    );
    _isAssignMyProjectToCP.value = isAccountTypePermissionAvailable(
        permissionString, ['55'],
        userTypeId: 1, currentUserId: userID);
    _isAssignMyProjectToUser.value = isPermissionAvailable(
      permissionString,
      filterPermissions: ['49'],
    );
    _isAssignProjectToCP.value = isAccountTypePermissionAvailable(
        permissionString, ['50'],
        userTypeId: 1, currentUserId: userID);

    _isRemoveMyProjectToCP.value = isAccountTypePermissionAvailable(
        permissionString, ['53'],
        userTypeId: 1, currentUserId: userID);
    _isRemoveMyProjectToUser.value = isPermissionAvailable(
      permissionString,
      filterPermissions: ['51'],
    );
    _isRemoveProjectToCP.value = isAccountTypePermissionAvailable(
        permissionString, ['67'],
        userTypeId: 1, currentUserId: userID);
    _isViewAllProject.value = isPermissionAvailable(
      permissionString,
      filterPermissions: ['54'],
    );
    _isViewCPProject.value = isAccountTypePermissionAvailable(
        permissionString, ['57'],
        userTypeId: 1, currentUserId: userID);
    _isViewMyProject.value = isPermissionAvailable(
      permissionString,
      filterPermissions: ['56'],
    );
    try {} on ApiError catch (e) {
      log(e.toString());
    }

    return true;
  }

  // This method validate user permissions based on his User-Id
  // Note* for using && condition make sure to provide User type id and current user id and list of permission id must to have parameter.
  bool isAccountTypePermissionAvailable(
      List<String> allPermissions, List<String> filterPermission,
      {List<String>? requiredPermissions,
      required int userTypeId,
      required int currentUserId}) {
    if (userTypeId == currentUserId) {
      return isPermissionAvailable(
        allPermissions,
        filterPermissions: filterPermission,
        requiredPermissions: requiredPermissions,
      );
    }
    return false;
  }

  // This method validate user permissions allowed from admin
  // Note* for using && condition make sure to provide list of permission_id(required permmision) is must to have and for just || condition of permision don't pass the required permission parameter.
  bool isPermissionAvailable(
    List<String> allPermissions, {
    List<String>? filterPermissions,
    List<String>? requiredPermissions,
    List<String>? excludePermissions,
  }) {
    if (excludePermissions != null && excludePermissions.isNotEmpty) {
      for (var excludePermission in excludePermissions) {
        if (!allPermissions.contains(excludePermission)) {
          if (filterPermissions == null &&
              requiredPermissions != null &&
              requiredPermissions.isNotEmpty) {
            for (var requiredPermission in requiredPermissions) {
              if (allPermissions.contains(requiredPermission)) return true;
            }
            return false;
          } else if (requiredPermissions != null &&
              requiredPermissions.isNotEmpty) {
            for (var requiredPermission in requiredPermissions) {
              if (allPermissions.contains(requiredPermission)) {
                if (filterPermissions!.isNotEmpty) {
                  for (var filterPermission in filterPermissions) {
                    if (allPermissions.contains(filterPermission)) return true;
                  }
                  return false;
                }
                return false;
              }
              return false;
            }
            return false;
          } else {
            for (var filterPermission in filterPermissions!) {
              if (allPermissions.contains(filterPermission)) return true;
            }
            return false;
          }
        }
        return false;
      }
      return false;
    } else {
      if (filterPermissions == null &&
          requiredPermissions != null &&
          requiredPermissions.isNotEmpty) {
        for (var requiredPermission in requiredPermissions) {
          if (allPermissions.contains(requiredPermission)) return true;
        }
        return false;
      } else if (requiredPermissions != null &&
          requiredPermissions.isNotEmpty) {
        for (var requiredPermission in requiredPermissions) {
          if (allPermissions.contains(requiredPermission)) {
            if (filterPermissions!.isNotEmpty) {
              for (var filterPermission in filterPermissions) {
                if (allPermissions.contains(filterPermission)) return true;
              }
              return false;
            }
            return false;
          }
          return false;
        }
        return false;
      } else {
        for (var filterPermission in filterPermissions!) {
          if (allPermissions.contains(filterPermission)) return true;
        }
        return false;
      }
    }
  }
}
