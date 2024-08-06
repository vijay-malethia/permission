import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '/ui/common/index.dart';

class UserRecords extends StatefulWidget {
  final String personName;
  final String companyName;
  final String location;

  final String leads;
  final String leadsCount;
  final String? imageUrl;
  final String? designation;

  final bool? actionUnavailable;
  final bool? callIconAvailable;
  final int? projectCount;
  final String path;
  final bool showActivateUserIcon;
  final bool showDeactivateUserIcon;
  final bool userStatus;
  final VoidCallback? onTap;
  final VoidCallback? onTapBuilding;
  final VoidCallback? onTapRemove;
  final GestureTapCallback? onCallIconTap;

  const UserRecords({
    super.key,
    required this.personName,
    required this.companyName,
    required this.leads,
    required this.leadsCount,
    required this.location,
    this.imageUrl,
    this.designation,
    this.callIconAvailable,
    this.actionUnavailable = false,
    this.projectCount,
    required this.path,
    this.showActivateUserIcon = false,
    this.showDeactivateUserIcon = false,
    this.userStatus = false,
    this.onTap,
    this.onTapBuilding,
    this.onTapRemove,
    this.onCallIconTap,
  });

  @override
  UserRecordsState createState() => UserRecordsState();
}

class UserRecordsState extends State<UserRecords> {
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
                  Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(
                          top: 10, bottom: 5, left: 15, right: 15),
                      decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Stack(
                            alignment: Alignment.topRight,
                            children: [
                              ClipOval(
                                child: SizedBox(
                                  height: 40,
                                  width: 40,
                                  child: Image.network(
                                    widget.imageUrl!,
                                    fit: BoxFit.fill,
                                    errorBuilder: (context, error,
                                            stackTrace) =>
                                        SvgPicture.asset(Images().leadPerson,
                                            height: 35, width: 35),
                                  ),
                                ),
                              ),
                              Positioned(
                                  top: 2,
                                  left: 28,
                                  child: CircleAvatar(
                                    backgroundColor: widget.userStatus
                                        ? defaultgreen
                                        : customGrey,
                                    radius: 6,
                                    child: SvgPicture.asset(
                                      Images().checkicon,
                                    ),
                                  ))
                            ],
                          ),
                          horizontalSpaceTiny,
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.personName,
                                      style: AppTextStyle().personName,
                                    ),
                                    horizontalSpaceExtraSmall,
                                    if (widget.callIconAvailable != null &&
                                        widget.callIconAvailable == true) ...[
                                      InkWell(
                                        onTap: widget.onCallIconTap,
                                        child: SvgPicture.asset(
                                            Images().phoneIcon,
                                            height: 10),
                                      )
                                    ],
                                  ],
                                ),
                                if (widget.designation != null &&
                                    widget.designation != '') ...[
                                  Text(widget.designation!)
                                ],
                                if (widget.location != '') ...[
                                  InkWell(
                                    onTap: widget.onTap,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SvgPicture.asset(
                                          Images().buildingIcon,
                                          height: 12,
                                          width: 15,
                                        ),
                                        horizontalSpaceTiny,
                                        Text(
                                          widget.location,
                                          style: AppTextStyle().subTitle,
                                        ),
                                        if (widget.projectCount != 0) ...[
                                          horizontalSpaceTiny,
                                          Container(
                                            padding: const EdgeInsets.all(2),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(3),
                                                color: lightOrange1),
                                            child: Center(
                                              child: Text(
                                                  '+ ${widget.projectCount}',
                                                  style: AppTextStyle()
                                                      .titletext1),
                                            ),
                                          )
                                        ]
                                      ],
                                    ),
                                  )
                                ]
                              ]),
                          const Spacer(),
                          Column(
                            children: [
                              CircleAvatar(
                                  radius: 18,
                                  backgroundColor: lightBgColor,
                                  child: Center(
                                      child: Text(
                                    widget.leadsCount,
                                    style:
                                        AppTextStyle().circleText(fontSize: 17),
                                  ))),
                              Text(
                                'Leads',
                                style: AppTextStyle().textTitleStyle,
                              ),
                            ],
                          ),
                        ],
                      )),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: borderColor,
                    ),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(widget.path),
                          horizontalSpaceTiny,
                          Text(widget.companyName,
                              style: AppTextStyle().company),
                          const Expanded(child: SizedBox()),
                          if (widget.actionUnavailable == null ||
                              widget.actionUnavailable == true) ...[
                            GestureDetector(
                              onTap: widget.onTapBuilding,
                              child: SvgPicture.asset(
                                Images().buildingPlusIcon,
                                height: 13,
                                width: 13,
                              ),
                            ),
                          ],
                          if (widget.showActivateUserIcon) ...[
                            horizontalSpaceTiny,
                            GestureDetector(
                              onTap: widget.onTapRemove,
                              child: SvgPicture.asset(
                                Images().personTick,
                                height: 13,
                                width: 13,
                              ),
                            ),
                          ],
                          if (widget.showDeactivateUserIcon) ...[
                            horizontalSpaceTiny,
                            GestureDetector(
                              onTap: widget.onTapRemove,
                              child: SvgPicture.asset(
                                Images().personminusIcon,
                                height: 13,
                                width: 13,
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
