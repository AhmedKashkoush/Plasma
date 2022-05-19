import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plasma/View/Mobile/login.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../Widgets/blood_loading.dart';
import '../Widgets/custom_text_field.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  static bool isBloodTypeGranted = false;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () {
                showModalBottomSheet(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(25),
                    ),
                  ),
                  context: context,
                  builder: (context) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.horizontal_rule_rounded,
                          size: 68,
                          color: Colors.grey.shade600.withOpacity(0.3),
                        ),
                        const Divider(),
                        QrImage(
                          size: 172,
                          data: 'Test QR Code View In The Application',
                          padding: const EdgeInsets.all(12),
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black87,
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        TextButton.icon(
                          onPressed: () {},
                          style: TextButton.styleFrom(primary: Colors.blueAccent),
                          label: Text('Share My Code'),
                          icon: Icon(Icons.adaptive.share),
                        ),
                        TextButton.icon(
                          onPressed: () {},
                          style: TextButton.styleFrom(primary: Colors.teal),
                          label: Text('Save To Gallery'),
                          icon: Icon(Icons.save_alt_rounded),
                        ),
                      ],
                    ),
                  ),
                );
              },
              icon: Icon(
                Icons.qr_code_rounded,
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 20, right: 10, left: 10),
              child: Column(children: [
                Icon(
                  Icons.account_circle,
                  size: 140,
                  color: Theme.of(context).primaryColor,
                ),
                Text(
                  'Username',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
                SizedBox(
                  height: height * .1,
                ),
                CustomTextField(
                  hint: 'Phone Number',
                  icon: Icon(Icons.phone_android_outlined),
                  isEditable: true,
                  readOnly: true,
                ),
                SizedBox(
                  height: height * .02,
                ),
                CustomTextField(
                  hint: 'Mail',
                  icon: Icon(Icons.email_outlined),
                  isEditable: true,
                  readOnly: true,
                ),
                SizedBox(
                  height: height * .02,
                ),
                if (isBloodTypeGranted) CustomTextField(
                  hint: 'Blood Type',
                  icon: Icon(Icons.bloodtype_outlined),
                  readOnly: true,
                ),
                if (isBloodTypeGranted) SizedBox(
                  height: height * .1,
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () async {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) => WillPopScope(
                        onWillPop: () async {
                          return false;
                        },
                        child: AlertDialog(
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                          content: Container(
                            padding: const EdgeInsets.all(50),
                            decoration: BoxDecoration(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: const [
                                BloodLoadingIndicator(),
                                const SizedBox(
                                  width: 32,
                                ),
                                Text(
                                  'Logging Out...',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                    await Future.delayed(const Duration(seconds: 3), () {
                      Navigator.pop(context);
                    });
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.logout,
                    color: Colors.white,
                  ),
                  label: Text(
                    'Logout',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}