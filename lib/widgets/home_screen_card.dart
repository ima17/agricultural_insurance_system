import 'package:flutter/material.dart';

import '../configs/palette.dart';

class HomeScreenCard extends StatelessWidget {
  final String? location;
  final String? date;
  final int? temperature;
  final String? icon;

  const HomeScreenCard({
    Key? key,
    required this.location,
    required this.date,
    required this.temperature,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Card(
        elevation: 20.0,
        shadowColor: Palette.kdropShadowColor.withOpacity(0.3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 15.0,
                        ),
                        Text(location ?? ""),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Text(
                          date ?? "",
                          style: TextStyle(
                              fontSize: 12, color: Palette.kheadingColor),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '$temperature°C',
                          style: TextStyle(fontSize: 60),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Palette.kdropShadowColor.withOpacity(0.3),
                          blurRadius: 30.0,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Text(
                      icon ?? "",
                      style: TextStyle(fontSize: 100),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
