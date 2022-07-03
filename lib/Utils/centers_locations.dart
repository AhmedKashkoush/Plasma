import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:plasma/Model/APIs/Dummy/dummy_places.dart';

class CentersLocations {
  static Set<Map<String, dynamic>> _centerLocations = {};

  static Set<Map<String, dynamic>> get centerLocations => _centerLocations;
  static BitmapDescriptor? _image;

  static BitmapDescriptor get image => _image!;

  static Future<void> loadLocations() async {
    ConnectivityResult _connectivity = await Connectivity().checkConnectivity();
    if (_connectivity == ConnectivityResult.none) await _loadLocationsFromCache(); //load from cache
    else await _getCentersLocations();
    _image = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration.empty,
      'assets/images/plasma-marker.png',
    );
  }

  static Future<void> _loadLocationsFromCache() async {
    Directory _directory = await getApplicationDocumentsDirectory();
    String _path = _directory.path;
    File _cacheFile = File('$_path/CenterLocations.txt');
    if (await _cacheFile.exists()) {
      String _data = _cacheFile.readAsStringSync();
      //Fluttertoast.showToast(msg: 'ss');
      Map<String,dynamic> _map = jsonDecode(_data);
      Set<Map<String, dynamic>> _set = _map['locations'];
      _centerLocations = _set;
    }
  }

  static Future<void> _cacheLocations() async {
    Directory _directory = await getApplicationDocumentsDirectory();
    String _path = _directory.path;
    File _cacheFile = File('$_path/CenterLocations.txt');
    if (!await _cacheFile.exists()) {
      await _cacheFile.create();
      Map<String,dynamic> _map = {
        'locations': _centerLocations,
      };
      String _data = jsonEncode(_map);
      //String _data = '${_centerLocations.toList()}';
      Fluttertoast.showToast(msg: _data);
      _cacheFile.writeAsStringSync(_data);
    }
    else {
      //await _deleteCacheFile();
      // String _data = _cacheFile.readAsStringSync();
      // Fluttertoast.showToast(msg: _data);
    }
  }

  static Future<void> _deleteCacheFile() async {
    Directory _directory = await getApplicationDocumentsDirectory();
    String _path = _directory.path;
    File _cacheFile = File('$_path/CenterLocations.txt');
    if (await _cacheFile.exists()) _cacheFile.delete();
  }

  static Future<bool> _isCacheFileExists() async {
    Directory _directory = await getApplicationDocumentsDirectory();
    String _path = _directory.path;
    File _cacheFile = File('$_path/CenterLocations.txt');
    bool isExists = await _cacheFile.exists();
    return isExists;
  }

  static Future<void> _loadLocationsFromNetworkAndCache() async {
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
      if (_centerLocations.length == placesListArabic.length) {
        await _cacheLocations();
        Fluttertoast.cancel();
        Fluttertoast.showToast(msg: '${_centerLocations.length}');
      }
    });
    //Cache locations
    //_cacheLocations();
  }

  static Future<void> _getCentersLocations() async {
    await _deleteCacheFile();
    //Load from Cache
    if (await _isCacheFileExists()) {
      await _loadLocationsFromCache();
    }
    else await _loadLocationsFromNetworkAndCache();
  }
}
