import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plasma/View/login.dart';

import 'login.dart';

class Before_login extends StatelessWidget {
  const Before_login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const
            Image(
              width: double.infinity,
              height: 400.0,
              image: AssetImage(
                'images/plsma.png',
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(


                  color: Colors.amber,
                  height: 40.0,
                  width: double.infinity,
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => login(
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      'LOGIN',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Container(
                  color: Colors.amber,
                  height: 40.0,
                  width: double.infinity,
                  child: MaterialButton(
                    onPressed: () {},
                    child: const Text(
                      'SIGN UP',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
