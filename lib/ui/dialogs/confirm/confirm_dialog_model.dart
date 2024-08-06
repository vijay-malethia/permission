import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '/app/app.router.dart';
import '/app/app.locator.dart';

class ConfirmDialogModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  void goToVerifyScreen() {
    navigationService.navigateTo(Routes.otpView);
    notifyListeners();
  }

  goBack() async {
    navigationService.back();
  }
}
