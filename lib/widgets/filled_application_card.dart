import 'package:agricultural_insurance_system/screens/view_application_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../configs/palette.dart';
import '../constants/theme_constants.dart';
import '../models/value_object_data.dart';

class FilledApplicationCard extends StatelessWidget {
  final ValueObject valueObject;

  const FilledApplicationCard({
    required this.valueObject,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        elevation: 20.0,
        shadowColor: Palette.kDropShadowColor.withOpacity(0.3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ThemeConstants.borderRadius),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                        valueObject.title,
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
                    "Customer : ${valueObject.value}",
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
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => ViewApplicationScreen(
              policyNo: valueObject.title,
              valueObject: valueObject.originalObject,
            ),
          ),
        );
      },
    );
  }
}
