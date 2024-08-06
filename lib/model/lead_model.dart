import 'package:flutter/material.dart';

class LeadsModel {
  String personName;
  String assignedToName;
  String status;
  String location;
  String date;
  String? cpName;
  int? followUpId;
  String? visitDate;
  String? clientVisitDate;
  String? clientVisitTime;
  String? trailingIconName;
  String? leadAge;
  String? nextFollowUp;
  String? phoneNumber;
  int? leadId;
  int? assignedTo;
  bool? isEditable;
  bool? isHandLockIconShow;
  bool? isLockIconShow;
  Color backgroundColor;
  Color borderColor;
  LeadsModel(
      {required this.backgroundColor,
      required this.borderColor,
      this.clientVisitDate,
      required this.date,
      required this.location,
      this.visitDate,
      this.isEditable,
      this.leadId,
      this.followUpId,
      this.cpName,
      required this.personName,
      required this.assignedToName,
      required this.status,
      this.leadAge,
       this.assignedTo,
      this.phoneNumber,
      this.nextFollowUp,
      this.isHandLockIconShow,
      this.isLockIconShow,
      this.trailingIconName,
      this.clientVisitTime});
}
