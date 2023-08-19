import 'package:agricultural_insurance_system/services/location_service.dart';
import 'package:geolocator/geolocator.dart';

import '../constants/constants.dart';
import 'network_caller.dart';

class WeatherModel {
  // Future<dynamic> getCityWeather(String cityName) async {
  //   NetworkCaller networkCaller =
  //       NetworkCaller(url: "$kurl?q=$cityName&appid=$kApiKey&units=metric");
  //   var currentWeatherData = await networkCaller.fetchWeatherData();
  //   return currentWeatherData;
  // }

  Future<dynamic> getLocationWeather() async {
    Position? currentPosition;
    LocationService location = LocationService();
    currentPosition = await location.getCurrentPosition();

    NetworkCaller networkCaller = NetworkCaller(
        url:
            "$kurl?lat=${currentPosition.latitude}&lon=${currentPosition.longitude}&appid=$kApiKey&units=metric");

    var currentWeatherData = await networkCaller.fetchWeatherData();
    return currentWeatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }
}
