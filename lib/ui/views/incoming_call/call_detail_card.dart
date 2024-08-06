import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '/ui/common/index.dart';

class CallDetailCard extends StatelessWidget {
  final String personName;
  final String visitDate;
  final String visitTime;
  final String callDuration;
  final String status;
  final String projectName;
  final void Function()? onTapPlay;
  final void Function()? onTapCall;
  final bool showPlayAudio;


  const CallDetailCard(
      {super.key,
      required this.personName,
      required this.callDuration,
      required this.visitDate,
      required this.visitTime,
      required this.status,
      required this.projectName,
      this.onTapPlay,
      this.onTapCall,
      this.showPlayAudio=false});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: borderColor),
      child: Column(
        children: [
          Container(
            height: 82,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: whiteColor),
            child: Row(
              children: [
                SvgPicture.asset(
                  Images().leadPerson,
                ),
                horizontalSpaceSmall,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Call from', style: AppTextStyle().ligthEightPixel()),
                    Row(
                      children: [
                        Text(personName,
                            style: AppTextStyle()
                                .buttonTextStyle(FontColor().grey)),
                        horizontalSpaceTiny,
                        InkWell(
                          onTap:onTapCall ,
                          child: SvgPicture.asset(
                            Images().phoneCloudIcon,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(Images().buildingIcon),
                        horizontalSpaceTiny,
                        Text(projectName,
                            style: AppTextStyle()
                                .tncTextStyle(textColor: FontColor().grey7)),
                      ],
                    ),
                    verticalSpaceTiny,
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SvgPicture.asset(
                          Images().calender,
                        ),
                        horizontalSpaceTiny,
                        Text(visitDate,
                            style: AppTextStyle().ninePixel(
                                fontColor: FontColor().brown,
                                fontFamily: 'Nexa-Bold')),
                        horizontalSpaceTiny,
                        SvgPicture.asset(
                          Images().clockIcon,
                        ),
                        horizontalSpaceTiny,
                        Text(visitTime,
                            style: AppTextStyle().ninePixel(
                                fontColor: FontColor().brown,
                                fontFamily: 'Nexa-Bold')),
                      ],
                    ),
                  ],
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.centerRight,
                    height: 65,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 15,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              callDuration == '0 m 0 s'
                                  ? SvgPicture.asset(
                                      Images().missCallIcon,
                                    )
                                  : SvgPicture.asset(
                                      Images().incomingCallIcon,
                                    ),
                              horizontalSpaceTiny,
                              Text(callDuration,
                                  style: AppTextStyle()
                                      .dateText(fontColor: FontColor().grey7)),
                            ],
                          ),
                        ),
                        verticalSpaceTiny,
                       showPlayAudio
                            ? InkWell(
                                onTap: onTapPlay,
                                child: SvgPicture.asset(
                                  Images().playIcon,
                                ),
                              )
                            : const SizedBox(height: 18, width: 18),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: borderColor,
            ),
            child: Text(status, style: AppTextStyle().company),
          ),
        ],
      ),
    );
  }
}
