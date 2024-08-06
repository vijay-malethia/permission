import 'package:flutter/material.dart';

class FilterModel {
  String title;
  Color color;
  Color selectedColor;
  Color textColor;
  int leadStageId;
  FilterModel(
      {required this.color,
      required this.selectedColor,
      required this.textColor,
      required this.title,required this.leadStageId});
}
