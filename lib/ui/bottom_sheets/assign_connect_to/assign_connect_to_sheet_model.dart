import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '/app/app.bottomsheets.dart';
import '/app/app.locator.dart';

String userCreationType = '';

class AssignConnectToSheetModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final BottomSheetService _bottomSheetService = locator<BottomSheetService>();
  int selectedIndex = 1;

//change selected container
  onSelect(index, String userType) {
    selectedIndex = index;
    userCreationType = userType;
    onCancel();
    _bottomSheetService.showCustomSheet(
        variant: BottomSheetType.registrationProcess, isScrollControlled: true);
    notifyListeners();
  }

//cancel bottomsheet
  onCancel() async {
    _navigationService.back();
  }
}
