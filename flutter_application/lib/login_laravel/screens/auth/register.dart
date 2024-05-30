import 'dart:convert';


import 'package:flutter/material.dart';

import 'package:flutter_application/login_laravel/methods/api.dart';
import 'package:flutter_application/login_laravel/helper/constant.dart';
import 'package:flutter_application/login_laravel/screens/auth/login.dart';
import 'package:flutter_application/login_laravel/screens/auth/register.dart';
import 'package:flutter_application/login_laravel/screens/home.dart';
import 'package:flutter_application/login_laravel/widget/input_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController email = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  void registerUser() async {
    final data = {
      'email': email.text.toString(),
      'name': username.text.toString(),
      'password': password.text.toString(),
    };
    final result = await API().postRequest(route: '/register', data: data);
    final response = jsonDecode(result.body);
    if (response['status'] == 200) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => Login(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = deviceWidth(context);
    double height = deviceHeight(context);
    return Scaffold(
      body: Container(
        width: width,
        height: height,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              primaryColor,
              secondaryColor,
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                spancer(h: height * 0.1),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const RotatedBox(
                      quarterTurns: 3,
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    spancer(
                      w: width * 0.05,
                    ),
                    Container(
                      width: width * 0.5,
                      child: const Text(
                        'We can start something new',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                        ),
                      ),
                    ),
                  ],
                ),
                spancer(
                  h: height * 0.15,
                ),
                InputField(
                  width: width,
                  controller: username,
                  hintText: 'Username',
                ),
                spancer(
                  h: height * 0.01,
                ),
                InputField(
                  width: width,
                  controller: email,
                  hintText: 'Email',
                ),
                spancer(
                  h: height * 0.01,
                ),
                InputField(
                    width: width,
                    controller: password,
                    hintText: 'Password',
                    isObscure: true),
                spancer(
                  h: height * 0.03,
                ),
                spancer(
                  h: height * 0.1,
                ),
                InkWell(
                  onTap: () {
                    registerUser();
                  },
                  child: Container(
                    width: double.maxFinite,
                    alignment: Alignment.centerRight,
                    padding: spacing(
                      h: 20,
                    ),
                    child: Container(
                      width: width * 0.3,
                      padding: spacing(
                        h: 20,
                        v: 10,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(width),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'OK',
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: 18,
                            ),
                            textAlign: TextAlign.right,
                          ),
                          spancer(
                            w: 10,
                          ),
                          Icon(
                            Icons.arrow_right_alt_rounded,
                            color: primaryColor,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.1,
                ),
                Row(
                  children: [
                    Text(
                      'Have we met before?',
                      style: TextStyle(
                        color: secondaryTextColor,
                        fontSize: 18,
                      ),
                    ),
                    spancer(w: 4),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => Login(),
                          ),
                        );
                      },
                      child: const Text(
                        'Sign In',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
