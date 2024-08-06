import 'dart:async';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/api/api_error.dart';
import '/app/app.router.dart';
import '/enum/index.dart';
import '/services/index.dart';
import '/ui/common/images.dart';
import '/app/app.locator.dart';
import '/model/index.dart';
import '/app/app.dialogs.dart';
import '/app/app.bottomsheets.dart';
import '/ui/views/create_user/create_user_view.form.dart';

// User image path
String userImagePath = '';

// Designation dropdown initial value
OptionItem designationOption = OptionItem(title: "");

// Reporting dropdown initial value
OptionItem reportingOption = OptionItem(title: "");
int? designationId;
int? reportingToId;

class CreateUserViewModel extends FormViewModel {
  final navigationService = locator<NavigationService>();
  final bottomSheetService = locator<BottomSheetService>();
  final dialogService = locator<DialogService>();

//Go to back page
  void goBack() {
    navigationService.back();
  }

  //Otp Timer---------------------------------------------------------------------------------------------------------------------------------------------
  late Timer emailOtpTimer;
  late Timer mobileOtpTimer;
// Designation dropdown value change notifier
  onDesignationChange(OptionItem value, index) {
    reportingDropListModel.clear();
    reportingOption = OptionItem(title: "");
    designationOption = designationDropList[index];
    designationId =
        designationData['designation_list'][index]['designation_id'];
    reportingToId = designationData['designation_list'][index]
        ['reporting_to_designation_id'];

    getReportingTo(
        designationData['designation_list'][index]['designation_id']);

    notifyListeners();
  }

// Reporting dropdown value change notifier
  onReportingChange(OptionItem value, index) {
    reportingOption = reportingDropListModel[index];

    notifyListeners();
  }

  // Pick user image from given image source
  pickUserImage(ImageSource source) async {
    await ImagePicker()
        .pickImage(source: source, maxHeight: 500, maxWidth: 500)
        .then((image) {
      if (image == null) {
        return;
      } else {
        userImagePath = image.path;
        notifyListeners();
      }
    });
  }

  //Show Change lead Bottomsheet
  void showImagePickerBottomSheet() async {
    var res = await bottomSheetService.showCustomSheet(
      variant: BottomSheetType.cameraGalleryPicker,
      isScrollControlled: true,
    );
    if (res!.confirmed == true) {
      pickUserImage(res.data);
    }
  }

  // Show success dialog when user is succesfully created
  void showSuccessDialog(String name) {
    dialogService.showCustomDialog(
      title: 'User Successfully Created',
      mainButtonTitle: 'ASSIGN PROJECTS',
      data: designationOption.title,
      description: name,
      secondaryButtonTitle: 'NOT NOW',
      imageUrl: Images().checked,
      variant: DialogType.userCreate,
      barrierDismissible: true,
    );
  }

  //Timer string value
  int emailTimerDuration = 30;
  int mobileTimerDuration = 30;
  String get emailTimerText {
    int seconds = emailTimerDuration % 60;
    return seconds.toString().padLeft(2, "0");
  }

  String get mobileTimerText {
    int seconds = mobileTimerDuration % 60;
    return seconds.toString().padLeft(2, "0");
  }

//Start Timer
  void verifyOtpViewInit() {
    emailOtpTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (emailTimerDuration > 0) {
        emailTimerDuration--;
        notifyListeners();
      } else {
        emailOtpTimer.cancel();
      }
    });
    mobileOtpTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mobileTimerDuration > 0) {
        mobileTimerDuration--;
        notifyListeners();
      } else {
        mobileOtpTimer.cancel();
      }
    });
  }

  goToOtp() {
    navigationService.navigateToVerifyUserView();
  }

  ///validators
  @override
  void setFormStatus() {
    setNameValidationMessage(requiredValidator(value: nameValue));
    setEmailValidationMessage(emailValidatior(emailValue!));
    setMobileValidationMessage(phoneNumberValidator(value: mobileValue));
  }

// Required name
  requiredValidator({String? value}) {
    if (value!.trim().isEmpty) {
      return 'Required';
    }
    return null;
  }

  // phone validation Field
  phoneNumberValidator({String? value}) {
    if (value!.trim().isEmpty) {
      return 'Required';
    } else if (value.length < 10) {
      return 'Invalid mobile number';
    }
    return null;
  }

  //email validator
  final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');

  emailValidatior(String value) {
    if (value.isNotEmpty && !emailRegex.hasMatch(value)) {
      return 'Invalid email address';
    }
  }

  bool isFormValid(bool isUserDstMember) {
    if (isUserDstMember) {
      return nameValue!.trim().isNotEmpty &&
              designationOption.title.isNotEmpty &&
              reportingOption.title.isNotEmpty &&
              mobileValue!.length == 10 && emailValue!.isEmpty||
          emailRegex.hasMatch(emailValue!);

    } else {
      return nameValue!.trim().isNotEmpty &&
              designationOption.title.isNotEmpty &&
              mobileValue!.length == 10 && emailValue!.isEmpty ||
          emailRegex.hasMatch(emailValue!);

    }
  }


  //////////////////////Api work//////////////////////
  final AuthService _authService = locator<AuthService>();
  final _snackbarService = locator<SnackbarService>();

  CreateUserViewModel() {
    getDesignationUserType();
    designationOption = OptionItem(title: "");
    reportingOption = OptionItem(title: "");

  }
//get designation drop down list
  Map designationData = {};
  List<OptionItem> designationDropList = [];
  void getDesignationUserType() async {
    setBusy(true);
    try {
      var res = await _authService.getDesignation();
      designationData = res.data['data'];
      for (var i = 0; i < designationData['designation_list'].length; i++) {
        designationDropList.add(OptionItem(
            title: designationData['designation_list'][i]['designation_name']));
      }
      notifyListeners();
    } on Error catch (e) {
      log('get Add Dst error = $e');
    } finally {
      setBusy(false);
    }
  }

  //get reportingTo DropDown List
  Map reportingData = {};
  List<OptionItem> reportingDropListModel = [];
  void getReportingTo(int id) async {
    setBusy(true);
    try {
      var res = await _authService.getReportsTo(id);
      reportingData = res.data['data'];
      for (var i = 0; i < reportingData['user_list'].length; i++) {
        reportingDropListModel
            .add(OptionItem(title: reportingData['user_list'][i]['name']));
      }
      notifyListeners();
    } on Error catch (e) {
      log('get Add Dst error = $e');
    } finally {
      setBusy(false);
    }
  }

  //Send otp on email and mobile
  sendEmailAndMobileVerificationOtp({
    required String email,
    required String mobile,
  }) async {
    try {
      setBusy(true);
      var prefs = await SharedPreferences.getInstance();
      await _authService.generatedOtp(mobile, email).then((value) {
        if (value.data['code'] == 200) {
          _snackbarService.showCustomSnackBar(
              message: value.data['message'], variant: SnackbarType.success);
          goToOtp();
          prefs.setString(
              'email_session_id', value.data['data']['email_session_id']);
          prefs.setString(
              'sms_session_id', value.data['data']['sms_session_id']);
        } else {
          _snackbarService.showCustomSnackBar(
              message: value.data['message'], variant: SnackbarType.error);
        }
      });
    } on ApiError catch (e) {
      log(e.toString());
    } finally {
      setBusy(false);
    }
  }

  //Restart Timer and resend otp on mobile
  void restartMobileOtpTimer(context, {String? mobileNumber}) async {
    mobileOtpTimer.cancel();
    await _authService
        .resendCPOtp(mobileNumber: mobileNumber)
        .then((value) async {
      if (value.data['code'] == 200) {
        _snackbarService.showCustomSnackBar(
            message: value.data['message'], variant: SnackbarType.success);
        var prefs = await SharedPreferences.getInstance();
        prefs.setString('sms_session_id', value.data['data']['sms_session_id']);
      } else {
        _snackbarService.showCustomSnackBar(
            message: value.data['message'], variant: SnackbarType.error);
      }
    });
    mobileTimerDuration = 30;
    mobileOtpTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mobileTimerDuration > 0) {
        mobileTimerDuration--;
        notifyListeners();
      } else {
        mobileOtpTimer.cancel();
      }
    });
    notifyListeners();
  }

  //Restart Timer and resend otp on Email
  void restartEmailOtpTimer(context, {String? email}) async {
    emailOtpTimer.cancel();
    await _authService.resendCPOtp(email: email).then((value) async {
      if (value.data['code'] == 200) {
        _snackbarService.showCustomSnackBar(
            message: value.data['message'], variant: SnackbarType.success);
        var prefs = await SharedPreferences.getInstance();
        prefs.setString(
            'email_session_id', value.data['data']['email_session_id']);
      } else {
        _snackbarService.showCustomSnackBar(
            message: value.data['message'], variant: SnackbarType.error);
      }
    });
    emailTimerDuration = 30;
    emailOtpTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (emailTimerDuration > 0) {
        emailTimerDuration--;
        notifyListeners();
      } else {
        emailOtpTimer.cancel();
      }
    });
    notifyListeners();
  }

  //Verify Channel partner email and mobile Otp
  otpVerification(
      {required TextEditingController email,
      required TextEditingController mobile,
      required TextEditingController emailOtp,
      required TextEditingController mobileNumberOtp,
      required TextEditingController name,
      required String profilePicture}) async {
    var prefs = await SharedPreferences.getInstance();
    try {
      setBusy(true);
      String emailSessionId = prefs.getString('email_session_id')!;
      String mobileNumberSessionId = prefs.getString('sms_session_id')!;

      await _authService
          .otpVerification(
              email: email.text,
              mobileNumber: mobile.text,
              emailOtp: emailOtp.text,
              mobileNumberOtp: mobileNumberOtp.text,
              emailSessionId: emailSessionId,
              mobileNumberSessionId: mobileNumberSessionId)
          .then((value) async {
        if (value.data['code'] == 200) {
          createUser(
              email: email,
              mobile: mobile,
              name: name,
              profilePicture: profilePicture,
              emailOtp: emailOtp,
              phoneOtp: mobileNumberOtp
              );
          // _snackbarService.showCustomSnackBar(
          //     message: value.data['message'], variant: SnackbarType.success);

          prefs.clear();
        } else {
          _snackbarService.showCustomSnackBar(
              message: value.data['message'], variant: SnackbarType.error);
        }
      });
    } on ApiError catch (e) {
      log(e.toString());
    } finally {
      setBusy(false);
    }
  }

  //Verify Channel partner email and mobile Otp
  createUser(
      {required TextEditingController email,
      required TextEditingController mobile,
      required TextEditingController name,
      required String profilePicture,
      required  TextEditingController phoneOtp,
      required  TextEditingController emailOtp
      }) async {
    try {
      setBusy(true);
      FormData formData = FormData.fromMap({
        'mobile_number': mobile,
        'email_address': email,
        'designation_id': designationId,
        'reporting_to_id': reportingToId,
        'name': name,
        'Profile_picture': profilePicture,
      });

      await _authService.createUser(formData).then((value) async {
        if (value.data['code'] == 200) {
          navigationService.navigateToHomeView(pageIndex: 0);
          showSuccessDialog(name.text);
          email.clear();
          mobile.clear();
          name.clear();
          userImagePath = '';
          designationOption = OptionItem(title: '');
          reportingOption = OptionItem(title: "");
          phoneOtp.clear();
          emailOtp.clear();

        } else {
          _snackbarService.showCustomSnackBar(
              message: value.data['message'], variant: SnackbarType.error);
        }
      });
    } on ApiError catch (e) {
      log(e.toString());
    } finally {
      setBusy(false);
    }
  }
}
