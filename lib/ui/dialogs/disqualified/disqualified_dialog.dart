import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:stacked/stacked.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:sales_lead/ui/common/index.dart';
import 'package:sales_lead/ui/common/widgets/buttons.dart';
import 'disqualified_dialog_model.dart';

class DisqualifiedDialog extends StackedView<DisqualifiedDialogModel> {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const DisqualifiedDialog({
    Key? key,
    required this.request,
    required this.completer,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    DisqualifiedDialogModel viewModel,
    Widget? child,
  ) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      backgroundColor: whiteColor,
      insetPadding: const EdgeInsets.symmetric(horizontal: 25),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
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
                          request.imageUrl ?? "",
                        ),
                        verticalSpaceMedium,
                        Text(
                          request.title!,
                          textAlign: TextAlign.center,
                          style: AppTextStyle().dialogLabelTextStyle(
                              textColor: FontColor().black),
                        ),
                      ]),
                ),
              ],
            ),
            verticalSpaceSmall,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Button(
                      onPressed: () {
                        completer(DialogResponse(confirmed: true));
                      },
                      backgroundColor: primaryColor,
                      title: request.mainButtonTitle ?? ''),
                ),
                horizontalSpaceSmall,
                Expanded(
                  child: Button(
                      onPressed: () {
                        completer(DialogResponse(confirmed: false));
                      },
                      backgroundColor: secondaryColor,
                      title: request.secondaryButtonTitle ?? ''),
                ),
              ],
            ),
            verticalSpaceMedium
          ],
        ),
      ),
    );
  }

  @override
  DisqualifiedDialogModel viewModelBuilder(BuildContext context) =>
      DisqualifiedDialogModel();
}
