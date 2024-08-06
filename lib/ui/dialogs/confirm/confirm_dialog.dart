import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../common/index.dart';
import 'confirm_dialog_model.dart';
import '/ui/common/widgets/buttons.dart';

class ConfirmDialog extends StackedView<ConfirmDialogModel> {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const ConfirmDialog({
    Key? key,
    required this.request,
    required this.completer,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    ConfirmDialogModel viewModel,
    Widget? child,
  ) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      backgroundColor: whiteColor,
      insetPadding: const EdgeInsets.symmetric(horizontal: 25),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        verticalSpaceExtraSmall,
                        SvgPicture.asset(
                          Images().callAlert,
                        ),
                        verticalSpaceMedium,
                        Text(
                          'Call ${request.title}?',
                          textAlign: TextAlign.center,
                          style: AppTextStyle().dialogLabelTextStyle(
                              textColor: FontColor().black),
                        ),
                      ]),
                ),
              ],
            ),
            verticalSpaceLarge,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Button(
                      onPressed: () {
                        completer(DialogResponse(
                            confirmed: true, data: request.data));
                      },
                      backgroundColor: primaryColor,
                      title: "CALL NOW"),
                ),
                horizontalSpaceSmall,
                Expanded(
                  child: Button(
                      onPressed: () {
                        completer(DialogResponse(confirmed: false));
                      },
                      backgroundColor: secondaryColor,
                      title: "CANCEL"),
                ),
              ],
            ),
            verticalSpaceLarge
          ],
        ),
      ),
    );
  }

  @override
  ConfirmDialogModel viewModelBuilder(BuildContext context) =>
      ConfirmDialogModel();
}
