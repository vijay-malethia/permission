import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '/ui/common/index.dart';
import '/ui/common/widgets/index.dart';
import 'deactive_dialog_model.dart';

class DeactiveDialog extends StackedView<DeactiveDialogModel> {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const DeactiveDialog({
    Key? key,
    required this.request,
    required this.completer,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    DeactiveDialogModel viewModel,
    Widget? child,
  ) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      insetPadding: const EdgeInsets.only(left: 15, right: 15),
      backgroundColor: whiteColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
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
                      SvgPicture.asset(
                        request.imageUrl ?? "",
                      ),
                      verticalSpaceSmall,
                      Text(
                        request.title!,
                        textAlign: TextAlign.center,
                        style: AppTextStyle()
                            .signHeaderStyle(textColor: blackColor),
                      ),
                      if (request.description!.isNotEmpty) ...[
                        const SizedBox(height: 15),
                        Text(
                          request.description!,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleMedium,
                          maxLines: 3,
                          softWrap: true,
                        )
                      ]
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Button(
                onPressed: () {
                  completer(DialogResponse(confirmed: true));
                },
                title: request.mainButtonTitle ?? ''),
            if (request.secondaryButtonTitle!.isNotEmpty) ...[
              verticalSpaceSmall,
              Button(
                  textColor: primaryColor,
                  borderColor: primaryColor,
                  backgroundColor: whiteColor,
                  onPressed: () {
                    completer(DialogResponse(confirmed: false));
                  },
                  title: request.secondaryButtonTitle!),
            ]
          ],
        ),
      ),
    );
  }

  @override
  DeactiveDialogModel viewModelBuilder(BuildContext context) =>
      DeactiveDialogModel();
}
