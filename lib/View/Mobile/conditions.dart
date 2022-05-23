import 'package:flutter/material.dart';

import '../../Utils/utils.dart';
import '../Widgets/mobile_custom_drawer.dart';
import '../Widgets/translated_text_widget.dart';

class ConditionsScreen extends StatelessWidget {
  const ConditionsScreen({Key? key}): super(key: key);
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
          screenIndex: 3,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 40.0),
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
                          'assets/images/avatar.png',
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      TranslatedTextWidget(
                        text: 'Conditions For Donating Blood Plasma',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 15.0,
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
                    text: 'The Permissible Age Ranges From 18 To 60.',
                    style: const TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 20.0,
                    ),
                  ),
                  leading: const Icon(
                    Icons.paste_sharp,
                  ),
                ),
                Divider(
                  indent: 50,
                  endIndent: 50,
                  thickness: 2,
                  color: Theme.of(context).primaryColor,
                ),
                ListTile(
                  title: TranslatedTextWidget(
                    text: 'Weight more than 50 kg.',
                    style: const TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 20.0,
                    ),
                  ),
                  leading: const Icon(
                    Icons.paste_sharp,
                  ),
                ),
                Divider(
                  indent: 50,
                  endIndent: 50,
                  thickness: 2,
                  color: Theme.of(context).primaryColor,
                ),
                ListTile(
                  title: TranslatedTextWidget(
                    text: 'Blood pressure must be regular.',
                    style: const TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 20.0,
                    ),
                  ),
                  leading: const Icon(
                    Icons.paste_sharp,
                  ),
                ),
                Divider(
                  indent: 50,
                  endIndent: 50,
                  thickness: 2,
                  color: Theme.of(context).primaryColor,
                ),
                ListTile(
                  title: TranslatedTextWidget(
                    text: 'If the donor has diabetes, he should not take insulin.',
                    style: const TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 20.0,
                    ),
                  ),
                  leading: const Icon(
                    Icons.paste_sharp,
                  ),
                ),
                Divider(
                  indent: 50,
                  endIndent: 50,
                  thickness: 2,
                  color: Theme.of(context).primaryColor,
                ),
                ListTile(
                  title: TranslatedTextWidget(
                    text: 'He does not suffer from any health problems in the heart, liver, kidneys or thyroid gland.',
                    style: const TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 20.0,
                    ),
                  ),
                  leading: const Icon(
                    Icons.paste_sharp,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  height: 70.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      30.0,
                    ),
                    color: Theme.of(context).primaryColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TranslatedTextWidget(
                      text: 'The donor is examined and carefully examined to ensure that his health condition is suitable for plasma donation',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 15.0,
                      ),
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
}
