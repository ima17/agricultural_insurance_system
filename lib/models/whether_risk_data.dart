class WeatherRiskData {
  final String weatherRisk;
  
  WeatherRiskData({required this.weatherRisk});

  factory WeatherRiskData.fromJson(Map<String, dynamic> json) {
    return WeatherRiskData(weatherRisk: json['weather_risk'] ?? '');
  }
}
