import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '/ui/common/index.dart';

class InputWithLabel extends StatelessWidget {
  final String? labelText;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? trailing;
  final Widget? suffixIcon;
  final bool obscureText;
  final void Function(String)? onChanged;
  final TextInputAction? textInputAction;
  final String? initialValue;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final int? maxLines;
  final int? maxLength;
  final TextStyle? hintstyle;
  final TextStyle? textStyle;
  final EdgeInsets? margin;
  final TextCapitalization? textCapitalization;
  final FocusNode? focusNode;
  final void Function(String)? onFieldSubmitted;
  final bool readOnly;
  final void Function()? onTap;
  final void Function()? onEditingComplete;
  final bool autofocus;
  final double? letterSpacing;
  final bool textAlign;
  final List<TextInputFormatter>? inputFormatters;
  final bool isOtp;

  const InputWithLabel(
      {this.labelText,
      this.hintText,
      this.prefixIcon,
      this.trailing,
      this.suffixIcon,
      this.obscureText = false,
      this.onChanged,
      this.textInputAction,
      this.initialValue,
      this.keyboardType,
      this.controller,
      this.maxLines,
      this.maxLength,
      this.textStyle,
      this.margin,
      this.textCapitalization,
      this.focusNode,
      this.onFieldSubmitted,
      this.readOnly = false,
      this.onTap,
      this.autofocus = false,
      this.letterSpacing,
      this.textAlign = false,
      this.onEditingComplete,
      this.inputFormatters,
      this.hintstyle,
      this.isOtp = false,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText != null) ...[
          Text(
            labelText!,
            style: AppTextStyle().inputLabelTextStyle(),
          ),
          verticalSpaceExtraSmall,
        ],
        Container(
            height: maxLines == null ? 45 : maxLines! * 25,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                color: whiteColor,
                border: Border.all(color: borderColor, width: 1),
                borderRadius: BorderRadius.circular(5)),
            child: Row(
                crossAxisAlignment: maxLines != null
                    ? CrossAxisAlignment.start
                    : CrossAxisAlignment.center,
                children: [
                  if (prefixIcon != null) ...[
                    prefixIcon!,
                    horizontalSpaceTiny,
                  ],
                  Expanded(
                      child: TextFormField(
                          textAlign:
                              textAlign ? TextAlign.center : TextAlign.start,
                          onTap: onTap,
                          controller: controller,
                          inputFormatters: inputFormatters,
                          readOnly: readOnly,
                          obscureText: obscureText,
                          cursorColor: greyDark,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(
                                  top: maxLines != null ? 7 : 0,
                                  bottom: maxLines != null ? 7 : 14,
                                  left: isOtp ? 0 : 5),
                              hintText: hintText,
                              hintStyle: hintstyle ??
                                  AppTextStyle().inputHintTextStyle,
                              counterText: '',
                              suffixIcon: suffixIcon,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide.none)),
                          textAlignVertical: maxLines != null
                              ? TextAlignVertical.top
                              : TextAlignVertical.center,
                          style: AppTextStyle().inputTextStyle,
                          onChanged: onChanged,
                          onEditingComplete: onEditingComplete,
                          autocorrect: false,
                          autofocus: autofocus,
                          textInputAction:
                              textInputAction ?? TextInputAction.next,
                          initialValue: initialValue,
                          keyboardType: keyboardType,
                          maxLines: maxLines ?? 1,
                          minLines: 1,
                          maxLength: maxLength,
                          focusNode: focusNode,
                          onFieldSubmitted: onFieldSubmitted,
                          textCapitalization:
                              textCapitalization ?? TextCapitalization.none)),
                  trailing ?? Container()
                ])),
      ],
    );
  }
}
