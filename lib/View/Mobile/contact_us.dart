import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Utils/utils.dart';
import '../Widgets/mobile_custom_drawer.dart';
import '../Widgets/translated_text_widget.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Utils.confirmExit(context),
      child: Scaffold(
        appBar: AppBar(
          //backgroundColor: Colors.amber,
          foregroundColor: Color.fromARGB(255, 255, 255, 255),
          title: TranslatedTextWidget(
            text: "Contact Us",
            // style: TextStyle(
            //   fontSize: 25.0,
            // ),
          ),
          elevation: 0.0,
        ),
        drawer: const MobileCustomDrawer(
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
      ),
    );
  }
}

class ContactUsPortrait extends StatelessWidget {
  const ContactUsPortrait({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Wrap(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: AssetImage('assets/images/contact.png'),
                  width: 220,
                ),
                const SizedBox(
                  height: 20.0,
                ),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
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
                    onPressed: () async {
                      if (!await launchUrl(
                        Uri.parse('https://www.facebook.com/DonatePlasmaEG'),
                        mode: LaunchMode.externalApplication,
                      )) Utils.showUrlLaunchingError(context);
                    },
                    icon: Icon(Icons.facebook),
                    label: TranslatedTextWidget(
                      text: 'Plasma On Facebook',
                      style: TextStyle(fontSize: 22.0),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
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
                      onPressed: () async {
                        if (!await launchUrl(
                          Uri.parse('https://www.instagram.com/DonateplasmaEg'),
                          mode: LaunchMode.externalApplication,
                        )) Utils.showUrlLaunchingError(context);
                      },
                      icon: FaIcon(FontAwesomeIcons.instagram),
                      label: TranslatedTextWidget(
                        text: 'Plasma On Instagram',
                        style: TextStyle(fontSize: 22.0),
                      )),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
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
                    onPressed: () async {
                      if (!await launchUrl(
                        Uri.parse('http://plasma.mohp.gov.eg/'),
                        mode: LaunchMode.externalApplication,
                      )) Utils.showUrlLaunchingError(context);
                    },
                    icon: Icon(Icons.integration_instructions_outlined),
                    label: Text(
                      'plasma.mohp.gov.eg',
                      style: TextStyle(fontSize: 22.0),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
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
                    onPressed: () async {
                      if (!await launchUrl(
                        Uri(scheme: 'tel', path: '15335'),
                      )) Utils.showUrlLaunchingError(context);
                    },
                    icon: Icon(Icons.phone),
                    label: TranslatedTextWidget(
                      text: 'Call Hot Line (15335)',
                      style: TextStyle(fontSize: 22.0),
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

class ContactUsLandscape extends StatelessWidget {
  const ContactUsLandscape({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Wrap(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image(
                image: AssetImage('assets/images/contact.png'),
                width: 220,
              ),
              const SizedBox(
                width: 80.0,
              ),
              IntrinsicWidth(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      //width: double.infinity,
                      height: 70,
                      child: FittedBox(
                        child: OutlinedButton.icon(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            side: MaterialStateProperty.all(
                                BorderSide(width: 3.0, color: Colors.black12)),
                            backgroundColor: MaterialStateProperty.all(Colors.blue),
                            foregroundColor:
                                MaterialStateProperty.all(Colors.white),
                            padding: MaterialStateProperty.all(
                              EdgeInsets.all(15),
                            ),
                          ),
                          onPressed: () async {
                            if (!await launchUrl(
                              Uri.parse('https://www.facebook.com/DonatePlasmaEG'),
                              mode: LaunchMode.externalApplication,
                            )) Utils.showUrlLaunchingError(context);
                          },
                          icon: Icon(Icons.facebook),
                          label: TranslatedTextWidget(
                            text: 'Plasma On Facebook',
                            style: TextStyle(fontSize: 22.0),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    SizedBox(
                      //width: double.infinity,
                      height: 60,
                      child: FittedBox(
                        child: OutlinedButton.icon(
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
                              foregroundColor:
                                  MaterialStateProperty.all(Colors.white),
                              padding: MaterialStateProperty.all(
                                EdgeInsets.all(15),
                              ),
                            ),
                            onPressed: () async {
                              if (!await launchUrl(
                                Uri.parse('https://www.instagram.com/DonateplasmaEg'),
                                mode: LaunchMode.externalApplication,
                              )) Utils.showUrlLaunchingError(context);
                            },
                            icon: FaIcon(FontAwesomeIcons.instagram),
                            label: TranslatedTextWidget(
                              text: 'Plasma On Instagram',
                              style: TextStyle(fontSize: 22.0),
                            )),
                      ),
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: FittedBox(
                        child: OutlinedButton.icon(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20))),
                            side: MaterialStateProperty.all(
                                BorderSide(width: 3.0, color: Colors.black12)),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.amber),
                            foregroundColor:
                                MaterialStateProperty.all(Colors.white),
                            padding: MaterialStateProperty.all(
                              EdgeInsets.all(15),
                            ),
                          ),
                          onPressed: () async {
                            if (!await launchUrl(
                              Uri.parse('http://plasma.mohp.gov.eg/'),
                              mode: LaunchMode.externalApplication,
                            )) Utils.showUrlLaunchingError(context);
                          },
                          icon: Icon(Icons.integration_instructions_outlined),
                          label: Text(
                            'plasma.mohp.gov.eg',
                            style: TextStyle(fontSize: 22.0),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: FittedBox(
                        child: OutlinedButton.icon(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            side: MaterialStateProperty.all(
                                BorderSide(width: 3.0, color: Colors.black12)),
                            backgroundColor: MaterialStateProperty.all(
                                Color.fromARGB(255, 95, 216, 47)),
                            foregroundColor:
                                MaterialStateProperty.all(Colors.white),
                            padding: MaterialStateProperty.all(
                              EdgeInsets.all(15),
                            ),
                          ),
                          onPressed: () async {
                            if (!await launchUrl(
                              Uri(scheme: 'tel', path: '15335'),
                            )) Utils.showUrlLaunchingError(context);
                          },
                          icon: Icon(Icons.phone),
                          label: TranslatedTextWidget(
                            text: 'Call Hot Line (15335)',
                            style: TextStyle(fontSize: 22.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
