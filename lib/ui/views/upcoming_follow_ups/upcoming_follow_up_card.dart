import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '/ui/common/index.dart';

class UpcomingFollowUpCard extends StatelessWidget {
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
  final String? trailingIconName;
  final String? followUpType;
  final void Function()? onTapCall;
  final void Function()? onTapCloudCall;
    final void Function()? onTapEmail;

  const UpcomingFollowUpCard(
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
      this.trailingIconName,
      this.followUpType,
      this.onTapCall,
      this.onTapCloudCall,
      this.onTapEmail});

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
                        if (followUpType == 'Call') ...[
                          horizontalSpaceTiny,
                          InkWell(
                              onTap: onTapCall,
                              child: SvgPicture.asset(Images().phoneIcon)),
                          horizontalSpaceTiny,
                          InkWell(
                              onTap: onTapCloudCall,
                              child: SvgPicture.asset(Images().phoneCloudIcon)),
                        ] else if (followUpType == 'Email') ...[
                          horizontalSpaceTiny,
                          InkWell(
                              onTap: onTapEmail,
                              child: SvgPicture.asset(Images().mailIcon))
                        ],
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
                          style: AppTextStyle().toastMessageTextStyle(
                              fontColor: FontColor().brown),
                        ),
                        const Expanded(child: SizedBox()),
                        Text(
                          date!,
                          style: AppTextStyle().date,
                        ),
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
                      const Expanded(child: SizedBox()),
                      Text(followUpType!, style: AppTextStyle().trailing)
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
                //  const Spacer(),
                //   Text(trailingIconName!, style: AppTextStyle().company),
              ]))
        ]));
  }
}
