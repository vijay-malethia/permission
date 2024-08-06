import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '/ui/common/index.dart';

class BottomSheetHeader extends StatelessWidget {
  final String? imageUrl;
  final String? headerText;
  final double? closeIconPadding;
  final bool showDrag;
  final GestureTapCallback? ontap;

  const BottomSheetHeader(
      {super.key,
      this.imageUrl,
      this.ontap,
      this.headerText,
      this.closeIconPadding = 5, //by default
      this.showDrag = false});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // show drag handle
              if (showDrag) _buildDragHandle(context),
              //alignment for close icon
              SizedBox(height: closeIconPadding),
              // center image or header text
              if (imageUrl != null)
                SvgPicture.asset(imageUrl!)
              else
                Text(headerText!, style: AppTextStyle().loadingLabelTextStyle),
              // image with header text
              if (imageUrl != null && headerText != null) ...[
                verticalSpaceExtraSmall,
                Text(headerText!,
                    style: Theme.of(context).textTheme.labelLarge),
              ],
            ],
          ),
        ),
        Positioned(
          right: 0,
          child: InkWell(
              onTap: ontap ??
                  () {
                    Navigator.pop(context);
                  },
              child: SvgPicture.asset(
                Images().cancelIcon,
              )),
        )
      ],
    );
  }
}

//drag handle
Container _buildDragHandle(BuildContext context) {
  return Container(
    margin: const EdgeInsets.only(bottom: 4),
    height: 3,
    width: screenWidth(context) / 6,
    decoration: BoxDecoration(
        color: customLightGrey, borderRadius: BorderRadius.circular(1.5)),
  );
}
