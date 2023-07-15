import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';


class LocationData {
  String address;
  Position position;

  LocationData(this.address, this.position);
}

class Location {
  String currentAddress = "";
  Position? currentPosition;

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return false;
    }
    return true;
  }

  Future<LocationData> getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) {
      throw Exception('Location permission not granted.');
    }
    try {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      currentPosition = position;
      await _getAddressFromLatLng();
      return LocationData(currentAddress, currentPosition!);
    } catch (e) {
      print(e.toString());
      throw Exception('Failed to get current position.');
    }
  }

  Future<void> _getAddressFromLatLng() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          currentPosition!.latitude, currentPosition!.longitude);
      Placemark place = placemarks[0];
      currentAddress =
          '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
    } catch (e) {
      print(e.toString());
      throw Exception('Failed to get address from coordinates.');
    }
  }
}

