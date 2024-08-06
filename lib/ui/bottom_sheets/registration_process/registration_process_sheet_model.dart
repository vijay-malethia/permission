import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '/ui/common/widgets/toast.dart';
import '/app/app.locator.dart';
import '/app/app.router.dart';
import '/ui/views/primary_person_detail/terms_condition/terms_condition_view.dart';

class RegistrationProcessSheetModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  bool isAgree = false;
  List<String> certificateTypes = [
    '1.  GST Certificate',
    '2. PAN Card',
    '3. RERA Certificate',
    '4. Bank Account & IFSC'
  ];

  onCheckBoxValueChange() {
    isAgree = !isAgree;
    notifyListeners();
  }

  goToPrimaryPersonDeatilPage(BuildContext context) {
    if (isAgree) {
      _navigationService.back();
      _navigationService.navigateTo(Routes.primaryPersonDetailsView);
    } else {
      showCustomToast(context,
          'Please accept the terms & conditions and privacy policy', '');
    }
  }

  goToCondtions(String title, BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (BuildContext context) {
        return TermsConditionView(title);
      },
    ));


    notifyListeners();
  }
}
