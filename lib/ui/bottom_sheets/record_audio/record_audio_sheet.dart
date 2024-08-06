import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '/ui/common/index.dart';
import '/ui/common/widgets/index.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '/ui/views/lead/caputre_lead/capture_lead_viewmodel.dart';
import 'wave.dart';

class RecordAudioSheet extends StackedView<CaptureLeadViewModel> {
  final Function(SheetResponse response)? completer;
  final SheetRequest request;
  const RecordAudioSheet({
    Key? key,
    required this.completer,
    required this.request,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    CaptureLeadViewModel viewModel,
    Widget? child,
  ) {
    return WillPopScope(
      onWillPop: () async {
        return completer!
            .call(SheetResponse(confirmed: true, data: viewModel.audioPath));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: const BoxDecoration(
          color: backgroundcolor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const BottomSheetHeader(headerText: 'Record Audio'),
            Text(
                viewModel.isStartRecording
                    ? 'Recording is in progress'
                    : 'Click to start recording audio',
                style: AppTextStyle().loadingDescriptionTextStyle),
            verticalSpaceMedium,
            renderAudioRecorder(viewModel, context),
            verticalSpaceSmall
          ],
        ),
      ),
    );
  }

  Row renderAudioRecorder(
      CaptureLeadViewModel viewModel, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (viewModel.isStartRecording) ...[
          Expanded(
            child: Text(viewModel.timerText,
                textAlign: TextAlign.right,
                style: AppTextStyle().buttonTextStyle(blackColor)),
          ),
        ],
        Expanded(
          child: InkWell(
              onTap: () {
                if (!viewModel.isRecording && !viewModel.isPause) {
                  viewModel.startRecording();
                } else if (!viewModel.isPause && viewModel.isRecording) {
                  viewModel.pauseRecording();
                } else if (viewModel.isPause) {
                  viewModel.resumeRecording();
                }
              },
              child: SizedBox(
                height: 100,
                width: 100,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    if (!viewModel.isPause && viewModel.isStartRecording) ...[
                      const CircleWave()
                    ],
                    Container(
                        height: 58,
                        width: 58,
                        decoration: const BoxDecoration(
                            color: primaryColor, shape: BoxShape.circle),
                        child: !viewModel.isStartRecording
                            ? Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: SvgPicture.asset(Images().recordingIcon),
                              )
                            : viewModel.isPause
                                ? const Icon(Icons.play_arrow,
                                    size: 20, color: whiteColor)
                                : const Icon(Icons.pause,
                                    size: 20, color: whiteColor)),
                  ],
                ),
              )),
        ),
        if (viewModel.isStartRecording) ...[
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: InkWell(
                onTap: () async {
                  await viewModel.stopRecording();
                  await Future.delayed(const Duration(seconds: 1));
                  completer!.call(SheetResponse(
                      confirmed: true, data: viewModel.audioPath));
                },
                child: Container(
                    height: 39,
                    width: 39,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: primaryColor),
                    child: const Icon(Icons.stop, color: whiteColor)),
              ),
            ),
          )
        ]
      ],
    );
  }

  @override
  CaptureLeadViewModel viewModelBuilder(BuildContext context) =>
      CaptureLeadViewModel();
}
