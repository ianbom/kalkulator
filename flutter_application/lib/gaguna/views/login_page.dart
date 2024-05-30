import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/gaguna/history.dart';
import 'package:flutter_application/gaguna/views/profile_screen.dart';
import 'package:flutter_application/gaguna/views/register_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
   // _checkOnboardingStatus();
  }

  void _checkOnboardingStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstTime = prefs.getBool('isFirstTime') ?? true;
    if (isFirstTime) {
      await prefs.setBool('isFirstTime', false);
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HistoryScreen()),
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
            colors: [Colors.indigo.shade800, Colors.indigo.shade600],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.savings_rounded,
                      color: Colors.indigo.shade800,
                      size: 60,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  const Text(
                    "Let's Save !",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "User Email",
                      hintStyle: TextStyle(color: Colors.white70),
                      prefixIcon: Icon(
                        Icons.mail_outline,
                        color: Colors.white,
                      ),
                      filled: true,
                      fillColor: Colors
                          .indigo.shade600, // Ubah sedikit warna latar belakang
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(
                            color: Colors
                                .white), // Ubah warna border menjadi putih
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Password",
                      hintStyle: TextStyle(color: Colors.white70),
                      prefixIcon: Icon(
                        Icons.lock_outline,
                        color: Colors.white,
                      ),
                      filled: true,
                      fillColor: Colors
                          .indigo.shade600, // Ubah sedikit warna latar belakang
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(
                            color: Colors
                                .white), // Ubah warna border menjadi putih
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegisterScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(color: Colors.white),
                      ),
                    ),
                    child: Text(
                      "Don't have an account? Register",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () async {
                      User? user = await loginUsingEmailPassword(
                        email: _emailController.text,
                        password: _passwordController.text,
                        context: context,
                      );
                      if (user != null) {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => ProfileScreen(),
                        ));
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 15),
                      minimumSize: Size(double.infinity, 0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    child: Text(
                      "Login",
                      style: TextStyle(
                          color: Colors.indigo.shade800, fontSize: 18.0),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Future<User?> loginUsingEmailPassword(
    {required String email,
    required String password,
    required BuildContext context}) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user;
  try {
    UserCredential userCredential = await auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    user = userCredential.user;
  } on FirebaseAuthException catch (e) {
    if (e.code == "user-not-found") {
      print("No user found");
    }
  }
  return user;
}
