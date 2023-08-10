import 'package:flutter/material.dart';

import '../configs/palette.dart';
import '../constants/theme_constants.dart';

class LocationCard extends StatelessWidget {
  final String title;
  final String subTitle;
  final IconData icon;
  const LocationCard(
      {super.key,
      required this.title,
      required this.subTitle,
      required this.icon});

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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 20.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Palette.kPrimaryColor,
                ),
                child: Icon(
                  icon,
                  size: 30,
                  color: Palette.kLightWhiteColor,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 24,
                  color: Palette.kHeadingColor,
                  fontWeight: FontWeight.normal,
                ),
              ),
              Text(
                subTitle,
                style: TextStyle(
                  fontSize: 12,
                  color: Palette.kPrimaryColor,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ));
  }
}
