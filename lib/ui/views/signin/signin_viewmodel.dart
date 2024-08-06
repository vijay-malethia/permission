import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sales_lead/ui/common/widgets/index.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '/api/api_error.dart';
import '/app/app.bottomsheets.dart';
import '/enum/index.dart';
import '/services/index.dart';
import '/app/app.dialogs.dart';
import '/app/app.locator.dart';
import '/app/app.router.dart';
import '/ui/common/index.dart';
import 'mobile_number_view.form.dart';

class SigninViewModel extends FormViewModel {
  final bottomSheetService = locator<BottomSheetService>();
  final navigationService = locator<NavigationService>();
  final snackBarService = locator<SnackbarService>();
  final dialogService = locator<DialogService>();
  final authService = locator<AuthService>();
  final sharedService = locator<SharedService>();

  //show validation flag
  bool showValidation = false;

//check if all field ok then call api
  isSiginValid() {
    showValidation = true;
    if (phoneNumberValue!.length == 10) {
      signIn();
    }
    notifyListeners();
  }

  //Api failed dialog
  void onApiErrorDialog(String description) {
    dialogService.showCustomDialog(
        variant: DialogType.deactive,
        title: 'Sales Lead',
        description: description,
        mainButtonTitle: "OK",
        secondaryButtonTitle: '',
        barrierDismissible: true,
        imageUrl: Images().infoAlert);
  }

  void signIn() async {
    try {
      setBusy(true);
      await authService.generateOtp(phoneNumberValue.toString()).then((value) {
        if (value.data['code'] == 200) {
          authService.setSessionId(value);
          navigationService.navigateTo(Routes.otpView);
        } else {
          onApiErrorDialog(value.data['message']);
        }
      });
    } on ApiError catch (e) {
      snackBarService.showCustomSnackBar(
          variant: SnackbarType.error,
          message: 'this is error message ${e.message}',
          duration: const Duration(seconds: 2));
    } finally {
      setBusy(false);
    }
  }

  void signInWithOTP() async {
    try {
      setBusy(true);
      var prefs = await SharedPreferences.getInstance();
      var sessionID = prefs.getString('session_id');
      await authService
          .signInWithOtp(
              mobileNumber: phoneNumberValue.toString(),
              otp: otpValue.toString(),
              sessionId: sessionID.toString())
          .then((value) {
        if (value.data['code'] == 200) {
          authService.setUserDetails(value);
          sharedService.prepareUserPermission();
          navigationService.clearStackAndShow(Routes.homeView,
              arguments: const HomeViewArguments(pageIndex: 0));
          phoneNumberValue = '';
        } else {
          otpValue = '';
          onApiErrorDialog(value.data['message'].toString());
        }
      });
    } on ApiError catch (e) {
      snackBarService.showCustomSnackBar(
          variant: SnackbarType.error,
          message: e.statusCode.toString(),
          duration: const Duration(seconds: 2));
    } finally {
      setBusy(false);
    }
  }

  void showAssignConnectBottomSheet() async {
    await bottomSheetService.showCustomSheet(
        variant: BottomSheetType.assignConnectTo, isScrollControlled: true);
  }

  void goBack() {
    navigationService.back();
  }

  void showAlertDialog() {
    dialogService.showCustomDialog(
      variant: DialogType.infoAlert,
      barrierDismissible: true,
    );
  }

  isFormValid() {
    return otpValue!.length == 4;
  }

  verifyOtp() {
    if (isFormValid()) {
      navigationService.clearStackAndShow(Routes.homeView,
          arguments: const HomeViewArguments(pageIndex: 0));
    }
  }

  //Format Time
  int _timerDuration = 30; // Initial countdown time in seconds
  late Timer _timer;
  String get timerText {
    int seconds = _timerDuration % 60;
    return seconds.toString().padLeft(2, "0");
  }

  //Start Timer
  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timerDuration > 0) {
        _timerDuration--;
        notifyListeners();
      } else {
        _timer.cancel();
      }
    });
  }

  //Restart Timer
  void restartTimer(BuildContext context) {
    signIn();
    _timer.cancel(); // Stop the timer when countdown reaches 0
    _timerDuration = 30;
    startTimer();
    showCustomToast(context, 'OTP sent successfully', '');
  }

  bool isResendOTP() {
    return _timerDuration == 0;
  }
}
