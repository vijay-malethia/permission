import 'package:flutter/material.dart';
import 'package:flutter_debouncer/flutter_debouncer.dart';
import '/ui/common/index.dart';

class Button extends StatelessWidget {
  final String title;
  final GestureTapCallback? onPressed;
  final EdgeInsets? margin;
  final bool loading;
  final bool disabled;
  final double? height;

  final Color? borderColor;
  final Color? textColor;
  final Color? backgroundColor;
  final double? borderRadious;

  const Button({
    required this.onPressed,
    required this.title,
    this.backgroundColor,
    this.margin,
    this.loading = false,
    this.disabled = false,
    this.height,
    this.textColor,
    this.borderColor,
    this.borderRadious,
    Key? key,
  }) : super(key: key);

  Widget getLoadingIndicator() {
    return const SizedBox(
      width: 20,
      height: 20,
      child: CircularProgressIndicator(strokeWidth: 2.5, color: whiteColor),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      width: MediaQuery.of(context).size.width,
      height: height ?? 44,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor ?? primaryColor,
            disabledBackgroundColor: backgroundColor != null
                ? backgroundColor!.withOpacity(0.5)
                : primaryColor.withOpacity(0.5),
            side: BorderSide(
              width: 1.0,
              color: borderColor ?? transparent,
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadious ?? 5))),
        onPressed: (disabled || loading || onPressed == null)
            ? null
            : () {
                dismissKeyboard(context);
                Debouncer().throttle(const Duration(seconds: 3), () {
                  onPressed!();
                });
              },
        child: loading
            ? getLoadingIndicator()
            : Text(title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyle().buttonTextStyle(textColor)),
      ),
    );
  }
}
