import 'package:agricultural_insurance_system/configs/palette.dart';
import 'package:agricultural_insurance_system/screens/filled_application_screen.dart';
import 'package:agricultural_insurance_system/screens/login_screen.dart';
import 'package:agricultural_insurance_system/screens/recording_screen.dart';
import 'package:agricultural_insurance_system/widgets/button_card.dart';
import 'package:agricultural_insurance_system/widgets/button_widget.dart';
import 'package:agricultural_insurance_system/widgets/home_screen_card.dart';
import 'package:agricultural_insurance_system/widgets/loading_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

import '../services/location_service.dart';
import '../services/weather_data_service.dart';
import '../widgets/top_container.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _fireStore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  var weatherData;
  WeatherModel weatherModel = WeatherModel();
  LocationService location = LocationService();
  Position? currentPosition;
  late String datetime;
  int tempreture=0;
  String cityName="";
  String weatherIcon="";
  String name="";
  bool isLoading = true;

  late User loggedInUser;

  @override
  @override
  void initState() {
    super.initState();

    Future.wait([
      getCurrentUser(),
      fetchData(),
      getDateTime(),
    ]).then((_) {
      setState(() {
        isLoading = false;
      });
    });
  }

  Future<void> fetchData() async {
    currentPosition = await location.getCurrentPosition();
    weatherData = await weatherModel.getLocationWeather();

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
      weatherIcon = weatherModel.getWeatherIcon(condition);
    });
  }

  Future<void> getDateTime() async {
    datetime = DateFormat("EEEEE, dd, yyyy").format(DateTime.now());
  }

  Future<void> getCurrentUser() async {
    try {
      final userEmail = _auth.currentUser?.email;
      if (userEmail != null) {
        final QuerySnapshot snapshot = await _fireStore
            .collection('users')
            .where('userEmail', isEqualTo: userEmail)
            .get();

        if (snapshot.docs.isNotEmpty) {
          final userData = snapshot.docs[0].data() as Map<String, dynamic>;
          setState(() {
            name = userData['userName'];
          });
        }
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? LoadingWidget()
        : Scaffold(
            body: Stack(
              children: [
                TopContainer(
                  name: name,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 160),
                      HomeScreenCard(
                        location: cityName,
                        date: datetime,
                        icon: weatherIcon,
                        temperature: tempreture,
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: ButtonCard(
                              iconLink: "assets/icons/fill.png",
                              label: 'Fill a New Application',
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        RecordingScreen(),
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(
                              width: 20), // Add space between the two cards
                          Expanded(
                            child: ButtonCard(
                              iconLink: "assets/icons/filled.png",
                              label: 'Show Filled Applications',
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        FilledApplicationScreen(),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      ButtonWidget(
                        buttonTextColor: Palette.kDarkBlackColor,
                        buttonBGColor: Palette.kLightWhiteColor,
                        buttonText: "Sign Out",
                        buttonTriggerFunction: () async {
                          await _auth.signOut();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) => LoginScreen(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
  }
}
