import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var emailController = TextEditingController();

  var passController = TextEditingController();
  var confirmController = TextEditingController();

  bool obscurePasswordText = true;
  bool obscureConfirmText = true;

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            //to make scroll
            child: Container(
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 10.0,
                    ),
                    const Text(
                      'Registration',
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 40.0),
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      onFieldSubmitted: (value) {
                        print(value);
                      },
                      onChanged: (value) {
                        print(value);
                      },
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'empty';
                        }
                      },
                      decoration: const InputDecoration(
                        labelText: 'Enter your Name',
                        prefixIcon: Icon(
                          Icons.person,
                        ),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(
                      height: 25.0,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      onFieldSubmitted: (value) {
                        print(value);
                      },
                      onChanged: (value) {
                        print(value);
                      },
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'empty';
                        }
                      },
                      decoration: const InputDecoration(
                        labelText: 'Enter your phone number',
                        prefixIcon: Icon(
                          Icons.phone,
                        ),
                        border: OutlineInputBorder(),
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
                          return 'empty';
                        }
                        if (!value.contains('@')) {
                          return 'it is not a valid email address ';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Enter your Email Address',
                        prefixIcon: Icon(
                          Icons.mail,
                        ),
                        border: OutlineInputBorder(),
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
                          return 'empty';
                        }
                        if (value.length < 8) {
                          return 'password length must contain at least 8 characters';
                        }
                        return null;
                      },
                      obscureText: obscurePasswordText,
                      decoration: InputDecoration(
                        labelText: 'Password',
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
                          return 'empty';
                        }
                        if (value != passController.text) {
                          return 'write the same password to confirm';
                        }
                        return null;
                      },
                      obscureText: obscureConfirmText,
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
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
                      height: 50.0,
                    ),
                    Container(
                      color: Colors.amber,
                      height: 40.0,
                      width: double.infinity,
                      child: MaterialButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            FocusScope.of(context).unfocus();
                          }
                          // print(emailcontroller.text);
                          // print(passcontroller.text);
                        },
                        child: const Text(
                          'Register Now',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
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
