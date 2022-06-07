import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plasma/View/Mobile/forget_password.dart';
import 'package:plasma/View/Mobile/sign_up.dart';
import 'package:plasma/ViewModel/authentication_view_model.dart';
import 'package:provider/provider.dart';

import '../../Utils/utils.dart';
import '../Widgets/translated_text_widget.dart';
import 'main_screen.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthenticationViewModel(),
      child: const LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();

  var passController = TextEditingController();

  bool obscureText = true;

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final AuthenticationViewModel _authVM =
    Provider.of<AuthenticationViewModel>(context);
    return WillPopScope(
      onWillPop: () => Utils.confirmExit(context),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: SingleChildScrollView(
              //to make scroll
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Image(
                      image: AssetImage(
                        'assets/images/plasma_img.png',
                      ),
                      width: 100.0,
                      height: 100.0,
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    TranslatedTextWidget(
                      text: 'Welcome To Plasma',
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 36.0,
                      ),
                    ),
                    const SizedBox(
                      height: 30.0,
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
                          return TranslatedTextWidget.translate(
                              'Required Field');
                        }
                        if (!value.contains('@')) {
                          return TranslatedTextWidget.translate(
                            'It is not a valid email address',
                          );
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText:
                            TranslatedTextWidget.translate('Email Address'),
                        prefixIcon: const Icon(
                          Icons.mail,
                        ),
                        border: const OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(
                      height: 15.0,
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
                          return TranslatedTextWidget.translate(
                              'Required Field');
                        }
                        return null;
                      },
                      obscureText: obscureText,
                      decoration: InputDecoration(
                        labelText: TranslatedTextWidget.translate('Password'),
                        prefixIcon: const Icon(
                          Icons.lock,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            obscureText
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              obscureText = !obscureText;
                            });
                          },
                        ),
                        border: const OutlineInputBorder(),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TextButton(
                          onPressed: () =>
                              Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => ForgetPasswordScreen(),
                            ),
                          ),
                          child: TranslatedTextWidget(
                            text: 'Forgot Password..?',
                          ),
                        ),
                      ],
                    ),
                    Container(
                      color: Theme.of(context).primaryColor.withOpacity(_authVM.isLoading? 0.2:1),
                      height: 50.0,
                      width: double.infinity,
                      child: MaterialButton(
                        onPressed: _authVM.isLoading
                            ? null
                            : () async{
                          if (formKey.currentState!.validate()) {
                            FocusScope.of(context).unfocus();
                            UserCredential? user = await _authVM.logIn(context,emailController.text,passController.text);
                            if (user != null) {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => const MainScreen(),
                                ),
                              );
                            }
                          }
                        },
                        child: _authVM.isLoading
                            ? const Center(
                          child: SizedBox(width:35,height: 35,child: CircularProgressIndicator()),
                        )
                            : TranslatedTextWidget(
                          text: 'Login',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TranslatedTextWidget(text: 'Don\'t Have An Account?'),
                        TextButton(
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignUpPage(),
                              ),
                            );
                          },
                          child: TranslatedTextWidget(
                            text: 'Register Now',
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
      ),
    );
  }
}
