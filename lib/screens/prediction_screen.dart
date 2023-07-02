import 'dart:convert';

import 'package:agricultural_insurance_system/constants/url_links.dart';
import 'package:agricultural_insurance_system/models/application_data.dart';
import 'package:agricultural_insurance_system/models/district_data.dart';
import 'package:agricultural_insurance_system/models/flood_risk_data.dart';
import 'package:agricultural_insurance_system/models/prediction_data.dart';
import 'package:agricultural_insurance_system/models/whether_risk_data.dart';
import 'package:agricultural_insurance_system/screens/result_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PredictionScreen extends StatefulWidget {
  final ApplicationData? applicationData;
  final DistrictData? districtData;
  final WeatherRiskData? weatherRiskData;
  final FloodRiskData? floodRiskData;

  const PredictionScreen({
    Key? key,
    required this.applicationData,
    required this.districtData,
    required this.weatherRiskData,
    required this.floodRiskData,
  }) : super(key: key);

  @override
  State<PredictionScreen> createState() => _PredictionScreenState();
}

class _PredictionScreenState extends State<PredictionScreen> {
  PredictionData? predictionData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    const url = premiumLink;

    final requestBody = {
      'gnd': widget.districtData!.gnd,
      'district': widget.districtData!.district,
      'method': widget.applicationData!.age,
      'season': widget.applicationData!.occupation,
      'paddy_type': 3,
      'flood_risk': widget.floodRiskData!.floodRisk,
      'weather_risk': widget.weatherRiskData!.weatherRisk,
      'land_size': 1.5,
    };

    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      setState(() {
        predictionData = PredictionData.fromJson(jsonResponse);
        isLoading = false;
      });
    } else {
      print('Request failed with status: ${response.statusCode}.');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Predicted Premium'),
      ),
body: Center(
  child: isLoading
      ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text(
              'Predicting the Premium',
              style: TextStyle(fontSize: 20),
            ),
          ],
        )
: DataTable(
  columns: const [
    DataColumn(
      label: Text(
        'Parameter',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    ),
    DataColumn(
      label: Text(
        'Value',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    ),
  ],
  rows: [
    if (predictionData != null) ...[
      DataRow(
        cells: [
          DataCell(
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Premium Rate',
                style: TextStyle(fontSize: 14),
              ),
            ),
          ),
          DataCell(
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                double.parse(predictionData!.premiumRate).toStringAsFixed(2)+' %',
                style: TextStyle(fontSize: 14),
              ),
            ),
          ),
        ],
      ),
      DataRow(
        cells: [
          DataCell(
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Given Sum Assured',
                style: TextStyle(fontSize: 14),
              ),
            ),
          ),
          DataCell(
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Rs.'+
                predictionData!.givenSumAssured,
                style: TextStyle(fontSize: 14),
              ),
            ),
          ),
        ],
      ),
      DataRow(
        cells: [
          DataCell(
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Monthly Premium',
                style: TextStyle(fontSize: 14),
              ),
            ),
          ),
          DataCell(
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Rs.'+
                double.parse(predictionData!.monthlyPremium).toStringAsFixed(2),
                style: TextStyle(fontSize: 14),
              ),
            ),
          ),
        ],
      ),
    ],
  ],
),

),

      floatingActionButton: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ResultScreen(
                applicationData: widget.applicationData,
                districtData: widget.districtData,
                weatherRiskData: widget.weatherRiskData,
                floodRiskData: widget.floodRiskData,
                predictionData: predictionData,
              ),
            ),
          );
        },
        child: const Text(
          'Show Results',
          style: TextStyle(fontSize: 18),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}


