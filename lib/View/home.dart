import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
                child: Text(
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
            SizedBox(
              height: 5,
            ),
            Text(
              'data:- the date for benefit of Donaciones',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 18.0,
              ),
            ),
            Divider(
              indent: 35,
              endIndent: 35,
              thickness: 2,
              color: Colors.amber,
            ),

            Image(
              image: AssetImage(
                'images/imgHome.png',
              ),
              width: double.maxFinite,
            ),
            Divider(
              indent: 70,
              endIndent: 70,
              thickness: 2,
              color: Colors.amber,
            ),

            SizedBox(
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
    );
  }
}
