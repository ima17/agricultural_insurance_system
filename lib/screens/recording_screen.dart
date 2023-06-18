import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class RecordingScreen extends StatefulWidget {
  const RecordingScreen({super.key});

  @override
  State<RecordingScreen> createState() => _RecordingScreenState();
}

class _RecordingScreenState extends State<RecordingScreen> {
  FlutterSoundRecorder? _recorder = FlutterSoundRecorder();
  FlutterSoundPlayer? _player = FlutterSoundPlayer();

  bool _isRecording = false;
  String? _path;
  Stopwatch _stopwatch = Stopwatch();
  final _stopwatchTimer = Stream<int>.periodic(const Duration(seconds: 1), (x) => x);

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
        title: const Text('Audio Recorder'),
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
                    onPressed: _stopRecording,
                    child: const Icon(Icons.stop),
                  )
                : FloatingActionButton(
                    onPressed: _startRecording,
                    child: const Icon(Icons.mic),
                  ),
            const SizedBox(height: 20),
            FloatingActionButton(
              onPressed: _play,
              child: const Icon(Icons.play_arrow),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async{
                if (_path != null) {
      File file = File(_path!);
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('https://7d6b-34-125-177-37.ngrok.io/uploadert'),
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
        print(value);
        Map<String, dynamic> data = jsonDecode(value);
        print(data);
      });

      } else {
        print('Audio uploading failed.');
      }
    }
              },
              child: const Text('Save and Next'),
            ),
          ],
        ),
      ),
    );
  }
}




// import 'dart:io';
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter_sound/flutter_sound.dart';
// import 'package:http/http.dart' as http;
// import 'package:path_provider/path_provider.dart';


// class RecordingScreen extends StatefulWidget {
//   const RecordingScreen({super.key});

//   @override
//   State<RecordingScreen> createState() => _RecordingScreenState();
// }

// class _RecordingScreenState extends State<RecordingScreen> {
//   FlutterSoundRecorder? _recorder = FlutterSoundRecorder();
//   FlutterSoundPlayer? _player = FlutterSoundPlayer();

//   bool _isRecording = false;
//   String? _path;

//   @override
//   void initState() {
//     super.initState();
//     _recorder!.openAudioSession().then((value) {
//       _player!.openAudioSession().then((value) {
//         setState(() {});
//       });
//     });
//   }

//   @override
//   void dispose() {
//     _recorder!.closeAudioSession();
//     _recorder = null;
//     _player!.closeAudioSession();
//     _player = null;
//     super.dispose();
//   }

//   Future<void> _startRecording() async {
//     Directory tempDir = await getTemporaryDirectory();
//     _path = '${tempDir.path}/flutter_sound_example.wav';

//     await _recorder!.startRecorder(
//       toFile: _path,
//       codec: Codec.pcm16WAV,
//     );
//     setState(() {
//       _isRecording = true;
//     });
//   }

//   Future<void> _stopRecording() async {
//     await _recorder!.stopRecorder();
//     setState(() {
//       _isRecording = false;
//     });
//     if (_path != null) {
//       File file = File(_path!);
//       var request = http.MultipartRequest(
//         'POST',
//         Uri.parse('https://22ca-34-91-92-241.ngrok.io/uploadert'),
//       );
//       request.files.add(http.MultipartFile(
//         'file',
//         file.readAsBytes().asStream(),
//         file.lengthSync(),
//         filename: file.path.split("/").last,
//       ));
//       var response = await request.send();
//       if (response.statusCode == 200) {
//         print('Audio uploaded and processed successfully.');
//         response.stream.transform(utf8.decoder).listen((value) {
//         print(value);
//         Map<String, dynamic> data = jsonDecode(value);
//         print(data);
//       });

//       } else {
//         print('Audio uploading failed.');
//       }
//     }
//   }

//   Future<void> _play() async {
//     await _player!.startPlayer(fromURI: _path);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Audio Recorder'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             _isRecording
//                 ? FloatingActionButton(
//                     onPressed: _stopRecording,
//                     child: Icon(Icons.stop),
//                   )
//                 : FloatingActionButton(
//                     onPressed: _startRecording,
//                     child: Icon(Icons.mic),
//                   ),
//             SizedBox(height: 20),
//             FloatingActionButton(
//               onPressed: _play,
//               child: Icon(Icons.play_arrow),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
