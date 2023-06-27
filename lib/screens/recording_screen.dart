import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:agricultural_insurance_system/constants/url_links.dart';
import 'package:agricultural_insurance_system/models/application_data.dart';
import 'package:agricultural_insurance_system/screens/application_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class RecordingScreen extends StatefulWidget {
  const RecordingScreen({Key? key}) : super(key: key);

  @override
  State<RecordingScreen> createState() => _RecordingScreenState();
}

class _RecordingScreenState extends State<RecordingScreen> {
  FlutterSoundRecorder? _recorder = FlutterSoundRecorder();
  FlutterSoundPlayer? _player = FlutterSoundPlayer();

  bool _isRecording = false;
  String? _path;
  Stopwatch _stopwatch = Stopwatch();
  final _stopwatchTimer =
      Stream<int>.periodic(const Duration(seconds: 1), (x) => x);

  @override
  void initState() {
    super.initState();
    _recorder!.openRecorder().then((value) {
      _player!.openPlayer().then((value) {
        setState(() {});
      });
    });
  }

  @override
  void dispose() {
    _recorder!.closeRecorder();
    _recorder = null;
    _player!.closePlayer();
    _player = null;
    super.dispose();
  }

  Future<void> _startRecording() async {
    Directory tempDir = await getTemporaryDirectory();
    _path = '${tempDir.path}/flutter_sound_example.wav';

    await _recorder!.startRecorder(
      toFile: _path,
      codec: Codec.pcm16WAV,
    );
    _stopwatch.start();
    setState(() {
      _isRecording = true;
    });
  }

  Future<void> _stopRecording() async {
    await _recorder!.stopRecorder();
    _stopwatch.stop();
    setState(() {
      _isRecording = false;
    });
  }

  Future<void> _play() async {
    await _player!.startPlayer(fromURI: _path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Record the Voice'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            StreamBuilder<int>(
              stream: _stopwatchTimer,
              builder: (context, snapshot) {
                final elapsedTime = _stopwatch.elapsed;
                return Text(
                  '${elapsedTime.inMinutes}:${(elapsedTime.inSeconds % 60).toString().padLeft(2, '0')}',
                  style: const TextStyle(fontSize: 30),
                );
              },
            ),
            const SizedBox(height: 20),
            _isRecording
                ? FloatingActionButton(
                    heroTag: "btn1",
                    onPressed: _stopRecording,
                    child: const Icon(Icons.stop),
                  )
                : FloatingActionButton(
                    heroTag: "btn2",
                    onPressed: _startRecording,
                    child: const Icon(Icons.mic),
                  ),
            const SizedBox(height: 20),
            FloatingActionButton(
              heroTag: "btn3",
              onPressed: _play,
              child: const Icon(Icons.play_arrow),
            ),
            const SizedBox(height: 60),
            ElevatedButton(
              onPressed: () async {
                if (_path != null) {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return const Dialog(
                        child: Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CircularProgressIndicator(),
                              SizedBox(height: 16),
                              Text(
                                'Filling the application',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );

                  File file = File(_path!);
                  var request = http.MultipartRequest(
                    'POST',
                    Uri.parse(recordLink),
                  );
                  request.files.add(http.MultipartFile(
                    'file',
                    file.readAsBytes().asStream(),
                    file.lengthSync(),
                    filename: file.path.split("/").last,
                  ));
                  var response = await request.send();
                  if (response.statusCode == 200) {
                    print('Audio uploaded and processed successfully.');
                    response.stream.transform(utf8.decoder).listen((value) {
                      Map<String, dynamic> data = jsonDecode(value);
                      ApplicationData applicationData =
                          ApplicationData.fromJson(data['application_data']);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ApplicationScreen(
                            applicationData: applicationData,
                          ),
                        ),
                      );
                    });
                  } else {
                    print('Audio uploading failed.');
                  }

                  Navigator.pop(context); // Close the loading dialog.
                }
              },
              child: const Text(
                'Save and Next',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}