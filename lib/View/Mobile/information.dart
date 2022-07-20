import 'package:flutter/material.dart';

import '../../Utils/utils.dart';
import '../Widgets/mobile_custom_drawer.dart';
import '../Widgets/translated_text_widget.dart';

class PlasmaInformationScreen extends StatelessWidget {
  const PlasmaInformationScreen({Key? key}): super(key: key);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Utils.confirmExit(context),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        drawer: const MobileCustomDrawer(
          screenIndex: 1,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Container(
                  height: 60.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      30.0,
                    ),
                    color: Theme.of(context).primaryColor,
                  ),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        backgroundColor: Color.fromARGB(255, 204, 194, 194),
                        radius: 30,
                        backgroundImage: AssetImage(
                          'assets/images/Properties.png',
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      TranslatedTextWidget(
                        text: 'What is blood plasma?',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 17.0,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                ListTile(
                  title: TranslatedTextWidget(
                    text: 'Plasma is the main source for the manufacture of derivatives such as clotting factors, which is the only treatment for patients with chronic bleeding, such as "hemophilia".',
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 20.0,
                    ),
                  ),
                  // leading: Icon(
                  //   Icons.list,
                  // ),
                ),
                Divider(
                  indent: 35,
                  endIndent: 35,
                  thickness: 2,
                  color: Theme.of(context).primaryColor,
                ),
                ListTile(
                  title: TranslatedTextWidget(
                    text: 'Blood plasma is made from proteins that are important for the treatment of inflammatory patients, liver cancers and kidney patients.',
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 20.0,
                    ),
                  ),
                  // leading: Icon(
                  //   Icons.list,
                  // ),
                ),
                Divider(
                  indent: 35,
                  endIndent: 35,
                  thickness: 2,
                  color: Theme.of(context).primaryColor,
                ),
                ListTile(
                  title: TranslatedTextWidget(
                    text: 'Plasma consists of 92% water and 8% blood plasma proteins.',
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 20.0,
                    ),
                  ),
                  // leading: Icon(
                  //   Icons.list,
                  // ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
