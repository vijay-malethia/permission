import 'package:dio/dio.dart';

import '/api/endpoints.dart';
import '/api/http_request.dart';

class RegistrationService {
  //Get Entities
  Future<Response> getEntitiesByType({
    required String type,
  }) async {
    return httpRequest.get(
      Endpoints.getEntitiesByType + type,
    );
  }

  // Send email and mobile verification otp for new channel partner creation
  Future<Response> cpGenerationOtpForVerification({
    required String email,
    required String mobileNumber,
  }) async {
    return httpRequest.post(
        '${Endpoints.cpGenerationOtpForVerification}?email_address=$email&mobile_number=$mobileNumber',
        data: {});
  }

  // Resend email and mobile verification otp for new channel partner creation
  Future<Response> resendCPOtp({String? email, String? mobileNumber}) async {
    if (email == null) {
      return httpRequest.post(
          '${Endpoints.generateOTPForVerification}?mobile_number=$mobileNumber',
          data: {});
    } else {
      return httpRequest.post(
          '${Endpoints.generateOTPForVerification}?email_address=$email',
          data: {});
    }
  }

  // Verify email and mobile number for new channel partner
  Future<Response> channelPartnerVerification({
    required String email,
    required String mobileNumber,
    required String emailOtp,
    required String mobileNumberOtp,
    required String emailSessionId,
    required String mobileNumberSessionId,
  }) async {
    return httpRequest.post(
        '${Endpoints.channelPartnerVerification}?email_address=$email&mobile_number=$mobileNumber',
        data: {
          "email_address": email,
          "mobile_Number": mobileNumber,
          "sms_otp": mobileNumberOtp,
          "email_otp": emailOtp,
          "sms_session_id": mobileNumberSessionId,
          "email_session_id": emailSessionId,
        });
  }

  // Verify Bank credential and get bank details
  Future<Response> bankVerification({
    required String accountNumber,
    required String ifscCode,
  }) async {
    return httpRequest.get(
      '${Endpoints.bankVerification}?accountNumber=$accountNumber&ifsc=$ifscCode',
    );
  }

  // Get Channel Partner Agreement details
  Future<Response> getCPAgreement({
    required String cpName,
    required String cpAddress,
    required String cpPrimaryContactName,
    required String panCardNumber,
  }) async {
    return httpRequest.get(
      '${Endpoints.cpAgreement}?channelpartnername=$cpName&address=$cpAddress&primarycontactname=$cpPrimaryContactName&pan=$panCardNumber',
    );
  }

  // Create Channel Partner with all pervious details
  Future<Response> createChannelPartner({
    int? channelPartnerId,
    String? reraId,
    required String channelPartnerName,
    required String entityType,
    required String entityId,
    bool? otherCompany,
    String? otherCompanyName,
    String? projectID,
    required String panNumber,
    required String gstin,
    required String primaryContactName,
    required String primaryContactMobile,
    required String primaryContactEmail,
    String? password,
    String? address1,
    String? address2,
    String? city,
    String? state,
    String? zipCode,
    String? website,
    required String gstImageName,
    required String panImageName,
    required String reraImageName,
    String? latitude,
    String? longitude,
    required String accountNumber,
    required String accountType,
    required String accountName,
    required String bankName,
    required String branchName,
    required String ifscCode,
    int? bankCpId,
    int? createdBy,
    String? createdTs,
    int? updatedBy,
    String? updatedTs,
    required bool isActive,
    String? canceledChequeImgagePath,
    String? profilePicture,
  }) async {
    FormData formdata = FormData.fromMap({
      "channel_partner_id": channelPartnerId,
      "rera_id": reraId,
      "channel_partner_name": channelPartnerName,
      "entity_type": entityType,
      "entity_id": entityId,
      "other_company": otherCompany,
      "other_companyname": otherCompanyName,
      "project_id": projectID,
      "pan_no": panNumber,
      "gstin": gstin,
      "primary_contactname": primaryContactName,
      "primary_contactmobile": primaryContactMobile,
      "primary_contactemail": primaryContactEmail,
      "password": password,
      "address1": address1,
      "address2": address2,
      "city": city,
      "state": state,
      "zipcode": zipCode,
      "website": website,
      "gst_img_name": gstImageName,
      "pan_img_name": panImageName,
      "rera_img_name": reraImageName,
      "latiude": latitude,
      "longitude": longitude,
      "agreed_cp_agreement": true,
      "bankdetails": {
        "account_name": accountName,
        "account_type": accountType,
        "account_number": accountNumber,
        "bank_name": bankName,
        "branch": branchName,
        "ifsc_code": ifscCode,
        "channel_partner_id": bankCpId,
        "created_by": createdBy,
        "created_ts": createdTs,
        "updated_by": updatedBy,
        "updated_ts": updatedTs,
        "isactive": isActive,
        "canceled_cheque_img_path": canceledChequeImgagePath,
      },
      "profile_picture": profilePicture == null
          ? null
          : MultipartFile.fromFileSync(profilePicture)
    });
    return httpRequest.post(Endpoints.createChannelPartner, data: formdata);
  }

  // Add Device details
  Future<Response> inserDeviceDetails({
    required int userId,
    required String deviceUniqueId,
    required String fcmToken,
    required String deviceModel,
    required String operatingSystem,
    required String osVersion,
  }) async {
    return httpRequest.post(Endpoints.insertDeviceDetail, data: {
      "user_id": 0,
      "device_unique_id": deviceUniqueId,
      "device_token_fcm": fcmToken,
      "device_model": deviceModel,
      "operating_system": operatingSystem,
      "os_version": osVersion
    });
  }
}
