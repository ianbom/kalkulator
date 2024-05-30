import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application/login_laravel/helper/constant.dart';
import 'package:flutter_application/login_laravel/screens/auth/register.dart';
import 'package:flutter_application/login_laravel/screens/home.dart';
import 'package:flutter_application/login_laravel/widget/input_field.dart';
import 'package:flutter_application/logreg/homefix.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../methods/api.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  void loginUser() async {
    final data = {
      'email': email.text.toString(),
      'password': password.text.toString(),
    };
    final result = await API().postRequest(route: '/login', data: data);
    final response = jsonDecode(result.body);
    if (response['status'] == 200) {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.setInt('user_id', response['user']['id']);
      await preferences.setString('name', response['user']['name']);
      await preferences.setString('email', response['user']['email']);
      await preferences.setString('token', response['token']);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response['message']),
        ),
      );
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => ProfileFix(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade400, Colors.blue.shade900],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Sign In',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                InputField(
                  controller: email,
                  hintText: 'Email',
                  isObscure: false,
                  width: MediaQuery.of(context).size.width * 0.8,
                ),
                SizedBox(height: 10),
                InputField(
                  controller: password,
                  hintText: 'Password',
                  isObscure: true,
                  width: MediaQuery.of(context).size.width * 0.8,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    loginUser();
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Text(
                      'Sign In',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don\'t have an account?',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(width: 5),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => Register()),
                        );
                      },
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
