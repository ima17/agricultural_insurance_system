import 'package:flutter/material.dart';

import '../configs/palette.dart';
import '../constants/theme_constants.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class RiskCard extends StatelessWidget {
  final String title;
  final String riskLevel;
  final IconData icon;
  const RiskCard(
      {Key? key,
      required this.title,
      required this.icon,
      required this.riskLevel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color progressColor;
    double progressValue;

    switch (riskLevel) {
      case 'No':
        progressColor = Colors.green;
        progressValue = 0;
        break;
      case 'Moderate':
        progressColor = Color.fromARGB(255, 212, 171, 36);
        progressValue = 70;
        break;
      case 'High':
        progressColor = Colors.red;
        progressValue = 150;
        break;
      default:
        progressColor = Colors.transparent;
        progressValue = 0.0;
    }

    return Card(
      elevation: 20.0,
      shadowColor: Palette.kDropShadowColor.withOpacity(0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ThemeConstants.borderRadius),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Material(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 10.0),
                  child: Icon(
                    icon,
                    size: 30,
                    color: Palette.kLightWhiteColor,
                  ),
                ),
                color: Colors.transparent,
              ),
              decoration: BoxDecoration(
                color: Palette.kPrimaryColor,
                borderRadius:
                    BorderRadius.circular(ThemeConstants.borderRadius / 1.5),
              ),
            ),
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 24,
                    color: Palette.kHeadingColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  riskLevel,
                  style: TextStyle(
                    fontSize: 16,
                    color: progressColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Container(
              height: 75,
              width: 75,
              child: SfRadialGauge(
                axes: <RadialAxis>[
                  RadialAxis(
                    showLabels: false,
                    showTicks: false,
                    minimum: 0,
                    maximum: 150,
                    ranges: <GaugeRange>[
                      GaugeRange(
                          startValue: 0, endValue: 50, color: Colors.green),
                      GaugeRange(
                          startValue: 50, endValue: 100, color: Colors.orange),
                      GaugeRange(
                          startValue: 100, endValue: 150, color: Colors.red),
                    ],
                    pointers: <GaugePointer>[
                      NeedlePointer(
                          enableAnimation: true,
                          animationDuration: 1000,
                          needleEndWidth: 6,
                          needleStartWidth: 1,
                          value: progressValue),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
