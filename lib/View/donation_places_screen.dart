import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:plasma/View/Widgets/custom_drawer.dart';
import 'package:plasma/View/Widgets/rounded_header.dart';

class DonationPlacesScreen extends StatefulWidget {
  const DonationPlacesScreen({Key? key}) : super(key: key);

  @override
  _DonationPlacesScreenState createState() => _DonationPlacesScreenState();
}

class _DonationPlacesScreenState extends State<DonationPlacesScreen> {
  bool _isExtended = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(
        screenIndex: 4,
      ),
      body: CustomScrollView(
        slivers: [
          PlacesHeader(),
          FloatingHeader(),
          // SliverToBoxAdapter(
          //   child:
          // ),
          PlacesBody(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue.shade800,
        foregroundColor: Colors.white,
        child: const Icon(Icons.location_searching_rounded),
        onPressed: () {
          setState(() {});
        },
      ),
    );
  }
}

class PlacesHeader extends SliverAppBar {
  PlacesHeader({Key? key})
      : super(
          key: key,
          //floating: true,
          pinned: true,
          elevation: 0,
          expandedHeight: 400,
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.mic),
            ),
            //SizedBox.shrink(),
          ],
          title: SizedBox(
            height: 40,
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
                label: const Text('Search'),
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
          ),
          // leading: Builder(builder: (context) {
          //   return IconButton(
          //     onPressed: () {
          //       Scaffold.of(context).openEndDrawer();
          //     },
          //     icon: const Icon(Icons.menu),
          //   );
          // }),
          foregroundColor: Colors.white,
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
              color: Colors.blueGrey,
              child: Center(
                child: GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(37.42796133580664, -122.085749655962),
                    zoom: 14,
                  ),
                ),
                // child: Icon(
                //   Icons.map_rounded,
                //   color: Colors.white.withOpacity(0.3),
                //   size: 80,
                // ),
              ),
            ),
          ),
        );
}

class FloatingHeader extends SliverAppBar {
  FloatingHeader({Key? key})
      : super(
          key: key,
          actions: const [
            SizedBox.shrink(),
          ],
          leading: const SizedBox.shrink(),
          elevation: 0,
          pinned: true,
          backgroundColor: Colors.transparent,
          toolbarHeight: 50,
          flexibleSpace: const FlexibleSpaceBar(
            background: const RoundedHeader(
              text: 'Plasma Collection Centers Nationwide',
            ),
          ),
        );
}

class PlacesBody extends SliverList {
  static const List<Map<String, String>> _places = [
    {
      "name": "المركز الاقليمي لنقل الدم بالعباسية",
      "address":
          "5أ شارع السكة البيضاء - أمام مصلحة الجوازات و الهجرة - العباسية",
      "gov": "القاهرة",
    },
    {
      "name": "المركز الاقليمي لنقل الدم بالعباسية",
      "address":
          "5أ شارع السكة البيضاء - أمام مصلحة الجوازات و الهجرة - العباسية",
      "gov": "القاهرة",
    },
    {
      "name": "المركز الاقليمي لنقل الدم بالعباسية",
      "address":
          "5أ شارع السكة البيضاء - أمام مصلحة الجوازات و الهجرة - العباسية",
      "gov": "القاهرة",
    },
    {
      "name": "المركز الاقليمي لنقل الدم بالعباسية",
      "address":
          "5أ شارع السكة البيضاء - أمام مصلحة الجوازات و الهجرة - العباسية",
      "gov": "القاهرة",
    },
    {
      "name": "المركز الاقليمي لنقل الدم بالعباسية",
      "address":
          "5أ شارع السكة البيضاء - أمام مصلحة الجوازات و الهجرة - العباسية",
      "gov": "القاهرة",
    },
    {
      "name": "المركز الاقليمي لنقل الدم بالعباسية",
      "address":
          "5أ شارع السكة البيضاء - أمام مصلحة الجوازات و الهجرة - العباسية",
      "gov": "القاهرة",
    },
    {
      "name": "المركز الاقليمي لنقل الدم بالعباسية",
      "address":
          "5أ شارع السكة البيضاء - أمام مصلحة الجوازات و الهجرة - العباسية",
      "gov": "القاهرة",
    },
    {
      "name": "المركز الاقليمي لنقل الدم بالعباسية",
      "address":
          "5أ شارع السكة البيضاء - أمام مصلحة الجوازات و الهجرة - العباسية",
      "gov": "القاهرة",
    },
    {
      "name": "المركز الاقليمي لنقل الدم بالعباسية",
      "address":
          "5أ شارع السكة البيضاء - أمام مصلحة الجوازات و الهجرة - العباسية",
      "gov": "القاهرة",
    },
    {
      "name": "المركز الاقليمي لنقل الدم بالعباسية",
      "address":
          "5أ شارع السكة البيضاء - أمام مصلحة الجوازات و الهجرة - العباسية",
      "gov": "القاهرة",
    },
    {
      "name": "المركز الاقليمي لنقل الدم بالعباسية",
      "address":
          "5أ شارع السكة البيضاء - أمام مصلحة الجوازات و الهجرة - العباسية",
      "gov": "القاهرة",
    },
  ];
  PlacesBody({Key? key})
      : super(
          key: key,
          delegate: SliverChildBuilderDelegate(
            (context, index) => ListTile(
              leading: Icon(
                Icons.location_on,
                color: Colors.red,
              ),
              title: Text(
                _places[index]["name"]!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                  "${_places[index]["address"]!}\n${_places[index]["gov"]!}"),
              isThreeLine: true,
            ),
            childCount: _places.length,
          ),
        );
}
