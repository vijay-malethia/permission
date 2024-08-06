import 'package:audio_wave/audio_wave.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '/ui/common/index.dart';
import '/ui/views/incoming_call/incoming_call_viewmodel.dart';

class PlayCallRecordSheet extends StackedView<IncomingCallViewModel> {
  final Function(SheetResponse response)? completer;
  final SheetRequest request;
  const PlayCallRecordSheet({
    Key? key,
    required this.completer,
    required this.request,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    IncomingCallViewModel viewModel,
    Widget? child,
  ) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      child: Stack(
        children: [
          Positioned(
            right: 0,
            top: 5,
            child: InkWell(
                onTap: () {
                  completer!.call(SheetResponse(confirmed: false));
                },
                child: SvgPicture.asset(Images().cancelIcon)),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              StreamBuilder<Object>(
                  stream: viewModel.audioPlayer.onPlayerStateChanged,
                  builder: (context, snapshot) {
                    if (snapshot.data == PlayerState.completed) {
                      viewModel.stopPlaying();
                    }

                    return Row(
                      children: [
                        InkWell(
                          onTap: () {
                            if (request.data != null) {
                              viewModel.playRecording(request.data);
                            }
                          },
                          child: Container(
                              height: 37,
                              width: 37,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle, color: secondaryColor),
                              child: Icon(
                                  viewModel.isPlaying
                                      ? Icons.pause
                                      : Icons.play_arrow,
                                  color: Colors.white)),
                        ),
                        const Spacer(),
                        // viewModel.isPlaying == false
                        //     ? Container()
                        //     :
                        AudioWave(
                            alignment: 'left',
                            height: 40,
                            animation: true,
                            beatRate: const Duration(milliseconds: 150),
                            width: MediaQuery.sizeOf(context).width * 0.6,
                            spacing: 8,
                            bars: List.generate(
                                viewModel.isPlaying == false
                                    ? 1
                                    : viewModel.value.length,
                                (index) => renderWave(viewModel.value[index]))),
                        const Spacer(),
                      ],
                    );
                  }),
            ],
          ),
        ],
      ),
    );
  }

  AudioWaveBar renderWave(height) {
    return AudioWaveBar(heightFactor: height, color: waveColor);
  }

  @override
  IncomingCallViewModel viewModelBuilder(BuildContext context) =>
      IncomingCallViewModel()..playRecording(request.data);
}
