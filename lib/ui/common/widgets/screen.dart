import 'package:flutter/material.dart';

import '../index.dart';

class Screen extends StatelessWidget {
  final Widget? headerChild;
  final Widget bodyChild;

  final double? height;

  final double? horizontalPadding;
  final double? verticalPadding;
  final bool showBg;
  final bool isRadiusColor;
  final bool isFollowUpView;

  const Screen(
      {required this.bodyChild,
      this.headerChild,
      this.height,
      this.horizontalPadding,
      this.verticalPadding,
      this.showBg = true,
      this.isRadiusColor = false,
      this.isFollowUpView = false,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundcolor,
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          if (showBg == true)
            Stack(children: [
              Container(
                  width: double.infinity,
                  height: isRadiusColor ? height : 200,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          alignment: Alignment.topCenter,
                          image: AssetImage(Images().loginBg),
                          fit: BoxFit.fill))),
              Container(color: black26)
            ]),
          SizedBox(
            height: screenHeight(context),
            width: screenWidth(context),
            child: Column(children: [
              SizedBox(
                height: MediaQuery.of(context).viewPadding.top,
              ),
              Container(
                  alignment: Alignment.centerLeft,
                  height: height == null
                      ? 180 - MediaQuery.of(context).viewPadding.top
                      : height! - 20 - MediaQuery.of(context).viewPadding.top,
                  width: double.infinity,
                  child: headerChild),
              Expanded(
                child: Container(
                  decoration: isRadiusColor
                      ? const BoxDecoration(
                          gradient: LinearGradient(
                              colors: [backgroundcolor, lightBgColor]))
                      : null,
                  child: Container(
                    width: screenWidth(context),
                    padding: EdgeInsets.symmetric(
                        horizontal: horizontalPadding ?? 20,
                        vertical: verticalPadding ?? 10),
                    decoration: BoxDecoration(
                        color: backgroundcolor,
                        borderRadius: BorderRadius.only(
                            topLeft: isFollowUpView
                                ? const Radius.circular(0)
                                : const Radius.circular(20),
                            topRight: isFollowUpView
                                ? const Radius.circular(0)
                                : const Radius.circular(20))),
                    child: bodyChild,
                  ),
                ),
              )
            ]),
          )
        ],
      ),
    );
  }
}
