// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter_application/gooolebottom.dart';
// import 'package:flutter_application/login_laravel/screens/auth/login.dart';
// import 'package:flutter_application/logreg/logfix.dart';
// import 'package:flutter_application/screens/link.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class Home extends StatefulWidget {
//   const Home({Key? key}) : super(key: key);

//   @override
//   _HomeState createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   int _selectedIndex = 2;
//   late SharedPreferences preferences;
//   bool isLoading = false;

//   @override
//   void initState() {
//     super.initState();
//     getUserData();
//   }

//   void getUserData() async {
//     setState(() {
//       isLoading = true;
//     });
//     preferences = await SharedPreferences.getInstance();
//     setState(() {
//       isLoading = false;
//     });
//   }

//   void logout() {
//     preferences.clear();
//     Navigator.of(context).pushReplacement(
//       MaterialPageRoute(
//         builder: (context) => LoginFix(),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Profile'),
//         actions: [
//           IconButton(
//             onPressed: () {
//               logout();
//             },
//             icon: Icon(Icons.logout),
//           ),
//         ],
//       ),
//       body: SafeArea(
//         child: isLoading
//             ? Center(
//                 child: CircularProgressIndicator(),
//               )
//             : SingleChildScrollView(
//                 padding: EdgeInsets.all(20.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Center(
//                       child: CircleAvatar(
//                         radius: 50,
//                         backgroundImage: NetworkImage(
//                             'https://images.hdqwalls.com/wallpapers/bthumb/sasuke-uchiha-mh.jpg'),
//                       ),
//                     ),
//                     SizedBox(height: 20),
//                     Text(
//                       'Name:',
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.blue,
//                       ),
//                     ),
//                     Text(
//                       preferences.getString('name').toString(),
//                       style: TextStyle(
//                         fontSize: 18,
//                         color: Colors.black,
//                       ),
//                     ),
//                     SizedBox(height: 10),
//                     Text(
//                       'Email:',
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.blue,
//                       ),
//                     ),
//                     Text(
//                       preferences.getString('email').toString(),
//                       style: TextStyle(
//                         fontSize: 18,
//                         color: Colors.black,
//                       ),
//                     ),
//                     SizedBox(height: 10),
//                     Text(
//                       'User ID:',
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.blue,
//                       ),
//                     ),
//                     Text(
//                       preferences.getInt('user_id').toString(),
//                       style: TextStyle(
//                         fontSize: 18,
//                         color: Colors.black,
//                       ),
//                     ),
//                     SizedBox(height: 20),
//                     // Container(
//                     //   width: double.infinity,
//                     //   padding: EdgeInsets.all(20.0),
//                     //   decoration: BoxDecoration(
//                     //     color: Colors.blue,
//                     //     borderRadius: BorderRadius.circular(10),
//                     //   ),
//                     //   child: Text(
//                     //     'Token:',
//                     //     style: TextStyle(
//                     //       fontSize: 20,
//                     //       fontWeight: FontWeight.bold,
//                     //       color: Colors.white,
//                     //     ),
//                     //   ),
//                     // ),
//                     // SizedBox(height: 10),
//                     // Container(
//                     //   width: double.infinity,
//                     //   padding: EdgeInsets.all(20.0),
//                     //   decoration: BoxDecoration(
//                     //     color: Colors.white,
//                     //     border: Border.all(color: Colors.blue),
//                     //     borderRadius: BorderRadius.circular(10),
//                     //   ),
//                     //   child: Text(
//                     //     preferences.getString('token').toString(),
//                     //     style: TextStyle(
//                     //       fontSize: 18,
//                     //       color: Colors.black,
//                     //     ),
//                     //   ),
//                     // ),
//                   ],
//                 ),
//               ),
//       ),
//       bottomNavigationBar: GoogleBottomBar(
//         currentIndex: _selectedIndex,
//         onTap: (index) {
//           setState(() {
//             _selectedIndex = index;
//           });
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => UrlShortenerScreen()),
//           );
//         },
//         child: Icon(Icons.link_sharp),
//       ),
//     );
//   }
// }
