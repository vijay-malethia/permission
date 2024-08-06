import 'package:flutter/material.dart';

import '/ui/common/index.dart';

class MyCard extends StatelessWidget {
  final Widget? child;
  final String? buttonTitle;
  final GestureTapCallback? onTap;
  final String? leadsName;

  const MyCard(
      {super.key, this.child, this.onTap, this.buttonTitle, this.leadsName});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: floatingActionGradient2,
        boxShadow: const [
          BoxShadow(
            color: greyShade100,
            blurRadius: 1.0,
            spreadRadius: 1,
            offset: Offset(2, 2),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            clipBehavior: Clip.hardEdge,
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: whiteColor,
              border: Border.all(color: whiteColor),
            ),
            child: child,
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Text(
                    leadsName!,
                    style: AppTextStyle().buttonTextStyle(FontColor().white),
                  ),
                ),
                InkWell(
                  onTap: onTap,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        buttonTitle!,
                        style: AppTextStyle()
                            .textButtonTextStyle(textColor: FontColor().white),
                      ),
                      horizontalSpaceTiny,
                      Container(
                        width: 12,
                        height: 15,
                        decoration: const BoxDecoration(
                          color: paleOrange,
                          shape: BoxShape.circle,
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.chevron_right_outlined,
                            size: 10,
                            color: purpleGrey,
                          ),
                        ),
                      ),
                      if (buttonTitle == viewAll) horizontalSpaceTiny,
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
