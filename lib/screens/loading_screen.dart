import 'package:agricultural_insurance_system/configs/palette.dart';
import 'package:agricultural_insurance_system/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';

import '../services/location_service.dart';
import '../services/weather_data_service.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  LoadingScreenState createState() => LoadingScreenState();
}

class LoadingScreenState extends State<LoadingScreen> {
  var weatherData;
  WeatherModel weatherModel = WeatherModel();
  LocationService location = LocationService();
  Position? currentPosition;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    currentPosition = await location.getCurrentPosition();
    weatherData = await weatherModel.getLocationWeather();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => HomeScreen(
                weatherData: weatherData,
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Palette.kPrimaryColor,
          size: 100.0,
        ),
      ),
    );
  }
}
