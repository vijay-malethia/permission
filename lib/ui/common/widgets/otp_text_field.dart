import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

import '/ui/common/index.dart';

class OTPTextField extends StatelessWidget {
  final TextEditingController otpController;
  final void Function(String)? onChanged;

  const OTPTextField({
    super.key,
    required this.otpController,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Pinput(
      controller: otpController,
      onChanged: onChanged,
      showCursor: true,
      obscureText: true,
      obscuringCharacter: '●',
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      preFilledWidget: Text("-", style: AppTextStyle().descriptionTextStyle()),
      defaultPinTheme: PinTheme(
          width: MediaQuery.of(context).size.width * 0.16,
          height: 44,
          textStyle: AppTextStyle().descriptionTextStyle(),
          decoration: BoxDecoration(
            color: whiteColor,
            border: Border.all(color: borderColor),
            borderRadius: BorderRadius.circular(5),
          )),
    );
  }
}
