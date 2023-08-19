import 'dart:convert';
import 'package:http/http.dart' as http;

import '../constants/url_links.dart';
import '../models/district_data.dart';
import '../models/flood_risk_data.dart';
import '../models/whether_risk_data.dart';

class RiskCalculateService {
  DistrictData? districtData;
  FloodRiskData? floodRiskData;
  WeatherRiskData? weatherRiskData;
  
  Future<void> getData(
      double latitude, double longitude, String occupation) async {
    final headers = {'Content-Type': 'application/json'};
    final requestBody1 = {
      'lat': latitude,
      'lon': longitude,
    };
    final requestBody2 = {
      'lat': latitude,
      'lon': longitude,
      'season': occupation,
    };

    try {
      final response1 = await http.post(Uri.parse(admBoundryLink),
          headers: headers, body: jsonEncode(requestBody1));

      if (response1.statusCode == 200) {
        // Request 1 successful, handle the response here
        print('API 1 response: ${response1.body}');
        districtData = DistrictData.fromJson(jsonDecode(response1.body));

        final response2 = await http.post(Uri.parse(floodRiskLink),
            headers: headers, body: jsonEncode(requestBody2));

        if (response2.statusCode == 200) {
          // Request 2 successful, handle the response here
          print('API 2 response: ${response2.body}');
          floodRiskData = FloodRiskData.fromJson(jsonDecode(response2.body));

          // Extract the necessary value from response 1 and assign it to request body 3
          final valueFromResponse1 = districtData?.district;
          final requestBody3 = {
            'location': valueFromResponse1,
            'year': 2011,
            'season': occupation
          };

          final response3 = await http.post(Uri.parse(weatherRiskLink),
              headers: headers, body: jsonEncode(requestBody3));

          if (response3.statusCode == 200) {
            // Request 3 successful, handle the response here
            print('API 3 response: ${response3.body}');
            weatherRiskData =
                WeatherRiskData.fromJson(jsonDecode(response3.body));
          } else {
            // Request 3 failed, handle the error
            print(
                'API request 3 failed with status code ${response3.statusCode}');
          }
        } else {
          // Request 2 failed, handle the error
          print(
              'API request 2 failed with status code ${response2.statusCode}');
        }
      } else {
        print('API request 1 failed with status code ${response1.statusCode}');
      }
    } catch (error) {
      print('Error making API request: $error');
    }
  }
}
