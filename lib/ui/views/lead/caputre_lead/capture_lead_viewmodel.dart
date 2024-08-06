import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:dio/dio.dart';
import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
import 'package:record/record.dart';
import 'package:sales_lead/services/index.dart';
import 'dart:developer';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../../../../app/app.bottomsheets.dart';
import '/enum/snackbar_type.dart';
import '../../../../app/app.locator.dart';
import '../../../../model/index.dart';
import 'capture_lead_view.form.dart';

class CaptureLeadViewModel extends FormViewModel implements FormStateHelper {
  final _bottomSheetService = locator<BottomSheetService>();
  final NavigationService _navigationService = locator<NavigationService>();

  //Record Audio Wave values
  var value = [
    0.3,
    0.5,
    0.7,
    0.5,
    0.3,
    0.5,
    0.7,
    0.9,
    0.7,
    0.5,
    0.3,
    0.7,
    0.9,
    1.0,
    0.9,
    0.7,
    0.5,
    0.3,
    0.5,
    0.7,
    0.5,
  ];

  //Change Unit Type
  int unitTypeindex = -1;
  int unitTypeId = 0;
  void changeUnitType(index) {
    unitTypeId = unitTypeList[index]['unit_type_id'];
    unitTypeindex = index;
    notifyListeners();
  }

  //Change floor
  SfRangeValues floorRange = const SfRangeValues(8.0, 12.0);
  void changeflorr(value) {
    floorRange = value;
    notifyListeners();
  }

  //Convert Speech To Text
  SpeechToText speechToText = SpeechToText();
  String speech = '';
  bool isListening = false;
  void startSpeechToText() async {
    isListening = true;
    var connected = await speechToText.initialize(
        onError: (error) {
          log('$error');
        },
        onStatus: (statusListener) {
          log(statusListener);
        },
        debugLogging: true,
        options: [SpeechToText.androidIntentLookup]);
    if (connected) {
      speechToText.listen(onResult: (result) {
        isListening = !result.finalResult;
        speech = result.recognizedWords;
        remarkValue = speech;
        if (!isListening) {
          stopSpeechToText();
        }
      });
    }
    notifyListeners();
  }

  void stopSpeechToText() {
    isListening = false;
    speechToText.stop();
    notifyListeners();
  }

  //Record audio, puase, resume and stop
  Record audioRecord = Record();
  AudioPlayer audioPlayer = AudioPlayer();
  bool isStartRecording = false;
  bool isRecording = false;
  bool isPause = false;
  String? audioPath;

  Future<void> startRecording() async {
    try {
      if (await audioRecord.hasPermission() && !isRecording) {
        audioRecord.start();
        startTimer();
        isRecording = true;
        isStartRecording = true;
      }
    } catch (erro) {
      log('Start Speech Error$error');
    }
    notifyListeners();
  }

  Future<void> stopRecording() async {
    try {
      audioPath = await audioRecord.stop();
      // convertM4AToMP3(audioPath!);
      resetTimer();
      isRecording = false;
      isStartRecording = false;
    } catch (erro) {
      log('Stop Speech Error$error');
    }
    notifyListeners();
  }

  Future<void> pauseRecording() async {
    try {
      await audioRecord.pause();
      stopTimer();
      isPause = true;
    } catch (erro) {
      log('Pause Recording Error$error');
    }
    notifyListeners();
  }

  Future<void> resumeRecording() async {
    try {
      await audioRecord.resume();
      startTimer();
      isPause = false;
    } catch (erro) {
      log('Resume Recording Error$error');
    }
    notifyListeners();
  }

//Play Audio Recording
  bool isPlaying = false;
  Future<void> playRecording() async {
    try {
      if (isPlaying) {
        audioPlayer.stop();
        isPlaying = false;
      } else {
        Source urlSource = UrlSource(audioPath!);
        await audioPlayer.play(urlSource);
        isPlaying = true;
      }
    } catch (error) {
      log('Player Error $error');
    }
    notifyListeners();
  }

  stopPlaying() {
    audioPlayer.stop();
    isPlaying = false;
  }

  //Show audio record bottom sheet
  void showRecordAudioSheet() async {
    var res = await _bottomSheetService.showCustomSheet(
      variant: BottomSheetType.recordAudio,
    );
    if (res != null) {
      audioPath = res.data;
      notifyListeners();
    }
  }

  Timer? timer;
  int secondsElapsed = 0;
  bool isRunning = false;

  void startTimer() {
    if (timer == null || !timer!.isActive) {
      timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        secondsElapsed++;
        notifyListeners();
      });
      isRunning = true;
    }
    notifyListeners();
  }

  void stopTimer() {
    if (timer != null && timer!.isActive) {
      timer!.cancel();
      isRunning = false;
    }
    notifyListeners();
  }

  void resetTimer() {
    stopTimer();
    secondsElapsed = 0;
    notifyListeners();
  }

  //Format Record Time
  String get timerText {
    int hours = (secondsElapsed / 3600).floor();
    int minutes = ((secondsElapsed % 3600) / 60).floor();
    int seconds = secondsElapsed % 60;
    return "${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
  }

  //Go back
  void goBack() {
    _navigationService.back();
  }

  //Change Project
  double minFloor = 0;
  double maxFloor = 32;
  OptionItem entityOption = OptionItem(title: "");
  onEntityChange(index) {
    getUnitTypesByProjectId(
        projectData['project_list'][index]['project_id'].toString());
    minFloor =
        double.parse('${projectData['project_list'][index]['min_floor']}');
    maxFloor =
        double.parse('${projectData['project_list'][index]['max_floor']}');
    floorRange = SfRangeValues(minFloor, maxFloor);
    entityOption = projectList[index];
    if (minFloor == maxFloor) {
      maxFloor += 0.001;
    }
    notifyListeners();
  }

  //Initial Function
  CaptureLeadViewModel() {
    getActiveProjects();
  }

  void resetData() {
    nameValue = '';
    mobileValue = '';
    remarkValue = '';
    emailIdValue = '';
    minFloor = 0;
    maxFloor = 32;
    entityOption = OptionItem(title: "");
    unitTypeList.clear();
    floorRange = const SfRangeValues(8.0, 12.0);
    notifyListeners();
  }

  String mp3FilePath = '';
  Future<void> convertM4AToMP3(String m4aFilePath) async {
    int lastSlashIndex = m4aFilePath.lastIndexOf('/');
    if (lastSlashIndex != -1) {
      mp3FilePath = '${m4aFilePath.substring(0, lastSlashIndex + 1)}output.mp3';
      try {
        // Convert m4a to MP3
        await FFmpegKit.executeWithArguments(['-i', m4aFilePath, mp3FilePath]);
      } catch (e) {
        log('M4A to MP3 conversion failed: $e');
      }
    }
    notifyListeners();
  }

  ////////////////////////////////////////////////////////////Api's Work/////////////////////////////////////////////////////////
  final LeadService _leadService = locator<LeadService>();
  final _snackBarService = locator<SnackbarService>();

  String projectId = '';
  Map projectData = {};
  List<OptionItem> projectList = [];
  void getActiveProjects() async {
    // setBusy(true);
    try {
      var res = await _leadService.getActiveProjects();
      projectData = res.data['data'];
      for (var i = 0; i < projectData['project_list'].length; i++) {
        projectList.add(
            OptionItem(title: projectData['project_list'][i]['project_name']));
      }
      notifyListeners();
    } on Error catch (e) {
      log('getActiveProjects error = $e');
    } finally {
      setBusy(false);
    }
  }

  List unitTypeList = [];
  void getUnitTypesByProjectId(String id) async {
    projectId = id;
    try {
      var res = await _leadService.getUnitTypesByProjectId(id);
      unitTypeList = res.data['data']['unit_types'];
      notifyListeners();
    } on Error catch (e) {
      log('getUnitTypesByProjectId error = $e');
    }
  }

  void createLead() async {
    if (audioPath != null) {
      await convertM4AToMP3(audioPath!);
    }
    FormData formData = FormData.fromMap({
      'lead_name': nameValue,
      'mobile_number': mobileValue,
      'email_address': emailIdValue,
      'project_id': projectId,
      'unit_type_id': unitTypeId,
      'floor_preference_min': int.parse(floorRange.start.toString()[0]),
      'floor_preference_max': int.parse(floorRange.end.toString()[0]),
      'remarks': remarkValue,
      'call_detail_id': null,
      'remarks_audio_file': mp3FilePath == ''
          ? null
          : await MultipartFile.fromFile(audioPath!,
              filename: mp3FilePath.split('/').last)
    });
    if (!hasMobileValidationMessage &&
        !hasNameValidationMessage &&
        unitTypeindex != -1 &&
        entityOption.title != '') {
      try {
        var res = await _leadService.createLead(formData);
        if (res.data['code'] == 200) {
          _snackBarService.showCustomSnackBar(
              variant: SnackbarType.success,
              message: res.data['message'].toString(),
              duration: const Duration(seconds: 2));
          goBack();
        }
      } on Error catch (e) {
        log('createLead error = $e');
      }
    }
  }
}
