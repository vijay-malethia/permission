import 'dart:io';

import 'package:stacked_services/stacked_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import '/app/app.bottomsheets.dart';
import '/app/app.dialogs.dart';
import '/app/app.locator.dart';
import '/app/app.router.dart';
import '/ui/common/index.dart';
import 'services/index.dart';

Future<void> main() async {
  if (Platform.isAndroid) {
    FlutterNativeSplash.remove();
  }
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  setupSnackbarUi();
  setupDialogUi();
  setupBottomSheetUi();
  runApp(const SalesLead());
}

class SalesLead extends StatelessWidget {
  const SalesLead({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        dismissKeyboard(context);
      },
      child: MaterialApp(
        initialRoute: Routes.startupView,
        theme: AppTheme().appTheme(),
        onGenerateRoute: StackedRouter().onGenerateRoute,
        navigatorKey: StackedService.navigatorKey,
        navigatorObservers: [
          StackedService.routeObserver,
        ],
        builder: (context, child) {
          return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: child!);
        },
      ),
    );
  }
}
