import 'package:audio_wave/audio_wave.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '/ui/common/index.dart';
import 'all_leads/all_leads_viewmodel.dart';
import 'caputre_lead/capture_lead_viewmodel.dart';

class RecordAudio extends StatelessWidget {
  final AllLeadsViewModel? viewModel;
  final CaptureLeadViewModel? model;
  final bool isAllLeadScreen;

  const RecordAudio(
      {this.viewModel, this.model, this.isAllLeadScreen = true, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isAllLeadScreen ? 0 : 20.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Record Audio',
                style: AppTextStyle().buttonTextStyle(FontColor().black),
              ),
              InkWell(
                  onTap: isAllLeadScreen
                      ? viewModel!.showRecordAudioSheet
                      : model!.showRecordAudioSheet,
                  child: Container(
                      height: 31,
                      width: 31,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: secondaryColor,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.shade400,
                                offset: const Offset(0, 3.0),
                                blurRadius: 3.0,
                                spreadRadius: 1.0), //
                          ]),
                      padding: const EdgeInsets.all(6),
                      child: SvgPicture.asset(Images().recordMicIcon)))
            ],
          ),
          verticalSpaceExtraSmall,
          viewModel?.audioPath == null && model?.audioPath == null
              ? Container()
              : Container(
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade100,
                        blurRadius: 1.0,
                        spreadRadius: 1,
                        offset: const Offset(2, 2),
                      )
                    ],
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: StreamBuilder<Object>(
                      stream: isAllLeadScreen
                          ? viewModel!.audioPlayer.onPlayerStateChanged
                          : model!.audioPlayer.onPlayerStateChanged,
                      builder: (context, snapshot) {
                        if (isAllLeadScreen &&
                            snapshot.data == PlayerState.completed) {
                          viewModel?.stopPlaying();
                        } else if (snapshot.data == PlayerState.completed) {
                          model?.stopPlaying();
                        }

                        return Row(
                          children: [
                            InkWell(
                              onTap: () {
                                if (viewModel?.audioPath != null) {
                                  viewModel?.playRecording();
                                } else if (model?.audioPath != null) {
                                  model?.playRecording();
                                }
                              },
                              child: Container(
                                  height: 37,
                                  width: 37,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: secondaryColor),
                                  child: Icon(
                                      isAllLeadScreen
                                          ? viewModel!.isPlaying
                                              ? Icons.pause
                                              : Icons.play_arrow
                                          : model!.isPlaying
                                              ? Icons.pause
                                              : Icons.play_arrow,
                                      color: Colors.white)),
                            ),
                            const Spacer(),
                            (viewModel != null &&
                                        viewModel!.isPlaying == false) ||
                                    (model != null && model!.isPlaying == false)
                                ? Container()
                                : AudioWave(
                                    alignment: 'left',
                                    height: 40,
                                    animation: true,
                                    beatRate: const Duration(milliseconds: 150),
                                    width:
                                        MediaQuery.sizeOf(context).width * 0.6,
                                    spacing: 8,
                                    bars: List.generate(
                                        isAllLeadScreen
                                            ? viewModel!.value.length
                                            : model!.value.length,
                                        (index) => renderWave(isAllLeadScreen
                                            ? viewModel!.value[index]
                                            : model!.value[index]))),
                            const Spacer(),
                          ],
                        );
                      }),
                )
        ],
      ),
    );
  }

  AudioWaveBar renderWave(height) {
    return AudioWaveBar(heightFactor: height, color: waveColor);
  }
}
