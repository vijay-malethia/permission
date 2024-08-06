import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '/api/api_error.dart';
import '/ui/common/index.dart';
import '/model/index.dart';
import '/enum/index.dart';
import '/services/index.dart';
import '/app/app.router.dart';
import '/app/app.dialogs.dart';
import '/app/app.locator.dart';
import '/app/app.bottomsheets.dart';
import '/ui/views/primary_person_detail/primary_person_detail/primary_person_details_view.form.dart';

File? gstinPath;
File? pancardPath;
File? reraCertificatePath;

class RegistrationViewModel extends FormViewModel {
  //Services---------------------------------------------------------------------------------------------------------------------------------------------
  final _navigationService = locator<NavigationService>();
  final _bottomSheetService = locator<BottomSheetService>();
  final _dialogService = locator<DialogService>();
  final _registrationService = locator<RegistrationService>();
  final _snackbarService = locator<SnackbarService>();

  //Integers---------------------------------------------------------------------------------------------------------------------------------------------
  int pageViewImageIndex = 0;
  //Controllers---------------------------------------------------------------------------------------------------------------------------------------------
  final scrollController = ScrollController();
  WebViewController controller = WebViewController(); //web controller
  WebViewController termsController = WebViewController();
  //Otp Timer---------------------------------------------------------------------------------------------------------------------------------------------
  late Timer emailOtpTimer;
  late Timer mobileOtpTimer;

  //Timer string value---------------------------------------------------------------------------------------------------------------------------------------------
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

  //Dropdown value---------------------------------------------------------------------------------------------------------------------------------------------
  OptionItem accountTypeOption = OptionItem(title: "Saving");
  OptionItem entityOption = OptionItem(title: "Select");

  //Dropdown value list---------------------------------------------------------------------------------------------------------------------------------------------
  List<OptionItem> entityDropListModel = [];
  List<OptionItem> accountTypeDropListModel = [
    OptionItem(title: "Saving"),
    OptionItem(title: "Currnet"),
    OptionItem(title: "Salary"),
  ];
  //bool---------------------------------------------------------------------------------------------------------------------------------------------
  bool invalidate = false;

  //Navigation methods---------------------------------------------------------------------------------------------------------------------------------------------
  //Navigate back
  void goBack() {
    _navigationService.back();
  }

  //Go to Home page
  goToHome() async {
    await _navigationService.clearStackAndShow(Routes.homeView,
        arguments: const HomeViewArguments(pageIndex: 0));
  }

  //Navigate back and cancel timer
  goBackToPrimaryDetailView() async {
    emailOtpTimer.cancel();
    mobileOtpTimer.cancel();

    _navigationService.back();
  }

  //Cancel timer and navigate to tax document page
  goToTaxDocumentSubmitPage({
    String? email,
    String? mobile,
    String? entityId,
    String? entityType,
    String? primarycontactname,
  }) async {
    emailOtpTimer.cancel();
    mobileOtpTimer.cancel();
    emailTimerDuration = 0;
    mobileTimerDuration = 0;
    notifyListeners();
    _navigationService.navigateTo(Routes.taxDocumentView,
        arguments: TaxDocumentViewArguments(
          email: email,
          mobileNumber: mobile,
          entityId: entityId,
          entityType: entityType,
          primarycontactname: primarycontactname,
        ));
  }

  //Go to Basic detail page
  goToBasicDetailPage({
    String? email,
    String? mobile,
    String? entityId,
    String? entityType,
    String? primarycontactname,
    String? gstin,
    String? panNumber,
    String? reraId,
  }) async {
    _navigationService.navigateTo(Routes.basicDetailView,
        arguments: BasicDetailViewArguments(
          email: email,
          mobileNumber: mobile,
          entityId: entityId,
          entityType: entityType,
          primarycontactname: primarycontactname,
          gstin: gstin,
          panNumber: panNumber,
          reraId: reraId,
        ));
  }

  //Navigate to Agreement view
  goToAgreementPage({
    String? accountNumber,
    String? ifscCode,
    String? bankName,
    String? accountHolderName,
    String? branchName,
    String? email,
    String? mobileNumber,
    String? primarycontactname,
    String? entityType,
    String? entityId,
    String? gstin,
    String? panNumber,
    String? reraId,
    String? channelPartnerName,
    String? primaryContactName,
    String? accountType,
    String? address1,
    String? city,
    String? state,
    String? zipCode,
    String? website,
    bool? isActive,
  }) async {
    await _navigationService.navigateTo(Routes.agreementView,
        arguments: AgreementViewArguments(
          accountNumber: accountNumber,
          ifscCode: ifscCode,
          bankName: bankName,
          accountHolderName: accountHolderName,
          branchName: branchName,
          email: email,
          mobileNumber: mobileNumber,
          entityType: entityType,
          entityId: entityId,
          gstin: gstin,
          panNumber: panNumber,
          reraId: reraId,
          channelPartnerName: channelPartnerName,
          primaryContactName: primaryContactName,
          accountType: accountType,
          address1: address1,
          city: city,
          state: state,
          zipCode: zipCode,
          website: website,
          isActive: isActive,
        ));
  }

  //On dropdown value change---------------------------------------------------------------------------------------------------------------------------------------------
  onEntityChange(OptionItem value, index) {
    for (var element in entityDropListModel) {
      if (element.title == entityDropListModel[index].title) {
        entityOption = entityDropListModel[index];
        notifyListeners();
      } else {}
    }
    notifyListeners();
  }

  onAccountTypeChange(OptionItem value, index) {
    for (var element in accountTypeDropListModel) {
      if (element.title == accountTypeDropListModel[index].title) {
        accountTypeOption = accountTypeDropListModel[index];
        notifyListeners();
      } else {}
    }
    notifyListeners();
  }

  refillAccountDetails() {
    invalidate = false;
    notifyListeners();
  }

  //Show custom dialog methods---------------------------------------------------------------------------------------------------------------------------------------------
  void showPreviewDialog(name) {
    _dialogService.showCustomDialog(
        variant: DialogType.imgePreview,
        data: name == 'Upload GSTIN'
            ? gstinPath
            : name == 'Upload PAN'
                ? pancardPath
                : reraCertificatePath);
  }

  //Show custom bottom sheet methods---------------------------------------------------------------------------------------------------------------------------------------------
  //Show loading bottomsheet
  showLoadingBottomSheet({
    String? email,
    String? mobile,
    String? entityId,
    String? entityType,
    String? primarycontactname,
  }) async {
    _bottomSheetService.showCustomSheet(
      variant: BottomSheetType.hangOn,
      barrierDismissible: false,
    );
    try {
      await Future.wait([Future.delayed(const Duration(seconds: 5))]);
      _navigationService.back();
      _navigationService.navigateTo(Routes.taxDetailView,
          arguments: TaxDetailViewArguments(
            email: email,
            mobileNumber: mobile,
            entityId: entityId,
            entityType: entityType,
            primarycontactname: primarycontactname,
          ));
    } on ApiError catch (e) {
      log(e.toString());
    }
  }

  //Show bank detail bottomsheet
  showBankBottomSheet({
    String? email,
    String? mobile,
    String? entityId,
    String? entityType,
    String? primarycontactname,
    String? gstin,
    String? panNumber,
    String? reraId,
    String? channelPartnerName,
    String? address,
    String? city,
    String? state,
    String? zipCode,
    String? website,
  }) async {
    await _bottomSheetService.showCustomSheet(
      variant: BottomSheetType.bankDetails,
      isScrollControlled: true,
      barrierDismissible: false,
      data: {
        "email": email,
        "mobile": mobile,
        "entityId": entityId,
        "entityType": entityType,
        "reraId": reraId,
        "primarycontactname": primarycontactname,
        "gstin": gstin,
        "panNumber": panNumber,
        "city": city,
        "address": address,
        "zipCode": zipCode,
        "state": state,
        "channelPartnerName": channelPartnerName,
        "website": website,
      },
    );
  }

  //Init methods---------------------------------------------------------------------------------------------------------------------------------------------
  //Get Entity type
  primaryPersonDetailViewInit() async {
    try {
      setBusy(true);
      await _registrationService
          .getEntitiesByType(type: 'EntityType')
          .then((value) {
        entityDropListModel = ListResponse<OptionItem>.fromJson(
            value.data['data']['entity_list'],
            (p0) => OptionItem.fromJson(p0)).data;
        notifyListeners();
      });
    } on ApiError catch (e) {
      log(e.toString());
    } finally {
      setBusy(false);
    }
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

  //Get Channel Partner Agreement
  void agreementInitState({
    String? channelPartnerName,
    String? primaryContactName,
    String? address,
    String? panNumber,
  }) async {
    try {
      setBusy(true);
      await _registrationService
          .getCPAgreement(
              cpName: channelPartnerName.toString(),
              cpAddress: address.toString(),
              cpPrimaryContactName: primaryContactName.toString(),
              panCardNumber: panNumber.toString())
          .then((value) {
        controller = WebViewController()
          ..loadHtmlString(value.data['data']['content'])
          ..setBackgroundColor(backgroundcolor);
      });
    } on ApiError catch (e) {
      log(e.toString());
    } finally {
      setBusy(false);
    }
  }

  //file methods---------------------------------------------------------------------------------------------------------------------------------------------
  //Show Change lead Bottomsheet
  void showImagePickerBottomSheet(String docType) async {
    var res = await _bottomSheetService.showCustomSheet(
      variant: BottomSheetType.cameraGalleryPicker,
      isScrollControlled: true,
    );
    if (res!.confirmed == true) {
      if (docType == 'GSTIN') {
        pickGstinImage(res.data);
      } else if (docType == 'PAN') {
        pickPancardImage(res.data);
      } else if (docType == 'RERA') {
        pickReraCertificateImage(res.data);
      }
    }
  }

  // Extract a common function to pick an image from the gallery.
  Future<XFile?> pickImageFromGallery(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    return image;
  }

// Update the pickGstinImage(), pickPancardImage(), and pickReraCertificateImage() functions to use the new pickImageFromGallery() function.
  Future<void> pickGstinImage(ImageSource source) async {
    XFile? gstinImagePath = await pickImageFromGallery(source);
    if (gstinImagePath != null) {
      gstinPath = File(gstinImagePath.path);
      notifyListeners();
    }
  }

  Future<void> pickPancardImage(ImageSource source) async {
    final pancardImagePath = await pickImageFromGallery(source);
    if (pancardImagePath != null) {
      pancardPath = File(pancardImagePath.path);
      notifyListeners();
    }
  }

  Future<void> pickReraCertificateImage(ImageSource source) async {
    final reraCertificateImagePath = await pickImageFromGallery(source);
    if (reraCertificateImagePath != null) {
      reraCertificatePath = File(reraCertificateImagePath.path);
      notifyListeners();
    }
  }

  bool isDataLoading = true;
  //terma & conditons and privacy policy
  getTermsAndConditons() {
    termsController = WebViewController()
      ..loadRequest(Uri.parse('http://terms.mcondev.com/'))
      ..setBackgroundColor(backgroundcolor);
    termsController = WebViewController()
      ..setBackgroundColor(backgroundcolor)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (String url) {
            isDataLoading = false;
            notifyListeners();
          },
        ),
      )
      ..loadRequest(Uri.parse('http://terms.mcondev.com/'));
    notifyListeners();
  }

  // API methods---------------------------------------------------------------------------------------------------------------------------------------------
  //Send otp on email and mobile
  sendEmailAndMobileVerificationOtp({
    required String email,
    required String mobile,
    required String entityId,
    required String primarycontactname,
  }) async {
    try {
      var prefs = await SharedPreferences.getInstance();
      await _registrationService
          .cpGenerationOtpForVerification(email: email, mobileNumber: mobile)
          .then((value) {
        if (value.data['code'] == 200) {
          _snackbarService.showCustomSnackBar(
              message: value.data['message'], variant: SnackbarType.success);
          prefs.setString(
              'email_session_id', value.data['data']['email_session_id']);
          prefs.setString(
              'sms_session_id', value.data['data']['sms_session_id']);
          _navigationService.navigateTo(Routes.verifyOtpView,
              arguments: VerifyOtpViewArguments(
                email: email,
                mobileNumber: mobile,
                entityId: entityId,
                entityType: entityOption.title,
                primarycontactname: primarycontactname,
              ));
        } else {
          _snackbarService.showCustomSnackBar(
              message: value.data['message'], variant: SnackbarType.error);
        }
      });
    } on ApiError catch (e) {
      log(e.toString());
    } finally {}
  }

  //Restart Timer and resend otp on mobile
  void restartMobileOtpTimer(context, {String? mobileNumber}) async {
    mobileOtpTimer.cancel();
    await _registrationService
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
    await _registrationService.resendCPOtp(email: email).then((value) async {
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
  channelPartnerVerification({
    required String email,
    required String mobile,
    required String emailOtp,
    required String mobileNumberOtp,
    required String entityId,
    required String entityType,
    required String primarycontactname,
  }) async {
    var prefs = await SharedPreferences.getInstance();
    try {
      String emailSessionId = prefs.getString('email_session_id')!;
      String mobileNumberSessionId = prefs.getString('sms_session_id')!;

      await _registrationService
          .channelPartnerVerification(
        email: email,
        mobileNumber: mobile,
        emailOtp: emailOtp,
        emailSessionId: emailSessionId,
        mobileNumberOtp: mobileNumberOtp,
        mobileNumberSessionId: mobileNumberSessionId,
      )
          .then((value) async {
        if (value.data['code'] == 200) {
          _snackbarService.showCustomSnackBar(
              message: value.data['message'], variant: SnackbarType.success);
          prefs.clear();
          goToTaxDocumentSubmitPage(
            email: email,
            mobile: mobile,
            entityId: entityId,
            entityType: entityType,
            primarycontactname: primarycontactname,
          );
        } else {
          _snackbarService.showCustomSnackBar(
              message: value.data['message'], variant: SnackbarType.error);
        }
      });
    } on ApiError catch (e) {
      log(e.toString());
    } finally {}
  }

  //verify bank details and navigate to account detail view
  bankVerification({
    required String accountNumber,
    required String ifsc,
    String? email,
    String? mobile,
    String? entityId,
    String? entityType,
    String? primarycontactname,
    String? gstin,
    String? panNumber,
    String? reraId,
    String? channelPartnerName,
    String? address,
    String? city,
    String? state,
    String? zipCode,
    String? website,
  }) async {
    try {
      setBusy(true);
      await _registrationService
          .bankVerification(accountNumber: accountNumber, ifscCode: ifsc)
          .then((value) {
        if (value.data['data']['name'] != null &&
            value.data['data']['ifsc'] != null) {
          _navigationService.navigateTo(Routes.accountDetailView,
              arguments: AccountDetailViewArguments(
                accountHolderName: value.data['data']['name'],
                accountNumber: accountNumber,
                bankName: value.data['data']['ifsc']['bank'],
                branchName: value.data['data']['ifsc']['branch'],
                ifscCode: value.data['data']['ifsc']['ifsc'],
                email: email,
                mobileNumber: mobile,
                entityId: entityId,
                entityType: entityType,
                primarycontactname: primarycontactname,
                gstin: gstin,
                panNumber: panNumber,
                reraId: reraId,
                address: address,
                channelPartnerName: channelPartnerName,
                city: city,
                isActive: value.data['data']['valid'],
                state: state,
                website: website,
                zipCode: zipCode,
              ));
        } else {
          _snackbarService.showCustomSnackBar(
              message: value.data['message'], variant: SnackbarType.error);
          invalidate = true;
          notifyListeners();
        }
      });
    } on ApiError catch (e) {
      log(e.toString());
      invalidate = true;
      notifyListeners();
    } finally {
      setBusy(false);
    }
  }

  //Create channel partner with previous filled details
  createChannelPartner({
    String? accountNumber,
    String? ifscCode,
    String? bankName,
    String? accountHolderName,
    String? branchName,
    String? email,
    String? mobileNumber,
    String? entityType,
    String? entityId,
    String? gstin,
    String? panNumber,
    String? reraId,
    String? channelPartnerName,
    String? primaryContactName,
    String? accountType,
    String? address1,
    String? city,
    String? state,
    String? zipCode,
    String? website,
    bool? isActive,
  }) async {
    try {
      setBusy(true);

      await _registrationService
          .createChannelPartner(
        channelPartnerName: channelPartnerName!,
        entityType: entityType!,
        entityId: entityId!,
        panNumber: panNumber!,
        gstin: gstin!,
        primaryContactName: primaryContactName!,
        primaryContactEmail: email!,
        primaryContactMobile: mobileNumber!,
        gstImageName: gstinPath!.path.toString().split('/').last,
        panImageName: pancardPath!.path.toString().split('/').last,
        reraImageName: reraCertificatePath!.path.toString().split('/').last,
        accountNumber: accountNumber!,
        accountType: accountType!,
        accountName: accountHolderName!,
        bankName: bankName!,
        branchName: branchName!,
        ifscCode: ifscCode!,
        isActive: isActive!,
        address1: address1,
        city: city,
        reraId: reraId,
        state: state,
        website: website,
        zipCode: zipCode,
      )
          .then((value) {
        if (value.data['code'] == 200) {
          _snackbarService.showCustomSnackBar(
              message: value.data['message'], variant: SnackbarType.success);
          _navigationService.navigateTo(Routes.applicationSuccessView,
              arguments: ApplicationSuccessViewArguments(
                  channelPartnerName: value.data['data']
                      ['channel_partner_name'],
                  channelPartnerId: value.data['data']['channel_partner_id'],
                  enrollmentNo: value.data['data']['enrollmentNo'],
                  name: value.data['data']['name'],
                  userId: value.data['data']['user_id']));
        } else {
          _snackbarService.showCustomSnackBar(
              message: value.data['message'], variant: SnackbarType.error);
        }
      });
    } catch (e) {
      log(e.toString());
    } finally {
      setBusy(false);
    }
  }

  //Send device details to BE
  insertDeviceDetail(
      {required int userId,
      required String deviceUniqueId,
      required String fcmToken,
      required String deviceModel,
      required String operatingSystem,
      required String osVersion}) async {
    await _registrationService
        .inserDeviceDetails(
            userId: userId,
            deviceUniqueId: deviceUniqueId,
            fcmToken: fcmToken,
            deviceModel: deviceModel,
            operatingSystem: operatingSystem,
            osVersion: osVersion)
        .then((value) {});
  }

//primary person button validation
  bool isFormValid() {
    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    return primaryPersonNameValue!.isNotEmpty &&
        entityOption.title != 'Select' &&
        entityIdValue!.isNotEmpty &&
        primaryPersonMobileValue!.length == 10 &&
        emailRegex.hasMatch(primaryPersonEmailValue!);
  }

  //tax document validation
  bool isDocFormValid() {
    return gstinPath != null && pancardPath != null;
  }
}
