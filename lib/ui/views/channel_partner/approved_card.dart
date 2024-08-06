import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '/ui/common/widgets/index.dart';
import '/ui/common/index.dart';

class ApprovedCard extends StatelessWidget {
  final String? comapanyName;
  final String? userName;
  final String? userCount;
  final String? leadsCount;
  final String? projectList;
  final String? projectListCount;
  final void Function()? onTapBuilding;
  final void Function()? onTapCall;
  final bool showProjectAssignIcon;
  final void Function()? onTapProject;

  const ApprovedCard(
      {super.key,
      this.comapanyName,
      this.userName,
      this.userCount,
      this.leadsCount,
      this.projectList,
      this.projectListCount,
      this.onTapBuilding,
      this.onTapCall,
      this.showProjectAssignIcon = false,
      this.onTapProject});

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
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: whiteColor,
              border: Border.all(color: whiteColor),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  //company name
                  title: Text(
                    comapanyName!,
                    style: AppTextStyle().sixteenPixel(textColor: primaryColor),
                  ),
                  //location name
                  subtitle: projectList != null
                      ? Row(
                          children: [
                            InkWell(
                              onTap: onTapBuilding,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SvgPicture.asset(Images().buildingIcon,
                                      height: 12, width: 15),
                                  horizontalSpaceTiny,
                                  Text(projectList!,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall),
                                  horizontalSpaceTiny,
                                  Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 2, vertical: 1),
                                      decoration: BoxDecoration(
                                          color: lightBgColor,
                                          borderRadius:
                                              BorderRadius.circular(4)),
                                      child: Text('+$projectListCount',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium))
                                ],
                              ),
                            ),
                          ],
                        )
                      : const Text(''),
                  //circle container with leads count
                  trailing: BadgeText.fromBadgeType(
                    text: leadsCount!,
                    badgeType: BadgeType.large,
                  ),
                ),
                //users count
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(Images().personIcon,
                            height: 12, width: 12),
                        horizontalSpaceExtraSmall,
                        Text('$userCount Users',
                            style: AppTextStyle().resendOtpTextStyle(
                                textColor: FontColor().grey))
                      ],
                    ),
                    Row(
                      children: [
                        Text('Leads',
                            style: Theme.of(context).textTheme.titleLarge),
                        horizontalSpaceExtraSmall
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 7.0, horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  userName!,
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                Row(
                  children: [
                    if (showProjectAssignIcon)
                      InkWell(
                        onTap: onTapBuilding,
                        child: Container(
                          margin: const EdgeInsets.only(left: 10, right: 5),
                          child: SvgPicture.asset(Images().buildingPlusIcon,
                              height: 12, width: 15),
                        ),
                      ),
                    horizontalSpaceTiny,
                    // ],
                    InkWell(
                        onTap: onTapCall,
                        child: SvgPicture.asset(Images().callIcon,
                            height: 18, width: 18)),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
