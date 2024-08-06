import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.dialogs.dart';
import '../../../app/app.locator.dart';
import '../../common/index.dart';

class InfoAlertDialogModel extends BaseViewModel {
  final dialogService = locator<DialogService>();
  void showConfirmDialog() {
    dialogService.showCustomDialog(
        variant: DialogType.confirm,
        title: 'Disqualified this \n lead?',
        mainButtonTitle: "CANCEL",
        additionalButtonTitle: "CONFIRM",
        barrierDismissible: true,
        imageUrl: Images().infoAlert);
  }
}
