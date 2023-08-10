import 'package:flutter/material.dart';

import '../configs/palette.dart';
import '../constants/theme_constants.dart';

class PremiumCard extends StatelessWidget {
  final String title;
  final String content;
  final IconData icon;
  const PremiumCard(
      {super.key,
      required this.title,
      required this.content,
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
          child: Row(
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
              Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 24,
                      color: Palette.kHeadingColor,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    width: 100,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(ThemeConstants.borderRadius),
                      color: Palette.kPrimaryColor,
                    ),
                    child: Center(
                      child: Text(
                        content,
                        style: TextStyle(
                          fontSize: 12,
                          color: Palette.kLightWhiteColor,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
