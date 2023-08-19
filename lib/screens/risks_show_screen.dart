import 'package:agricultural_insurance_system/widgets/custom_app_bar.dart';
import 'package:agricultural_insurance_system/widgets/loading_widget.dart';
import 'package:agricultural_insurance_system/widgets/location_card.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:agricultural_insurance_system/models/application_data.dart';
import 'package:agricultural_insurance_system/models/district_data.dart';
import 'package:agricultural_insurance_system/models/flood_risk_data.dart';
import 'package:agricultural_insurance_system/models/whether_risk_data.dart';
import 'package:agricultural_insurance_system/screens/prediction_screen.dart';
import 'package:agricultural_insurance_system/widgets/risk_card.dart';
import 'package:agricultural_insurance_system/services/risk_calculate_service.dart';

import '../configs/palette.dart';
import '../widgets/button_widget.dart';

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
  RiskCalculateService riskCalculateService = RiskCalculateService();
  DistrictData? districtData;
  FloodRiskData? floodRiskData;
  WeatherRiskData? weatherRiskData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    riskCalculateService
        .getData(
      widget.currentPosition.latitude,
      widget.currentPosition.longitude,
      widget.applicationData!.occupation,
    )
        .then((_) {
      setState(() {
        isLoading = false;
        districtData = riskCalculateService.districtData;
        floodRiskData = riskCalculateService.floodRiskData;
        weatherRiskData = riskCalculateService.weatherRiskData;
      });
    });
  }

  get floodRisk => floodRiskData?.floodRisk;
  get weatherRisk => weatherRiskData?.weatherRisk;

  @override
  Widget build(BuildContext context) {
    return !isLoading
        ? Scaffold(
            appBar: CustomAppBar(elevation: 0, title: 'Risk Details'),
            body: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ListView(
                      children: [
                        Text(
                          'Location Details',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: LocationCard(
                                title: 'District',
                                subTitle: districtData!.district,
                                icon: FontAwesomeIcons.mapLocationDot,
                              ),
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: LocationCard(
                                title: 'GND',
                                subTitle: districtData!.gnd,
                                icon: FontAwesomeIcons.locationDot,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 18),
                        Divider(
                          color: Palette.kPrimaryColor,
                        ),
                        SizedBox(height: 18),
                        Text(
                          'Risks Details',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 16),
                        RiskCard(
                          title: "Flood Risk",
                          icon: FontAwesomeIcons.houseFloodWater,
                          riskLevel: 'High',
                        ),
                        SizedBox(height: 10),
                        RiskCard(
                          title: "Weather Risk",
                          icon: FontAwesomeIcons.cloudShowersWater,
                          riskLevel: 'No',
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    child: ButtonWidget(
                      buttonText: 'Save and Next',
                      buttonTriggerFunction: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PredictionScreen(
                              applicationData: widget.applicationData,
                              districtData: districtData,
                              weatherRiskData: weatherRiskData,
                              floodRiskData: floodRiskData,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          )
        : LoadingWidget(
            text: "Calculating Risks",
          );
  }
}
