import 'package:flutter/material.dart';

import '../configs/palette.dart';
import '../constants/theme_constants.dart';

class InfoCard extends StatelessWidget {
  final IconData icon;
  final String infoTitle;
  final String info;
  const InfoCard(
      {super.key,
      required this.icon,
      required this.infoTitle,
      required this.info});

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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    infoTitle,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Palette.kHeadingColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    info,
                    style: TextStyle(
                      fontSize: 12,
                      color: Palette.kPrimaryColor,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
              Spacer(),
              Icon(
                icon,
                size: 15,
                color: Palette.kPrimaryColor,
              ),
            ],
          ),
        ));
  }
}
