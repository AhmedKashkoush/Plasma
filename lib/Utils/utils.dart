import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:plasma/Model/APIs/Dummy/dummy_places.dart';
import 'package:url_launcher/url_launcher.dart';

import '../View/Mobile/donation_places_screen.dart';

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
      showConnectionError(context);
    }
  }

  static Future<void> showConnectionError(BuildContext context) => showDialog(
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

  static Future<void> showPermissionError(BuildContext context,
          {required String permissionType}) =>
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Permission Error'),
          content: Text(
              'Cannot Access $permissionType Services In Your Device.Please Enable Service From App Settings To Continue'),
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

  static Future<bool?> showPermissionErrorAndRequest(BuildContext context,
          {required String permissionType}) =>
      showDialog(
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: Text('Permission Error'),
          content: Text('$permissionType Access Is Denied'),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.pop(context, true);
              },
              child: const Text('Request Permission'),
            ),
            TextButton(
              style: TextButton.styleFrom(primary: Colors.red),
              onPressed: () async {
                Navigator.pop(context, false);
              },
              child: const Text('Dismiss'),
            ),
          ],
        ),
        context: context,
      );

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

  static Future<void> showUrlLaunchingError(BuildContext context) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: const Text(
              'Something Went Wrong While Opening The Link.Try Again Or Check Your Internet Connection'),
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

  static void showAboutInfoDialog(BuildContext context) async{
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;
    showAboutDialog(
      context: context,
      applicationIcon: Image.asset('images/logo.png', width: 120),
      applicationName: 'Plasma',
      applicationVersion: 'v$version',
      applicationLegalese: 'Copyright© ${DateTime.now().year}',
      children: [
        const SizedBox(
          height: 20,
        ),
        Text(
          'Build number: $buildNumber',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(
          'Platform: ${Platform.operatingSystem}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 20,
        ),
        const Text(
            'The app purpose is to facilitate the donation process between users and the head organization.'),
        const Text(
            'We provide you with all information you need for donation and the right steps to follow to donate.'),
        const SizedBox(
          height: 10,
        ),
        StatefulBuilder(
          builder:
              (BuildContext context, void Function(void Function()) setState) {
            bool isTapped = false;
            return Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text:
                        'For more info about the application,donation or organization visit: ',
                  ),
                  TextSpan(
                    text: 'plasma.mohp.gov.eg',
                    style: TextStyle(
                      color: Colors.blue,
                      backgroundColor:
                          // ignore: dead_code
                          isTapped ? Colors.blue.withOpacity(0.4) : null,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () async {
                        if (!await launchUrl(
                          Uri.parse('plasma.mohp.gov.eg'),
                        )) showUrlLaunchingError(context);
                      }
                      ..onTapDown = (details) {
                        setState(() {
                          isTapped = true;
                        });
                      }
                      ..onTapUp = (details) {
                        setState(() {
                          isTapped = false;
                        });
                      },
                  ),
                ],
              ),
            );
          },
        )
      ],
    );
  }
}
