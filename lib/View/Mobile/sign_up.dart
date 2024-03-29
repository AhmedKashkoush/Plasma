import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plasma/Utils/files_api.dart';
import 'package:plasma/View/Mobile/login.dart';
import 'package:plasma/ViewModel/authentication_view_model.dart';
import 'package:provider/provider.dart';

import '../../Model/Models/user_model.dart';
import '../../Utils/utils.dart';
import '../Widgets/translated_text_widget.dart';

// class SignUpPage extends StatelessWidget {
//   const SignUpPage({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (context) => AuthenticationViewModel(),
//       child: const SignUpScreen(),
//     );
//   }
// }

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController fNameController = TextEditingController();
  final TextEditingController lNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController nationalIDController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();
  String? gender;

  bool obscurePasswordText = true;
  bool obscureConfirmText = true;

  final String phoneRegex = r'(^(?:[+0]9)?[0-9]{10,12}$)';
  final String emailRegex =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
  final String passwordRegex =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final double alignment = 15;

  File? imageFile;

  @override
  void dispose() {
    fNameController.dispose();
    lNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passController.dispose();
    nationalIDController.dispose();
    confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isLTR = Directionality.of(context) == TextDirection.ltr;
    final AuthenticationViewModel _authVM =
        Provider.of<AuthenticationViewModel>(context);
    return WillPopScope(
      onWillPop: () => Utils.confirmExit(context),
      child: Scaffold(
        body: SingleChildScrollView(
          //to make scroll
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 40.0,
                  ),
                  TranslatedTextWidget(
                    text: 'Registration',
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 40.0,
                    ),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  Row(
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          if (imageFile != null)
                            CircleAvatar(
                              radius: 50,
                              backgroundColor: Theme.of(context).primaryColor,
                              backgroundImage: FileImage(imageFile!),
                            )
                          else
                            CircleAvatar(
                              radius: 50,
                              backgroundColor: Theme.of(context).primaryColor,
                              backgroundImage: const AssetImage(
                                'assets/images/user.png',
                              ),
                            ),
                          isLTR
                              ? Positioned(
                                  right: -alignment,
                                  bottom: -alignment,
                                  child: ElevatedButton(
                                    onPressed:
                                        _showPhotoTypeSelectionBottomSheet,
                                    child: Icon(Icons.camera_alt_rounded),
                                    style: ElevatedButton.styleFrom(
                                      shape: const CircleBorder(),
                                      primary: Theme.of(context)
                                          .primaryColor
                                          .withOpacity(0.3),
                                    ),
                                  ),
                                )
                              : Positioned(
                                  left: -alignment,
                                  bottom: -alignment,
                                  child: ElevatedButton(
                                    onPressed:
                                        _showPhotoTypeSelectionBottomSheet,
                                    child: Icon(Icons.camera_alt_rounded),
                                    style: ElevatedButton.styleFrom(
                                      shape: const CircleBorder(),
                                      primary: Theme.of(context)
                                          .primaryColor
                                          .withOpacity(0.3),
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  TextFormField(
                    controller: fNameController,
                    keyboardType: TextInputType.text,
                    onFieldSubmitted: (value) {
                      print(value);
                    },
                    onChanged: (value) {
                      print(value);
                    },
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return TranslatedTextWidget.translate('Required Field');
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: TranslatedTextWidget.translate(
                          'Enter your First Name'),
                      prefixIcon: const Icon(
                        Icons.person,
                      ),
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  TextFormField(
                    controller: lNameController,
                    keyboardType: TextInputType.text,
                    onFieldSubmitted: (value) {
                      print(value);
                    },
                    onChanged: (value) {
                      print(value);
                    },
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return TranslatedTextWidget.translate('Required Field');
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: TranslatedTextWidget.translate(
                          'Enter your Last Name'),
                      prefixIcon: const Icon(
                        Icons.person,
                      ),
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  DropdownButtonFormField<String>(
                    items: [
                      DropdownMenuItem<String>(
                        child: TranslatedTextWidget(
                          text: 'Male',
                        ),
                        value: 'male',
                      ),
                      DropdownMenuItem<String>(
                        child: TranslatedTextWidget(
                          text: 'Female',
                        ),
                        value: 'female',
                      ),
                    ],
                    validator: (value) {
                      if (value == null) {
                        return TranslatedTextWidget.translate('Required Field');
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        gender = value;
                      });
                    },
                    hint: TranslatedTextWidget(
                      text: 'Gender',
                    ),
                    decoration: InputDecoration(
                      prefixIcon: gender == 'male'
                          ? const Icon(Icons.male)
                          : gender == 'female'
                              ? const Icon(Icons.female)
                              : SizedBox(
                                  width: 16,
                                  child: Center(
                                    child: const FaIcon(
                                      FontAwesomeIcons.genderless,
                                    ),
                                  ),
                                ),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  TextFormField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    onFieldSubmitted: (value) {
                      print(value);
                    },
                    onChanged: (value) {
                      print(value);
                    },
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return TranslatedTextWidget.translate('Required Field');
                      }
                      final RegExp exp = RegExp(phoneRegex);
                      if (!exp.hasMatch(value))
                        return TranslatedTextWidget.translate(
                            'It is not a valid phone number');
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: TranslatedTextWidget.translate(
                          'Enter your phone number'),
                      prefixIcon: const Icon(
                        Icons.phone,
                      ),
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    onFieldSubmitted: (value) {
                      print(value);
                    },
                    onChanged: (value) {
                      print(value);
                    },
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return TranslatedTextWidget.translate('Required Field');
                      }
                      // if (!value.contains('@')) {
                      //   return TranslatedTextWidget.translate(
                      //       'It is not a valid email address');
                      // }
                      final RegExp exp = RegExp(emailRegex);
                      if (!exp.hasMatch(value))
                        return TranslatedTextWidget.translate(
                            'It is not a valid email address');
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: TranslatedTextWidget.translate(
                          'Enter your Email Address'),
                      prefixIcon: const Icon(
                        Icons.mail,
                      ),
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  TextFormField(
                    controller: passController,
                    keyboardType: TextInputType.visiblePassword,
                    onFieldSubmitted: (value) {
                      print(value);
                    },
                    onChanged: (value) {
                      print(value);
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return TranslatedTextWidget.translate('Required Field');
                      }
                      if (value.length < 8) {
                        return TranslatedTextWidget.translate(
                            'Password must contain at least 8 characters');
                      }
                      final RegExp exp = RegExp(passwordRegex);
                      if (!exp.hasMatch(value))
                        return TranslatedTextWidget.translate(
                            'It is not a valid password');
                      return null;
                    },
                    obscureText: obscurePasswordText,
                    decoration: InputDecoration(
                      labelText: TranslatedTextWidget.translate('Password'),
                      prefixIcon: const Icon(
                        Icons.lock,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          obscurePasswordText
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            obscurePasswordText = !obscurePasswordText;
                          });
                        },
                      ),
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  TextFormField(
                    controller: confirmController,
                    keyboardType: TextInputType.visiblePassword,
                    onFieldSubmitted: (value) {
                      print(value);
                    },
                    onChanged: (value) {
                      print(value);
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return TranslatedTextWidget.translate('Required Field');
                      }
                      if (value != passController.text) {
                        return TranslatedTextWidget.translate(
                            'Write the same password to confirm');
                      }
                      return null;
                    },
                    obscureText: obscureConfirmText,
                    decoration: InputDecoration(
                      labelText:
                          TranslatedTextWidget.translate('Confirm Password'),
                      prefixIcon: const Icon(
                        Icons.password,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          obscureConfirmText
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            obscureConfirmText = !obscureConfirmText;
                          });
                        },
                      ),
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  TextFormField(
                    controller: nationalIDController,
                    keyboardType: TextInputType.number,
                    onFieldSubmitted: (value) {
                      print(value);
                    },
                    onChanged: (value) {
                      print(value);
                    },
                    maxLength: 14,
                    validator: (String? value) {
                      if (value!.isNotEmpty && value.length < 14)
                        return TranslatedTextWidget.translate(
                            'National ID must be 14 numbers');
                      if (value.isEmpty) {
                        return TranslatedTextWidget.translate('Required Field');
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: TranslatedTextWidget.translate(
                          'Enter your National ID'),
                      prefixIcon: const Icon(
                        Icons.perm_identity_rounded,
                      ),
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 50.0,
                  ),
                  Container(
                    color: Theme.of(context)
                        .primaryColor
                        .withOpacity(_authVM.isLoading ? 0.2 : 1),
                    height: 50.0,
                    width: double.infinity,
                    child: MaterialButton(
                      onPressed: _authVM.isLoading
                          ? null
                          : () async {
                              if (formKey.currentState!.validate()) {
                                FocusScope.of(context).unfocus();
                                final UserModel userModel = UserModel(
                                  firstName: fNameController.text,
                                  lastName: lNameController.text,
                                  gender: gender!,
                                  phone: phoneController.text,
                                  email: emailController.text,
                                  password: passController.text,
                                  nationalId: nationalIDController.text,
                                );
                                UserCredential? createdUser =
                                    await _authVM.createNewUser(
                                        userModel, context, imageFile);
                                if (createdUser != null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: Colors.green,
                                      padding: const EdgeInsets.all(0),
                                      content: ListTile(
                                        leading: Icon(
                                          Icons.check,
                                          color: Colors.white,
                                        ),
                                        title: TranslatedTextWidget(
                                          text: 'Account was created successfully',
                                          style: const TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (context) => const LoginScreen(),
                                    ),
                                  );
                                }
                              }
                              // print(emailcontroller.text);
                              // print(passcontroller.text);
                            },
                      child: _authVM.isLoading
                          ? const Center(
                              child: SizedBox(
                                width: 35,
                                height: 35,
                                child: CircularProgressIndicator(),
                              ),
                            )
                          : TranslatedTextWidget(
                              text: 'Register Now',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TranslatedTextWidget(
                          text: 'You Already Have An Account?'),
                      TextButton(
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ),
                          );
                        },
                        child: TranslatedTextWidget(
                          text: 'Login',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Future<void> _takePhoto(ImageSource source) async {
  //   XFile? pickedFile = await ImagePicker().pickImage(source: source);
  //   if (pickedFile == null) return;
  //   setState(() {
  //     imageFile = File(pickedFile!.path);
  //   });
  // }

  void _showPhotoTypeSelectionBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TranslatedTextWidget(
              text: 'Pick up from',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            const SizedBox(
              height: 25,
            ),
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: TranslatedTextWidget(text: 'Camera'),
              onTap: () async {
                imageFile = await FilesApi.takePhoto(ImageSource.camera);
                if (imageFile != null) setState(() {});
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.image),
              title: TranslatedTextWidget(text: 'Gallery'),
              onTap: () async {
                imageFile = await FilesApi.takePhoto(ImageSource.gallery);
                if (imageFile != null) setState(() {});
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
