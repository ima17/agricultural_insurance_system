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
            const SizedBox(height: 60),
            ElevatedButton(
              onPressed: () async {

                  var request = http.MultipartRequest(
                    'POST',
                    Uri.parse(recordLink),
                  );
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
