import 'package:agricultural_insurance_system/models/application_data.dart';
import 'package:agricultural_insurance_system/models/district_data.dart';
import 'package:agricultural_insurance_system/models/flood_risk_data.dart';
import 'package:agricultural_insurance_system/models/prediction_data.dart';
import 'package:agricultural_insurance_system/models/whether_risk_data.dart';
import 'package:agricultural_insurance_system/screens/result_screen.dart';
import 'package:agricultural_insurance_system/widgets/premium_card.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../services/prediction_service.dart';
import '../widgets/button_widget.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/loading_widget.dart';

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
    final data = await PredictionServices.fetchData(
        widget.districtData!,
        widget.applicationData!,
        widget.floodRiskData!,
        widget.weatherRiskData!);
    setState(() {
      predictionData = data;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return !isLoading
        ? Scaffold(
            appBar: CustomAppBar(elevation: 0, title: 'Predicted Preemium'),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  PremiumCard(
                      title: "Premium Rate",
                      content: double.parse(predictionData!.premiumRate)
                              .toStringAsFixed(2) +
                          ' %',
                      icon: FontAwesomeIcons.percent),
                  SizedBox(
                    height: 10,
                  ),
                  PremiumCard(
                      title: "Given Sum Assured",
                      content: 'Rs.' +
                          double.parse(predictionData!.givenSumAssured)
                              .toStringAsFixed(0),
                      icon: FontAwesomeIcons.sackDollar),
                  SizedBox(
                    height: 10,
                  ),
                  PremiumCard(
                      title: "Monthly Premium",
                      content: 'Rs.' +
                          double.parse(predictionData!.monthlyPremium)
                              .toStringAsFixed(0),
                      icon: FontAwesomeIcons.coins),
                  Spacer(),
                  ButtonWidget(
                    buttonText: 'Save and Next',
                    buttonTriggerFunction: () {
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
                  ),
                ],
              ),
            ),
          )
        : LoadingWidget(
            text: "Predicting the Premium",
          );
  }
}
