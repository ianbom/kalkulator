import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/gooolebottom.dart';
import 'package:flutter_application/screens/link.dart';
import 'package:flutter_application/gaguna/views/login_page.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen();

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _selectedIndex = 2;
  User? _user;

  @override
  void initState() {
    super.initState();
    _getUserInfo();
  }

  Future<void> _getUserInfo() async {
    User? user = FirebaseAuth.instance.currentUser;
    setState(() {
      _user = user;
    });
  }

  Future<void> _signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Profile',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue.shade600,
      ),
      body: Center(
        child: _user != null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(
                            'https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/df2abcf3-0c0e-4b0d-bced-86c3a3d6bf8e/dg8xrio-fb110f71-8924-4a49-a1ff-75f2934f2361.jpg?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7InBhdGgiOiJcL2ZcL2RmMmFiY2YzLTBjMGUtNGIwZC1iY2VkLTg2YzNhM2Q2YmY4ZVwvZGc4eHJpby1mYjExMGY3MS04OTI0LTRhNDktYTFmZi03NWYyOTM0ZjIzNjEuanBnIn1dXSwiYXVkIjpbInVybjpzZXJ2aWNlOmZpbGUuZG93bmxvYWQiXX0.Zj3ZwwTXdu6dIbFkphYw9u3xa3B3hExa8E6mdSmtHig',
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Welcome, ${_user!.email!.split('@')[0]}',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Email: ${_user!.email}',
                          style: TextStyle(fontSize: 18),
                        ),
                        
                      ],
                    ),
                  ),
                  SizedBox(height: 20), // Tambahkan jarak antara card dan tombol logout
                        ElevatedButton.icon(
                          onPressed: () => _signOut(context),
                          icon: Icon(Icons.logout, color: Colors.white),
                          label: Text(
                            'Logout',
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 110),
                          ),
                        ),
                ],
              )
            : CircularProgressIndicator(),
      ),
      bottomNavigationBar: GoogleBottomBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => UrlShortenerScreen()),
          );
        },
        child: Icon(Icons.link_sharp),
      ),
    );
  }
}
