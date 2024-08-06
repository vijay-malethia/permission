class Endpoints {
//Login API Endpoints
  static const String getOtp = 'GenerateOTP';
  static const String signInWithOtp = 'SigninWithOTP';
  static const String signOut = 'Signout';

  //Home Screen
  static const String dashBoardV2 = 'DashBoardV2';

  //Capture Lead
  static const String getActiveProjects = 'GetActiveProjects';
  static const String getUnitTypesByProjectId =
      'GetUnitTypesByProjectId?project_id=';
  static const String createLead = 'CreateLead';

//Register API Endpoints
  static const String getEntitiesByType = 'GetEntitiesByType?entitytype=';
  static const String cpGenerationOtpForVerification =
      'CPGenerationOTPForVerification';
  static const String generateOTPForVerification = 'GenerateOTPForVerification';
  static const String channelPartnerVerification = 'ChannelPartnerVerification';
  static const String gSTPANVerify = 'GSTPANVerify';
  static const String bankVerification = 'BankVerification';
  static const String cpAgreement = 'GetCPAgreement';
  static const String createChannelPartner = 'CreateChannelPartner';
  static const String insertDeviceDetail = 'InsertDeviceDetail';
  //channel partner
  static const String cpList = 'ChannelPartnersList?status_id=';
  static const String cpDetails = 'GetChannelPartnerById?channel_partner_id=';
  static const String cpActiveUser =
      'GetActiveUserByChannelPartnerId?channel_partner_id=';
  static const String cpCurrentProject =
      'GetAllProjectsByChannelPartnerId?channel_partner_id=';
  static const String cpAcceptReject =
      'approveChannelPartner?ChannelPartnerId=';
  static const String cpAssignProjectList =
      'GetProjectsListToAssign?page_no=1&user_type_id=1&cp_id=';
  static const String cpDeactive =
      'ChannelPartnerStatusUpdate?ChannelPartnerId=';
  static const String cpAssignProject =
      'AssignProjectToChannelPartner?project_id=';
  static const String cpProjectForRemove =
      'GetAssignedProjectsByChannelPartnerId?channel_partner_id=';
  static const String getUserToReassignCPLead =
      'GetUserToReassignCPLeads?project_id=';
  static const String removeProjectCp =
      'RemoveProjectFromCP?channel_partner_id=';

  //Lead
  static const String viewLeadsBySource = 'ViewLeadsBySource';
  static const String getLeadCurrentStages = 'GetLeadCurrentStages';
  static const String getAssignedLeads = 'GetAssignedLeads';
  static const String getActiveDSTListByLeadId =
      'GetActiveDSTListByLeadId?lead_id=';
  static const String leadAssignment = 'LeadAssignment';
  static const String leadStageUpdate = 'LeadStageUpdate';
  static const String getUserListForLeadFilter = 'GetUserListForLeadFilter';
  static const String getActiveProjectsForFilter = 'GetActiveProjectsForFilter';
  static const String getLeadListByChannelPartnerId =
      'GetLeadListByChannelPartnerId';
  static const String connectToCall = 'ConnectToCall?';
  static const String activeChannelPartnersList = 'ActiveChannelPartnersList';
  static const String updateFollowUpStatus = 'UpdateFollowUpStatus';

  //Schedule
  static const String getFollowupById = 'GetFollowupById?followup_id=';
  static const String editFollowUp = 'EditFollowUp';
  static const String getListOfCallRecordsByLeadId =
      'GetListOfCallRecordsByLeadId?lead_id=';

  //Add dst user
  static const String getDesignation = 'GetDesignationByUserType';
  static const String getReportsTo = 'GetDSTUserByDesignation?designation_id=';
  static const String otpVerification = 'OTPVerification';
  static const String createUser = 'CreateUserAfterLogin';

  //Follow Up
  static const String getFollowupTypes = 'GetFollowupTypes';
  static const String scheduleFollowup = 'ScheduleFollowup';
  static const String getFollowupTimeUnits = 'GetFollowupTimeUnits';
  static const String getFollowupsByLeadId = 'GetFollowupsByLeadId';
  static const String getFollowupStatusForSearch = 'GetFollowupStatusForSearch';

  //All Projects
  static const String getProjectDetailById = 'GetProjectDetailsById';
  static const String getAllProjectsToAssign = 'GetProjectsListToAssign';
  static const String getMyProjects = 'GetAllMyProjects';
  static const String getUnassignedUsersByProjectId =
      'GetUnassignedUsersByProjectId';
  static const String getAssignedUsersByProjectId =
      'GetAssignedUsersByProjectId';
  static const String getAssignedCpByProjectId = 'GetAssignedCPByProjectId';
  static const String getUnassignedCPByProjectId = 'GetUnassignedCPByProjectId';
  static const String assignProjectToUser = 'AssignProjectToUser';
  static const String removeProjectFromUser = 'RemoveProjectFromUser';
  static const String removeProjectFromCp = 'RemoveProjectFromCP';
  static const String assignProjectToChannelPartner =
      'AssignProjectToChannelPartner';
  //Icoming call record
  static const String getIncomingCallRecods =
      'GetAllIncomingCallRecords?page_no=';
  static const String disposeCall =
      'DisposeCallByCalldetailsId?call_details_id=';

  //All Users
  static const String viewTeamMembers = 'ViewMyTeamMembers';
  static const String getUserListByUserType = 'GetUserListByUserType';
  static const String getUserListByChannelPartnerId =
      'GetUserByChannelPartnerId';
  static const String getProjectsToAssignByUserId =
      'GetProjectsToAssignByUserId';
  static const String getAssignedProjectsbyUserID =
      'GetAssignedProjectsbyUserId';
  static const String changeUserStatus = 'ChangeUserStatus';
//Scheduled Site vistis
  static const String scheduledSiteVisits = 'GetScheduleSiteVisit?page_no=';
  static const String getSiteVisitCode = 'GetSiteVisitCode?site_visit_id=';
  static const String completeSiteVisit = 'CompleteSiteVisit?';

  //Upcoming follow ups

  static const String getUpComingFollowUps = 'GetUpcomingFollowups?';
  static const String getUpcomingFollowUpsCount =
      'GetFollowupDaysWithCount?monthYear=';
  static const String getUpScheduleSiteVisitCount =
      'GetSiteVisitDaysWithCount?monthYear=';
}
