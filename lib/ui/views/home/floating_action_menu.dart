import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '/ui/views/home/home_viewmodel.dart';
import '../../common/index.dart';

class FloatingActionMenu extends StatefulWidget {
  final void Function()? onChannelPartnerTap;
  final void Function()? onCaptureLeadTap;

  const FloatingActionMenu(
      {required this.onChannelPartnerTap,
      required this.onCaptureLeadTap,
      super.key});

  @override
  FloatingActionMenuState createState() => FloatingActionMenuState();
}

class FloatingActionMenuState extends State<FloatingActionMenu>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;

  FloatingActionMenuState();

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
    animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.easeIn,
    );
    _runExpandCheck();
  }

  void _runExpandCheck() async {
    await animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
        opacity: animation,
        child: Container(
            width: double.infinity,
            color: black54,
            padding: const EdgeInsets.all(10),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (HomeViewModel().sharedService.isCreateDSTUser!)
                    _renderButton(
                        name: 'ADD DST USER',
                        iconName: Images().person,
                        context: context,
                        ontap: widget.onChannelPartnerTap,
                        isNotAllign: true),
                  verticalSpaceTiny,
                  if (HomeViewModel().sharedService.isCreateCPUser!)
                    _renderButton(
                        name: 'ADD CP USER',
                        iconName: Images().btnChannelPartnerIcon,
                        context: context,
                        ontap: widget.onChannelPartnerTap,
                        isNotAllign: true),
                  verticalSpaceTiny,
                  if (HomeViewModel().sharedService.isCaptureLead!)
                    _renderButton(
                        name: 'CAPTURE LEAD',
                        iconName: Images().captureLeadsIcon,
                        ontap: widget.onCaptureLeadTap,
                        context: context,
                        isNotAllign: true),
                  verticalSpaceTiny
                ])));
  }
}

//Render button
_renderButton({name, iconName, ontap, context, bool isNotAllign = false}) {
  return InkWell(
    onTap: ontap,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          decoration: const BoxDecoration(
              color: secondaryColor, shape: BoxShape.circle),
          height: screenDimension(context) / 25.9,
          width: screenDimension(context) / 25.9,
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.only(right: 12),
          child: SvgPicture.asset(iconName),
        ),
        verticalSpaceExtraSmall,
        Container(
          padding: EdgeInsets.only(right: isNotAllign ? 7.5 : 0),
          child: Text(
            name,
            textAlign: TextAlign.center,
            style: AppTextStyle().floatingButtonTextStyle,
          ),
        )
      ],
    ),
  );
}
