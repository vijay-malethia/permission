// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedNavigatorGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/material.dart' as _i29;
import 'package:flutter/material.dart';
import 'package:sales_lead/model/lead_model.dart' as _i30;
import 'package:sales_lead/ui/views/all_project/all_project_view.dart' as _i26;
import 'package:sales_lead/ui/views/allusers/allusers_view.dart' as _i16;
import 'package:sales_lead/ui/views/channel_partner/channel_partner_view.dart'
    as _i18;
import 'package:sales_lead/ui/views/channel_partner/channelpartnercarddetais_view.dart'
    as _i19;
import 'package:sales_lead/ui/views/create_user/create_user_view.dart' as _i21;
import 'package:sales_lead/ui/views/create_user/verify_user_view.dart' as _i27;
import 'package:sales_lead/ui/views/home/home_view.dart' as _i2;
import 'package:sales_lead/ui/views/incoming_call/incoming_call_view.dart'
    as _i17;
import 'package:sales_lead/ui/views/lead/all_leads/all_leads_view.dart' as _i15;
import 'package:sales_lead/ui/views/lead/caputre_lead/capture_lead_view.dart'
    as _i14;
import 'package:sales_lead/ui/views/lead/follow_up_details/follow_up_detail_view.dart'
    as _i22;
import 'package:sales_lead/ui/views/lead/schedule/schedule_view.dart' as _i20;
import 'package:sales_lead/ui/views/primary_person_detail/account_detail/account_detail_view.dart'
    as _i11;
import 'package:sales_lead/ui/views/primary_person_detail/agreement/agreement_view.dart'
    as _i8;
import 'package:sales_lead/ui/views/primary_person_detail/application_success/application_success_view.dart'
    as _i7;
import 'package:sales_lead/ui/views/primary_person_detail/basic_detail/basic_detail_view.dart'
    as _i10;
import 'package:sales_lead/ui/views/primary_person_detail/primary_person_detail/primary_person_details_view.dart'
    as _i6;
import 'package:sales_lead/ui/views/primary_person_detail/tax_document/tax_detail_view.dart'
    as _i12;
import 'package:sales_lead/ui/views/primary_person_detail/tax_document/tax_document_view.dart'
    as _i13;
import 'package:sales_lead/ui/views/primary_person_detail/terms_condition/terms_condition_view.dart'
    as _i28;
import 'package:sales_lead/ui/views/primary_person_detail/verify_otp/verify_otp_view.dart'
    as _i9;
import 'package:sales_lead/ui/views/project_detail/project_detail_view.dart'
    as _i24;
import 'package:sales_lead/ui/views/scheduled_site_visits/scheduled_site_visits_view.dart'
    as _i25;
import 'package:sales_lead/ui/views/signin/mobile_number_view.dart' as _i4;
import 'package:sales_lead/ui/views/signin/otp_view.dart' as _i5;
import 'package:sales_lead/ui/views/startup/startup_view.dart' as _i3;
import 'package:sales_lead/ui/views/upcoming_follow_ups/upcoming_follow_ups_view.dart'
    as _i23;
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i31;

class Routes {
  static const homeView = '/home-view';

  static const startupView = '/startup-view';

  static const mobileNumberView = '/mobile-number-view';

  static const otpView = '/otp-view';

  static const primaryPersonDetailsView = '/primary-person-details-view';

  static const applicationSuccessView = '/application-success-view';

  static const agreementView = '/agreement-view';

  static const verifyOtpView = '/verify-otp-view';

  static const basicDetailView = '/basic-detail-view';

  static const accountDetailView = '/account-detail-view';

  static const taxDetailView = '/tax-detail-view';

  static const taxDocumentView = '/tax-document-view';

  static const captureLeadView = '/capture-lead-view';

  static const allLeadsView = '/all-leads-view';

  static const allusersView = '/allusers-view';

  static const incomingCallView = '/incoming-call-view';

  static const channelPartnerView = '/channel-partner-view';

  static const channelpartnercarddetaisView = '/channelpartnercarddetais-view';

  static const scheduleView = '/schedule-view';

  static const createUserView = '/create-user-view';

  static const followUpDetailView = '/follow-up-detail-view';

  static const upcomingFollowUpsView = '/upcoming-follow-ups-view';

  static const projectDetailView = '/project-detail-view';

  static const scheduledSiteVisitsView = '/scheduled-site-visits-view';

  static const allProjectView = '/all-project-view';

  static const verifyUserView = '/verify-user-view';

  static const termsConditionView = '/terms-condition-view';

  static const all = <String>{
    homeView,
    startupView,
    mobileNumberView,
    otpView,
    primaryPersonDetailsView,
    applicationSuccessView,
    agreementView,
    verifyOtpView,
    basicDetailView,
    accountDetailView,
    taxDetailView,
    taxDocumentView,
    captureLeadView,
    allLeadsView,
    allusersView,
    incomingCallView,
    channelPartnerView,
    channelpartnercarddetaisView,
    scheduleView,
    createUserView,
    followUpDetailView,
    upcomingFollowUpsView,
    projectDetailView,
    scheduledSiteVisitsView,
    allProjectView,
    verifyUserView,
    termsConditionView,
  };
}

class StackedRouter extends _i1.RouterBase {
  final _routes = <_i1.RouteDef>[
    _i1.RouteDef(
      Routes.homeView,
      page: _i2.HomeView,
    ),
    _i1.RouteDef(
      Routes.startupView,
      page: _i3.StartupView,
    ),
    _i1.RouteDef(
      Routes.mobileNumberView,
      page: _i4.MobileNumberView,
    ),
    _i1.RouteDef(
      Routes.otpView,
      page: _i5.OtpView,
    ),
    _i1.RouteDef(
      Routes.primaryPersonDetailsView,
      page: _i6.PrimaryPersonDetailsView,
    ),
    _i1.RouteDef(
      Routes.applicationSuccessView,
      page: _i7.ApplicationSuccessView,
    ),
    _i1.RouteDef(
      Routes.agreementView,
      page: _i8.AgreementView,
    ),
    _i1.RouteDef(
      Routes.verifyOtpView,
      page: _i9.VerifyOtpView,
    ),
    _i1.RouteDef(
      Routes.basicDetailView,
      page: _i10.BasicDetailView,
    ),
    _i1.RouteDef(
      Routes.accountDetailView,
      page: _i11.AccountDetailView,
    ),
    _i1.RouteDef(
      Routes.taxDetailView,
      page: _i12.TaxDetailView,
    ),
    _i1.RouteDef(
      Routes.taxDocumentView,
      page: _i13.TaxDocumentView,
    ),
    _i1.RouteDef(
      Routes.captureLeadView,
      page: _i14.CaptureLeadView,
    ),
    _i1.RouteDef(
      Routes.allLeadsView,
      page: _i15.AllLeadsView,
    ),
    _i1.RouteDef(
      Routes.allusersView,
      page: _i16.AllusersView,
    ),
    _i1.RouteDef(
      Routes.incomingCallView,
      page: _i17.IncomingCallView,
    ),
    _i1.RouteDef(
      Routes.channelPartnerView,
      page: _i18.ChannelPartnerView,
    ),
    _i1.RouteDef(
      Routes.channelpartnercarddetaisView,
      page: _i19.ChannelpartnercarddetaisView,
    ),
    _i1.RouteDef(
      Routes.scheduleView,
      page: _i20.ScheduleView,
    ),
    _i1.RouteDef(
      Routes.createUserView,
      page: _i21.CreateUserView,
    ),
    _i1.RouteDef(
      Routes.followUpDetailView,
      page: _i22.FollowUpDetailView,
    ),
    _i1.RouteDef(
      Routes.upcomingFollowUpsView,
      page: _i23.UpcomingFollowUpsView,
    ),
    _i1.RouteDef(
      Routes.projectDetailView,
      page: _i24.ProjectDetailView,
    ),
    _i1.RouteDef(
      Routes.scheduledSiteVisitsView,
      page: _i25.ScheduledSiteVisitsView,
    ),
    _i1.RouteDef(
      Routes.allProjectView,
      page: _i26.AllProjectView,
    ),
    _i1.RouteDef(
      Routes.verifyUserView,
      page: _i27.VerifyUserView,
    ),
    _i1.RouteDef(
      Routes.termsConditionView,
      page: _i28.TermsConditionView,
    ),
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.HomeView: (data) {
      final args = data.getArgs<HomeViewArguments>(nullOk: false);
      return _i29.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i2.HomeView(pageIndex: args.pageIndex, key: args.key),
        settings: data,
      );
    },
    _i3.StartupView: (data) {
      return _i29.MaterialPageRoute<dynamic>(
        builder: (context) => const _i3.StartupView(),
        settings: data,
      );
    },
    _i4.MobileNumberView: (data) {
      return _i29.MaterialPageRoute<dynamic>(
        builder: (context) => const _i4.MobileNumberView(),
        settings: data,
      );
    },
    _i5.OtpView: (data) {
      return _i29.MaterialPageRoute<dynamic>(
        builder: (context) => const _i5.OtpView(),
        settings: data,
      );
    },
    _i6.PrimaryPersonDetailsView: (data) {
      return _i29.MaterialPageRoute<dynamic>(
        builder: (context) => const _i6.PrimaryPersonDetailsView(),
        settings: data,
      );
    },
    _i7.ApplicationSuccessView: (data) {
      final args = data.getArgs<ApplicationSuccessViewArguments>(nullOk: false);
      return _i29.MaterialPageRoute<dynamic>(
        builder: (context) => _i7.ApplicationSuccessView(
            channelPartnerName: args.channelPartnerName,
            channelPartnerId: args.channelPartnerId,
            enrollmentNo: args.enrollmentNo,
            name: args.name,
            userId: args.userId,
            key: args.key),
        settings: data,
      );
    },
    _i8.AgreementView: (data) {
      final args = data.getArgs<AgreementViewArguments>(
        orElse: () => const AgreementViewArguments(),
      );
      return _i29.MaterialPageRoute<dynamic>(
        builder: (context) => _i8.AgreementView(
            accountHolderName: args.accountHolderName,
            accountNumber: args.accountNumber,
            bankName: args.bankName,
            branchName: args.branchName,
            ifscCode: args.ifscCode,
            email: args.email,
            mobileNumber: args.mobileNumber,
            gstin: args.gstin,
            panNumber: args.panNumber,
            reraId: args.reraId,
            entityId: args.entityId,
            entityType: args.entityType,
            channelPartnerName: args.channelPartnerName,
            address1: args.address1,
            city: args.city,
            state: args.state,
            zipCode: args.zipCode,
            website: args.website,
            isActive: args.isActive,
            accountType: args.accountType,
            primaryContactName: args.primaryContactName,
            key: args.key),
        settings: data,
      );
    },
    _i9.VerifyOtpView: (data) {
      final args = data.getArgs<VerifyOtpViewArguments>(
        orElse: () => const VerifyOtpViewArguments(),
      );
      return _i29.MaterialPageRoute<dynamic>(
        builder: (context) => _i9.VerifyOtpView(
            email: args.email,
            mobileNumber: args.mobileNumber,
            entityId: args.entityId,
            entityType: args.entityType,
            primarycontactname: args.primarycontactname,
            key: args.key),
        settings: data,
      );
    },
    _i10.BasicDetailView: (data) {
      final args = data.getArgs<BasicDetailViewArguments>(
        orElse: () => const BasicDetailViewArguments(),
      );
      return _i29.MaterialPageRoute<dynamic>(
        builder: (context) => _i10.BasicDetailView(
            email: args.email,
            mobileNumber: args.mobileNumber,
            gstin: args.gstin,
            panNumber: args.panNumber,
            reraId: args.reraId,
            entityId: args.entityId,
            entityType: args.entityType,
            primarycontactname: args.primarycontactname,
            key: args.key),
        settings: data,
      );
    },
    _i11.AccountDetailView: (data) {
      final args = data.getArgs<AccountDetailViewArguments>(
        orElse: () => const AccountDetailViewArguments(),
      );
      return _i29.MaterialPageRoute<dynamic>(
        builder: (context) => _i11.AccountDetailView(
            accountHolderName: args.accountHolderName,
            accountNumber: args.accountNumber,
            bankName: args.bankName,
            branchName: args.branchName,
            ifscCode: args.ifscCode,
            email: args.email,
            mobileNumber: args.mobileNumber,
            gstin: args.gstin,
            panNumber: args.panNumber,
            reraId: args.reraId,
            entityId: args.entityId,
            entityType: args.entityType,
            primarycontactname: args.primarycontactname,
            channelPartnerName: args.channelPartnerName,
            address: args.address,
            city: args.city,
            state: args.state,
            zipCode: args.zipCode,
            website: args.website,
            isActive: args.isActive,
            key: args.key),
        settings: data,
      );
    },
    _i12.TaxDetailView: (data) {
      final args = data.getArgs<TaxDetailViewArguments>(
        orElse: () => const TaxDetailViewArguments(),
      );
      return _i29.MaterialPageRoute<dynamic>(
        builder: (context) => _i12.TaxDetailView(
            email: args.email,
            mobileNumber: args.mobileNumber,
            entityId: args.entityId,
            entityType: args.entityType,
            primarycontactname: args.primarycontactname,
            key: args.key),
        settings: data,
      );
    },
    _i13.TaxDocumentView: (data) {
      final args = data.getArgs<TaxDocumentViewArguments>(
        orElse: () => const TaxDocumentViewArguments(),
      );
      return _i29.MaterialPageRoute<dynamic>(
        builder: (context) => _i13.TaxDocumentView(
            email: args.email,
            mobileNumber: args.mobileNumber,
            entityId: args.entityId,
            entityType: args.entityType,
            primarycontactname: args.primarycontactname,
            key: args.key),
        settings: data,
      );
    },
    _i14.CaptureLeadView: (data) {
      return _i29.MaterialPageRoute<dynamic>(
        builder: (context) => const _i14.CaptureLeadView(),
        settings: data,
      );
    },
    _i15.AllLeadsView: (data) {
      return _i29.MaterialPageRoute<dynamic>(
        builder: (context) => const _i15.AllLeadsView(),
        settings: data,
      );
    },
    _i16.AllusersView: (data) {
      return _i29.MaterialPageRoute<dynamic>(
        builder: (context) => const _i16.AllusersView(),
        settings: data,
      );
    },
    _i17.IncomingCallView: (data) {
      return _i29.MaterialPageRoute<dynamic>(
        builder: (context) => const _i17.IncomingCallView(),
        settings: data,
      );
    },
    _i18.ChannelPartnerView: (data) {
      return _i29.MaterialPageRoute<dynamic>(
        builder: (context) => const _i18.ChannelPartnerView(),
        settings: data,
      );
    },
    _i19.ChannelpartnercarddetaisView: (data) {
      final args =
          data.getArgs<ChannelpartnercarddetaisViewArguments>(nullOk: false);
      return _i29.MaterialPageRoute<dynamic>(
        builder: (context) => _i19.ChannelpartnercarddetaisView(
            showDeactive: args.showDeactive, chId: args.chId, key: args.key),
        settings: data,
      );
    },
    _i20.ScheduleView: (data) {
      final args = data.getArgs<ScheduleViewArguments>(nullOk: false);
      return _i29.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i20.ScheduleView(userInfo: args.userInfo, key: args.key),
        settings: data,
      );
    },
    _i21.CreateUserView: (data) {
      final args = data.getArgs<CreateUserViewArguments>(nullOk: false);
      return _i29.MaterialPageRoute<dynamic>(
        builder: (context) => _i21.CreateUserView(
            isUserDstMember: args.isUserDstMember, key: args.key),
        settings: data,
      );
    },
    _i22.FollowUpDetailView: (data) {
      final args = data.getArgs<FollowUpDetailViewArguments>(nullOk: false);
      return _i29.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i22.FollowUpDetailView(leadId: args.leadId, key: args.key),
        settings: data,
      );
    },
    _i23.UpcomingFollowUpsView: (data) {
      return _i29.MaterialPageRoute<dynamic>(
        builder: (context) => const _i23.UpcomingFollowUpsView(),
        settings: data,
      );
    },
    _i24.ProjectDetailView: (data) {
      final args = data.getArgs<ProjectDetailViewArguments>(nullOk: false);
      return _i29.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i24.ProjectDetailView(projectId: args.projectId, key: args.key),
        settings: data,
      );
    },
    _i25.ScheduledSiteVisitsView: (data) {
      return _i29.MaterialPageRoute<dynamic>(
        builder: (context) => const _i25.ScheduledSiteVisitsView(),
        settings: data,
      );
    },
    _i26.AllProjectView: (data) {
      return _i29.MaterialPageRoute<dynamic>(
        builder: (context) => const _i26.AllProjectView(),
        settings: data,
      );
    },
    _i27.VerifyUserView: (data) {
      return _i29.MaterialPageRoute<dynamic>(
        builder: (context) => const _i27.VerifyUserView(),
        settings: data,
      );
    },
    _i28.TermsConditionView: (data) {
      final args = data.getArgs<TermsConditionViewArguments>(nullOk: false);
      return _i29.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i28.TermsConditionView(args.headerTitle, key: args.key),
        settings: data,
      );
    },
  };

  @override
  List<_i1.RouteDef> get routes => _routes;
  @override
  Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
}

class HomeViewArguments {
  const HomeViewArguments({
    required this.pageIndex,
    this.key,
  });

  final int pageIndex;

  final _i29.Key? key;

  @override
  String toString() {
    return '{"pageIndex": "$pageIndex", "key": "$key"}';
  }

  @override
  bool operator ==(covariant HomeViewArguments other) {
    if (identical(this, other)) return true;
    return other.pageIndex == pageIndex && other.key == key;
  }

  @override
  int get hashCode {
    return pageIndex.hashCode ^ key.hashCode;
  }
}

class ApplicationSuccessViewArguments {
  const ApplicationSuccessViewArguments({
    required this.channelPartnerName,
    required this.channelPartnerId,
    required this.enrollmentNo,
    required this.name,
    required this.userId,
    this.key,
  });

  final String channelPartnerName;

  final int channelPartnerId;

  final String enrollmentNo;

  final String name;

  final int userId;

  final _i29.Key? key;

  @override
  String toString() {
    return '{"channelPartnerName": "$channelPartnerName", "channelPartnerId": "$channelPartnerId", "enrollmentNo": "$enrollmentNo", "name": "$name", "userId": "$userId", "key": "$key"}';
  }

  @override
  bool operator ==(covariant ApplicationSuccessViewArguments other) {
    if (identical(this, other)) return true;
    return other.channelPartnerName == channelPartnerName &&
        other.channelPartnerId == channelPartnerId &&
        other.enrollmentNo == enrollmentNo &&
        other.name == name &&
        other.userId == userId &&
        other.key == key;
  }

  @override
  int get hashCode {
    return channelPartnerName.hashCode ^
        channelPartnerId.hashCode ^
        enrollmentNo.hashCode ^
        name.hashCode ^
        userId.hashCode ^
        key.hashCode;
  }
}

class AgreementViewArguments {
  const AgreementViewArguments({
    this.accountHolderName,
    this.accountNumber,
    this.bankName,
    this.branchName,
    this.ifscCode,
    this.email,
    this.mobileNumber,
    this.gstin,
    this.panNumber,
    this.reraId,
    this.entityId,
    this.entityType,
    this.channelPartnerName,
    this.address1,
    this.city,
    this.state,
    this.zipCode,
    this.website,
    this.isActive,
    this.accountType,
    this.primaryContactName,
    this.key,
  });

  final String? accountHolderName;

  final String? accountNumber;

  final String? bankName;

  final String? branchName;

  final String? ifscCode;

  final String? email;

  final String? mobileNumber;

  final String? gstin;

  final String? panNumber;

  final String? reraId;

  final String? entityId;

  final String? entityType;

  final String? channelPartnerName;

  final String? address1;

  final String? city;

  final String? state;

  final String? zipCode;

  final String? website;

  final bool? isActive;

  final String? accountType;

  final String? primaryContactName;

  final _i29.Key? key;

  @override
  String toString() {
    return '{"accountHolderName": "$accountHolderName", "accountNumber": "$accountNumber", "bankName": "$bankName", "branchName": "$branchName", "ifscCode": "$ifscCode", "email": "$email", "mobileNumber": "$mobileNumber", "gstin": "$gstin", "panNumber": "$panNumber", "reraId": "$reraId", "entityId": "$entityId", "entityType": "$entityType", "channelPartnerName": "$channelPartnerName", "address1": "$address1", "city": "$city", "state": "$state", "zipCode": "$zipCode", "website": "$website", "isActive": "$isActive", "accountType": "$accountType", "primaryContactName": "$primaryContactName", "key": "$key"}';
  }

  @override
  bool operator ==(covariant AgreementViewArguments other) {
    if (identical(this, other)) return true;
    return other.accountHolderName == accountHolderName &&
        other.accountNumber == accountNumber &&
        other.bankName == bankName &&
        other.branchName == branchName &&
        other.ifscCode == ifscCode &&
        other.email == email &&
        other.mobileNumber == mobileNumber &&
        other.gstin == gstin &&
        other.panNumber == panNumber &&
        other.reraId == reraId &&
        other.entityId == entityId &&
        other.entityType == entityType &&
        other.channelPartnerName == channelPartnerName &&
        other.address1 == address1 &&
        other.city == city &&
        other.state == state &&
        other.zipCode == zipCode &&
        other.website == website &&
        other.isActive == isActive &&
        other.accountType == accountType &&
        other.primaryContactName == primaryContactName &&
        other.key == key;
  }

  @override
  int get hashCode {
    return accountHolderName.hashCode ^
        accountNumber.hashCode ^
        bankName.hashCode ^
        branchName.hashCode ^
        ifscCode.hashCode ^
        email.hashCode ^
        mobileNumber.hashCode ^
        gstin.hashCode ^
        panNumber.hashCode ^
        reraId.hashCode ^
        entityId.hashCode ^
        entityType.hashCode ^
        channelPartnerName.hashCode ^
        address1.hashCode ^
        city.hashCode ^
        state.hashCode ^
        zipCode.hashCode ^
        website.hashCode ^
        isActive.hashCode ^
        accountType.hashCode ^
        primaryContactName.hashCode ^
        key.hashCode;
  }
}

class VerifyOtpViewArguments {
  const VerifyOtpViewArguments({
    this.email,
    this.mobileNumber,
    this.entityId,
    this.entityType,
    this.primarycontactname,
    this.key,
  });

  final String? email;

  final String? mobileNumber;

  final String? entityId;

  final String? entityType;

  final String? primarycontactname;

  final _i29.Key? key;

  @override
  String toString() {
    return '{"email": "$email", "mobileNumber": "$mobileNumber", "entityId": "$entityId", "entityType": "$entityType", "primarycontactname": "$primarycontactname", "key": "$key"}';
  }

  @override
  bool operator ==(covariant VerifyOtpViewArguments other) {
    if (identical(this, other)) return true;
    return other.email == email &&
        other.mobileNumber == mobileNumber &&
        other.entityId == entityId &&
        other.entityType == entityType &&
        other.primarycontactname == primarycontactname &&
        other.key == key;
  }

  @override
  int get hashCode {
    return email.hashCode ^
        mobileNumber.hashCode ^
        entityId.hashCode ^
        entityType.hashCode ^
        primarycontactname.hashCode ^
        key.hashCode;
  }
}

class BasicDetailViewArguments {
  const BasicDetailViewArguments({
    this.email,
    this.mobileNumber,
    this.gstin,
    this.panNumber,
    this.reraId,
    this.entityId,
    this.entityType,
    this.primarycontactname,
    this.key,
  });

  final String? email;

  final String? mobileNumber;

  final String? gstin;

  final String? panNumber;

  final String? reraId;

  final String? entityId;

  final String? entityType;

  final String? primarycontactname;

  final _i29.Key? key;

  @override
  String toString() {
    return '{"email": "$email", "mobileNumber": "$mobileNumber", "gstin": "$gstin", "panNumber": "$panNumber", "reraId": "$reraId", "entityId": "$entityId", "entityType": "$entityType", "primarycontactname": "$primarycontactname", "key": "$key"}';
  }

  @override
  bool operator ==(covariant BasicDetailViewArguments other) {
    if (identical(this, other)) return true;
    return other.email == email &&
        other.mobileNumber == mobileNumber &&
        other.gstin == gstin &&
        other.panNumber == panNumber &&
        other.reraId == reraId &&
        other.entityId == entityId &&
        other.entityType == entityType &&
        other.primarycontactname == primarycontactname &&
        other.key == key;
  }

  @override
  int get hashCode {
    return email.hashCode ^
        mobileNumber.hashCode ^
        gstin.hashCode ^
        panNumber.hashCode ^
        reraId.hashCode ^
        entityId.hashCode ^
        entityType.hashCode ^
        primarycontactname.hashCode ^
        key.hashCode;
  }
}

class AccountDetailViewArguments {
  const AccountDetailViewArguments({
    this.accountHolderName,
    this.accountNumber,
    this.bankName,
    this.branchName,
    this.ifscCode,
    this.email,
    this.mobileNumber,
    this.gstin,
    this.panNumber,
    this.reraId,
    this.entityId,
    this.entityType,
    this.primarycontactname,
    this.channelPartnerName,
    this.address,
    this.city,
    this.state,
    this.zipCode,
    this.website,
    this.isActive,
    this.key,
  });

  final String? accountHolderName;

  final String? accountNumber;

  final String? bankName;

  final String? branchName;

  final String? ifscCode;

  final String? email;

  final String? mobileNumber;

  final String? gstin;

  final String? panNumber;

  final String? reraId;

  final String? entityId;

  final String? entityType;

  final String? primarycontactname;

  final String? channelPartnerName;

  final String? address;

  final String? city;

  final String? state;

  final String? zipCode;

  final String? website;

  final bool? isActive;

  final _i29.Key? key;

  @override
  String toString() {
    return '{"accountHolderName": "$accountHolderName", "accountNumber": "$accountNumber", "bankName": "$bankName", "branchName": "$branchName", "ifscCode": "$ifscCode", "email": "$email", "mobileNumber": "$mobileNumber", "gstin": "$gstin", "panNumber": "$panNumber", "reraId": "$reraId", "entityId": "$entityId", "entityType": "$entityType", "primarycontactname": "$primarycontactname", "channelPartnerName": "$channelPartnerName", "address": "$address", "city": "$city", "state": "$state", "zipCode": "$zipCode", "website": "$website", "isActive": "$isActive", "key": "$key"}';
  }

  @override
  bool operator ==(covariant AccountDetailViewArguments other) {
    if (identical(this, other)) return true;
    return other.accountHolderName == accountHolderName &&
        other.accountNumber == accountNumber &&
        other.bankName == bankName &&
        other.branchName == branchName &&
        other.ifscCode == ifscCode &&
        other.email == email &&
        other.mobileNumber == mobileNumber &&
        other.gstin == gstin &&
        other.panNumber == panNumber &&
        other.reraId == reraId &&
        other.entityId == entityId &&
        other.entityType == entityType &&
        other.primarycontactname == primarycontactname &&
        other.channelPartnerName == channelPartnerName &&
        other.address == address &&
        other.city == city &&
        other.state == state &&
        other.zipCode == zipCode &&
        other.website == website &&
        other.isActive == isActive &&
        other.key == key;
  }

  @override
  int get hashCode {
    return accountHolderName.hashCode ^
        accountNumber.hashCode ^
        bankName.hashCode ^
        branchName.hashCode ^
        ifscCode.hashCode ^
        email.hashCode ^
        mobileNumber.hashCode ^
        gstin.hashCode ^
        panNumber.hashCode ^
        reraId.hashCode ^
        entityId.hashCode ^
        entityType.hashCode ^
        primarycontactname.hashCode ^
        channelPartnerName.hashCode ^
        address.hashCode ^
        city.hashCode ^
        state.hashCode ^
        zipCode.hashCode ^
        website.hashCode ^
        isActive.hashCode ^
        key.hashCode;
  }
}

class TaxDetailViewArguments {
  const TaxDetailViewArguments({
    this.email,
    this.mobileNumber,
    this.entityId,
    this.entityType,
    this.primarycontactname,
    this.key,
  });

  final String? email;

  final String? mobileNumber;

  final String? entityId;

  final String? entityType;

  final String? primarycontactname;

  final _i29.Key? key;

  @override
  String toString() {
    return '{"email": "$email", "mobileNumber": "$mobileNumber", "entityId": "$entityId", "entityType": "$entityType", "primarycontactname": "$primarycontactname", "key": "$key"}';
  }

  @override
  bool operator ==(covariant TaxDetailViewArguments other) {
    if (identical(this, other)) return true;
    return other.email == email &&
        other.mobileNumber == mobileNumber &&
        other.entityId == entityId &&
        other.entityType == entityType &&
        other.primarycontactname == primarycontactname &&
        other.key == key;
  }

  @override
  int get hashCode {
    return email.hashCode ^
        mobileNumber.hashCode ^
        entityId.hashCode ^
        entityType.hashCode ^
        primarycontactname.hashCode ^
        key.hashCode;
  }
}

class TaxDocumentViewArguments {
  const TaxDocumentViewArguments({
    this.email,
    this.mobileNumber,
    this.entityId,
    this.entityType,
    this.primarycontactname,
    this.key,
  });

  final String? email;

  final String? mobileNumber;

  final String? entityId;

  final String? entityType;

  final String? primarycontactname;

  final _i29.Key? key;

  @override
  String toString() {
    return '{"email": "$email", "mobileNumber": "$mobileNumber", "entityId": "$entityId", "entityType": "$entityType", "primarycontactname": "$primarycontactname", "key": "$key"}';
  }

  @override
  bool operator ==(covariant TaxDocumentViewArguments other) {
    if (identical(this, other)) return true;
    return other.email == email &&
        other.mobileNumber == mobileNumber &&
        other.entityId == entityId &&
        other.entityType == entityType &&
        other.primarycontactname == primarycontactname &&
        other.key == key;
  }

  @override
  int get hashCode {
    return email.hashCode ^
        mobileNumber.hashCode ^
        entityId.hashCode ^
        entityType.hashCode ^
        primarycontactname.hashCode ^
        key.hashCode;
  }
}

class ChannelpartnercarddetaisViewArguments {
  const ChannelpartnercarddetaisViewArguments({
    required this.showDeactive,
    required this.chId,
    this.key,
  });

  final bool showDeactive;

  final int chId;

  final _i29.Key? key;

  @override
  String toString() {
    return '{"showDeactive": "$showDeactive", "chId": "$chId", "key": "$key"}';
  }

  @override
  bool operator ==(covariant ChannelpartnercarddetaisViewArguments other) {
    if (identical(this, other)) return true;
    return other.showDeactive == showDeactive &&
        other.chId == chId &&
        other.key == key;
  }

  @override
  int get hashCode {
    return showDeactive.hashCode ^ chId.hashCode ^ key.hashCode;
  }
}

class ScheduleViewArguments {
  const ScheduleViewArguments({
    required this.userInfo,
    this.key,
  });

  final _i30.LeadsModel userInfo;

  final _i29.Key? key;

  @override
  String toString() {
    return '{"userInfo": "$userInfo", "key": "$key"}';
  }

  @override
  bool operator ==(covariant ScheduleViewArguments other) {
    if (identical(this, other)) return true;
    return other.userInfo == userInfo && other.key == key;
  }

  @override
  int get hashCode {
    return userInfo.hashCode ^ key.hashCode;
  }
}

class CreateUserViewArguments {
  const CreateUserViewArguments({
    required this.isUserDstMember,
    this.key,
  });

  final bool isUserDstMember;

  final _i29.Key? key;

  @override
  String toString() {
    return '{"isUserDstMember": "$isUserDstMember", "key": "$key"}';
  }

  @override
  bool operator ==(covariant CreateUserViewArguments other) {
    if (identical(this, other)) return true;
    return other.isUserDstMember == isUserDstMember && other.key == key;
  }

  @override
  int get hashCode {
    return isUserDstMember.hashCode ^ key.hashCode;
  }
}

class FollowUpDetailViewArguments {
  const FollowUpDetailViewArguments({
    required this.leadId,
    this.key,
  });

  final int leadId;

  final _i29.Key? key;

  @override
  String toString() {
    return '{"leadId": "$leadId", "key": "$key"}';
  }

  @override
  bool operator ==(covariant FollowUpDetailViewArguments other) {
    if (identical(this, other)) return true;
    return other.leadId == leadId && other.key == key;
  }

  @override
  int get hashCode {
    return leadId.hashCode ^ key.hashCode;
  }
}

class ProjectDetailViewArguments {
  const ProjectDetailViewArguments({
    required this.projectId,
    this.key,
  });

  final int projectId;

  final _i29.Key? key;

  @override
  String toString() {
    return '{"projectId": "$projectId", "key": "$key"}';
  }

  @override
  bool operator ==(covariant ProjectDetailViewArguments other) {
    if (identical(this, other)) return true;
    return other.projectId == projectId && other.key == key;
  }

  @override
  int get hashCode {
    return projectId.hashCode ^ key.hashCode;
  }
}

class TermsConditionViewArguments {
  const TermsConditionViewArguments({
    required this.headerTitle,
    this.key,
  });

  final String? headerTitle;

  final _i29.Key? key;

  @override
  String toString() {
    return '{"headerTitle": "$headerTitle", "key": "$key"}';
  }

  @override
  bool operator ==(covariant TermsConditionViewArguments other) {
    if (identical(this, other)) return true;
    return other.headerTitle == headerTitle && other.key == key;
  }

  @override
  int get hashCode {
    return headerTitle.hashCode ^ key.hashCode;
  }
}

extension NavigatorStateExtension on _i31.NavigationService {
  Future<dynamic> navigateToHomeView({
    required int pageIndex,
    _i29.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.homeView,
        arguments: HomeViewArguments(pageIndex: pageIndex, key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToStartupView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.startupView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToMobileNumberView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.mobileNumberView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToOtpView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.otpView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToPrimaryPersonDetailsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.primaryPersonDetailsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToApplicationSuccessView({
    required String channelPartnerName,
    required int channelPartnerId,
    required String enrollmentNo,
    required String name,
    required int userId,
    _i29.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.applicationSuccessView,
        arguments: ApplicationSuccessViewArguments(
            channelPartnerName: channelPartnerName,
            channelPartnerId: channelPartnerId,
            enrollmentNo: enrollmentNo,
            name: name,
            userId: userId,
            key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToAgreementView({
    String? accountHolderName,
    String? accountNumber,
    String? bankName,
    String? branchName,
    String? ifscCode,
    String? email,
    String? mobileNumber,
    String? gstin,
    String? panNumber,
    String? reraId,
    String? entityId,
    String? entityType,
    String? channelPartnerName,
    String? address1,
    String? city,
    String? state,
    String? zipCode,
    String? website,
    bool? isActive,
    String? accountType,
    String? primaryContactName,
    _i29.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.agreementView,
        arguments: AgreementViewArguments(
            accountHolderName: accountHolderName,
            accountNumber: accountNumber,
            bankName: bankName,
            branchName: branchName,
            ifscCode: ifscCode,
            email: email,
            mobileNumber: mobileNumber,
            gstin: gstin,
            panNumber: panNumber,
            reraId: reraId,
            entityId: entityId,
            entityType: entityType,
            channelPartnerName: channelPartnerName,
            address1: address1,
            city: city,
            state: state,
            zipCode: zipCode,
            website: website,
            isActive: isActive,
            accountType: accountType,
            primaryContactName: primaryContactName,
            key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToVerifyOtpView({
    String? email,
    String? mobileNumber,
    String? entityId,
    String? entityType,
    String? primarycontactname,
    _i29.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.verifyOtpView,
        arguments: VerifyOtpViewArguments(
            email: email,
            mobileNumber: mobileNumber,
            entityId: entityId,
            entityType: entityType,
            primarycontactname: primarycontactname,
            key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToBasicDetailView({
    String? email,
    String? mobileNumber,
    String? gstin,
    String? panNumber,
    String? reraId,
    String? entityId,
    String? entityType,
    String? primarycontactname,
    _i29.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.basicDetailView,
        arguments: BasicDetailViewArguments(
            email: email,
            mobileNumber: mobileNumber,
            gstin: gstin,
            panNumber: panNumber,
            reraId: reraId,
            entityId: entityId,
            entityType: entityType,
            primarycontactname: primarycontactname,
            key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToAccountDetailView({
    String? accountHolderName,
    String? accountNumber,
    String? bankName,
    String? branchName,
    String? ifscCode,
    String? email,
    String? mobileNumber,
    String? gstin,
    String? panNumber,
    String? reraId,
    String? entityId,
    String? entityType,
    String? primarycontactname,
    String? channelPartnerName,
    String? address,
    String? city,
    String? state,
    String? zipCode,
    String? website,
    bool? isActive,
    _i29.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.accountDetailView,
        arguments: AccountDetailViewArguments(
            accountHolderName: accountHolderName,
            accountNumber: accountNumber,
            bankName: bankName,
            branchName: branchName,
            ifscCode: ifscCode,
            email: email,
            mobileNumber: mobileNumber,
            gstin: gstin,
            panNumber: panNumber,
            reraId: reraId,
            entityId: entityId,
            entityType: entityType,
            primarycontactname: primarycontactname,
            channelPartnerName: channelPartnerName,
            address: address,
            city: city,
            state: state,
            zipCode: zipCode,
            website: website,
            isActive: isActive,
            key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToTaxDetailView({
    String? email,
    String? mobileNumber,
    String? entityId,
    String? entityType,
    String? primarycontactname,
    _i29.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.taxDetailView,
        arguments: TaxDetailViewArguments(
            email: email,
            mobileNumber: mobileNumber,
            entityId: entityId,
            entityType: entityType,
            primarycontactname: primarycontactname,
            key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToTaxDocumentView({
    String? email,
    String? mobileNumber,
    String? entityId,
    String? entityType,
    String? primarycontactname,
    _i29.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.taxDocumentView,
        arguments: TaxDocumentViewArguments(
            email: email,
            mobileNumber: mobileNumber,
            entityId: entityId,
            entityType: entityType,
            primarycontactname: primarycontactname,
            key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToCaptureLeadView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.captureLeadView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToAllLeadsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.allLeadsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToAllusersView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.allusersView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToIncomingCallView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.incomingCallView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToChannelPartnerView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.channelPartnerView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToChannelpartnercarddetaisView({
    required bool showDeactive,
    required int chId,
    _i29.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.channelpartnercarddetaisView,
        arguments: ChannelpartnercarddetaisViewArguments(
            showDeactive: showDeactive, chId: chId, key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToScheduleView({
    required _i30.LeadsModel userInfo,
    _i29.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.scheduleView,
        arguments: ScheduleViewArguments(userInfo: userInfo, key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToCreateUserView({
    required bool isUserDstMember,
    _i29.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.createUserView,
        arguments:
            CreateUserViewArguments(isUserDstMember: isUserDstMember, key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToFollowUpDetailView({
    required int leadId,
    _i29.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.followUpDetailView,
        arguments: FollowUpDetailViewArguments(leadId: leadId, key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToUpcomingFollowUpsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.upcomingFollowUpsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToProjectDetailView({
    required int projectId,
    _i29.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.projectDetailView,
        arguments: ProjectDetailViewArguments(projectId: projectId, key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToScheduledSiteVisitsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.scheduledSiteVisitsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToAllProjectView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.allProjectView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToVerifyUserView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.verifyUserView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToTermsConditionView({
    required String? headerTitle,
    _i29.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.termsConditionView,
        arguments:
            TermsConditionViewArguments(headerTitle: headerTitle, key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithHomeView({
    required int pageIndex,
    _i29.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.homeView,
        arguments: HomeViewArguments(pageIndex: pageIndex, key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithStartupView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.startupView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithMobileNumberView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.mobileNumberView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithOtpView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.otpView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithPrimaryPersonDetailsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.primaryPersonDetailsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithApplicationSuccessView({
    required String channelPartnerName,
    required int channelPartnerId,
    required String enrollmentNo,
    required String name,
    required int userId,
    _i29.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.applicationSuccessView,
        arguments: ApplicationSuccessViewArguments(
            channelPartnerName: channelPartnerName,
            channelPartnerId: channelPartnerId,
            enrollmentNo: enrollmentNo,
            name: name,
            userId: userId,
            key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithAgreementView({
    String? accountHolderName,
    String? accountNumber,
    String? bankName,
    String? branchName,
    String? ifscCode,
    String? email,
    String? mobileNumber,
    String? gstin,
    String? panNumber,
    String? reraId,
    String? entityId,
    String? entityType,
    String? channelPartnerName,
    String? address1,
    String? city,
    String? state,
    String? zipCode,
    String? website,
    bool? isActive,
    String? accountType,
    String? primaryContactName,
    _i29.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.agreementView,
        arguments: AgreementViewArguments(
            accountHolderName: accountHolderName,
            accountNumber: accountNumber,
            bankName: bankName,
            branchName: branchName,
            ifscCode: ifscCode,
            email: email,
            mobileNumber: mobileNumber,
            gstin: gstin,
            panNumber: panNumber,
            reraId: reraId,
            entityId: entityId,
            entityType: entityType,
            channelPartnerName: channelPartnerName,
            address1: address1,
            city: city,
            state: state,
            zipCode: zipCode,
            website: website,
            isActive: isActive,
            accountType: accountType,
            primaryContactName: primaryContactName,
            key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithVerifyOtpView({
    String? email,
    String? mobileNumber,
    String? entityId,
    String? entityType,
    String? primarycontactname,
    _i29.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.verifyOtpView,
        arguments: VerifyOtpViewArguments(
            email: email,
            mobileNumber: mobileNumber,
            entityId: entityId,
            entityType: entityType,
            primarycontactname: primarycontactname,
            key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithBasicDetailView({
    String? email,
    String? mobileNumber,
    String? gstin,
    String? panNumber,
    String? reraId,
    String? entityId,
    String? entityType,
    String? primarycontactname,
    _i29.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.basicDetailView,
        arguments: BasicDetailViewArguments(
            email: email,
            mobileNumber: mobileNumber,
            gstin: gstin,
            panNumber: panNumber,
            reraId: reraId,
            entityId: entityId,
            entityType: entityType,
            primarycontactname: primarycontactname,
            key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithAccountDetailView({
    String? accountHolderName,
    String? accountNumber,
    String? bankName,
    String? branchName,
    String? ifscCode,
    String? email,
    String? mobileNumber,
    String? gstin,
    String? panNumber,
    String? reraId,
    String? entityId,
    String? entityType,
    String? primarycontactname,
    String? channelPartnerName,
    String? address,
    String? city,
    String? state,
    String? zipCode,
    String? website,
    bool? isActive,
    _i29.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.accountDetailView,
        arguments: AccountDetailViewArguments(
            accountHolderName: accountHolderName,
            accountNumber: accountNumber,
            bankName: bankName,
            branchName: branchName,
            ifscCode: ifscCode,
            email: email,
            mobileNumber: mobileNumber,
            gstin: gstin,
            panNumber: panNumber,
            reraId: reraId,
            entityId: entityId,
            entityType: entityType,
            primarycontactname: primarycontactname,
            channelPartnerName: channelPartnerName,
            address: address,
            city: city,
            state: state,
            zipCode: zipCode,
            website: website,
            isActive: isActive,
            key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithTaxDetailView({
    String? email,
    String? mobileNumber,
    String? entityId,
    String? entityType,
    String? primarycontactname,
    _i29.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.taxDetailView,
        arguments: TaxDetailViewArguments(
            email: email,
            mobileNumber: mobileNumber,
            entityId: entityId,
            entityType: entityType,
            primarycontactname: primarycontactname,
            key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithTaxDocumentView({
    String? email,
    String? mobileNumber,
    String? entityId,
    String? entityType,
    String? primarycontactname,
    _i29.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.taxDocumentView,
        arguments: TaxDocumentViewArguments(
            email: email,
            mobileNumber: mobileNumber,
            entityId: entityId,
            entityType: entityType,
            primarycontactname: primarycontactname,
            key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithCaptureLeadView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.captureLeadView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithAllLeadsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.allLeadsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithAllusersView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.allusersView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithIncomingCallView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.incomingCallView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithChannelPartnerView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.channelPartnerView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithChannelpartnercarddetaisView({
    required bool showDeactive,
    required int chId,
    _i29.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.channelpartnercarddetaisView,
        arguments: ChannelpartnercarddetaisViewArguments(
            showDeactive: showDeactive, chId: chId, key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithScheduleView({
    required _i30.LeadsModel userInfo,
    _i29.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.scheduleView,
        arguments: ScheduleViewArguments(userInfo: userInfo, key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithCreateUserView({
    required bool isUserDstMember,
    _i29.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.createUserView,
        arguments:
            CreateUserViewArguments(isUserDstMember: isUserDstMember, key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithFollowUpDetailView({
    required int leadId,
    _i29.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.followUpDetailView,
        arguments: FollowUpDetailViewArguments(leadId: leadId, key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithUpcomingFollowUpsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.upcomingFollowUpsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithProjectDetailView({
    required int projectId,
    _i29.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.projectDetailView,
        arguments: ProjectDetailViewArguments(projectId: projectId, key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithScheduledSiteVisitsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.scheduledSiteVisitsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithAllProjectView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.allProjectView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithVerifyUserView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.verifyUserView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithTermsConditionView({
    required String? headerTitle,
    _i29.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.termsConditionView,
        arguments:
            TermsConditionViewArguments(headerTitle: headerTitle, key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }
}
