import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final GlobalKey<CurvedNavigationBarState> bottomBarKey;
  const HomeScreen({Key? key, required this.bottomBarKey}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: GestureDetector(
            onTap: () => bottomBarKey.currentState?.setPage(3),
            child: Text(
              'Username',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
            )),
        leading: GestureDetector(
          onTap: () => bottomBarKey.currentState?.setPage(3),
          child: Icon(
            Icons.account_circle,
            size: 32,
            color: Colors.amber,
          ),
        ),
      ),
      extendBody: true,
      body: SingleChildScrollView(
        reverse: true,
        child: Padding(
          padding: const EdgeInsets.only(
            top: 80,
            left: 10,
            right: 10,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 40.0,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    15.0,
                  ),
                  color: Colors.amber,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: const Text(
                    'Most Sick People Need Blood Plasma',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              const Text(
                'data:- the date for benefit of Donaciones',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 18.0,
                ),
              ),
              const Divider(
                indent: 35,
                endIndent: 35,
                thickness: 2,
                color: Colors.amber,
              ),

              const Image(
                image: AssetImage(
                  'images/imgHome.png',
                ),
                width: 420,
              ),
              const Divider(
                indent: 70,
                endIndent: 70,
                thickness: 2,
                color: Colors.amber,
              ),

              const SizedBox(
                height: 5,
              ),
              // اتبرع الان !!!!!!
              Container(
                color: Colors.amber,
                height: 40.0,
                child: MaterialButton(
                  onPressed: () {},
                  child: const Text(
                    ' Donate Now',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
