import 'package:agricultural_insurance_system/screens/recording_screen.dart';
import 'package:flutter/material.dart';

import '../configs/palette.dart';

class ButtonCard extends StatelessWidget {
  final String iconLink;
  final String label;
  final VoidCallback onTap;
  const ButtonCard({
    Key? key,
    required this.iconLink,
    required this.label, required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: SizedBox(
        child: Card(
          elevation: 20.0,
          shadowColor: Palette.kdropShadowColor.withOpacity(0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image(image: AssetImage(iconLink)),
                SizedBox(
                  height: 10,
                ), // Adjust size as needed
                Text('$label',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12)),
              ],
            ),
          ),
        ),
      ),
      onTap: onTap,
    );
  }
}
