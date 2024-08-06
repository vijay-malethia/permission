import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '/ui/common/index.dart';
import '/ui/common/widgets/index.dart';
import 'user_create_dialog_model.dart';

class UserCreateDialog extends StackedView<UserCreateDialogModel> {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const UserCreateDialog({
    Key? key,
    required this.request,
    required this.completer,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    UserCreateDialogModel viewModel,
    Widget? child,
  ) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      backgroundColor: whiteColor,
      insetPadding: const EdgeInsets.only(left: 15, right: 15),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
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
                        request.title ?? "",
                        style: AppTextStyle().signHeaderStyle(textColor: blackColor),
                        textAlign: TextAlign.center,
                      ),
                      verticalSpaceSmall,
                      Text(
                        request.description ?? "",
                        textAlign: TextAlign.center,
                        style: AppTextStyle()
                            .signHeaderStyle(textColor: borderColor),
                      ),
                      verticalSpaceTiny,
                      Text(
                        request.data ?? "",
                        textAlign: TextAlign.center,
                        style: AppTextStyle().signSubHeader,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Button(
                onPressed: () {
                  completer(DialogResponse(confirmed: true));
                },
                title: request.mainButtonTitle ?? ''),
            verticalSpaceExtraSmall,
            Button(
                onPressed: () {
                  completer(DialogResponse(confirmed: false));
                },
                backgroundColor: whiteColor,
                textColor: primaryColor,
                borderColor: primaryColor,
                title: request.secondaryButtonTitle ?? '')
          ],
        ),
      ),
    );
  }

  @override
  UserCreateDialogModel viewModelBuilder(BuildContext context) =>
      UserCreateDialogModel();
}
