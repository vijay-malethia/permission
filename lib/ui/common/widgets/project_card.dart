import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '/ui/common/index.dart';

class ProjectCard extends StatefulWidget {
  final String cityName;
  final String cpName;
  final int cpLength;

  final String projectName;
  final String lastSale;

  final int leadCount;
  final String leads;

  final bool? actionUnavailable;
  final String path;
  final String path2;

  final VoidCallback? onIconTap;
  final VoidCallback? onAssignedUserTap;
  final VoidCallback? onTap;

  const ProjectCard(
      {super.key,
      required this.leads,
      required this.cityName,
      required this.cpName,
      required this.cpLength,
      required this.projectName,
      required this.lastSale,
      required this.leadCount,
      this.actionUnavailable,
      required this.path,
      required this.path2,
      this.onIconTap,
      this.onAssignedUserTap,
      this.onTap});

  @override
  ProjectCardState createState() => ProjectCardState();
}

class ProjectCardState extends State<ProjectCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: lightYellow,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: borderColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  InkWell(
                    onTap: widget.onTap,
                    child: Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.symmetric(
                            vertical: 3, horizontal: 15),
                        decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SvgPicture.asset(
                              Images().buildingIcon,
                              height: 32,
                              width: 25,
                            ),
                            horizontalSpaceTiny,
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  verticalSpaceTiny,
                                  Text(
                                    capitalizeFirstLetter(widget.projectName),
                                    style: AppTextStyle().personName,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SvgPicture.asset(
                                        Images().locationIcon,
                                      ),
                                      horizontalSpaceTiny,
                                      Text(
                                        capitalizeFirstLetter(widget.cityName),
                                        style: AppTextStyle().subTitle,
                                      ),
                                    ],
                                  ),
                                  if (widget.lastSale != '') ...[
                                    Row(
                                      children: [
                                        Text(
                                          'Last Sale ',
                                          style: AppTextStyle().ninePixel(
                                              fontColor: FontColor().black,
                                              fontFamily: 'nexa-regular'),
                                        ),
                                        Text(
                                          DateFormat('dd-MMM-yyyy').format(
                                              DateTime.parse(widget.lastSale)),
                                          style: AppTextStyle().ninePixel(
                                              fontColor: FontColor().grey,
                                              fontFamily: 'nexa-regular'),
                                        ),
                                      ],
                                    )
                                  ],
                                ]),
                            const Spacer(),
                            Column(
                              children: [
                                verticalSpaceTiny,
                                CircleAvatar(
                                    radius: 22,
                                    backgroundColor: lightBgColor,
                                    child: Center(
                                        child: Text(
                                      widget.leadCount.toString(),
                                      style: AppTextStyle()
                                          .circleText(fontSize: 17),
                                    ))),
                                Text(
                                  'Leads',
                                  style: AppTextStyle().textTitleStyle,
                                ),
                              ],
                            ),
                          ],
                        )),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: borderColor,
                    ),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: widget.onAssignedUserTap,
                            child: Row(children: [
                              SvgPicture.asset(
                                widget.path,
                              ),
                              horizontalSpaceTiny,
                              Container(
                                constraints: BoxConstraints(
                                    maxWidth: screenWidth(context) * 0.3),
                                child: Text(
                                    capitalizeFirstLetter(widget.cpName),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppTextStyle().company),
                              ),
                              if (widget.cpLength > 1) ...[
                                Text(' +${widget.cpLength - 1}',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppTextStyle().company)
                              ]
                            ]),
                          ),
                          const Spacer(),
                          if (widget.actionUnavailable == null ||
                              widget.actionUnavailable == false) ...[
                            InkWell(
                              radius: 230,
                              onTap: widget.onIconTap,
                              child: Container(
                                alignment: Alignment.centerRight,
                                width: 30,
                                child: SvgPicture.asset(
                                  widget.path2,
                                ),
                              ),
                            ),
                          ]
                        ]),
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
