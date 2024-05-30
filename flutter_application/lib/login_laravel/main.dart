

// import 'package:flutter_application/login_laravel/screens/auth/login.dart';


// import 'package:flutter/material.dart';
// import 'package:flutter_application/login_laravel/screens/home.dart';
// import 'package:flutter_application/screens/link.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// void main() {
//   runApp(ChangeNotifierProvider(
//     create: (context) => UrlShortenerState(),
//     child: MaterialApp(
//       title: "TESSS",
//       home: MyApp(),
//     ),
//   ));
//   ;
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: FutureBuilder(
//           future: SharedPreferences.getInstance(),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Center(
//                 child: CircularProgressIndicator(),
//               );
//             } else if (snapshot.hasError) {
//               return Text('Some error has Occurred');
//             } else if (snapshot.hasData) {
//               final token = snapshot.data!.getString('token');
//               if (token != null) {
//                 return Home();
//               } else {
//                 return Login();
//               }
//             } else {
//               return Login();
//             }
//           }),
//     );
//   }
// }
