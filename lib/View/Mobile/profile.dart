import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:plasma/Utils/auth.dart';
import 'package:plasma/Utils/files_api.dart';
import 'package:plasma/View/Mobile/login.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../Utils/utils.dart';
import '../Widgets/custom_text_field.dart';
import '../Widgets/translated_text_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isBloodTypeGranted = AuthHelper.currentUser?.bloodType != null &&
      AuthHelper.currentUser?.bloodType != "";

  final GlobalKey repaintBoundaryKey = GlobalKey();

  final TextEditingController phoneController =
      TextEditingController(text: '${AuthHelper.currentUser?.phone}');
  final TextEditingController emailController =
      TextEditingController(text: '${AuthHelper.currentUser?.email}');
  final TextEditingController bloodTypeController =
      TextEditingController(text: '${AuthHelper.currentUser?.bloodType}');
  final String qrData =
      'plasma-donor-data:${AuthHelper.currentUser?.firstName} ${AuthHelper.currentUser?.lastName};${AuthHelper.currentUser?.nationalId};${AuthHelper.currentUser?.bloodType}';

  @override
  void dispose() {
    phoneController.dispose();
    emailController.dispose();
    bloodTypeController.dispose();
    super.dispose();
  }

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
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(25),
                    ),
                  ),
                  context: context,
                  builder: (context) => SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Icon(
                          //   Icons.horizontal_rule_rounded,
                          //   size: 68,
                          //   color: Colors.grey.shade600.withOpacity(0.3),
                          // ),
                          //const Divider(),
                          RepaintBoundary(
                            key: repaintBoundaryKey,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 15),
                              width: 280,
                              height: 320,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Theme.of(context).scaffoldBackgroundColor,
                                ),
                                child: FittedBox(
                                  child: Column(
                                    children: [
                                      CircleAvatar(
                                        child: CircleAvatar(
                                          foregroundImage: AuthHelper.currentUser?.image != null && AuthHelper.currentUser?.image != ""?CachedNetworkImageProvider(
                                            '${AuthHelper.currentUser?.image}',
                                            cacheKey: '${AuthHelper.currentUser?.image}',
                                          ): null,
                                          radius: 32,
                                          child: Icon(Icons.person,color: Colors.white,size: 48,),
                                          backgroundColor: Theme.of(context).primaryColor,
                                        ),
                                        radius: 34,
                                        backgroundColor: Colors.white,
                                      ),
                                      const SizedBox(height: 20,),
                                      Text(
                                        '${AuthHelper.currentUser?.firstName} ${AuthHelper.currentUser?.lastName}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w600, fontSize: 20),
                                      ),
                                      const SizedBox(
                                        height: 18,
                                      ),
                                      QrImage(
                                        size: 172,
                                        data: qrData,
                                        padding: const EdgeInsets.all(12),
                                        backgroundColor: Colors.white,
                                        eyeStyle: QrEyeStyle(eyeShape: QrEyeShape.circle),
                                        //foregroundColor: Theme.of(context).primaryColor,
                                        //foregroundColor: Colors.black87,
                                        foregroundColor: Colors.black,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // const SizedBox(
                          //   height: 25,
                          // ),
                          TextButton.icon(
                            onPressed: () async {
                              await FilesApi.shareImage(
                                  repaintBoundaryKey, qrData);
                              Navigator.pop(context);
                            },
                            // style:
                            //     TextButton.styleFrom(primary: Colors.blueAccent),
                            label: TranslatedTextWidget(
                              text: 'Share My Code',
                            ),
                            icon: Icon(Icons.adaptive.share),
                          ),
                          TextButton.icon(
                            onPressed: () async {
                              await FilesApi.saveImageToGallery(
                                  context, repaintBoundaryKey, qrData);
                              Navigator.pop(context);
                            },
                            //style: TextButton.styleFrom(primary: Colors.teal),
                            label: TranslatedTextWidget(
                              text: 'Save To Gallery',
                            ),
                            icon: const Icon(Icons.save_alt_rounded),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              icon: const Icon(
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
                AuthHelper.currentUser?.image != null &&
                        AuthHelper.currentUser?.image != ""
                    ? Transform.scale(
                        scale: 0.8,
                        child: CircleAvatar(
                          radius: 80,
                          backgroundColor: Colors.transparent,
                          backgroundImage: CachedNetworkImageProvider(
                            '${AuthHelper.currentUser?.image}',
                            cacheKey: '${AuthHelper.currentUser?.image}',
                          ),
                        ),
                      )
                    : Icon(
                        Icons.account_circle,
                        size: 140,
                        color: Theme.of(context).primaryColor,
                      ),
                Text(
                  '${AuthHelper.currentUser?.firstName} ${AuthHelper.currentUser?.lastName}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 25),
                ),
                SizedBox(
                  height: height * .1,
                ),
                CustomTextField(
                  controller: phoneController,
                  hint: 'Phone Number',
                  icon: const Icon(Icons.phone_android_outlined),
                  isEditable: true,
                  readOnly: true,
                ),
                SizedBox(
                  height: height * .02,
                ),
                CustomTextField(
                  controller: emailController,
                  hint: 'Mail',
                  icon: const Icon(Icons.email_outlined),
                  isEditable: true,
                  readOnly: true,
                ),
                SizedBox(
                  height: height * .02,
                ),
                if (isBloodTypeGranted)
                  CustomTextField(
                    controller: bloodTypeController,
                    hint: 'Blood Type',
                    icon: const Icon(Icons.bloodtype_outlined),
                    readOnly: true,
                  ),
                SizedBox(
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
                    // showDialog(
                    //   context: context,
                    //   barrierDismissible: false,
                    //   builder: (context) => WillPopScope(
                    //     onWillPop: () async {
                    //       return false;
                    //     },
                    //     child: AlertDialog(
                    //       backgroundColor: Colors.transparent,
                    //       elevation: 0,
                    //       content: Container(
                    //         padding: const EdgeInsets.all(50),
                    //         decoration: BoxDecoration(
                    //           color: Theme.of(context).scaffoldBackgroundColor,
                    //           borderRadius: BorderRadius.circular(25),
                    //         ),
                    //         child: Row(
                    //           mainAxisSize: MainAxisSize.min,
                    //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //           children: const [
                    //             BloodLoadingIndicator(),
                    //             const SizedBox(
                    //               width: 32,
                    //             ),
                    //             Text(
                    //               'Logging Out...',
                    //               style: const TextStyle(
                    //                 fontWeight: FontWeight.bold,
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // );
                    Utils.showBloodLoadingDialog(
                      context,
                      text: 'Logging Out...',
                    );
                    bool success = await AuthHelper.logOut();
                    Navigator.pop(context);
                    if (success) {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      );
                    }
                  },
                  icon: const Icon(
                    Icons.logout,
                    color: Colors.white,
                  ),
                  label: TranslatedTextWidget(
                    text: 'Log Out',
                    style: const TextStyle(color: Colors.white),
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
