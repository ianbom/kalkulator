import 'package:flutter/material.dart';
import 'package:flutter_application/logreg/logfix.dart';
import 'dart:convert';

import 'package:flutter_application/login_laravel/methods/api.dart';
import 'package:flutter_application/login_laravel/helper/constant.dart';
import 'package:flutter_application/login_laravel/screens/auth/login.dart';
import 'package:flutter_application/login_laravel/screens/auth/register.dart';
import 'package:flutter_application/login_laravel/screens/home.dart';
import 'package:flutter_application/login_laravel/widget/input_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterFix extends StatefulWidget {
  const RegisterFix({Key? key}) : super(key: key);

  @override
  State<RegisterFix> createState() => _RegisterFixState();
}

class _RegisterFixState extends State<RegisterFix> {
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
          builder: (context) => LoginFix(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Account'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/signup.png',
                fit: BoxFit.cover,
                height: 300,
                width: 350,
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Create Account',
                style: TextStyle(
                  fontSize: 30,
                  fontFamily: 'Courier',
                  color: Color.fromARGB(255, 43, 161, 235),
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: username,
                decoration: const InputDecoration(
                  icon: Icon(Icons.person),
                  hintText: 'Enter Your Username',
                  labelText: 'Username',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: email,
                decoration: const InputDecoration(
                  icon: Icon(Icons.email),
                  hintText: 'Enter Your Email/Username',
                  labelText: 'Email or Username',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: password,
                obscureText: true,
                decoration: const InputDecoration(
                  icon: Icon(Icons.lock),
                  hintText: 'Enter Your Password',
                  labelText: 'Password',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton.icon(
  onPressed: registerUser,
  icon: const Icon(Icons.create_rounded, color: Colors.white,),
  label: const Text(
    'Sign Up',
    style: TextStyle(
      color: Colors.white, // Ubah warna teks menjadi putih
    ),
  ),
  style: ElevatedButton.styleFrom(
    backgroundColor: Color.fromARGB(255, 43, 161, 235),
  ),
),

              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already have an account?'),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginFix()),
                      );
                    },
                    child: const Text(
                      'Sign In',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'By signing up you agree to our terms, conditions and privacy Policy.',
                style: TextStyle(
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
