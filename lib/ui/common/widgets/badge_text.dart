import 'package:flutter/material.dart';

import '/ui/common/index.dart';

enum BadgeType {
  small,
  medium,
  large,
}

class BadgeText extends StatelessWidget {
  final String text;
  final double? radius;
  final double? fontSize;
  final dynamic fontFamily;

  const BadgeText(
      {Key? key,
      required this.text,
      this.radius,
      this.fontSize,
      this.fontFamily})
      : super(key: key);

  factory BadgeText.fromBadgeType({
    Key? key,
    required String text,
    required BadgeType badgeType,
  }) {
    double? radius;
    double? fontSize;
    dynamic fontFamily;

    switch (badgeType) {
      case BadgeType.small:
        radius = 11.5;
        fontSize = 11;
        fontFamily = 'Nexa-Bold';
        break;
      case BadgeType.medium:
        radius = 18;
        fontSize=14;
        fontFamily = 'Nexa-Bold';
        break;
      case BadgeType.large:
        radius = 23.5;
        break;
    }

    return BadgeText(
        key: key,
        text: text,
        radius: radius,
        fontSize: fontSize,
        fontFamily: fontFamily);
  }

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: lightBgColor,
      child: Center(
        child: Text(
          text,
          style: AppTextStyle()
              .circleText(fontSize: fontSize, fontFamily: fontFamily),
        ),
      ),
    );
  }
}
