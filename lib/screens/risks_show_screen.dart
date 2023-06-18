import 'package:agricultural_insurance_system/models/application_data.dart';
import 'package:agricultural_insurance_system/models/district_data.dart';
import 'package:agricultural_insurance_system/models/flood_risk_data.dart';
import 'package:agricultural_insurance_system/models/whether_risk_data.dart';
import 'package:agricultural_insurance_system/screens/prediction_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class RiskShowScreen extends StatefulWidget {
  final ApplicationData? applicationData;
  final LatLng currentPosition;

  const RiskShowScreen({
    Key? key,
    this.applicationData,
    required this.currentPosition,
  }) : super(key: key);

  @override
  State<RiskShowScreen> createState() => _RiskShowScreenState();
}

class _RiskShowScreenState extends State<RiskShowScreen> {
  DistrictData? districtData;
  FloodRiskData? floodRiskData;
  WeatherRiskData? weatherRiskData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  Future<void> _getData() async {
    print(
        'Latitude: ${widget.currentPosition.latitude}, Longitude: ${widget.currentPosition.latitude}');

    const url1 = 'https://517f-34-85-162-247.ngrok.io/ADMBoundry';
    const url2 = 'https://517f-34-85-162-247.ngrok.io/flood_risk';
    const url3 = 'https://0701-35-221-231-137.ngrok.io/weather_risk';

    final headers = {'Content-Type': 'application/json'};
    final requestBody1 = {
      'lat': widget.currentPosition.latitude,
      'lon': widget.currentPosition.longitude,
    };
    final requestBody2 = {
      'lat': widget.currentPosition.latitude,
      'lon': widget.currentPosition.longitude,
      'season': widget.applicationData!.occupation,
    };

    try {
      final response1 = await http.post(Uri.parse(url1),
          headers: headers, body: jsonEncode(requestBody1));

      if (response1.statusCode == 200) {
        // Request 1 successful, handle the response here
        print('API 1 response: ${response1.body}');
        districtData = DistrictData.fromJson(jsonDecode(response1.body));

        final response2 = await http.post(Uri.parse(url2),
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
            'season': widget.applicationData!.occupation
          };

          final response3 = await http.post(Uri.parse(url3),
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
        // Request 1 failed, handle the error
        print('API request 1 failed with status code ${response1.statusCode}');
      }
    } catch (error) {
      // An error occurred while making the request
      print('Error making API request: $error');
    }

    setState(() {
      isLoading = false; // Set isLoading to false after receiving the data
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Risk Details'),
      ),
      body: Center(
        child: isLoading
            ? const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Calculating Risks'),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (districtData != null)
                    Text('District: ${districtData!.district}'),
                  if (districtData != null) Text('GND: ${districtData!.gnd}'),
                  SizedBox(height: 16),
                  if (floodRiskData != null)
                    Text('Flood Risk: ${floodRiskData!.floodRisk}'),
                  SizedBox(height: 16),
                  if (weatherRiskData != null)
                    Text('Weather Risk: ${weatherRiskData!.weatherRisk}'),
                ],
              ),
      ),
      floatingActionButton: ElevatedButton(
         
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PredictionScreen(
                      applicationData: widget.applicationData,
                      districtData: districtData,
                      weatherRiskData: weatherRiskData,
                      floodRiskData: floodRiskData,
                    )),
          );
        },
        child: const Text('Save and Next'),
        
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      
    );
  }
}
