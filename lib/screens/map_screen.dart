import 'package:agricultural_insurance_system/models/application_data.dart';
import 'package:agricultural_insurance_system/screens/risks_show_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart' as ph;
import 'dart:async';

class MapScreen extends StatefulWidget {
  final ApplicationData? applicationData;
  const MapScreen({super.key, this.applicationData});

  @override
  MapScreenState createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen> {
  late GoogleMapController _controller;
  LatLng? _currentPosition;
  final Location _location = Location();

  @override
  void initState() {
    super.initState();
    _requestLocationPermission();
  }

  Future<void> _requestLocationPermission() async {
    ph.PermissionStatus status = await ph.Permission.location.request();
    if (status.isGranted) {
      _getCurrentLocation();
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Location Permission Denied'),
            content: const Text(
                'Please enable location permission to use this feature.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  void _getCurrentLocation() async {
    final locationData = await _location.getLocation();
    setState(() {
      _currentPosition =
          LatLng(locationData.latitude!, locationData.longitude!);
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller = controller;
  }

  void _onCameraMove(CameraPosition position) {
    _currentPosition = position.target;
  }

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
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (_currentPosition != null)
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition:
                CameraPosition(target: _currentPosition!, zoom: 15),
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            onCameraMove: _onCameraMove,
            onTap: _onMapTap,
            markers: {
              Marker(
                  markerId: const MarkerId('current_position'),
                  position: _currentPosition!)
            },
          ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: _onSaveAndNext,
              child: const Text('Save and next'),
            ),
          ),
        ),
      ],
    );
  }
}
