import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:plasma/Model/APIs/Dummy/dummy_places.dart';

import '../View/donation_places_screen.dart';

class Utils {
  static Future<void> animateToAddress(String address,
      {required BuildContext context,
      required GlobalKey<MapBodyState> mapKey}) async {
    try {
      List<Location> locations =
          await locationFromAddress(address, localeIdentifier: 'ar');
      final LatLng _coordinates =
          LatLng(locations.first.latitude, locations.first.longitude);
      mapKey.currentState?.controller?.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: _coordinates,
            zoom: 16,
          ),
        ),
      );
    } on PlatformException catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Connection Error'),
          content: const Text('Check Your Internet Connection'),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
              },
              child: const Text('Ok'),
            ),
          ],
        ),
      );
    }
  }

  static Future<void> showNearestCenter(
      {required BuildContext context,
      required GoogleMapController controller}) async {
    if (await Permission.location.serviceStatus != PermissionStatus.granted) {
      PermissionStatus newStatus = await Permission.location.request();
      if (newStatus != PermissionStatus.granted) return;
    }
    if (!await Geolocator.isLocationServiceEnabled()) return;
    if (await Connectivity().checkConnectivity() == ConnectivityResult.none)
      return;
    Position currentLocation = await Geolocator.getCurrentPosition();
    double? minDistance;
    String? centerName;
    String? centerAddress;
    String? centerGov;
    LatLng? coordinates;
    placesList.forEach((place) async {
      List<Location> locations =
          await locationFromAddress(place["address"]!, localeIdentifier: 'ar');
      final LatLng _coordinates =
          LatLng(locations.first.latitude, locations.first.longitude);
      double distance = Geolocator.distanceBetween(
        currentLocation.latitude,
        currentLocation.longitude,
        _coordinates.latitude,
        _coordinates.longitude,
      );
      if (minDistance != null) {
        if (distance < minDistance!) {
          minDistance = distance;
          centerName = place["name"]!;
          centerAddress = place["address"]!;
          centerGov = place["gov"]!;
          coordinates = _coordinates;
        }
      } else {
        minDistance = distance;
        centerName = place["name"]!;
        centerAddress = place["address"]!;
        centerGov = place["gov"]!;
        coordinates = _coordinates;
      }
    });
    ScaffoldMessenger.of(context).showMaterialBanner(
      MaterialBanner(
        leading: Icon(
          Icons.info_outline,
          color: Colors.white,
        ),
        content: const Text(
          'We Have Detected The Nearest Center Based On Your Current Location',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        // content: ListTile(
        //   title: const Text(
        //     'We Detected The Nearest Center Based On Your Current',
        //     style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        //   ),
        //   subtitle: Text(
        //     '$centerName\n$centerAddress\n$centerGov',
        //     style: const TextStyle(
        //       color: Colors.white,
        //     ),
        //   ),
        //   isThreeLine: true,
        // ),
        backgroundColor: Colors.blue.shade800,
        actions: [
          TextButton(
            onPressed: () {
              controller.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(
                    target: coordinates!,
                    zoom: 16,
                  ),
                ),
              );
              ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
            },
            child: const Text('Show In Map'),
          ),
          TextButton(
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
            },
            child: const Text('Dismiss'),
          ),
        ],
      ),
    );
  }
}
