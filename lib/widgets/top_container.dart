import 'package:agricultural_insurance_system/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../configs/palette.dart';

class TopContainer extends StatelessWidget {
  final String? name;
  const TopContainer({
    Key? key,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String currentTime = DateFormat("HH:mm:ss").format(DateTime.now());
    String greeting = getGreeting(currentTime);

    return Container(
      height: 250,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Palette.kPrimaryColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20.0),
          bottomRight: Radius.circular(20.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          top: 50,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      greeting,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      name ?? "",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                      'https://cdn.pixabay.com/photo/2022/09/08/15/16/cute-7441224_1280.jpg',
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => ProfileScreen(
                          name: name ?? "",
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String getGreeting(String currentTime) {
    int hour = int.parse(currentTime.split(':')[0]);

    if (hour < 12) {
      return 'Good morning';
    } else if (hour < 18) {
      return 'Good afternoon';
    } else {
      return 'Good evening';
    }
  }
}
