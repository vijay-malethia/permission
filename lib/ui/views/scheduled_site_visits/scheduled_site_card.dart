import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '/ui/common/index.dart';

class ScheduledSiteCard extends StatelessWidget {
  final String? personName;
  final String? companyName;
  final String? location;
  final String? vistDate;
  final String? clientVistDate;
  final String? clientVistTime;
  final String? date;
  final String? status;
  final Color? statusColor;
  final Color? statusBorderColor;
  final void Function()? onFollowUpTap;
  final Widget? childCard;
  final Widget? slideCard;
  final Color? bgColor;
  final String? isVerified;
  final void Function()? onTapCall;
  final bool lockIcon;

  const ScheduledSiteCard(
      {super.key,
      this.personName,
      this.companyName,
      this.date,
      this.location,
      this.vistDate,
      this.clientVistDate,
      this.onFollowUpTap,
      this.status,
      this.statusBorderColor,
      this.statusColor,
      this.childCard,
      this.slideCard,
      this.bgColor,
      this.clientVistTime,
      this.isVerified = '',
      this.onTapCall,
      this.lockIcon = false});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: borderColor,
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
              width: double.infinity,
              clipBehavior: Clip.hardEdge,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: whiteColor,
                border: Border.all(color: whiteColor),
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          personName!,
                          style: AppTextStyle().personName,
                        ),
                        // horizontalSpaceTiny,
                        InkWell(
                            onTap: onTapCall,
                            child: Container(
                              margin:const EdgeInsets.symmetric(horizontal: 10),
                              child: SvgPicture.asset(Images().phoneIcon))),
                        const Spacer(),
                        Container(
                            width: 90,
                            height: 22,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: statusColor,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: statusBorderColor!)),
                            child: Text(status!.toUpperCase(),
                                style: AppTextStyle().eightPixel))
                      ],
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(Images().buildingIcon),
                        horizontalSpaceTiny,
                        Text(
                          location!,
                          style: AppTextStyle()
                              .inputLabelTextStyle(fontColor: borderColor),
                        ),
                        const Expanded(child: SizedBox()),
                        Text(date!, style: AppTextStyle().date),
                        const SizedBox(width: 17)
                      ],
                    ),
                    const Divider(),
                    Row(children: [
                      SvgPicture.asset(
                        Images().calenderIcon,
                        height: 10,
                      ),
                      horizontalSpaceTiny,
                      Text(clientVistDate!, style: AppTextStyle().visitDate),
                      horizontalSpaceTiny,
                      SvgPicture.asset(
                        Images().watch,
                        height: 10,
                      ),
                      horizontalSpaceTiny,
                      Text("$clientVistTime", style: AppTextStyle().amPM),
                      horizontalSpaceTiny,
                      Text(
                        isVerified!,
                        style: AppTextStyle().ninePixel(fontColor: darkGreen),
                      )
                    ])
                  ])),
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: borderColor,
              ),
              child:
                  Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                SvgPicture.asset(
                  Images().person,
                ),
                horizontalSpaceTiny,
                Text(companyName!, style: AppTextStyle().company),
                if (lockIcon) ...[
                  const Spacer(),
                  SvgPicture.asset(Images().cloudIcon,width: 15)
                ]
              ]))
        ]));
  }
}
