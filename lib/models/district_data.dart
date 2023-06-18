class DistrictData {
  final String gnd;
  final String district;
  
  DistrictData({required this.gnd, required this.district});

  factory DistrictData.fromJson(Map<String, dynamic> json) {
    return DistrictData(
      gnd: json['GND'] ?? '',
      district: json['District'] ?? '',
    );
  }
}
