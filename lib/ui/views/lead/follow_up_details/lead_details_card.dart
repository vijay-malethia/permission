import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '/ui/common/index.dart';

class LeadDetailsCard extends StatelessWidget {
  final String personName;
  final String visitDate;
  final String visitTime;
  final String callDuration;
  final String recordingUrl;

  const LeadDetailsCard({
    super.key,
    required this.personName,
    required this.callDuration,
    required this.visitDate,
    required this.visitTime,
    required this.recordingUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsetsDirectional.only(bottom: 12),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            color: Colors.grey.shade300,
            offset: const Offset(0, 1.0),
            blurRadius: 5.0,
            spreadRadius: 1.0), //
      ], borderRadius: BorderRadius.circular(10), color: borderColor),
      child: Column(
        children: [
          Container(
            height: 65,
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
                    Text('Caller', style: AppTextStyle().ligthEightPixel()),
                    Row(
                      children: [
                        Text(personName,
                            style: AppTextStyle().inputLabelTextStyle(
                                fontColor: FontColor().grey)),
                      ],
                    ),
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
                            )),
                        horizontalSpaceTiny,
                        SvgPicture.asset(
                          Images().clockIcon,
                        ),
                        horizontalSpaceTiny,
                        Text(visitTime,
                            style: AppTextStyle()
                                .ninePixel(fontColor: FontColor().brown)),
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
                      children: [
                        SizedBox(
                          height: 15,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SvgPicture.asset(
                                Images().incomingCallIcon,
                              ),
                              horizontalSpaceTiny,
                              Text(
                                  callDuration == '0'
                                      ? '0 m 0 s'
                                      : callDuration,
                                  style: AppTextStyle().ligthEightPixel(
                                      fontColor: FontColor().grey7)),
                            ],
                          ),
                        ),
                        verticalSpaceTiny,
                        if (recordingUrl.isNotEmpty)
                          SvgPicture.asset(
                            Images().playIcon,
                          )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
