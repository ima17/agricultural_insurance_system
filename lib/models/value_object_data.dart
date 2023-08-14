import 'package:flutter/material.dart';

class ValueObject {
  final String title;
  final String value;
  final IconData? icon;

  ValueObject({
    required this.title,
    required this.value,
    this.icon,
  });

  factory ValueObject.fromJson(Map<String, dynamic> json) {
    return ValueObject(
      title: json['title'],
      value: json['value'],
      icon: IconData(json['icon'], fontFamily: 'FontAwesomeSolid'),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'value': value,
      'icon': icon!.codePoint,
    };
  }
}
