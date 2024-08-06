// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedBottomsheetGenerator
// **************************************************************************

import 'package:stacked_services/stacked_services.dart';

import 'app.locator.dart';
import '../ui/bottom_sheets/active_users/active_users_sheet.dart';
import '../ui/bottom_sheets/add_user_to_project/add_user_to_project_sheet.dart';
import '../ui/bottom_sheets/assign_connect_to/assign_connect_to_sheet.dart';
import '../ui/bottom_sheets/assign_lead/assign_lead_sheet.dart';
import '../ui/bottom_sheets/assign_project/assign_project_sheet.dart';
import '../ui/bottom_sheets/assign_project_cp/assign_project_cp_sheet.dart';
import '../ui/bottom_sheets/assign_project_to_user/assign_project_to_user_sheet.dart';
import '../ui/bottom_sheets/assigned_projects/assigned_projects_sheet.dart';
import '../ui/bottom_sheets/bank_details/bank_details_sheet.dart';
import '../ui/bottom_sheets/camera_gallery_picker/camera_gallery_picker_sheet.dart';
import '../ui/bottom_sheets/change_lead_stage/change_lead_stage_sheet.dart';
import '../ui/bottom_sheets/confirm_site_visit/confirm_site_visit_sheet.dart';
import '../ui/bottom_sheets/current_project/currentproject_sheet.dart';
import '../ui/bottom_sheets/date_picker/date_picker_sheet.dart';
import '../ui/bottom_sheets/filter_by/filter_by_sheet.dart';
import '../ui/bottom_sheets/follow_up_filter/follow_up_filter_sheet.dart';
import '../ui/bottom_sheets/history/history_sheet.dart';
import '../ui/bottom_sheets/hong_on/hangon_sheet.dart';
import '../ui/bottom_sheets/leads_filter/filter_sheet.dart';
import '../ui/bottom_sheets/notice/notice_sheet.dart';
import '../ui/bottom_sheets/play_call_record/play_call_record_sheet.dart';
import '../ui/bottom_sheets/project_document/project_document_sheet.dart';
import '../ui/bottom_sheets/record_audio/record_audio_sheet.dart';
import '../ui/bottom_sheets/registration_process/registration_process_sheet.dart';
import '../ui/bottom_sheets/remove_from_project/remove_from_project_sheet.dart';
import '../ui/bottom_sheets/remove_project/remove_project_sheet.dart';
import '../ui/bottom_sheets/remove_project_cp/remove_project_cp_sheet.dart';
import '../ui/bottom_sheets/remove_project_from_user/remove_project_from_user_sheet.dart';
import '../ui/bottom_sheets/remove_user_from_project/remove_user_from_project_sheet.dart';
import '../ui/bottom_sheets/show_bank_account_details/showbankaccountdetails_sheet.dart';
import '../ui/bottom_sheets/time_picker/time_picker_sheet.dart';
import '../ui/bottom_sheets/update_follow_up/update_follow_up_sheet.dart';

enum BottomSheetType {
  notice,
  registrationProcess,
  hangOn,
  assignConnectTo,
  bankDetails,
  filterBy,
  recordAudio,
  datePicker,
  assignLead,
  changeLeadStage,
  history,
  filter,
  showBankAccountDetails,
  currentProject,
  timePicker,
  activeUsers,
  allUserAssignProject,
  removeFromProject,
  assignProjectCp,
  assignedProjects,
  followUpFilter,
  updateFollowUp,
  projectDocument,
  confirmSiteVisit,
  removeProjectFromUser,
  assignProjectToUser,
  addUserToProject,
  removeUserFromProject,
  playCallRecord,
  cameraGalleryPicker,
  removeProjectCp,
  removeProject,
}

void setupBottomSheetUi() {
  final bottomsheetService = locator<BottomSheetService>();

  final Map<BottomSheetType, SheetBuilder> builders = {
    BottomSheetType.notice: (context, request, completer) =>
        NoticeSheet(request: request, completer: completer),
    BottomSheetType.registrationProcess: (context, request, completer) =>
        RegistrationProcessSheet(request: request, completer: completer),
    BottomSheetType.hangOn: (context, request, completer) =>
        HangOnSheet(request: request, completer: completer),
    BottomSheetType.assignConnectTo: (context, request, completer) =>
        AssignConnectToSheet(request: request, completer: completer),
    BottomSheetType.bankDetails: (context, request, completer) =>
        BankDetailsSheet(request: request, completer: completer),
    BottomSheetType.filterBy: (context, request, completer) =>
        FilterBySheet(request: request, completer: completer),
    BottomSheetType.recordAudio: (context, request, completer) =>
        RecordAudioSheet(request: request, completer: completer),
    BottomSheetType.datePicker: (context, request, completer) =>
        DatePickerSheet(request: request, completer: completer),
    BottomSheetType.assignLead: (context, request, completer) =>
        AssignLeadSheet(request: request, completer: completer),
    BottomSheetType.changeLeadStage: (context, request, completer) =>
        ChangeLeadStageSheet(request: request, completer: completer),
    BottomSheetType.history: (context, request, completer) =>
        HistorySheet(request: request, completer: completer),
    BottomSheetType.filter: (context, request, completer) =>
        FilterSheet(request: request, completer: completer),
    BottomSheetType.showBankAccountDetails: (context, request, completer) =>
        ShowBankAccountDetailsSheet(request: request, completer: completer),
    BottomSheetType.currentProject: (context, request, completer) =>
        CurrentProjectSheet(request: request, completer: completer),
    BottomSheetType.timePicker: (context, request, completer) =>
        TimePickerSheet(request: request, completer: completer),
    BottomSheetType.activeUsers: (context, request, completer) =>
        ActiveUsersSheet(request: request, completer: completer),
    BottomSheetType.allUserAssignProject: (context, request, completer) =>
        AllUserAssignProjectSheet(request: request, completer: completer),
    BottomSheetType.removeFromProject: (context, request, completer) =>
        RemoveFromProjectSheet(request: request, completer: completer),
    BottomSheetType.assignProjectCp: (context, request, completer) =>
        AssignProjectCpSheet(request: request, completer: completer),
    BottomSheetType.assignedProjects: (context, request, completer) =>
        AssignedProjectsSheet(request: request, completer: completer),
    BottomSheetType.followUpFilter: (context, request, completer) =>
        FollowUpFilterSheet(request: request, completer: completer),
    BottomSheetType.updateFollowUp: (context, request, completer) =>
        UpdateFollowUpSheet(request: request, completer: completer),
    BottomSheetType.projectDocument: (context, request, completer) =>
        ProjectDocumentSheet(request: request, completer: completer),
    BottomSheetType.confirmSiteVisit: (context, request, completer) =>
        ConfirmSiteVisitSheet(request: request, completer: completer),
    BottomSheetType.removeProjectFromUser: (context, request, completer) =>
        RemoveProjectFromUserSheet(request: request, completer: completer),
    BottomSheetType.assignProjectToUser: (context, request, completer) =>
        AssignProjectToUserSheet(request: request, completer: completer),
    BottomSheetType.addUserToProject: (context, request, completer) =>
        AddUserToProjectSheet(request: request, completer: completer),
    BottomSheetType.removeUserFromProject: (context, request, completer) =>
        RemoveUserFromProjectSheet(request: request, completer: completer),
    BottomSheetType.playCallRecord: (context, request, completer) =>
        PlayCallRecordSheet(request: request, completer: completer),
    BottomSheetType.cameraGalleryPicker: (context, request, completer) =>
        CameraGalleryPickerSheet(request: request, completer: completer),
    BottomSheetType.removeProjectCp: (context, request, completer) =>
        RemoveProjectCpSheet(request: request, completer: completer),
    BottomSheetType.removeProject: (context, request, completer) =>
        RemoveProjectSheet(request: request, completer: completer),
  };

  bottomsheetService.setCustomSheetBuilders(builders);
}
