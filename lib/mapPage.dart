import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  // Latitude : 위도(38)
  // Longitude : 경도(127)
  final CameraPosition position =
      CameraPosition(target: LatLng(37.8839362, 127.7378349), zoom: 15);
  //3d37.8839362!
  //4d127.7378349!
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('보물지도')),
        body: Container(
            child: GoogleMap(
          initialCameraPosition: this.position,
        )));
  }
}
