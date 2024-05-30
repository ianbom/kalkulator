import 'package:flutter/material.dart';
import 'package:flutter_application/gooolebottom.dart';
import 'package:flutter_application/logreg/logfix.dart';
import 'package:flutter_application/screens/link.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileFix extends StatefulWidget {
  const ProfileFix({super.key});

  @override
  State<ProfileFix> createState() => _ProfileFixState();
}

class _ProfileFixState extends State<ProfileFix> {
  int _selectedIndex = 6;
  late Future<SharedPreferences> _preferences;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _preferences = SharedPreferences.getInstance();
  }
  

  void logout() {
    _preferences.then((preferences) {
      preferences.clear();
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => LoginFix(),
        ),
      );
    });
  }

  void editUser(String newName, String newEmail) {
    _preferences.then((preferences) {
      preferences.setString('name', newName);
      //preferences.setString('email', newEmail);
      setState(() {});
    });
  }

  void _showEditDialog(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    //TextEditingController emailController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Profile'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'New Name'),
              ),
              // TextField(
              //   controller: emailController,
              //   decoration: InputDecoration(labelText: 'New Email'),
              // ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                //editUser(nameController.text, emailController.text);
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<SharedPreferences>(
        future: _preferences,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          final preferences = snapshot.data!;

          return Column(
            children: [
              const Expanded(flex: 2, child: _TopPortion()),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        preferences.getString('name').toString(),
                        style: Theme.of(context)
                            .textTheme
                            .headline6
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FloatingActionButton.extended(
                            onPressed: () {
                              // _showEditDialog(context);
                            },
                            heroTag: 'Edit',
                            elevation: 0,
                            label: const Text("Ayo Menabung"),
                            icon: const Icon(Icons.attach_money),
                          ),
                          const SizedBox(width: 16.0),
                          FloatingActionButton.extended(
                            onPressed: () {
                              logout();
                            },
                            heroTag: 'mesage',
                            elevation: 0,
                            backgroundColor: Colors.red,
                            label: const Text("Logout"),
                            icon: const Icon(Icons.logout),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: SizedBox(
                          // Menggunakan SizedBox untuk mengatur ukuran kartu
                          width: 300, // Atur tinggi sesuai kebutuhan Anda
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              preferences.getString('email').toString(),
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const _ProfileInfoRow()
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: GoogleBottomBar(
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

class _ProfileInfoRow extends StatelessWidget {
  const _ProfileInfoRow({Key? key}) : super(key: key);

  final List<ProfileInfoItem> _items = const [];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      constraints: const BoxConstraints(maxWidth: 400),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: _items
            .map((item) => Expanded(
                    child: Row(
                  children: [
                    if (_items.indexOf(item) != 0) const VerticalDivider(),
                    Expanded(child: _singleItem(context, item)),
                  ],
                )))
            .toList(),
      ),
    );
  }

  Widget _singleItem(BuildContext context, ProfileInfoItem item) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              item.value.toString(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          Text(
            item.title,
            style: Theme.of(context).textTheme.caption,
          )
        ],
      );
}

class ProfileInfoItem {
  final String title;
  final int value;
  const ProfileInfoItem(this.title, this.value);
}

class _TopPortion extends StatelessWidget {
  const _TopPortion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 50),
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Color(0xff0043ba), Color(0xff006df1)]),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              )),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            width: 150,
            height: 150,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            'https://wallpapers.com/images/high/sasuke-pfp-chibi-a0xso7lx97b8j5s8.webp')),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    child: Container(
                      margin: const EdgeInsets.all(8.0),
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 10, 142, 230),
                          shape: BoxShape.circle),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
