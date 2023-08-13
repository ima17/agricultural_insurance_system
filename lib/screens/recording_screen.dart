import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../configs/palette.dart';
import '../models/application_data.dart';
import '../services/audio_service.dart';
import '../widgets/button_widget.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/loading_widget.dart';
import '../widgets/wave_animation_widget.dart';
import 'application_screen.dart';

class RecordingScreen extends StatefulWidget {
  const RecordingScreen({Key? key}) : super(key: key);

  @override
  State<RecordingScreen> createState() => _RecordingScreenState();
}

class _RecordingScreenState extends State<RecordingScreen> {
  bool isLoading = false;
  bool isRecorded = false;
  bool isRecording = false;
  Duration recordDuration = Duration.zero;
  late Timer timer;

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        recordDuration = recordDuration + Duration(seconds: 1);
      });
    });
  }

  void stopTimer() {
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    String formattedDuration =
        "${recordDuration.inMinutes.toString().padLeft(2, '0')}:${(recordDuration.inSeconds % 60).toString().padLeft(2, '0')}";

    return isLoading
        ? LoadingWidget(
            text: "Filling The Application",
          )
        : Scaffold(
            appBar: CustomAppBar(
              elevation: 0,
              title: "Record the Audio",
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isRecording = !isRecording;
                        if (isRecording) {
                          startTimer();
                        } else {
                          stopTimer();
                          isRecorded = true;
                        }
                      });
                    },
                    child: Container(
                      width: 250,
                      height: 250,
                      child: WaveAnimation(
                        size: 250,
                        color: Palette.kPrimaryColor,
                        centerChild: Icon(
                          FontAwesomeIcons.microphone,
                          color: Colors.white,
                          size: 50,
                        ),
                        isAnimating: isRecording,
                      ),
                    ),
                  ),
                  Text(
                    isRecording
                        ? "Recording..."
                        : isRecorded
                            ? "Tap to resume the recording"
                            : "Tap to start Recording",
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    formattedDuration,
                    style:
                        TextStyle(fontSize: 36, color: Palette.kPrimaryColor),
                  ),
                  Spacer(),
                  ButtonWidget(
                    isDisabled: !isRecorded || isRecording,
                    buttonText: "Fill Application",
                    buttonTriggerFunction: () async {
                      setState(() {
                        isLoading = true;
                      });
                      ApplicationData? applicationData = await uploadAudio();
                      if (applicationData != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ApplicationScreen(
                              applicationData: applicationData,
                            ),
                          ),
                        );
                      } else {
                        print("Something went wrong");
                      }
                      setState(() {
                        isLoading = false;
                      });
                    },
                  )
                ],
              ),
            ),
          );
  }
}
