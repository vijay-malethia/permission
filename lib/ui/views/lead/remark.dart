import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:sales_lead/ui/common/app_fonts.dart';
import 'package:sales_lead/ui/common/images.dart';
import 'package:sales_lead/ui/common/ui_helpers.dart';
import 'package:sales_lead/ui/common/widgets/input.dart';
import 'package:sales_lead/ui/views/lead/all_leads/all_leads_viewmodel.dart';
import 'package:sales_lead/ui/views/lead/caputre_lead/capture_lead_viewmodel.dart';

class Remark extends StatelessWidget {
  final AllLeadsViewModel? viewModel;
  final CaptureLeadViewModel? model;
  final TextEditingController? controller;
  final String? title;
  final bool isAllLeadScreen;
  const Remark(
      {this.viewModel,
      this.model,
      this.controller,
      this.title,
      this.isAllLeadScreen = true,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isAllLeadScreen ? 0 : 20.0),
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              title ?? 'Remarks',
              style: AppTextStyle().buttonTextStyle(FontColor().black),
            ),
            InkWell(
              onTap: () {
                isAllLeadScreen
                    ? viewModel!.isListening
                        ? viewModel!.stopSpeechToText()
                        : viewModel!.startSpeechToText()
                    : model!.isListening
                        ? model!.stopSpeechToText()
                        : model!.startSpeechToText();
              },
              child: Row(mainAxisSize: MainAxisSize.max, children: [
                Text(
                  isAllLeadScreen
                      ? viewModel!.isListening
                          ? 'Listening...'
                          : 'use voice prompt'
                      : model!.isListening
                          ? 'Listening...'
                          : 'use voice prompt',
                  style: AppTextStyle().record,
                ),
                horizontalSpaceTiny,
                SvgPicture.asset(Images().micIcon, height: 13)
              ]),
            )
          ]),
          verticalSpaceTiny,
          InputWithLabel(
            maxLines: 3,
            controller: controller,
            textInputAction: TextInputAction.done,
          )
        ],
      ),
    );
  }
}
