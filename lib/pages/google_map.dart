import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapPage extends StatefulWidget {
  GoogleMapPage({super.key, required this.ulke});
  TextEditingController ulke;
  @override
  State<GoogleMapPage> createState() => _MyAppState();
}

class _MyAppState extends State<GoogleMapPage> {
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void initState() {
    super.initState();
  }

  Future<List<String>> findLocation(double a, double b) async {
    placemarkFromCoordinates(a, b).then((placemarks) {
      var output = 'No results found.';
      if (placemarks.isNotEmpty) {
        widget.ulke.text = placemarks[0].country??"";

        return [placemarks[0].isoCountryCode, placemarks[0].country];

      }
      //print(output);
    });
    widget.ulke.text = "";
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.green[700],
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text('Bölge Seçin'),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          elevation: 0,
        ),
        body: GoogleMap(
          onTap: (a) {
            findLocation(a.latitude, a.longitude);
            Navigator.pop(context);
            setState(() {

            });
          },
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 11.0,
          ),
        ),
      ),
    );
  }
}
