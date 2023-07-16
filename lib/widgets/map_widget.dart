import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapWidget extends StatelessWidget {
  final LatLng? currentPosition;
  final void Function(GoogleMapController) onMapCreated;
  final void Function(LatLng) onMapTap;

  const MapWidget({
    Key? key,
    required this.currentPosition,
    required this.onMapCreated,
    required this.onMapTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      zoomControlsEnabled: false,
      onMapCreated: onMapCreated,
      initialCameraPosition: CameraPosition(target: currentPosition!, zoom: 15),
      myLocationEnabled: true,
      myLocationButtonEnabled: false,
      markers: {
        Marker(
          markerId: const MarkerId('current_position'),
          position: currentPosition!,
        ),
      },
      onTap: onMapTap,
    );
  }
}
