import 'package:flutter/material.dart';


const String kApiKey = "216aaf070eb2da400b07aa8e6c8e3f7b";

const String kurl = "https://api.openweathermap.org/data/2.5/weather";

const kTextFieldInputDecoration = InputDecoration(
  icon: Icon(
    Icons.location_city,
    color: Colors.white,
  ),
  filled: true,
  fillColor: Colors.white,
  hintText: "Enter city name",
  hintStyle: TextStyle(
    color: Colors.grey,
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
    borderSide: BorderSide.none,
  ),
);
