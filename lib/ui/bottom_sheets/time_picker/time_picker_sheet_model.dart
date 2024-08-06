import 'package:stacked/stacked.dart';

class TimePickerSheetModel extends BaseViewModel {
  String time = '';
  void pickTime(value) {
    time = value.toString().split('.').first;
    notifyListeners();
  }
}
