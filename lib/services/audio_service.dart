import 'dart:convert';
import 'package:http/http.dart' as http;

import '../constants/url_links.dart';
import '../models/application_data.dart';

Future<ApplicationData?> uploadAudio() async {
  var request = http.MultipartRequest(
    'POST',
    Uri.parse(recordLink),
  );
  var response = await request.send();
  if (response.statusCode == 200) {
    print('Audio uploaded and processed successfully.');
    final value = await response.stream.transform(utf8.decoder).join();
    Map<String, dynamic> data = jsonDecode(value);
    ApplicationData applicationData =
        ApplicationData.fromJson(data['application_data']);
    return applicationData;
  } else {
    print('Audio uploading failed.');
    return null;
  }
}
