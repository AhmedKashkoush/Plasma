import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Widgets/custom_drawer.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        foregroundColor: Color.fromARGB(255, 255, 255, 255),
        title: Text(
          "Contact Us ",
          style: TextStyle(
            fontSize: 25.0,
          ),
        ),
        elevation: 0.0,
      ),
      drawer: const CustomDrawer(
        screenIndex: 5,
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          if (orientation == Orientation.portrait)
            return ContactUsPortrait();
          else
            return ContactUsLandscape();
        },
      ),
    );
  }
}

class ContactUsPortrait extends StatelessWidget {
  const ContactUsPortrait({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            image: AssetImage('images/contact.png'),
            width: 220,
          ),
          const SizedBox(
            height: 20.0,
          ),
          OutlinedButton.icon(
            style: ButtonStyle(
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              side: MaterialStateProperty.all(
                BorderSide(width: 3.0, color: Colors.black12),
              ),
              backgroundColor: MaterialStateProperty.all(Colors.blue),
              foregroundColor: MaterialStateProperty.all(Colors.white),
              padding: MaterialStateProperty.all(
                EdgeInsets.all(15),
              ),
            ),
            onPressed: () => {},
            icon: Icon(Icons.facebook),
            label: Text(
              'Plasma On Facebook',
              style: TextStyle(fontSize: 22.0),
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          OutlinedButton.icon(
              style: ButtonStyle(
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                side: MaterialStateProperty.all(
                    BorderSide(width: 3.0, color: Colors.black12)),
                backgroundColor: MaterialStateProperty.all(
                  Color.fromARGB(255, 240, 61, 61),
                ),
                foregroundColor: MaterialStateProperty.all(Colors.white),
                padding: MaterialStateProperty.all(
                  EdgeInsets.all(15),
                ),
              ),
              onPressed: () => {},
              icon: Icon(Icons.camera_alt_outlined),
              label: Text(
                'Plasma On Instagram',
                style: TextStyle(fontSize: 22.0),
              )),
          const SizedBox(
            height: 20.0,
          ),
          OutlinedButton.icon(
            style: ButtonStyle(
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20))),
              side: MaterialStateProperty.all(
                  BorderSide(width: 3.0, color: Colors.black12)),
              backgroundColor: MaterialStateProperty.all(Colors.amber),
              foregroundColor: MaterialStateProperty.all(Colors.white),
              padding: MaterialStateProperty.all(
                EdgeInsets.all(15),
              ),
            ),
            onPressed: () => {},
            icon: Icon(Icons.integration_instructions_outlined),
            label: Text(
              'plasma.mohp.gov.eg',
              style: TextStyle(fontSize: 22.0),
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          OutlinedButton.icon(
            style: ButtonStyle(
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              side: MaterialStateProperty.all(
                BorderSide(width: 3.0, color: Colors.black12),
              ),
              backgroundColor: MaterialStateProperty.all(
                Color.fromARGB(255, 95, 216, 47),
              ),
              foregroundColor: MaterialStateProperty.all(Colors.white),
              padding: MaterialStateProperty.all(
                EdgeInsets.all(15),
              ),
            ),
            onPressed: () => {},
            icon: Icon(Icons.phone),
            label: Text(
              'Call Hot Line (15335)',
              style: TextStyle(fontSize: 22.0),
            ),
          ),
        ],
      ),
    );
  }
}

class ContactUsLandscape extends StatelessWidget {
  const ContactUsLandscape({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(
            image: AssetImage('images/contact.png'),
            width: 220,
          ),
          const SizedBox(
            width: 80.0,
          ),
          FittedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                OutlinedButton.icon(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    side: MaterialStateProperty.all(
                        BorderSide(width: 3.0, color: Colors.black12)),
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                    padding: MaterialStateProperty.all(
                      EdgeInsets.all(15),
                    ),
                  ),
                  onPressed: () => {},
                  icon: Icon(Icons.facebook),
                  label: Text(
                    'Plasma On Facebook',
                    style: TextStyle(fontSize: 22.0),
                  ),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                OutlinedButton.icon(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      side: MaterialStateProperty.all(
                          BorderSide(width: 3.0, color: Colors.black12)),
                      backgroundColor: MaterialStateProperty.all(
                        Color.fromARGB(255, 240, 61, 61),
                      ),
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                      padding: MaterialStateProperty.all(
                        EdgeInsets.all(15),
                      ),
                    ),
                    onPressed: () => {},
                    icon: Icon(Icons.camera_alt_outlined),
                    label: Text(
                      'Plasma On Instagram',
                      style: TextStyle(fontSize: 22.0),
                    )),
                const SizedBox(
                  height: 15.0,
                ),
                OutlinedButton.icon(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
                    side: MaterialStateProperty.all(
                        BorderSide(width: 3.0, color: Colors.black12)),
                    backgroundColor: MaterialStateProperty.all(Colors.amber),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                    padding: MaterialStateProperty.all(
                      EdgeInsets.all(15),
                    ),
                  ),
                  onPressed: () => {},
                  icon: Icon(Icons.integration_instructions_outlined),
                  label: Text(
                    'plasma.mohp.gov.eg',
                    style: TextStyle(fontSize: 22.0),
                  ),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                OutlinedButton.icon(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    side: MaterialStateProperty.all(
                        BorderSide(width: 3.0, color: Colors.black12)),
                    backgroundColor:
                        MaterialStateProperty.all(Color.fromARGB(255, 95, 216, 47)),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                    padding: MaterialStateProperty.all(
                      EdgeInsets.all(15),
                    ),
                  ),
                  onPressed: () => {},
                  icon: Icon(Icons.phone),
                  label: Text(
                    'Call Hot Line (15335)',
                    style: TextStyle(fontSize: 22.0),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
