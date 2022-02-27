import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class login extends StatefulWidget {
  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  var emailcontroller = TextEditingController();

  var passcontroller = TextEditingController();

  bool obscureText = true;

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
                    Container(
                      child: const Image(
                        image: AssetImage(
                          'images/plasma_img.png',
                        ),
                        width: 100.0,
                        height: 100.0,
                      ),
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    const Text(
                      'Welcome To Plasma',
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 40.0),
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    TextFormField(
                      controller: emailcontroller,
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
                        labelText: 'Email Adress',
                        prefixIcon: Icon(
                          Icons.mail,
                        ),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    TextFormField(
                      controller: passcontroller,
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
                        return null;
                      },
                      obscureText: obscureText,
                      decoration: InputDecoration(
                        labelText: 'Password',
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
                        border: OutlineInputBorder(),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            'Forget Password..?',
                          ),
                        ),
                      ],
                    ),
                    Container(
                      color: Colors.amber,
                      height: 40.0,
                      width: double.infinity,
                      child: MaterialButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {}
                          // print(emailcontroller.text);
                          // print(passcontroller.text);
                        },
                        child: const Text(
                          'LOGIN',
                          style: TextStyle(
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
                        const Text('Don\'t Have An Account?'),
                        TextButton(
                          onPressed: () {},
                          child: const Text('Register Now'),
                        ),
                      ],
                    )
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
