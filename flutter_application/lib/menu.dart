import 'package:flutter/material.dart';
import 'package:flutter_application/deposito/deposito_create.dart';
import 'package:flutter_application/deposito/deposito_history.dart';
import 'package:flutter_application/kredit/create_kredit.dart';
import 'package:flutter_application/kredit/history_kredit.dart';
import 'package:flutter_application/logreg/homefix.dart';
import 'package:flutter_application/tabungan/create_tabungan.dart';
import 'package:flutter_application/tabungan/history_tabungan.dart';

class MyGridView extends StatelessWidget {
  final List<IconData> icons = [
    Icons.history,
    Icons.calculate,
    Icons.work_history,
    Icons.credit_card,
    Icons.history_toggle_off_rounded,
    Icons.money,
    Icons.person,
  ];

  final List<String> labels = [
    'History',
    'Calculate',
    'History Kredit',
    'Kredit',
    'Deposito History',
    'Calculate',
    'Profile',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Grid View'),
      ),
      body: GridView.builder(
        itemCount: icons.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Adjust this as per your need
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
          childAspectRatio: 1.0,
        ),
        itemBuilder: (context, index) {
          return GridTile(
            child: GestureDetector(
              onTap: () {
                // Handle onTap event here
                switch (index) {
                  case 0: // History
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HistoryTabungan()),
                    );
                    break;
                  case 1: // Calculate
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CreateTabungan()),
                    );
                    break;
                  case 2: // History Kredit
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HistoryKredit()),
                    );
                    break;
                  case 3: // Kredit
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddKredit()),
                    );
                    break;
                  case 4: // Deposito History
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HistoryDeposito()),
                    );
                    break;
                  case 5: // Calculate
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CreateDeposito()),
                    );
                    break;
                  case 6: // Profile
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProfileFix()),
                    );
                    break;
                  default:
                    break;
                }
              },
              child: Card(
                elevation: 5.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(icons[index], size: 50.0),
                    SizedBox(height: 10.0),
                    Text(
                      labels[index],
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class HistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History Page'),
      ),
      body: Center(
        child: Text('History Page Content'),
      ),
    );
  }
}

class CalculatePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculate Page'),
      ),
      body: Center(
        child: Text('Calculate Page Content'),
      ),
    );
  }
}

// Define other pages similarly...
