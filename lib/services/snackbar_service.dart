import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

import '/app/app.locator.dart';
import '/enum/index.dart';
import '/ui/common/index.dart';

// SnackBar configuration
void setupSnackbarUi() {
  final service = locator<SnackbarService>();

  service.registerCustomSnackbarConfig(
    variant: SnackbarType.success,
    config: SnackbarConfig(
      backgroundColor: green1,
      textColor: Colors.white,
      snackPosition: SnackPosition.TOP,
      maxWidth: 700,
    ),
  );

  service.registerCustomSnackbarConfig(
    variant: SnackbarType.error,
    config: SnackbarConfig(
      backgroundColor: piChartRed,
      textColor: Colors.white,
      snackPosition: SnackPosition.TOP,
      maxWidth: 700,
    ),
  );
}
