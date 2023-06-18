class ApplicationData {
  final String name;
  final String address;
  final String contactNumber;
  final String dateOfBirth;
  final String gender;
  final String occupation;
  final String age;
  final String propertySize;

  ApplicationData({
    required this.name,
    required this.address,
    required this.contactNumber,
    required this.dateOfBirth,
    required this.gender,
    required this.occupation,
    required this.age,
    required this.propertySize,
  });

  factory ApplicationData.fromJson(Map<String, dynamic> json) {
    return ApplicationData(
      name: json['නම'] ?? '',
      address: json['ලිපිනය'] ?? '',
      contactNumber: json['හැඳුනුම්පත් අංකය'] ?? '',
      dateOfBirth: json['උපන්දිනය'] ?? '',
      gender: json['වී වර්ගය'] ?? '',
      occupation: json['කන්නය'] ?? '',
      age: json['වගා ක්‍රමය'] ?? '',
      propertySize: json['ඉඩමේ ප්‍රමාණය'] ?? '',
    );
  }
}
