import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:plasma/Model/APIs/Dummy/dummy_places.dart';
import 'package:plasma/Model/Models/center_model.dart';
import 'package:plasma/Utils/centers_locations.dart';
import 'package:plasma/View/Mobile/team_members_screen.dart';
import 'package:plasma/View/Widgets/link_widget.dart';

import '../View/Mobile/donation_places_screen.dart';
import '../View/Widgets/blood_loading.dart';
import '../View/Widgets/translated_text_widget.dart';

class Utils {
  static Future<void> animateToAddress(
    String address, {
    required BuildContext context,
    required GlobalKey<MapBodyState> mapKey,
  }) async {
    try {
      CenterModel? model;
      LatLng _coordinates;
      CentersLocations.centerLocations.forEach((center) {
        int index = CentersLocations.centerLocations.toList().indexOf(center);
        String _address = '${placesListArabic[index]["address"]},${placesListArabic[index]["gov"]}';
        if (_address == address){
          model = CenterModel.fromJson(center);
        }
      });
      if (model == null) {
        final List<Location> locations =
          await locationFromAddress(address, localeIdentifier: 'ar');
          _coordinates =
          LatLng(locations.first.latitude, locations.first.longitude);
      }
      else {
        _coordinates = LatLng(model!.latitude, model!.longitude);
      }
      mapKey.currentState?.controller?.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: _coordinates,
            zoom: 16,
          ),
        ),
      );
    } on PlatformException {
      showConnectionError(context);
    }
  }

  static Future<void> showConnectionError(BuildContext context) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: TranslatedTextWidget(
            text: 'Connection Error',
          ),
          content: TranslatedTextWidget(
            text: 'Check Your Internet Connection',
          ),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
              },
              child: TranslatedTextWidget(
                text: 'Ok',
              ),
            ),
          ],
        ),
      );

  static Future<void> showPermissionError(BuildContext context,
          {required String permissionType}) =>
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: TranslatedTextWidget(
            text: 'Permission Error',
          ),
          content: TranslatedTextWidget(
            text:
                'Cannot Access $permissionType Services In Your Device.Please Enable Service From App Settings To Continue',
          ),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
              },
              child: TranslatedTextWidget(
                text: 'Ok',
              ),
            ),
          ],
        ),
      );

  static Future<bool?> showPermissionErrorAndRequest(BuildContext context,
          {required String permissionType}) =>
      showDialog(
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: TranslatedTextWidget(
            text: 'Permission Error',
          ),
          content: TranslatedTextWidget(
            text: '$permissionType Access Is Denied',
          ),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.pop(context, true);
              },
              child: TranslatedTextWidget(
                text: 'Request Permission',
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(primary: Colors.red),
              onPressed: () async {
                Navigator.pop(context, false);
              },
              child: TranslatedTextWidget(
                text: 'Dismiss',
              ),
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
    // String? centerName;
    // String? centerAddress;
    // String? centerGov;
    LatLng? coordinates;
    LatLng _coordinates;
    placesListArabic.forEach((place) async {
      if (CentersLocations.centerLocations.isNotEmpty) {
        List<Location> locations = await locationFromAddress(
          "${place["address"]},${place["gov"]}",
          localeIdentifier: 'ar',
        );
        _coordinates =
            LatLng(locations.first.latitude, locations.first.longitude);
      }
      else {
        int _index = placesListArabic.indexOf(place);
        List _list = CentersLocations.centerLocations.toList();
        Map<String,dynamic> _center = _list[_index];
        CenterModel _model = CenterModel.fromJson(_center);
        _coordinates =
            LatLng(_model.latitude, _model.longitude);
      }
      double distance = Geolocator.distanceBetween(
        currentLocation.latitude,
        currentLocation.longitude,
        _coordinates.latitude,
        _coordinates.longitude,
      );
      if (minDistance != null) {
        if (distance < minDistance!) {
          minDistance = distance;
          // centerName = place["name"]!;
          // centerAddress = place["address"]!;
          // centerGov = place["gov"]!;
          coordinates = _coordinates;
        }
      } else {
        minDistance = distance;
        // centerName = place["name"]!;
        // centerAddress = place["address"]!;
        // centerGov = place["gov"]!;
        coordinates = _coordinates;
      }
    });
    ScaffoldMessenger.of(context).showMaterialBanner(
      MaterialBanner(
        leading: const Icon(
          Icons.info_outline,
          color: Colors.white,
        ),
        content: TranslatedTextWidget(
          text:
              'We Have Detected The Nearest Center Based On Your Current Location',
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
            child: TranslatedTextWidget(
              text: 'Show In Map',
            ),
          ),
          TextButton(
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
            },
            child: TranslatedTextWidget(
              text: 'Dismiss',
            ),
          ),
        ],
      ),
    );
  }

  static Future<void> showUrlLaunchingError(BuildContext context) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: TranslatedTextWidget(
            text: 'Error',
          ),
          content: TranslatedTextWidget(
            text:
                'Something Went Wrong While Opening The Link.Try Again Or Check Your Internet Connection',
          ),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
              },
              child: TranslatedTextWidget(
                text: 'Ok',
              ),
            ),
          ],
        ),
      );

  static void showAboutInfoDialog(BuildContext context) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;
    //bool isTapped = false;
    showAboutDialog(
      context: context,
      applicationIcon:
          const Image(image: AssetImage('assets/images/logo.png'), width: 120),
      applicationName: 'Plasma',
      applicationVersion: 'v$version',
      applicationLegalese: 'Copyright© ${DateTime.now().year}',
      children: [
        const SizedBox(
          height: 20,
        ),
        Text(
          '${TranslatedTextWidget.translate('Build number:')} $buildNumber',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(
          '${TranslatedTextWidget.translate('Platform:')} ${Platform.operatingSystem}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 20,
        ),
        TranslatedTextWidget(
          text:
              'The app purpose is to facilitate the donation process between users and the head organization.',
        ),
        TranslatedTextWidget(
          text:
              'We provide you with all information you need for donation and the right steps to follow to donate.',
        ),
        const SizedBox(
          height: 10,
        ),
        LinkWidget(
          link: 'http://plasma.mohp.gov.eg/',
          linkText: 'plasma.mohp.gov.eg',
          text:
              'For more info about the application,donation or organization, visit:',
        ),
        // return Text.rich(
        //   TextSpan(
        //     children: [
        //       TextSpan(
        //         text:
        //             '${TranslatedTextWidget.translate('For more info about the application,donation or organization, visit:')} ',
        //       ),
        //       TextSpan(
        //         text: 'plasma.mohp.gov.eg',
        //         style: TextStyle(
        //           color: Colors.blue,
        //           backgroundColor:
        //               isTapped ? Colors.blue.withOpacity(0.4) : null,
        //         ),
        //         recognizer: TapGestureRecognizer()
        //           ..onTap = () async {
        //             if (!await launchUrl(
        //               Uri.parse('http://plasma.mohp.gov.eg/'),
        //             )) showUrlLaunchingError(context);
        //           }
        //           ..onTapDown = (details) {
        //             setState(() {
        //               isTapped = true;
        //             });
        //           }
        //           ..onTapUp = (details) {
        //             setState(() {
        //               isTapped = false;
        //             });
        //           }
        //           ..onTapCancel = () {
        //             setState(() {
        //               isTapped = false;
        //             });
        //           },
        //       ),
        //     ],
        //   ),
        // );
        Builder(builder: (context) {
          return TextButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TeamMembersScreen(),
              ),
            ),
            child: TranslatedTextWidget(text: 'View Developers Team'),
          );
        }),
      ],
    );
  }

  static void showBloodLoadingDialog(BuildContext context, {String? text}) =>
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: AlertDialog(
            backgroundColor: Colors.transparent,
            elevation: 0,
            content: Container(
              padding: const EdgeInsets.all(50),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(25),
              ),
              child: text != null && text != ''
                  ? Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: const BloodLoadingIndicator(),
                        ),
                        Expanded(
                          child: const SizedBox(
                              //width: 32,
                              ),
                        ),
                        Expanded(
                          flex: 4,
                          child: TranslatedTextWidget(
                            text: text,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    )
                  : const Center(
                      child: BloodLoadingIndicator(),
                    ),
            ),
          ),
        ),
      );

  static Future<bool> confirmExit(BuildContext context) async {
    bool canPop = await Navigator.of(context).canPop();
    if (canPop) return canPop;
    return await showDialog(
          builder: (context) => AlertDialog(
            title: TranslatedTextWidget(
              text: 'Exit?',
            ),
            actions: [
              TextButton(
                style: TextButton.styleFrom(primary: Colors.red),
                onPressed: () async {
                  Navigator.pop(context, true);
                },
                child: TranslatedTextWidget(
                  text: 'Yes',
                ),
              ),
              TextButton(
                onPressed: () async {
                  Navigator.pop(context, false);
                },
                child: TranslatedTextWidget(
                  text: 'No',
                ),
              ),
            ],
          ),
          context: context,
        ) ??
        false;
  }
}
