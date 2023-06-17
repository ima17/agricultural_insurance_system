import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FlutterSoundRecorder? _recorder = FlutterSoundRecorder();
  FlutterSoundPlayer? _player = FlutterSoundPlayer();

  bool _isRecording = false;
  String? _path;

  @override
  void initState() {
    super.initState();
    _recorder!.openAudioSession().then((value) {
      _player!.openAudioSession().then((value) {
        setState(() {});
      });
    });
  }

  @override
  void dispose() {
    _recorder!.closeAudioSession();
    _recorder = null;
    _player!.closeAudioSession();
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
    setState(() {
      _isRecording = true;
    });
  }

  Future<void> _stopRecording() async {
    await _recorder!.stopRecorder();
    setState(() {
      _isRecording = false;
    });
    if (_path != null) {
      File file = File(_path!);
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('https://22ca-34-91-92-241.ngrok.io/uploadert'),
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
        print(response);
      } else {
        print('Audio uploading failed.');
      }
    }
  }

  Future<void> _play() async {
    await _player!.startPlayer(fromURI: _path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Audio Recorder'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _isRecording
                ? FloatingActionButton(
                    onPressed: _stopRecording,
                    child: Icon(Icons.stop),
                  )
                : FloatingActionButton(
                    onPressed: _startRecording,
                    child: Icon(Icons.mic),
                  ),
            SizedBox(height: 20),
            FloatingActionButton(
              onPressed: _play,
              child: Icon(Icons.play_arrow),
            ),
          ],
        ),
      ),
    );
  }
}
