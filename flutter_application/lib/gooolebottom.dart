import 'package:flutter/material.dart';
import 'package:flutter_application/deposito/deposito_create.dart';
import 'package:flutter_application/deposito/deposito_history.dart';
import 'package:flutter_application/kredit/create_kredit.dart';
import 'package:flutter_application/kredit/history_kredit.dart';
import 'package:flutter_application/kredit/home_page.dart';
import 'package:flutter_application/login_laravel/screens/home.dart';
import 'package:flutter_application/logreg/homefix.dart';
import 'package:flutter_application/screens/url_shortener_screen.dart';
import 'package:flutter_application/tabungan/create_tabungan.dart';
import 'package:flutter_application/tabungan/history_tabungan.dart';
import 'package:flutter_application/gaguna/views/profile_screen.dart';
//import 'package:flutter_application/kredit/add_kredit.dart'; // Import halaman AddKredit
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:flutter_application/money_page.dart';
import 'package:flutter_application/gaguna/history.dart';
import 'package:http/http.dart' as http;
//import 'package:flutter_application/link_screen.dart'; // Impor halaman yang ingin ditampilkan

class GoogleBottomBar extends StatefulWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const GoogleBottomBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  State<GoogleBottomBar> createState() => _GoogleBottomBarState();
}

class _GoogleBottomBarState extends State<GoogleBottomBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 255, 255, 255), // Set background to white
      child: BottomNavigationBar(
        currentIndex: widget.currentIndex,
        onTap: (index) {
          // Tambahkan logika navigasi berdasarkan indeks yang dipilih
          switch (index) {
            case 0: // History
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HistoryTabungan()),
              );
              break;
            case 1: // AddMoney
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CreateTabungan()),
              );
              break;
            case 2: // Profile
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HistoryKredit()),
              );
              break;
            case 3: // History Kredit
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddKredit
                ()),
              );
              break;
            case 4: // Add Kredit
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HistoryDeposito()),
              );
              break;
            case 5: // Add Kredit
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CreateDeposito()),
              );
              break;
            case 6: // Add Kredit
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileFix()),
              );
              break;
            default:
              break;
          }
          // Panggil fungsi onTap yang diberikan
          widget.onTap(index);
        },
        backgroundColor:
            Color.fromARGB(255, 221, 232, 244), // Set background to transparent
        selectedItemColor: Color.fromARGB(255, 14, 82, 207),
        unselectedItemColor: Color.fromARGB(255, 173, 168, 171),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calculate),
            label: 'Calculate',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.work_history),
            label: 'History Kredit',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.credit_card),
            label: 'Kredit',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history_toggle_off_rounded),
            label: 'Deposito History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.money),
            label: 'Calculate',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
