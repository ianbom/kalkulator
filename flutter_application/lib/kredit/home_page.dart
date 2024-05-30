import 'package:flutter/material.dart';
import 'package:flutter_application/gooolebottom.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application/kredit/login_kredit.dart';

class HomePage extends StatefulWidget {
  final int id;
  final String name;
  final String email;
  final String token;

  HomePage(
      {required this.id,
      required this.name,
      required this.email,
      required this.token});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 2;

  Future<void> handleLogout(String token) async {
    final url = 'http://10.0.2.2:8000/api/logout';
    final headers = {
      'Authorization': 'Bearer ${this.widget.token}',
      'Content-Type': 'application/json',
    };

    final response = await http.post(Uri.parse(url), headers: headers);

    print(response.body);

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginKredit()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
            onPressed: () => handleLogout(this.widget.token),
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Welcome, ${this.widget.name}!'),
            SizedBox(height: 16.0),
            SizedBox(height: 16.0),
            Text('Your Identity'),
            SizedBox(height: 16.0),
            Text('ID: ${this.widget.id}'),
            SizedBox(height: 16.0),
            Text('Email: ${this.widget.email}'),
            SizedBox(height: 16.0),
            Text('Name: ${this.widget.name}'),
            SizedBox(height: 16.0),
            Text('Token:'),
            Text('${this.widget.token}'),
          ],
        ),
      ),
      bottomNavigationBar: GoogleBottomBar(
        // Menggunakan GoogleBottomBar
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
