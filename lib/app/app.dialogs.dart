// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedDialogGenerator
// **************************************************************************

import 'package:stacked_services/stacked_services.dart';

import 'app.locator.dart';
import '../ui/dialogs/confirm/confirm_dialog.dart';
import '../ui/dialogs/deactive/deactive_dialog.dart';
import '../ui/dialogs/disqualified/disqualified_dialog.dart';
import '../ui/dialogs/imge_preview/imge_preview_dialog.dart';
import '../ui/dialogs/info_alert/info_alert_dialog.dart';
import '../ui/dialogs/user_create/user_create_dialog.dart';

enum DialogType {
  infoAlert,
  confirm,
  userCreate,
  deactive,
  imgePreview,
  disqualified,
}

void setupDialogUi() {
  final dialogService = locator<DialogService>();

  final Map<DialogType, DialogBuilder> builders = {
    DialogType.infoAlert: (context, request, completer) =>
        InfoAlertDialog(request: request, completer: completer),
    DialogType.confirm: (context, request, completer) =>
        ConfirmDialog(request: request, completer: completer),
    DialogType.userCreate: (context, request, completer) =>
        UserCreateDialog(request: request, completer: completer),
    DialogType.deactive: (context, request, completer) =>
        DeactiveDialog(request: request, completer: completer),
    DialogType.imgePreview: (context, request, completer) =>
        ImgePreviewDialog(request: request, completer: completer),
    DialogType.disqualified: (context, request, completer) =>
        DisqualifiedDialog(request: request, completer: completer),
  };

  dialogService.registerCustomDialogBuilders(builders);
}
