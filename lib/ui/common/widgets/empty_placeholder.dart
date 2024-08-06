import 'package:flutter/material.dart';

import '/ui/common/app_colors.dart';
import '/ui/common/app_fonts.dart';


class EmptyPlaceHolder extends StatelessWidget {
  final String? msg;
  final String? iconName;

  const EmptyPlaceHolder({this.msg, this.iconName, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(iconName?? 'assets/images/nodata_sandle.gif'),
        Text('No Record Found', style: AppTextStyle().mediumSmallText(textColor: borderColor))
      ],
    );
  }
}
