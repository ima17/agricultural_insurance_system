import 'package:agricultural_insurance_system/widgets/home_screen_card.dart';
import 'package:flutter/material.dart';
import 'package:agricultural_insurance_system/services/location_service.dart';
import 'package:intl/intl.dart';

import '../services/weather_data_service.dart';

class HomeScreen extends StatefulWidget {
  final weatherData;
  final LocationData? locationData;
  const HomeScreen(
      {Key? key, required this.weatherData, required this.locationData})
      : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late String datetime;
  int? tempreture;
  String? cityName;
  String? weatherIcon;
  WeatherModel weather = WeatherModel();

  @override
  void initState() {
    super.initState();
    getDateTime();
    updateUIData(widget.weatherData);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            HomeScreenCard(
              location: cityName,
              date: datetime,
              icon: weatherIcon,
              temperature: tempreture,
            ),
          ],
        ),
      ),
    );
  }
}
