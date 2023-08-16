import 'package:agricultural_insurance_system/screens/filled_application_screen.dart';
import 'package:agricultural_insurance_system/screens/recording_screen.dart';
import 'package:agricultural_insurance_system/widgets/button_card.dart';
import 'package:agricultural_insurance_system/widgets/home_screen_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../services/weather_data_service.dart';
import '../widgets/top_container.dart';

class HomeScreen extends StatefulWidget {
  final weatherData;
  const HomeScreen({Key? key, required this.weatherData}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late String datetime;
  int? tempreture;
  String? cityName;
  String? weatherIcon;
  String? name;
  WeatherModel weather = WeatherModel();
  final _auth = FirebaseAuth.instance;

  late User loggedInUser;

  @override
  void initState() {
    super.initState();
    getDateTime();
    updateUIData(widget.weatherData);
    getCurrentUser();
  }

  void getDateTime() {
    datetime = DateFormat("EEEEE, dd, yyyy").format(DateTime.now());
  }

  void updateUIData(dynamic weatherData) {
    if (weatherData == null) {
      tempreture = 0;
      cityName = "";
      weatherIcon = "";
      return;
    }
    setState(() {
      double temp = weatherData['main']['temp'];
      tempreture = temp.toInt();
      cityName = weatherData['name'];
      var condition = weatherData['weather'][0]['id'];
      weatherIcon = weather.getWeatherIcon(condition);
    });
  }

  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        setState(() {
          name = user.displayName;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          TopContainer(
            name: name ?? "User",
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 160),
                HomeScreenCard(
                  location: cityName,
                  date: datetime,
                  icon: weatherIcon,
                  temperature: tempreture,
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: ButtonCard(
                        iconLink: "assets/icons/fill.png",
                        label: 'Fill a New Application',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  RecordingScreen(),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(width: 20), // Add space between the two cards
                    Expanded(
                      child: ButtonCard(
                        iconLink: "assets/icons/filled.png",
                        label: 'Show Filled Applications',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  FilledApplicationScreen(),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
