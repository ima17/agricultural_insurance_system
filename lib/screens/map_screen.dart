import 'package:agricultural_insurance_system/models/application_data.dart';
import 'package:agricultural_insurance_system/screens/risks_show_screen.dart';
import 'package:agricultural_insurance_system/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../configs/palette.dart';
import '../services/location_service.dart';
import '../widgets/map_widget.dart';

class MapScreen extends StatefulWidget {
  final ApplicationData? applicationData;

  const MapScreen({Key? key, this.applicationData}) : super(key: key);

  @override
  MapScreenState createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen> {
  late GoogleMapController _controller;
  LatLng? _currentPosition;
  LocationService location = LocationService();
  Position? currentPosition;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  void _getCurrentLocation() async {
    final locationData = await location.getCurrentPosition();
    setState(() {
      _currentPosition = LatLng(locationData.latitude, locationData.longitude);
      _isLoading = false;
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller = controller;
    setState(() {
      _isLoading = false;
    });
  }

  // void _onCameraMove(CameraPosition position) {
  //   _currentPosition = position.target;
  // }

  void _onMapTap(LatLng position) {
    setState(() {
      _currentPosition = position;
    });
  }

  void _onSaveAndNext() async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RiskShowScreen(
          currentPosition: _currentPosition!,
          applicationData: widget.applicationData,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Location'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: _isLoading
          ? Center(
              child: SpinKitDoubleBounce(
                color: Palette.kPrimaryColor,
                size: 100.0,
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: MapWidget(
                    currentPosition: _currentPosition,
                    onMapCreated: _onMapCreated,
                    onMapTap: _onMapTap,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16.0),
                  child: ButtonWidget(
                    buttonText: 'Save Location',
                    buttonTriggerFunction: _onSaveAndNext,
                  ),
                ),
              ],
            ),
    );
  }
}
