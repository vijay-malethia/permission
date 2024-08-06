import 'package:sales_lead/ui/views/primary_person_detail/agreement/agreement_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

// Import views
import '/ui/views/primary_person_detail/account_detail/account_detail_view.dart';
import '/ui/views/primary_person_detail/application_success/application_success_view.dart';
import '/ui/views/primary_person_detail/basic_detail/basic_detail_view.dart';
import '/ui/views/primary_person_detail/tax_document/tax_document_view.dart';
import '/ui/views/all_project/all_project_view.dart';
import '/ui/views/allusers/allusers_view.dart';
import '/ui/views/signin/otp_view.dart';
import '/ui/views/channel_partner/channelpartnercarddetais_view.dart';
import '/ui/views/home/home_view.dart';
import '/ui/views/startup/startup_view.dart';
import '/ui/views/primary_person_detail/verify_otp/verify_otp_view.dart';

import '/ui/views/primary_person_detail/tax_document/tax_detail_view.dart';
import '/ui/views/lead/caputre_lead/capture_lead_view.dart';
import '/ui/views/lead/all_leads/all_leads_view.dart';
import '/ui/views/incoming_call/incoming_call_view.dart';
import '/ui/views/channel_partner/channel_partner_view.dart';
import '/ui/views/lead/schedule/schedule_view.dart';
import '/ui/views/create_user/create_user_view.dart';
import '/ui/views/lead/follow_up_details/follow_up_detail_view.dart';
import '/ui/views/signin/mobile_number_view.dart';
import '/ui/views/primary_person_detail/primary_person_detail/primary_person_details_view.dart';
import '/ui/views/upcoming_follow_ups/upcoming_follow_ups_view.dart';
import '/ui/views/project_detail/project_detail_view.dart';
import '/ui/views/scheduled_site_visits/scheduled_site_visits_view.dart';

// Import bottom sheets
import '/ui/bottom_sheets/filter_by/filter_by_sheet.dart';
import '/ui/bottom_sheets/record_audio/record_audio_sheet.dart';
import '/ui/bottom_sheets/time_picker/time_picker_sheet.dart';
import '/ui/bottom_sheets/active_users/active_users_sheet.dart';
import '/ui/bottom_sheets/date_picker/date_picker_sheet.dart';
import '/ui/bottom_sheets/assign_lead/assign_lead_sheet.dart';
import '/ui/bottom_sheets/change_lead_stage/change_lead_stage_sheet.dart';
import '/ui/bottom_sheets/history/history_sheet.dart';
import '/ui/bottom_sheets/leads_filter/filter_sheet.dart';
import '/ui/bottom_sheets/show_bank_account_details/showbankaccountdetails_sheet.dart';
import '/ui/bottom_sheets/current_project/currentproject_sheet.dart';
import '/ui/bottom_sheets/assign_project/assign_project_sheet.dart';
import '/ui/bottom_sheets/remove_from_project/remove_from_project_sheet.dart';
import '/ui/bottom_sheets/assigned_projects/assigned_projects_sheet.dart';
import '/ui/bottom_sheets/assign_project_cp/assign_project_cp_sheet.dart';
import '/ui/bottom_sheets/notice/notice_sheet.dart';
import '/ui/bottom_sheets/registration_process/registration_process_sheet.dart';
import '../ui/bottom_sheets/hong_on/hangon_sheet.dart';
import '/ui/bottom_sheets/assign_connect_to/assign_connect_to_sheet.dart';
import '/ui/bottom_sheets/bank_details/bank_details_sheet.dart';
import '/ui/bottom_sheets/follow_up_filter/follow_up_filter_sheet.dart';
import '/ui/bottom_sheets/update_follow_up/update_follow_up_sheet.dart';
import '/ui/bottom_sheets/project_document/project_document_sheet.dart';
import '/ui/bottom_sheets/confirm_site_visit/confirm_site_visit_sheet.dart';
import '/ui/bottom_sheets/remove_project_from_user/remove_project_from_user_sheet.dart';
import '/ui/bottom_sheets/assign_project_to_user/assign_project_to_user_sheet.dart';
import '/ui/bottom_sheets/add_user_to_project/add_user_to_project_sheet.dart';
import '/ui/bottom_sheets/remove_user_from_project/remove_user_from_project_sheet.dart';

// Import dialogs
import '/ui/dialogs/deactive/deactive_dialog.dart';
import '/ui/dialogs/confirm/confirm_dialog.dart';
import '/ui/dialogs/user_create/user_create_dialog.dart';
import '/ui/dialogs/info_alert/info_alert_dialog.dart';
import '/ui/dialogs/imge_preview/imge_preview_dialog.dart';
import '/ui/dialogs/disqualified/disqualified_dialog.dart';

// Import services
import '/services/index.dart';

import 'package:sales_lead/ui/views/create_user/verify_user_view.dart';

import 'package:sales_lead/ui/bottom_sheets/play_call_record/play_call_record_sheet.dart';

import 'package:sales_lead/ui/bottom_sheets/camera_gallery_picker/camera_gallery_picker_sheet.dart';

import 'package:sales_lead/ui/views/primary_person_detail/terms_condition/terms_condition_view.dart';

import 'package:sales_lead/ui/bottom_sheets/remove_project_cp/remove_project_cp_sheet.dart';

import 'package:sales_lead/ui/bottom_sheets/remove_project/remove_project_sheet.dart';

// @stacked-import
@StackedApp(
  routes: [
    MaterialRoute(page: HomeView),
    MaterialRoute(page: StartupView),
    MaterialRoute(page: MobileNumberView),
    MaterialRoute(page: OtpView),
    MaterialRoute(page: PrimaryPersonDetailsView),
    MaterialRoute(page: ApplicationSuccessView),
    MaterialRoute(page: AgreementView),
    MaterialRoute(page: VerifyOtpView),
    MaterialRoute(page: BasicDetailView),
    MaterialRoute(page: AccountDetailView),
    MaterialRoute(page: TaxDetailView),
    MaterialRoute(page: TaxDocumentView),
    MaterialRoute(page: CaptureLeadView),
    MaterialRoute(page: AllLeadsView),
    MaterialRoute(page: AllusersView),
    MaterialRoute(page: IncomingCallView),
    MaterialRoute(page: ChannelPartnerView),
    MaterialRoute(page: ChannelpartnercarddetaisView),
    MaterialRoute(page: ScheduleView),
    MaterialRoute(page: CreateUserView),
    MaterialRoute(page: FollowUpDetailView),
    MaterialRoute(page: UpcomingFollowUpsView),
    MaterialRoute(page: ProjectDetailView),
    MaterialRoute(page: ScheduledSiteVisitsView),
    MaterialRoute(page: AllProjectView),
    MaterialRoute(page: VerifyUserView),
    MaterialRoute(page: TermsConditionView),
// @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: SnackbarService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: AppService),
    LazySingleton(classType: AuthService),
    LazySingleton(classType: HomeService),
    LazySingleton(classType: SharedService),
    LazySingleton(classType: LeadService),
    LazySingleton(classType: RegistrationService),
    LazySingleton(classType: CPService),
    LazySingleton(classType: AllProjectService),
    LazySingleton(classType: CallRecordService),
    LazySingleton(classType: AllUserService),
    LazySingleton(classType: ScheduledSiteVisitsService),
    LazySingleton(classType: UpcomingFollowUpServices)
// @stacked-service
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
    StackedBottomsheet(classType: RegistrationProcessSheet),
    StackedBottomsheet(classType: HangOnSheet),
    StackedBottomsheet(classType: AssignConnectToSheet),
    StackedBottomsheet(classType: BankDetailsSheet),
    StackedBottomsheet(classType: FilterBySheet),
    StackedBottomsheet(classType: RecordAudioSheet),
    StackedBottomsheet(classType: DatePickerSheet),
    StackedBottomsheet(classType: AssignLeadSheet),
    StackedBottomsheet(classType: ChangeLeadStageSheet),
    StackedBottomsheet(classType: HistorySheet),
    StackedBottomsheet(classType: FilterSheet),
    StackedBottomsheet(classType: ShowBankAccountDetailsSheet),
    StackedBottomsheet(classType: CurrentProjectSheet),
    StackedBottomsheet(classType: TimePickerSheet),
    StackedBottomsheet(classType: ActiveUsersSheet),
    StackedBottomsheet(classType: AllUserAssignProjectSheet),
    StackedBottomsheet(classType: RemoveFromProjectSheet),
    StackedBottomsheet(classType: AssignProjectCpSheet),
    StackedBottomsheet(classType: AssignedProjectsSheet),
    StackedBottomsheet(classType: FollowUpFilterSheet),
    StackedBottomsheet(classType: UpdateFollowUpSheet),
    StackedBottomsheet(classType: ProjectDocumentSheet),
    StackedBottomsheet(classType: ConfirmSiteVisitSheet),
    StackedBottomsheet(classType: RemoveProjectFromUserSheet),
    StackedBottomsheet(classType: AssignProjectToUserSheet),
    StackedBottomsheet(classType: AddUserToProjectSheet),
    StackedBottomsheet(classType: RemoveUserFromProjectSheet),
    StackedBottomsheet(classType: PlayCallRecordSheet),
    StackedBottomsheet(classType: CameraGalleryPickerSheet),
    StackedBottomsheet(classType: RemoveProjectCpSheet),
    StackedBottomsheet(classType: RemoveProjectSheet),
// @stacked-bottom-sheet
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
    StackedDialog(classType: ConfirmDialog),
    StackedDialog(classType: UserCreateDialog),
    StackedDialog(classType: DeactiveDialog),
    StackedDialog(classType: ImgePreviewDialog),
    StackedDialog(classType: DisqualifiedDialog),
// @stacked-dialog
  ],
)
class App {}
