import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '/ui/common/index.dart';

showCustomToast(BuildContext context, String text1Value, String text2Value,
    {GestureTapCallback? onTap, int? toastDuration}) {
  FToast fToast = FToast();
  fToast.init(context);
  Widget toast = Container(
    height: 48,
    padding: const EdgeInsets.symmetric(horizontal: 12.0),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0), color: blackColor),
    child: Row(
      children: [
        Expanded(
          child: Text(
            text1Value,
            style: AppTextStyle().toastMessageTextStyle(),
          ),
        ),
        GestureDetector(
            onTap: onTap,
            child: Text(
              text2Value,
              style: AppTextStyle().toastActionTextStyle,
            ))
      ],
    ),
  );

  fToast.showToast(
      child: toast,
      toastDuration: Duration(seconds: toastDuration ?? 3),
      gravity: ToastGravity.BOTTOM);
}
