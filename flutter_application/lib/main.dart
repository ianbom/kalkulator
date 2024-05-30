import 'package:flutter/material.dart';
import 'package:flutter_application/login_laravel/screens/auth/login.dart';
import 'package:flutter_application/logreg/homefix.dart';
import 'package:flutter_application/logreg/logfix.dart';
import 'package:flutter_application/screens/link.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => UrlShortenerState(),
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Kalkulator",
      theme: ThemeData(
        fontFamily: 'Roboto', // Gunakan font bawaan Flutter di sini
      ),
      home: MyApp(),
    ),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: SharedPreferences.getInstance(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Text('Some error has Occurred');
          } else if (snapshot.hasData) {
            final token = snapshot.data!.getString('token');
            if (token != null) {
              return ProfileFix();
            } else {
              return LoginFix();
            }
          } else {
            return LoginFix();
          }
        },
      ),
    );
  }
}
