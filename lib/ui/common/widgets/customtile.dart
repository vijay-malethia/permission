import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '/ui/common/index.dart';

class CustomTile extends StatefulWidget {
  final String? personName;
  final String? companyName;
  final String? location;
  final String? visitDate;
  final String? clientVistDate;
  final String? date;
  final String? status;
  final String? cpName;
  final Color? statusColor;
  final Color? statusBorderColor;
  final void Function()? onFollowUpTap;
  final void Function()? onHistoryTap;
  final void Function()? onStatusTap;
  final void Function()? onCompanyTap;
  final void Function()? onCallIconTap;
  final void Function()? onCallCloudTap;
  final void Function()? onViewTap;
  final Widget? childCard;
  final bool? isEditable;
  final Widget? slideCard;
  final Color? bgColor;
  final bool? isHandLockIconShow;
  final bool? isLockIconShow;
  final bool isShowLeadHistory;
  final bool isShowNormalCall;
  final bool isShowCloudCall;
  final bool isEnableArchive;

  const CustomTile(
      {super.key,
      this.personName,
      this.companyName,
      this.date,
      this.location,
      this.visitDate,
      this.clientVistDate,
      this.onFollowUpTap,
      this.status,
      this.isEditable,
      this.statusBorderColor,
      this.statusColor,
      this.childCard,
      this.slideCard,
      this.bgColor,
      this.onHistoryTap,
      this.onStatusTap,
      this.onCompanyTap,
      this.onCallIconTap,
      this.onCallCloudTap,
      this.cpName,
      this.isHandLockIconShow = false,
      this.isLockIconShow = false,
      this.isShowLeadHistory = false,
      this.isShowNormalCall = false,
      this.isShowCloudCall = false,
      this.isEnableArchive = false,
      this.onViewTap});

  @override
  CustomTileState createState() => CustomTileState();
}

class CustomTileState extends State<CustomTile>
    with SingleTickerProviderStateMixin {
  late AnimationController expandController;
  late Animation<double> animation;

  bool isShow = false;

  CustomTileState();

  @override
  void initState() {
    super.initState();
    expandController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 350));
    animation = CurvedAnimation(
      parent: expandController,
      curve: Curves.fastOutSlowIn,
    );
    _runExpandCheck();
  }

  void _runExpandCheck() async {
    if (isShow) {
      await expandController.forward();
    } else {
      expandController.reverse();
    }
  }

  @override
  void dispose() {
    expandController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.bgColor ?? lightYellow,
        borderRadius: BorderRadius.circular(10),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                isShow = !isShow;
                _runExpandCheck();
                setState(() {});
              },
              child: widget.childCard ??
                  Column(
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
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 15),
                              decoration: BoxDecoration(
                                color: whiteColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text("${widget.personName}",
                                          style: AppTextStyle().personName),
                                      horizontalSpaceExtraSmall,
                                      if (widget.isShowNormalCall)
                                        InkWell(
                                            onTap: widget.onCallIconTap,
                                            child: SvgPicture.asset(
                                                Images().phoneIcon)),
                                      horizontalSpaceExtraSmall,
                                      if (widget.isShowCloudCall)
                                        InkWell(
                                            onTap: widget.onCallCloudTap,
                                            child: SvgPicture.asset(
                                                Images().phoneCloudIcon)),
                                      // ],
                                      const Spacer(),
                                      InkWell(
                                        onTap: widget.onStatusTap,
                                        child: Stack(
                                          alignment: Alignment.centerRight,
                                          children: [
                                            Container(
                                                height: 18,
                                                width: 75,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                    color: widget.statusColor,
                                                    borderRadius: BorderRadius
                                                        .circular(12),
                                                    border: Border.all(
                                                        color: widget
                                                            .statusBorderColor!)),
                                                child: Text(widget.status!,
                                                    style: AppTextStyle()
                                                        .ninePixel(
                                                            fontColor:
                                                                FontColor()
                                                                    .black2))),
                                            if (widget.isEditable != null &&
                                                widget.isEditable == true) ...[
                                              horizontalSpaceTiny,
                                              Positioned(
                                                  right: 7,
                                                  child: SvgPicture.asset(
                                                      Images().editPen))
                                            ]
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      SvgPicture.asset(Images().buildingIcon),
                                      horizontalSpaceTiny,
                                      Text(
                                        widget.location!,
                                        style: AppTextStyle().subTitle,
                                      ),
                                      const Spacer(),
                                      Container(
                                        width: 75,
                                        alignment: Alignment.center,
                                        child: Text(
                                          widget.date!,
                                          style: AppTextStyle().date,
                                        ),
                                      ),
                                    ],
                                  ),
                                  if (isShow) ...[verticalSpaceTiny],
                                  SizeTransition(
                                    axisAlignment: 1.0,
                                    sizeFactor: animation,
                                    child: Row(
                                      //108,218,159
                                      children: [
                                        if(widget.visitDate !=
                                            'Site not yet visited')
                                        Container(
                                          alignment: Alignment.center,
                                          height: 8,
                                          width: 8,
                                          decoration: BoxDecoration(
                                              color: green1,
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Container(
                                            height: 4,
                                            width: 4,
                                            decoration: BoxDecoration(
                                                color: green2,
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                          ),
                                        ),
                                        horizontalSpaceTiny,
                                        Text('${widget.visitDate}',
                                            style: AppTextStyle().visitDate),
                                        const Expanded(child: SizedBox()),
                                        if (widget
                                            .clientVistDate!.isNotEmpty) ...[
                                          SvgPicture.asset(
                                            Images().calenderIcon,
                                          ),
                                          horizontalSpaceTiny,
                                          Text(
                                            '${widget.clientVistDate}',
                                            style: AppTextStyle().visitDate,
                                          )
                                        ]
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: borderColor,
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    Images().handShakeIcon,
                                  ),
                                  horizontalSpaceTiny,
                                  InkWell(
                                    onTap: widget.onCompanyTap,
                                    child: Text(
                                        (widget.cpName!.isNotEmpty)
                                            ? widget.cpName!
                                            : widget.companyName!,
                                        style: AppTextStyle().company),
                                  ),
                                  const Expanded(child: SizedBox()),
                                  if (widget.isLockIconShow!)
                                    SvgPicture.asset(Images().cloudIcon),
                                  if (widget.isHandLockIconShow!)
                                    SvgPicture.asset(Images().handLockIcon),
                                  horizontalSpaceExtraSmall,
                                  if (widget.isShowLeadHistory)
                                    InkWell(
                                      onTap: widget.onHistoryTap,
                                      child: SvgPicture.asset(
                                        Images().timerIcon,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
            ),
            SizeTransition(
              axisAlignment: 1.0,
              sizeFactor: animation,
              child: widget.slideCard ??
                  Container(
                      height: 45,
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.zero,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: widget.onFollowUpTap,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  verticalSpaceTiny,
                                  SvgPicture.asset(Images().followUpIcon),
                                  Text('Follow Up',
                                      style: AppTextStyle().ninePixel(
                                          fontColor: FontColor().grey))
                                ],
                              ),
                            ),
                          ),
                          const VerticalDivider(
                            color: yellow2,
                            indent: 10,
                            endIndent: 5,
                            thickness: 1,
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: widget.isEnableArchive ? () {} : null,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  verticalSpaceTiny,
                                  SvgPicture.asset(
                                    Images().archiveIcon,
                                  ),
                                  Text('Archive',
                                      style: AppTextStyle().ninePixel(
                                          fontColor: FontColor().grey))
                                ],
                              ),
                            ),
                          ),
                          const VerticalDivider(
                              color: yellow2,
                              indent: 10,
                              endIndent: 5,
                              thickness: 1),
                          Expanded(
                            child: InkWell(
                              onTap: widget.onViewTap,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  verticalSpaceTiny,
                                  SvgPicture.asset(
                                    Images().pageView,
                                  ),
                                  Text('View',
                                      style: AppTextStyle().ninePixel(
                                          fontColor: FontColor().grey))
                                ],
                              ),
                            ),
                          ),
                        ],
                      )),
            )
          ],
        ),
      ),
    );
  }
}
