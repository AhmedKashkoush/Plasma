import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:plasma/View/Widgets/blood_loading.dart';
import 'package:plasma/View/Widgets/mobile_custom_drawer.dart';
import 'package:plasma/View/Widgets/rounded_header.dart';
import 'package:plasma/View/Mobile/voice_search.dart';
import 'package:plasma/Utils/utils.dart';

import '../../Model/APIs/Dummy/dummy_places.dart';

class DonationPlacesScreen extends StatefulWidget {
  const DonationPlacesScreen({Key? key}) : super(key: key);

  @override
  _DonationPlacesScreenState createState() => _DonationPlacesScreenState();
}

class _DonationPlacesScreenState extends State<DonationPlacesScreen> {
  final GlobalKey<MapBodyState> mapKey = GlobalKey<MapBodyState>();

  @override
  void initState() {
    _handleLocationPermission();
    _getLocationService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Utils.confirmExit(context),
      child: Scaffold(
        drawer: const MobileCustomDrawer(
          screenIndex: 4,
        ),
        extendBodyBehindAppBar: true,
        appBar: PlacesAppBar(mapKey: mapKey),
        body: MapBody(key: mapKey),
        // body: CustomScrollView(
        //   slivers: [
        //     PlacesHeader(),
        //     FloatingHeader(),
        //     // SliverToBoxAdapter(
        //     //   child:
        //     // ),
        //     PlacesBody(),
        //   ],
        // ),
        // floatingActionButton:           FloatingActionButton(
        //   backgroundColor: Colors.blue.shade800,
        //   foregroundColor: Colors.white,
        //   child: const Icon(Icons.location_searching_rounded),
        //   onPressed: () {
        //     setState(() {});
        //   },
        // ),
        floatingActionButton: Wrap(
          direction: Axis.vertical,
          verticalDirection: VerticalDirection.up,
          spacing: 8,
          children: [
            FloatingActionButton(
              heroTag: 'current location',
              backgroundColor: Colors.blue.shade800,
              foregroundColor: Colors.white,
              child: const Icon(Icons.location_searching_rounded),
              onPressed: () async {
                if (await Connectivity().checkConnectivity() ==
                    ConnectivityResult.none) {
                  await Utils.showConnectionError(context);
                  return;
                }
                if (await Permission.location.status == PermissionStatus.denied) {
                  PermissionStatus newStatus =
                      await Permission.location.request();
                  if (newStatus == PermissionStatus.denied)
                    await Utils.showPermissionError(context,
                        permissionType: 'Location');

                  return;
                }
                if (await _getLocationService()) {
                  geo.Position? position =
                      await geo.Geolocator.getCurrentPosition();
                  mapKey.currentState?.controller?.animateCamera(
                    CameraUpdate.newCameraPosition(
                      CameraPosition(
                        target: LatLng(
                          position.latitude,
                          position.longitude,
                        ),
                        zoom: 20,
                      ),
                    ),
                  );
                } else {
                  await showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      content: const Text('Enable Location To Access'),
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
              },
            ),
            FloatingActionButton(
              heroTag: 'original zoom',
              backgroundColor: Colors.black87,
              foregroundColor: Colors.white,
              child: const Icon(Icons.fit_screen),
              onPressed: _zoomOutToInitial,
            ),
            FloatingActionButton(
              heroTag: 'places',
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              child: const Icon(Icons.place),
              onPressed: () {
                setState(() {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => PlacesBottomSheet(mapKey: mapKey),
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                  );
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  void _zoomOutToInitial() {
    CameraPosition? cameraPosition = mapKey.currentState?.initialPosition;
    mapKey.currentState?.controller?.animateCamera(
      CameraUpdate.newCameraPosition(cameraPosition!),
    );
  }

  Future<bool> _getLocationService() async {
    return geo.Geolocator.isLocationServiceEnabled();
  }

  Future<void> _handleLocationPermission() async {
    PermissionStatus status = await Permission.location.status;
    if (status == PermissionStatus.denied)
      status = await Permission.location.request();
    switch (status) {
      case PermissionStatus.granted:
        return;
    }
  }
}

class PlacesAppBar extends AppBar {
  final GlobalKey<MapBodyState> mapKey;

  PlacesAppBar({
    Key? key,
    required this.mapKey,
  }) : super(
          key: key,
          elevation: 0,
          backgroundColor: Colors.transparent,
          actions: [
            Builder(builder: (context) {
              return IconButton(
                onPressed: () async {
                  ScaffoldMessenger.of(context).removeCurrentMaterialBanner();
                  String? result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const VoiceSearchPage(),
                    ),
                  );
                  if (result != null) {
                    await Utils.animateToAddress(result,
                        context: context, mapKey: mapKey);
                  }
                },
                icon: const Icon(Icons.mic),
              );
            }),
            //SizedBox.shrink(),
          ],
          title: SizedBox(
            height: 40,
            child: Builder(builder: (context) {
              return GestureDetector(
                onTap: () async {
                  ScaffoldMessenger.of(context).removeCurrentMaterialBanner();
                  String result = await showSearch(
                    context: context,
                    delegate: PlacesSearchDelegate(mapKey: mapKey),
                  );
                  if (result != '') {
                    await Utils.animateToAddress(result,
                        context: context, mapKey: mapKey);
                  }
                },
                child: TextField(
                  readOnly: true,
                  enabled: false,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.3),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.black.withOpacity(0.3),
                    ),
                    labelText: 'Search',
                    labelStyle: TextStyle(
                      color: Colors.black.withOpacity(0.3),
                      fontWeight: FontWeight.w500,
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                ),
              );
            }),
          ),
          foregroundColor: Colors.white,
        );

// Future<void> animateToAddress(String address) async {
//   List<Location> locations =
//       await locationFromAddress(address, localeIdentifier: 'ar');
//   final LatLng _coordinates =
//       LatLng(locations.first.latitude, locations.first.longitude);
//   mapKey.currentState?.controller?.animateCamera(
//     CameraUpdate.newCameraPosition(
//       CameraPosition(
//         target: _coordinates,
//         zoom: 16,
//       ),
//     ),
//   );
// }
}

class PlacesSearchDelegate extends SearchDelegate {
  List<Map<String, String>> filterList = [];
  final GlobalKey<MapBodyState> mapKey;

  PlacesSearchDelegate({required this.mapKey})
      : super(
          searchFieldStyle: TextStyle(
            color: Colors.grey.shade500,
            fontWeight: FontWeight.w500,
          ),
        );

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(Icons.close),
        ),
      if (query.isNotEmpty)
        IconButton(
          onPressed: () {
            showResults(context);
          },
          icon: Icon(Icons.search),
        ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return BackButton(
      onPressed: () {
        close(context, "");
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    filterList = placesList.where((element) {
      bool condition = element["name"]!.startsWith(query) ||
          element["address"]!.startsWith(query) ||
          element["gov"]!.startsWith(query) ||
          query.contains(element["name"]!) ||
          query.contains(element["address"]!) ||
          query.contains(element["gov"]!);
      return condition;
    }).toList();
    if (query.isEmpty)
      return const SizedBox();
    else
      return filterList.isNotEmpty
          ? Material(
              color: Colors.transparent,
              child: ListView.separated(
                padding: const EdgeInsets.only(
                  top: 24,
                ),
                itemCount: filterList.length,
                separatorBuilder: (context, index) => Divider(
                  thickness: 1,
                ),
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      close(context,
                          "${filterList[index]["address"]} ${filterList[index]["gov"]}");
                    },
                    leading: Icon(
                      Icons.location_on,
                      color: Colors.red,
                      size: 28,
                    ),
                    title: Text(
                      filterList[index]["name"]!,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                        "${filterList[index]["address"]!}\n${filterList[index]["gov"]!}"),
                    isThreeLine: true,
                  );
                },
              ),
            )
          : const Center(
              child: Text('No Results'),
            );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    filterList = query.trim().split(',').isNotEmpty
        ? placesList.where((element) {
            bool condition = element["name"]!.startsWith(query) ||
                element["address"]!.startsWith(query) ||
                element["gov"]!.startsWith(query) ||
                query.contains(element["name"]!) ||
                query.contains(element["address"]!) ||
                query.contains(element["gov"]!);
            return condition;
          }).toList()
        : placesList;
    return Material(
      color: Colors.transparent,
      child: ListView.separated(
        padding: const EdgeInsets.only(
          top: 24,
        ),
        itemCount: filterList.length,
        separatorBuilder: (context, index) => Divider(
          thickness: 1,
        ),
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              close(context,
                  "${filterList[index]["address"]} ${filterList[index]["gov"]}");
            },
            trailing: IconButton(
              onPressed: () {
                query =
                    "${filterList[index]["name"]} ${filterList[index]["address"]} ${filterList[index]["gov"]}";
              },
              icon: Icon(Icons.north_west),
            ),
            title: Text(
              filterList[index]["name"]!,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade600,
              ),
            ),
            subtitle: Text(
                "${filterList[index]["address"]!}\n${filterList[index]["gov"]!}"),
            isThreeLine: true,
          );
        },
      ),
    );
  }
}

class MapBody extends StatefulWidget {
  const MapBody({
    Key? key,
  }) : super(key: key);

  @override
  State<MapBody> createState() => MapBodyState();
}

class MapBodyState extends State<MapBody> {
  Set<Marker> _markers = {};
  GoogleMapController? controller;
  final CameraPosition initialPosition = CameraPosition(
    target: LatLng(27.5206, 30.8025),
    zoom: 6.55,
  );

  CameraPosition? currentPosition;

  StreamSubscription? subscription;
  bool locationEnabled = true;

  @override
  void initState() {
    super.initState();
  }

  void _showNearestCenter() async {
    await Utils.showNearestCenter(
      context: context,
      controller: controller!,
    );
  }

  void _initConnectivity() async {
    ConnectivityResult result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none)
      Utils.showConnectionError(
        context,
      );
    subscription =
        Connectivity().onConnectivityChanged.listen((connectivity) async {
      if (connectivity != ConnectivityResult.none) {
        if (result == ConnectivityResult.none) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.green.shade600,
              content: SizedBox(
                height: 16,
                child: Center(
                  child: Text(
                    'Online',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          );
        }
        _initiateMarkers();
      } else {
        if (result != ConnectivityResult.none)
          Utils.showConnectionError(
            context,
          );
        // setState(() {
        //   _markers.clear();
        // });
      }
      result = connectivity;
    });
  }

  Future<bool> _isLocationEnabled() async {
    return await geo.Geolocator.isLocationServiceEnabled();
  }

  void _onLocationStatusChange() {
    geo.Geolocator.getServiceStatusStream().listen((status) {
      setState(() {
        locationEnabled = status == geo.ServiceStatus.enabled;
      });
    });
  }

  void _onLocationChange() {
    geo.Geolocator.getPositionStream().listen((position) {
      setState(() {
        currentPosition = CameraPosition(
          target: LatLng(position.latitude, position.longitude),
          zoom: 20,
        );
      });
    });
  }

  Future<void> _getCurrentLocation() async {
    if (await Permission.location.status != PermissionStatus.granted) return;
    if (!await geo.Geolocator.isLocationServiceEnabled()) return;
    geo.Position? position = await geo.Geolocator.getCurrentPosition();
    currentPosition = CameraPosition(
      target: LatLng(
        position.latitude,
        position.longitude,
      ),
      zoom: 20,
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        zoomControlsEnabled: false,
        onMapCreated: (controller) {
          this.controller = controller;
          _initConnectivity();
          _isLocationEnabled();
          _onLocationStatusChange();
          _onLocationChange();
          _getCurrentLocation();
          _showNearestCenter();
        },
        //initialCameraPosition: locationEnabled?currentPosition!:initialPosition,
        initialCameraPosition: initialPosition,
        markers: _markers,
        mapToolbarEnabled: false,
        myLocationEnabled: locationEnabled,
        myLocationButtonEnabled: false,
      ),
    );
  }

  Future<void> _initiateMarkers() async {
    try {
      placesList.forEach((center) async {
        List<Location> locations = await locationFromAddress(
            "${center["address"]},${center["gov"]}",
            localeIdentifier: 'ar');
        final LatLng _coordinates =
            LatLng(locations.first.latitude, locations.first.longitude);
        Marker _marker = Marker(
          markerId: MarkerId("${center["address"]},${center["gov"]}"),
          position: _coordinates,
          infoWindow: InfoWindow(
            title: "${center["name"]}",
            onTap: () {
              controller?.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(target: _coordinates, zoom: 16),
                ),
              );
            },
          ),
          //icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
          icon: await BitmapDescriptor.fromAssetImage(
            ImageConfiguration.empty,
            'assets/images/plasma-marker.png',
          ),
        );
        _markers.add(_marker);
      });
      setState(() {});
    } on PlatformException catch (e) {
      setState(() {
        _markers = {};
      });
      Utils.showConnectionError(
        context,
      );
    }
  }
}

// class PlacesHeader extends SliverAppBar {
//   PlacesHeader({Key? key})
//       : super(
//           key: key,
//           //floating: true,
//           pinned: true,
//           elevation: 0,
//           expandedHeight: 400,
//           actions: [
//             IconButton(
//               onPressed: () {},
//               icon: const Icon(Icons.mic),
//             ),
//             //SizedBox.shrink(),
//           ],
//           title: SizedBox(
//             height: 40,
//             child: TextField(
//               readOnly: true,
//               enabled: false,
//               decoration: InputDecoration(
//                 filled: true,
//                 fillColor: Colors.white.withOpacity(0.3),
//                 prefixIcon: Icon(
//                   Icons.search,
//                   color: Colors.black.withOpacity(0.3),
//                 ),
//                 label: const Text('Search'),
//                 labelStyle: TextStyle(
//                   color: Colors.black.withOpacity(0.3),
//                   fontWeight: FontWeight.w500,
//                 ),
//                 border: OutlineInputBorder(
//                   borderSide: BorderSide.none,
//                   borderRadius: BorderRadius.circular(25),
//                 ),
//               ),
//             ),
//           ),
//           // leading: Builder(builder: (context) {
//           //   return IconButton(
//           //     onPressed: () {
//           //       Scaffold.of(context).openEndDrawer();
//           //     },
//           //     icon: const Icon(Icons.menu),
//           //   );
//           // }),
//           foregroundColor: Colors.white,
//           flexibleSpace: FlexibleSpaceBar(
//             background: Container(
//               color: Colors.blueGrey,
//               child: Center(
//                 child: GoogleMap(
//                   mapType: MapType.normal,
//                   initialCameraPosition: CameraPosition(
//                     target: LatLng(37.42796133580664, -122.085749655962),
//                     zoom: 14,
//                   ),
//                 ),
//                 // child: Icon(
//                 //   Icons.map_rounded,
//                 //   color: Colors.white.withOpacity(0.3),
//                 //   size: 80,
//                 // ),
//               ),
//             ),
//           ),
//         );
// }
//
// class FloatingHeader extends SliverAppBar {
//   FloatingHeader({Key? key})
//       : super(
//           key: key,
//           actions: const [
//             SizedBox.shrink(),
//           ],
//           leading: const SizedBox.shrink(),
//           elevation: 0,
//           pinned: true,
//           backgroundColor: Colors.transparent,
//           toolbarHeight: 50,
//           flexibleSpace: const FlexibleSpaceBar(
//             background: const RoundedHeader(
//               text: 'Plasma Collection Centers Nationwide',
//             ),
//           ),
//         );
// }
class PlacesBottomSheet extends StatelessWidget {
  final GlobalKey<MapBodyState> mapKey;

  const PlacesBottomSheet({Key? key, required this.mapKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => Navigator.pop(context),
      child: GestureDetector(
        onTap: () {},
        child: DraggableScrollableSheet(
          initialChildSize: 0.6,
          minChildSize: 0.3,
          maxChildSize: 0.9,
          snapSizes: [
            0.3,
            0.6,
            0.9,
          ],
          expand: false,
          snap: true,
          builder: (context, scrollController) => Container(
            //padding: const EdgeInsets.only(top: 36,),
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(25),
              ),
            ),
            child: Column(
              children: [
                RoundedHeader(
                  text: 'Plasma Collection Centers Nationwide',
                  height: 52,
                ),
                Expanded(
                  child: Material(
                    color: Colors.transparent,
                    child: ListView.separated(
                      padding: const EdgeInsets.only(
                        top: 24,
                      ),
                      itemCount: placesList.length,
                      controller: scrollController,
                      separatorBuilder: (context, index) => Divider(
                        thickness: 1,
                      ),
                      itemBuilder: (context, index) {
                        //if (index == 0) return RoundedHeader(text: 'Plasma Collection Centers Nationwide',);
                        return ListTile(
                          onTap: () async {
                            Utils.animateToAddress(
                                "${placesList[index]["address"]},${placesList[index]["gov"]}",
                                context: context,
                                mapKey: mapKey);
                            // await _animateToAddress(
                            //     "${placesList[index]["address"]},${placesList[index]["gov"]}",context,);
                            Navigator.pop(context);
                          },
                          leading: Icon(
                            Icons.location_on,
                            color: Colors.red,
                            size: 28,
                          ),
                          title: Text(
                            placesList[index]["name"]!,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                              "${placesList[index]["address"]!}\n${placesList[index]["gov"]!}"),
                          isThreeLine: true,
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

// Future<void> _animateToAddress(String address,BuildContext context) async {
//   try {
//     List<Location> locations =
//         await locationFromAddress(address, localeIdentifier: 'ar');
//     final LatLng _coordinates =
//         LatLng(locations.first.latitude, locations.first.longitude);
//     mapKey.currentState?.controller?.animateCamera(
//       CameraUpdate.newCameraPosition(
//         CameraPosition(
//           target: _coordinates,
//           zoom: 16,
//         ),
//       ),
//     );
//   } on Exception catch (e) {
//     showDialog(context: context,builder: (context) => AlertDialog(
//       title: Text('$e'),
//       // content: const Text(
//       //     'Cannot Access Microphone Services In Your Device.Please Enable Service From App Settings To Continue'),
//       actions: [
//         TextButton(
//           onPressed: () async {
//             Navigator.pop(context);
//           },
//           child: const Text('Ok'),
//         ),
//       ],
//     ),);
//     // TODO
//   }
// }
}

// class PlacesBody extends SliverList {
//   PlacesBody({Key? key})
//       : super(
//           key: key,
//           delegate: SliverChildBuilderDelegate(
//             (context, index) => ListTile(
//               leading: Icon(
//                 Icons.location_on,
//                 color: Colors.red,
//               ),
//               title: Text(
//                 placesList[index]["name"]!,
//                 style: const TextStyle(fontWeight: FontWeight.bold),
//               ),
//               subtitle: Text(
//                   "${placesList[index]["address"]!}\n${placesList[index]["gov"]!}"),
//               isThreeLine: true,
//             ),
//             childCount: placesList.length,
//           ),
//         );
// }
