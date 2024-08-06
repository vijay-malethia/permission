import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '/ui/common/index.dart';
import '/ui/common/widgets/buttons.dart';
import 'info_alert_dialog_model.dart';

class InfoAlertDialog extends StackedView<InfoAlertDialogModel> {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const InfoAlertDialog({
    Key? key,
    required this.request,
    required this.completer,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    InfoAlertDialogModel viewModel,
    Widget? child,
  ) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 25),
      backgroundColor: whiteColor,
      child: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(Images().infoAlert),
            verticalSpaceSmall,
            Text(
              request.title ?? 'Notification Title',
              style: AppTextStyle()
                  .dialogLabelTextStyle(textColor: FontColor().black),
            ),
            const SizedBox(height: 15),
            Text(
              request.data ??
                  'Your Email / Mobile is not\nregistered or inactive',
              textAlign: TextAlign.center,
              style: AppTextStyle().countryCodeTextStyle,
              softWrap: true,
            ),
            const SizedBox(height: 30),
            Button(
                onPressed: () {
                  completer(DialogResponse(confirmed: true));
                  if (request.data == null) {
                    viewModel.showConfirmDialog();
                  }
                },
                title: "OK"),
          ],
        ),
      ),
    );
  }

  @override
  InfoAlertDialogModel viewModelBuilder(BuildContext context) =>
      InfoAlertDialogModel();
}
