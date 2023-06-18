class FloodRiskData {
  final String floodRisk;
  
  FloodRiskData({required this.floodRisk});

  factory FloodRiskData.fromJson(Map<String, dynamic> json) {
    return FloodRiskData(floodRisk: json['flood_risk'] ?? '');
  }
}

