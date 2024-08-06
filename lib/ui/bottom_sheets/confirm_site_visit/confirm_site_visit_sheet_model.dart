// import 'package:flutter/material.dart';
// import 'package:stacked/stacked.dart';
// import 'package:stacked_services/stacked_services.dart';

// import '/app/app.dialogs.dart';
// import '/app/app.locator.dart';
// import '/model/lead_model.dart';
// import '/ui/common/index.dart';

// class ScheduledSiteVisitsViewModel extends BaseViewModel {
//   final _dialogService = locator<DialogService>();

//   void showDeactiveDialog() {
//     _dialogService.showCustomDialog(
//         variant: DialogType.deactive,
//         title: 'Invalid Code for \n this site visit',
//         description: '',
//         mainButtonTitle: "OK",
//         barrierDismissible: true,
//         imageUrl: Images().infoAlert);
//   }

//   //Switch focus Client code inputs
//   switchFocus1(String value, BuildContext context,
//       TextEditingController clientCode1Controller) {
//     if (clientCode1Controller.text.length == 1) {
//       FocusScope.of(context).nextFocus();
//     }

//     notifyListeners();
//   }

//   switchFocus2(String value, BuildContext context,
//       TextEditingController clientCode2Controller) {
//     if (clientCode2Controller.text.length == 1) {
//       FocusScope.of(context).nextFocus();
//     } else if (clientCode2Controller.text.isEmpty) {
//       FocusScope.of(context).previousFocus();
//     }

//     notifyListeners();
//   }

//   switchFocus3(String value, BuildContext context,
//       TextEditingController clientCode3Controller) {
//     if (clientCode3Controller.text.length == 1) {
//       FocusScope.of(context).nextFocus();
//     } else if (clientCode3Controller.text.isEmpty) {
//       FocusScope.of(context).previousFocus();
//     }

//     notifyListeners();
//   }

//   switchFocus4(String value, BuildContext context,
//       TextEditingController clientCode4Controller) {
//     if (clientCode4Controller.text.length == 1) {
//       FocusScope.of(context).nextFocus();
//     } else if (clientCode4Controller.text.isEmpty) {
//       FocusScope.of(context).previousFocus();
//     }

//     notifyListeners();
//   }

//   //Switch focus User Code inputs

//   switchFocusUser1(String value, BuildContext context,
//       TextEditingController userCode1Controller) {
//     if (userCode1Controller.text.length == 1) {
//       FocusScope.of(context).nextFocus();
//     } else if (userCode1Controller.text.isEmpty) {
//       FocusScope.of(context).previousFocus();
//     }

//     notifyListeners();
//   }

//   switchFocusUser2(String value, BuildContext context,
//       TextEditingController userCode2Controller) {
//     if (userCode2Controller.text.length == 1) {
//       FocusScope.of(context).nextFocus();
//     } else if (userCode2Controller.text.isEmpty) {
//       FocusScope.of(context).previousFocus();
//     }

//     notifyListeners();
//   }

//   switchFocusUser3(String value, BuildContext context,
//       TextEditingController userCode3Controller) {
//     if (userCode3Controller.text.length == 1) {
//       FocusScope.of(context).nextFocus();
//     } else if (userCode3Controller.text.isEmpty) {
//       FocusScope.of(context).previousFocus();
//     }

//     notifyListeners();
//   }

//   switchFocusUser4(String value, BuildContext context,
//       TextEditingController userCode4Controller) {
//     if (userCode4Controller.text.isEmpty) {
//       FocusScope.of(context).previousFocus();
//     }

//     notifyListeners();
//   }

//   List<LeadsModel> scheduleList = [
//     LeadsModel(
//         backgroundColor: prospectCardBackground,
//         borderColor: prospectCardBorder,
//         assignedTo: 'Ravi Kumar ',
//         date: '11th Aug 2023',
//         location: 'Swarnamani',
//         clientVisitDate: '3th Aug 2023',
//         visitDate: '4th Aug 2023',
//         personName: 'Manoj Kumar Tiwary',
//         status: 'Prospect',
//         trailingIconName: "Site Visit",
//         clientVisitTime: "1:00-2:30"),
//   ];
// }
