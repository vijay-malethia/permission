import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:stacked/stacked.dart';

import '/ui/common/index.dart';
import 'startup_viewmodel.dart';

class StartupView extends StackedView<StartupViewModel> {
  const StartupView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    StartupViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      body: Container(
          color: backgroundcolor,
          height: screenHeight(context),
          width: screenWidth(context),
          child: isSplashScreenOn && Platform.isAndroid
              ? Image.asset(
                  'assets/images/splash.png',
                  fit: BoxFit.fill,
                  height: screenHeight(context),
                  width: screenWidth(context),
                )
              : Container()),
    );
  }

  @override
  StartupViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      StartupViewModel();

  @override
  void onViewModelReady(StartupViewModel viewModel) => SchedulerBinding.instance
      .addPostFrameCallback((timeStamp) => viewModel.runStartupLogic());
}
