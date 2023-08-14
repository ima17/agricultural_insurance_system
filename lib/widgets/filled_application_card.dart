import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../configs/palette.dart';
import '../constants/theme_constants.dart';

class FilledApplicationCard extends StatelessWidget {
  final String policyNumber;
  final String name;

  const FilledApplicationCard({
    required this.policyNumber,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 20.0,
        shadowColor: Palette.kDropShadowColor.withOpacity(0.3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ThemeConstants.borderRadius),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 80,
                    height: 25,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          ThemeConstants.borderRadius / 2),
                      color: Palette.kPrimaryColor,
                    ),
                    child: Center(
                      child: Text(
                        policyNumber,
                        style: TextStyle(
                          fontSize: 12,
                          color: Palette.kLightWhiteColor,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Customer : $name",
                    style: const TextStyle(
                      fontSize: 12,
                      color: Palette.kHeadingColor,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
              Spacer(),
              Icon(
                FontAwesomeIcons.circleCheck,
                size: 15,
                color: Palette.kPrimaryColor,
              ),
            ],
          ),
        ));
  }
}
