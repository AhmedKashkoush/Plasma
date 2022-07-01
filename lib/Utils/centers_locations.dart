import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:plasma/Model/APIs/Dummy/dummy_places.dart';
import 'package:plasma/View/Widgets/translated_text_widget.dart';

class CentersLocations {
  static Set<Map<String, dynamic>> _centerLocations = {};

  static Set<Map<String, dynamic>> get centerLocations => _centerLocations;
  static BitmapDescriptor? _image;

  static BitmapDescriptor get image => _image!;

  static Future<void> loadLocations() async {
    ConnectivityResult _connectivity = await Connectivity().checkConnectivity();
    if (_connectivity == ConnectivityResult.none) return; //load from cache
    await _getCentersLocations();
    _image = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration.empty,
      'assets/images/plasma-marker.png',
    );
  }

  static Future<void> _getCentersLocations() async {
    placesListArabic.forEach((center) async {
      List<Location> locations = await locationFromAddress(
        "${center["address"]},${center["gov"]}",
        localeIdentifier: 'ar',
      );
      final int index = placesListArabic.indexOf(center);
      final String _name = placesList[index]["name"]!;
      final String _address = placesList[index]["address"]!;
      final String _gov = placesList[index]["gov"]!;
      final double _latitude = locations.first.latitude;
      final double _longitude = locations.first.longitude;
      final Map<String, dynamic> _centerMap = {
        'name': _name,
        'address': _address,
        'gov': _gov,
        'latitude': _latitude,
        'longitude': _longitude,
      };
      _centerLocations.add(_centerMap);
    });
  }
}
