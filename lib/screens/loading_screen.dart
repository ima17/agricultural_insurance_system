import 'package:agricultural_insurance_system/configs/palette.dart';
import 'package:agricultural_insurance_system/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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
  LocationData? locationData;
  Location location = Location();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    locationData = await location.getCurrentPosition();
    weatherData = await weatherModel.getLocationWeather();

    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => HomeScreen(
                weatherData: weatherData,
                locationData: locationData,
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Palette.kprimaryColor,
          size: 100.0,
        ),
      ),
    );
  }
}
