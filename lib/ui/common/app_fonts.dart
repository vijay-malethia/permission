import 'package:flutter/material.dart';
import 'index.dart';

// Font Colors
class FontColor {
  FontColor._();
  static final FontColor _instance = FontColor._();
  factory FontColor() => _instance;
  Color black = blackColor;
  Color black2 = black26Dark;
  Color blue1 = blueColor;
  Color blue2 = blueGreyDark;
  Color brown = borderColor;
  Color darkgrey = greyShade900;
  Color darkRed = redBrown;
  Color grey = greyDark;
  Color grey2 = greyShade400;
  Color grey3 = customGrey;
  Color grey4 = greyShade500;
  Color grey6 = greyShade300;
  Color grey7 = greyShade600;
  Color grey9 = greyShade700;
  Color lightGrey = greyShade800;
  Color orange = secondaryColor;
  Color orange2 = piChartYellow;
  Color red = primaryColor;
  Color white = whiteColor;
  Color yellow = tabBg;
  Color green = green2;
}

class AppTextStyle {
  AppTextStyle._();
  static final AppTextStyle _instance = AppTextStyle._();
  factory AppTextStyle() => _instance;
// Common Widget TextStyle
  TextStyle numberTitle({Color? textColor, double? lineHeight}) => TextStyle(
        fontFamily: 'Nexa-Bold',
        color: textColor,
        fontSize: 22,
        height: lineHeight,
      );
  TextStyle inputLabelTextStyle({fontColor}) => TextStyle(
      fontSize: 15,
      fontFamily: 'Nexa-Bold',
      height: 1,
      color: fontColor ?? FontColor().grey4,
      fontWeight: FontWeight.w500);
  TextStyle inputHintTextStyle = TextStyle(
      fontSize: 13,
      fontFamily: 'nexa-regular',
      color: FontColor().lightGrey,
      fontWeight: FontWeight.w400);
  TextStyle inputTextStyle = TextStyle(
      fontSize: 15,
      fontFamily: 'nexa-regular',
      color: FontColor().grey,
      fontWeight: FontWeight.w400);
  TextStyle countryCodeTextStyle = TextStyle(
      fontSize: 15,
      fontFamily: 'nexa-regular',
      color: FontColor().lightGrey,
      fontWeight: FontWeight.w400);
  TextStyle toastMessageTextStyle({fontColor, fontFamily}) => TextStyle(
        fontSize: 13,
        height: 1,
        fontFamily: fontFamily ?? 'Nexa-Bold',
        color: fontColor ?? FontColor().white,
        fontWeight: FontWeight.w400,
      );
  TextStyle toastActionTextStyle = TextStyle(
    fontSize: 12,
    fontFamily: 'Nexa-Bold',
    color: FontColor().orange,
    fontWeight: FontWeight.w400,
  );
  TextStyle buttonTextStyle(Color? textColor, {double? fontSize}) => TextStyle(
      fontSize:fontSize ?? 14,
      fontFamily: 'Nexa-Bold',
      color: textColor ?? FontColor().white,
      fontWeight: FontWeight.w400);
  TextStyle textButtonTextStyle({Color? textColor}) => TextStyle(
        fontSize: 10,
        fontFamily: 'Nexa-Bold',
        height: 1.5,
        color: textColor ?? FontColor().white,
      );
  TextStyle floatingButtonTextStyle = TextStyle(
      fontWeight: FontWeight.w400,
      fontFamily: 'Nexa-Bold',
      color: FontColor().white,
      fontSize: 7);

  TextStyle textdescriptionstyle = TextStyle(
      color: FontColor().grey2, fontSize: 14, fontFamily: 'nexa-regular');

  TextStyle textTitleStyle = const TextStyle(
      fontSize: 11, fontFamily: 'Nexa-Light', fontWeight: FontWeight.bold);
  TextStyle company =
      const TextStyle(color: whiteColor, fontSize: 11, fontFamily: 'Nexa-Bold');
  TextStyle textheading = TextStyle(
      fontWeight: FontWeight.w400,
      fontFamily: 'Nexa-Bold',
      color: FontColor().white,
      fontSize: 8);
  TextStyle personName = TextStyle(
      fontSize: 15,
      color: FontColor().grey,
      fontFamily: 'Nexa-Bold',
      fontWeight: FontWeight.w400);
  TextStyle titletext = TextStyle(
    fontSize: 20,
    color: FontColor().blue1,
    fontFamily: 'nexa-regular',
  );
  TextStyle titletext1 = TextStyle(color: FontColor().grey9);
  TextStyle searchStyle = TextStyle(
      color: FontColor().grey6,
      fontSize: 14,
      fontFamily: 'Nexa-Bold',
      height: 1,
      letterSpacing: 0.5);
  //Home screen textstyle
  TextStyle userNameTextStyle({Color? textColor, double? lineHeight}) =>
      TextStyle(
          fontFamily: 'Nexa-Bold',
          color: textColor ?? FontColor().orange,
          fontSize: 22,
          height: lineHeight,
          fontWeight: FontWeight.w400);

  TextStyle subTitle = const TextStyle(
      fontSize: 12,
      fontFamily: 'Nexa-Bold',
      fontWeight: FontWeight.w400,
      color: borderColor);

  //Auth Screen TextStyle
  TextStyle signHeaderStyle({Color? textColor, double? lineHeight}) =>
      TextStyle(
          fontFamily: 'Nexa-Bold',
          color: textColor ?? FontColor().orange,
          fontSize: 20,
          height: lineHeight,
          fontWeight: FontWeight.w400);

  TextStyle signSubHeader = TextStyle(
      fontFamily: 'nexa-regular',
      color: FontColor().grey,
      fontSize: 16,
      fontWeight: FontWeight.w400);

// Registration Module TextStyle
  //Document Sheet
  TextStyle descriptionTextStyle({fontFamily, Color? fontColor}) => TextStyle(
      fontFamily: fontFamily ?? 'nexa-regular',
      color: fontColor ?? FontColor().grey,
      fontSize: 14,
      height: 1.5,
      fontWeight: FontWeight.w400);
  TextStyle tncTextStyle(
          {Color? textColor, FontWeight? fontWeight, double? height}) =>
      TextStyle(
          fontSize: 12,
          height: height ?? 1.4,
          fontFamily: 'nexa-regular',
          color: textColor ?? FontColor().grey,
          fontWeight: fontWeight ?? FontWeight.w400);
  //loading Sheet
  TextStyle loadingDescriptionTextStyle = TextStyle(
      fontFamily: 'nexa-regular',
      color: FontColor().grey2,
      fontSize: 14,
      height: 1.5,
      fontWeight: FontWeight.w400);
  TextStyle loadingLabelTextStyle = TextStyle(
    fontSize: 20,
    fontFamily: 'Nexa-Bold',
    color: FontColor().red,
    fontWeight: FontWeight.w400,
  );
  // Agreement View
  TextStyle agreementTitleTextStyle({fontColor}) => TextStyle(
        fontSize: 20,
        fontFamily: 'Nexa-Bold',
        color: fontColor ?? FontColor().white,
        fontWeight: FontWeight.w400,
      );
  TextStyle agreementSubtitleTextStyle({fontColor}) => TextStyle(
        fontSize: 14,
        fontFamily: 'nexa-regular',
        color: fontColor ?? FontColor().white,
        fontWeight: FontWeight.w400,
      );
  TextStyle agreementLabelTextStyle({Color? textColor}) => TextStyle(
        fontSize: 18,
        fontFamily: 'Cambria-Bold',
        height: 1.2,
        color: textColor ?? FontColor().black,
        fontWeight: FontWeight.w500,
      );
  TextStyle dialogLabelTextStyle({Color? textColor}) => TextStyle(
        fontSize: 20,
        fontFamily: 'Nexa-Bold',
        height: 1.2,
        color: textColor ?? FontColor().black,
        fontWeight: FontWeight.w600,
      );
  TextStyle agreementDescriptionTextStyle = TextStyle(
    fontSize: 17,
    fontFamily: 'Cambria-Regular',
    height: 1.3,
    color: FontColor().black,
    fontWeight: FontWeight.w500,
  );
  //Application Success
  TextStyle successDescriptionLargeTextStyle({Color? fontColor}) => TextStyle(
      fontSize: 15,
      fontFamily: 'nexa-regular',
      color: fontColor ?? FontColor().grey4,
      fontWeight: FontWeight.w400);
  TextStyle partnerComapnyTextStyle({Color? textColor}) => TextStyle(
      fontSize: 18,
      fontFamily: 'nexa-regular',
      color: textColor ?? FontColor().brown,
      fontWeight: FontWeight.w500);
  TextStyle applicaitonNumberTextStyle = TextStyle(
      fontSize: 30,
      fontFamily: 'Nexa-Bold',
      color: FontColor().orange,
      fontWeight: FontWeight.w400);
  TextStyle registerTitleTextStyle = TextStyle(
      fontFamily: 'Nexa-Bold',
      color: FontColor().orange,
      fontSize: 23,
      fontWeight: FontWeight.w400);
  TextStyle registerDescriptionTextStyle = TextStyle(
      fontFamily: 'Nexa-Light',
      color: FontColor().grey4,
      fontSize: 12,
      fontWeight: FontWeight.w600);
  TextStyle resendOtpTextStyle({Color? textColor, FontWeight? fontWeight}) =>
      TextStyle(
          fontFamily: 'nexa-regular',
          color: textColor ?? FontColor().grey2,
          fontSize: 12,
          fontWeight: fontWeight ?? FontWeight.w400);

  //All Lead
  TextStyle numberStyle({fontColor}) => TextStyle(
      fontFamily: 'nexa-regular',
      color: fontColor ?? FontColor().grey3,
      fontSize: 14);
  TextStyle smallText({fontFamily, fontColor}) => TextStyle(
      fontFamily: fontFamily ?? 'nexa-regular',
      color: fontColor ?? FontColor().grey2,
      fontSize: 10);
  TextStyle mediumSmallText({Color? textColor}) => TextStyle(
      fontSize: 14,
      fontFamily: 'Nexa-Bold',
      color: textColor ?? FontColor().grey,
      fontWeight: FontWeight.w400);
  TextStyle smallLarge({fontFamily, fontColor}) => TextStyle(
      fontSize: 11,
      fontFamily: fontFamily ?? 'nexa-regular',
      color: fontColor ?? FontColor().grey2,
      fontWeight: FontWeight.w400);

  TextStyle smallestTest = TextStyle(
      fontSize: 6,
      fontFamily: 'nexa-regular',
      color: FontColor().grey,
      height: 1.2,
      fontWeight: FontWeight.w400);

  TextStyle eightPixel = TextStyle(
      fontSize: 8,
      fontFamily: 'Nexa-Bold',
      color: FontColor().black2,
      fontWeight: FontWeight.w400);

  TextStyle sixteenPixel({Color? textColor}) => TextStyle(
      fontSize: 16,
      fontFamily: 'Nexa-Bold',
      color: textColor ?? FontColor().white,
      fontWeight: FontWeight.w400);

  TextStyle ninePixel({fontFamily, fontColor}) => TextStyle(
      fontSize: 9,
      fontFamily: fontFamily ?? 'Nexa-Bold',
      color: fontColor ?? FontColor().brown,
      fontWeight: FontWeight.w400);
  TextStyle ligthEightPixel({Color? fontColor}) => TextStyle(
      fontSize: 8,
      fontFamily: 'nexa-regular',
      color: fontColor ?? FontColor().grey7,
      fontWeight: FontWeight.w400);

  TextStyle dash = TextStyle(
      fontSize: 8,
      height: -0.5,
      fontFamily: 'nexa-regular',
      fontWeight: FontWeight.w400,
      color: FontColor().grey2);

  TextStyle record = TextStyle(
      fontFamily: 'Nexa-Bold',
      color: FontColor().orange,
      fontSize: 10,
      fontWeight: FontWeight.w400);

  //channel partner
  TextStyle circleText({double? fontSize, fontFamily}) => TextStyle(
      color: blueColor,
      fontWeight: FontWeight.w400,
      fontFamily: fontFamily ?? 'nexa-regular',
      fontSize: fontSize ?? 20);
//project details fonts
  TextStyle projectText({double? fontSize}) => TextStyle(
      fontSize: fontSize ?? 9,
      fontFamily: 'Nexa-Bold',
      color: FontColor().brown,
      fontWeight: FontWeight.w400);

  TextStyle dateText({Color? fontColor}) => TextStyle(
        fontSize: 7,
        fontFamily: 'Nexa-Bold',
        color: fontColor ?? FontColor().grey,
        fontWeight: FontWeight.w400,
      );
  // Table calender fonts
  TextStyle tableToday = TextStyle(
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
    fontFamily: 'Nexa-Bold',
    fontSize: 13,
    color: FontColor().white,
  );
  TextStyle table1 = const TextStyle(
    fontStyle: FontStyle.normal,
    fontSize: 10,
    fontFamily: 'nexa-regular',
    color: whiteColor,
  );
  TextStyle tableTitle = TextStyle(
    fontWeight: FontWeight.w600,
    fontStyle: FontStyle.normal,
    fontSize: 15,
    color: FontColor().yellow,
  );
  TextStyle amPM = const TextStyle(
      fontSize: 9,
      fontWeight: FontWeight.w400,
      fontFamily: 'nexa-regular',
      color: greyShade600);
  TextStyle visitDate = const TextStyle(
      fontSize: 9,
      fontWeight: FontWeight.w400,
      fontFamily: 'nexa-regular',
      color: greyShade600);
  TextStyle date = TextStyle(
      fontSize: 6,
      color: FontColor().grey,
      fontFamily: 'nexa-regular',
      fontWeight: FontWeight.w300);
  TextStyle trailing = const TextStyle(
      fontSize: 9,
      fontWeight: FontWeight.w400,
      fontFamily: 'Nexa-Bold',
      color: primaryColor);

  TextStyle selectBar(Color? textColor) => TextStyle(
      fontFamily: 'Nexa-Bold',
      height: 1.4,
      fontSize: 12,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
      color: textColor ?? whiteColor);
}
