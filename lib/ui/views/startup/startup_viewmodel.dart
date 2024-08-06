import 'dart:developer';
import 'dart:io';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import '/services/app_service.dart';
import '/services/auth_service.dart';
import '/app/app.locator.dart';
import '/app/app.router.dart';

bool isSplashScreenOn = false;

class StartupViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final AppService _appService = locator<AppService>();
  final AuthService _authService = locator<AuthService>();
  Future runStartupLogic() async {
    try {
      await Future.wait(
        [
          _appService.bootstrap(),
          Future.delayed(Duration(seconds: Platform.isAndroid ? 5 : 0))
              .then((value) {
            isSplashScreenOn = false;
            notifyListeners();
          }),
        ],
      );
      if (Platform.isIOS) {
        FlutterNativeSplash.remove();
      }
      if (_authService.isAuthorized) {
        _navigationService.clearStackAndShow(Routes.homeView,
            arguments: const HomeViewArguments(pageIndex: 0));
      } else {
        _navigationService.clearStackAndShow(Routes.mobileNumberView);
      }
    } on Error catch (error) {
      log('$error');
    }
  }

  StartupViewModel() {
    if (Platform.isAndroid) {
      isSplashScreenOn = true;
      notifyListeners();
    }
  }
}
