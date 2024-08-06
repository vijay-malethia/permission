import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '/ui/common/index.dart';

class ChannelPartnerCard extends StatelessWidget {
  final String? comapanyName;
  final String? userName;
  final String? appNumber;
  final void Function()? onTapCall;


  const ChannelPartnerCard(
      {super.key, this.comapanyName, this.userName, this.appNumber,this.onTapCall});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: borderColor,
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
            width: double.infinity,
            clipBehavior: Clip.hardEdge,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: whiteColor,
              border: Border.all(color: whiteColor),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  comapanyName!,
                  style: AppTextStyle().sixteenPixel(textColor: primaryColor),
                ),
                verticalSpaceExtraSmall,
                Text('Application #: $appNumber',
                    style: AppTextStyle().toastMessageTextStyle(
                        fontColor: FontColor().grey,
                        fontFamily: 'nexa-regular'))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 7.0, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  userName!,
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                InkWell(onTap: onTapCall,
                  child: SvgPicture.asset(Images().callIcon, height: 18, width: 18))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
