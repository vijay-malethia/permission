import 'dart:developer';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';

import '../api/endpoints.dart';
import '/api/http_request.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  bool _isAuthorized = false;
  get isAuthorized => _isAuthorized;

  Future<Response> generateOtp(
    String mobileNumber,
  ) async {
    return httpRequest.post(
      Endpoints.getOtp,
      data: {
        "mobile_Number": mobileNumber,
      },
    );
  }

  Future<Response> signInWithOtp({
    required String mobileNumber,
    required String otp,
    required String sessionId,
  }) async {
    return httpRequest.put(
      Endpoints.signInWithOtp,
      data: {
        "mobile_Number": mobileNumber,
        "otp": otp,
        "session_id": sessionId,
      },
    );
  }

  // Check token is valid or not
  Future<bool> prepareUserSession() async {
    try {
      _isAuthorized = false;
      var prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('auth_token');
      log(token.toString());
      if (token != null) {
        _isAuthorized = true;
        setToken(token);
      }
      return _isAuthorized;
    } catch (err) {
      return _isAuthorized;
    }
  }

  // Store current session id
  Future<bool> setSessionId(Response json) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString('session_id', json.data['data']['session_id']);
    return true;
  }

  // Store current user's authentication token
  Future<bool> setUserDetails(Response json) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString('auth_token', json.data['data']['token']);
    prefs.setInt('user_id', json.data['data']['userdetails']['user_type_id']);
    prefs.setInt(
        'user_type_id', json.data['data']['userdetails']['user_type_id']);
    prefs.setInt('channel_partner_id',
        json.data['data']['userdetails']['channel_partner_id'] ?? 0);
    prefs.setStringList(
        'permissions_array',
        json.data['data']['userdetails']['permissions_array']
            .toString()
            .split(','));

    prefs.setString(
        'user_name', json.data['data']['userdetails']['name'] ?? '');
    prefs.setString('user_profile',
        json.data['data']['userdetails']['profile_picture_url'] ?? '');
    prefs.setString('project_list',
        json.data['data']['userdetails']['project_list'].toString());
    await prepareUserSession();
    return true;
  }

  Future<String?> getId() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.id; // unique ID on Android
    }
    return '';
  }

  // clear storage and logout user from current session
  logout() async {
    String? deviceId = await getId();
    return httpRequest
        .get(Endpoints.signOut, data: {'device_unique_id': deviceId});
  }

//////////////////////Add dst user////////////////////////////
//get designation list
  Future<Response> getDesignation() async {
    return httpRequest.get(Endpoints.getDesignation);
  }

  //get reports to list
  Future<Response> getReportsTo(int id) async {
    return httpRequest.get('${Endpoints.getReportsTo}$id');
  }

  //genrate otp for verification
  Future<Response> generatedOtp(String mobileNumber, String email) async {
    return httpRequest.post(
        '${Endpoints.generateOTPForVerification}?mobile_number=$mobileNumber&email_address=$email');
  }

  // Resend email and mobile verification otp for new channel partner creation
  Future<Response> resendCPOtp({String? email, String? mobileNumber}) async {
    if (email == null) {
      return httpRequest.post(
          '${Endpoints.generateOTPForVerification}?mobile_number=$mobileNumber');
    } else {
      return httpRequest
          .post('${Endpoints.generateOTPForVerification}?email_address=$email');
    }
  }

  // Verify otp
  Future<Response> otpVerification({
    required String email,
    required String mobileNumber,
    required String emailOtp,
    required String mobileNumberOtp,
    required String emailSessionId,
    required String mobileNumberSessionId,
  }) async {
    return httpRequest.post(Endpoints.otpVerification, data: {
      "email_address": email,
      "mobile_Number": mobileNumber,
      "sms_otp": mobileNumberOtp,
      "email_otp": emailOtp,
      "sms_session_id": mobileNumberSessionId,
      "email_session_id": emailSessionId
    });
  }

  Future<Response> createUser(data) async {
    return httpRequest.post(Endpoints.createUser, data: data);
  }
}
