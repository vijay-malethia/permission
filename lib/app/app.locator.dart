// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedLocatorGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, implementation_imports, depend_on_referenced_packages

import 'package:stacked_services/src/bottom_sheet/bottom_sheet_service.dart';
import 'package:stacked_services/src/dialog/dialog_service.dart';
import 'package:stacked_services/src/navigation/navigation_service.dart';
import 'package:stacked_services/src/snackbar/snackbar_service.dart';
import 'package:stacked_shared/stacked_shared.dart';

import '../services/all_project_service.dart';
import '../services/all_user_service.dart';
import '../services/app_service.dart';
import '../services/auth_service.dart';
import '../services/call_record_service.dart';
import '../services/cp_service.dart';
import '../services/home_service.dart';
import '../services/lead_service.dart';
import '../services/registration_service.dart';
import '../services/scheduled_site_visits_service.dart';
import '../services/shared_service.dart';
import '../services/upcoming_follow_ups_service.dart';

final locator = StackedLocator.instance;

Future<void> setupLocator({
  String? environment,
  EnvironmentFilter? environmentFilter,
}) async {
// Register environments
  locator.registerEnvironment(
      environment: environment, environmentFilter: environmentFilter);

// Register dependencies
  locator.registerLazySingleton(() => BottomSheetService());
  locator.registerLazySingleton(() => SnackbarService());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => AppService());
  locator.registerLazySingleton(() => AuthService());
  locator.registerLazySingleton(() => HomeService());
  locator.registerLazySingleton(() => SharedService());
  locator.registerLazySingleton(() => LeadService());
  locator.registerLazySingleton(() => RegistrationService());
  locator.registerLazySingleton(() => CPService());
  locator.registerLazySingleton(() => AllProjectService());
  locator.registerLazySingleton(() => CallRecordService());
  locator.registerLazySingleton(() => AllUserService());
  locator.registerLazySingleton(() => ScheduledSiteVisitsService());
  locator.registerLazySingleton(() => UpcomingFollowUpServices());
}
