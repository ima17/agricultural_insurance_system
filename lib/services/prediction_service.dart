import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:agricultural_insurance_system/constants/url_links.dart';
import 'package:agricultural_insurance_system/models/application_data.dart';
import 'package:agricultural_insurance_system/models/district_data.dart';
import 'package:agricultural_insurance_system/models/flood_risk_data.dart';
import 'package:agricultural_insurance_system/models/prediction_data.dart';
import 'package:agricultural_insurance_system/models/whether_risk_data.dart';

class PredictionServices {
  static Future<PredictionData?> fetchData(
      DistrictData districtData,
      ApplicationData applicationData,
      FloodRiskData floodRiskData,
      WeatherRiskData weatherRiskData) async {
    const url = premiumLink;

    final requestBody = {
      'gnd': districtData.gnd,
      'district': districtData.district,
      'method': applicationData.age,
      'season': applicationData.occupation,
      'paddy_type': 3,
      'flood_risk': floodRiskData.floodRisk,
      'weather_risk': weatherRiskData.weatherRisk,
      'land_size': 1.5,
    };

    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return PredictionData.fromJson(jsonResponse);
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return null;
    }
  }
}
