import 'package:flutter/material.dart';

class plaseSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 50.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 60.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    30.0,
                  ),
                  color: Colors.amber,
                ),
                child: Row(
                  children: const [
                    CircleAvatar(
                      backgroundColor: Color.fromARGB(255, 204, 194, 194),
                      radius: 30,
                      backgroundImage: AssetImage(
                        'images/plase.png',
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Plasma Collection Centers in Egypt',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 15.0,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 30,
                ),
                child: Column(
                  children: [
                    MaterialButton(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
                      elevation: 10.0,
                      minWidth: 200.0,
                      height: 35,
                      color:Colors.amberAccent,
                      onPressed: () {},
                      child: Row(
                        children: const [
                          CircleAvatar(
                            backgroundColor: Color.fromARGB(255, 204, 194, 194),
                            radius: 10,
                            backgroundImage: AssetImage(
                              'images/plase.png',
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Dr. Ehab Serag El-Din Center for Blood Transfusion and Plasma Collection Services - 15 Ministry of Agriculture Street, Agouza, Giza',
                                maxLines: 4,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 15.0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(),
                    const SizedBox(
                      height: 15,
                    ),
                    MaterialButton(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
                      elevation: 10.0,
                      minWidth: 200.0,
                      height: 35,
                      color:Colors.amberAccent,
                      onPressed: () {},
                      child: Row(
                        children: const [
                          CircleAvatar(
                            backgroundColor: Color.fromARGB(255, 204, 194, 194),
                            radius: 10,
                            backgroundImage: AssetImage(
                              'images/plase.png',
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Dr. Ehab Serag El-Din Center for Blood Transfusion and Plasma Collection Services - 15 Ministry of Agriculture Street, Agouza, Giza',
                                maxLines: 4,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 15.0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(),
                    const SizedBox(
                      height: 15,
                    ),
                    MaterialButton(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
                        elevation: 10.0,
                        minWidth: 200.0,
                        height: 35,
                        color:Colors.amberAccent,

                      onPressed: () {},
                      child: Row(
                        children: const [
                          CircleAvatar(
                            backgroundColor: Color.fromARGB(255, 204, 194, 194),
                            radius: 10,
                            backgroundImage: AssetImage(
                              'images/plase.png',
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Dr. Ehab Serag El-Din Center for Blood Transfusion and Plasma Collection Services - 15 Ministry of Agriculture Street, Agouza, Giza',
                                maxLines: 4,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 15.0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(),
                    const SizedBox(
                      height: 15,
                    ),
                    MaterialButton(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
                      elevation: 10.0,
                      minWidth: 200.0,
                      height: 35,
                      color:Colors.amberAccent,
                      onPressed: () {},
                      child: Row(
                        children: const [
                          CircleAvatar(
                            backgroundColor: Color.fromARGB(255, 204, 194, 194),
                            radius: 10,
                            backgroundImage: AssetImage(
                              'images/plase.png',
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Dr. Ehab Serag El-Din Center for Blood Transfusion and Plasma Collection Services - 15 Ministry of Agriculture Street, Agouza, Giza',
                                maxLines: 4,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 15.0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(),
                    const SizedBox(
                      height: 15,
                    ),
                    MaterialButton(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
                      elevation: 10.0,
                      minWidth: 200.0,
                      height: 35,
                      color:Colors.amberAccent,
                      onPressed: () {},
                      child: Row(
                        children: const [
                          CircleAvatar(
                            backgroundColor: Color.fromARGB(255, 204, 194, 194),
                            radius: 10,
                            backgroundImage: AssetImage(
                              'images/plase.png',
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Dr. Ehab Serag El-Din Center for Blood Transfusion and Plasma Collection Services - 15 Ministry of Agriculture Street, Agouza, Giza',
                                maxLines: 4,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 15.0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(),
                    const SizedBox(
                      height: 15,
                    ),
                    MaterialButton(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
                      elevation: 10.0,
                      minWidth: 200.0,
                      height: 35,
                      color:Colors.amberAccent,
                      onPressed: () {},
                      child: Row(
                        children: const [
                          CircleAvatar(
                            backgroundColor: Color.fromARGB(255, 204, 194, 194),
                            radius: 10,
                            backgroundImage: AssetImage(
                              'images/plase.png',
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Dr. Ehab Serag El-Din Center for Blood Transfusion and Plasma Collection Services - 15 Ministry of Agriculture Street, Agouza, Giza',
                                maxLines: 4,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 15.0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(),
                    const SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
