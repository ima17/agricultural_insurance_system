import 'package:agricultural_insurance_system/models/prediction_data.dart';
import 'package:flutter/material.dart';

import '../models/application_data.dart';
import '../models/district_data.dart';
import '../models/flood_risk_data.dart';
import '../models/whether_risk_data.dart';

class ResultScreen extends StatefulWidget {
  final PredictionData? predictionData;
  final ApplicationData? applicationData;
  final DistrictData? districtData;
  final WeatherRiskData? weatherRiskData;
  final FloodRiskData? floodRiskData;
  const ResultScreen(
      {super.key,
      required this.applicationData,
      required this.districtData,
      required this.weatherRiskData,
      required this.floodRiskData,
      required this.predictionData});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  void initState() {
    print(widget.applicationData!.name);
    print(widget.districtData!.district);
    print(widget.floodRiskData!.floodRisk);
    print(widget.weatherRiskData!.weatherRisk);
    print(widget.predictionData!.givenSumAssured);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
