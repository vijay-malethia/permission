import 'package:flutter/material.dart';

class AllUserModel {
  String personName;
  String dstPersonName;
  String dstAsigneeName;
  String companyName;
  String status;
  String location;
  String leads;
  String leadsCount;
  String city;
  String? visitDate;
  String? clientVisitDate;

  Color backgroundColor;
  Color borderColor;
  AllUserModel({
    required this.backgroundColor,
    required this.borderColor,
    this.clientVisitDate,
    required this.leads,
    required this.leadsCount,
    required this.city,
    required this.location,
    this.visitDate,
    required this.personName,
    required this.dstPersonName,
    required this.dstAsigneeName,
    required this.companyName,
    required this.status,
  });
}
