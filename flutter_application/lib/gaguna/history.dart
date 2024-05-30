import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_application/gaguna/edit_money.dart';
import 'package:flutter_application/money.dart';
import 'package:flutter_application/money_controller.dart';
import 'package:flutter_application/money_page.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:flutter_application/gooolebottom.dart';
import 'package:flutter_application/gaguna/views/profile_screen.dart';
import 'package:flutter_application/screens/link.dart';
import 'package:google_fonts/google_fonts.dart';

class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final _moneyRepository = MoneyRepository();
  List<Money> _moneyList = [];
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadMoneyHistory();
  }

  Future<void> _loadMoneyHistory() async {
    final moneyList = await _moneyRepository.getAllMoney();
    final updatedMoneyList = await Future.wait(
      moneyList.map((money) async {
        final updatedMoney =
            await _moneyRepository.calculateEstimatedMonths(money);
        return updatedMoney ?? money;
      }),
    );
    setState(() {
      _moneyList = updatedMoneyList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Riwayat',
          style: TextStyle(
              color: Colors.white,
              ),
        ),
        backgroundColor: Colors.blue.shade600,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade600, Colors.white],
          ),
        ),
        child: ListView.builder(
          itemCount: _moneyList.length,
          itemBuilder: (context, index) {
            final money = _moneyList[index];
            return Card(
              elevation: 4,
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Target: Rp.${money.target != null ? money.target!.toStringAsFixed(0) : '0'}',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Penghasilan: Rp.${money.income != null ? money.income!.toStringAsFixed(0) : '0'}',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Pengeluaran: Rp.${money.expense != null ? money.expense!.toStringAsFixed(0) : '0'}',
                          style: TextStyle(fontSize: 16),
                        ),
                        const Divider(),
                        SizedBox(height: 8),
                        Text(
                          'Now: ${DateFormat('dd-MM-yyyy').format(DateTime.now())}',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Waktu Target: ${money.time_target != null ? DateFormat('dd-MM-yyyy').format(DateTime.now().add(Duration(days: (money.time_target! * 30)))) : 'Can\'t reach the target'}',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Bulan: ${money.time_target}',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 8),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        _deleteMoney(money);
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
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

  Future<void> _deleteMoney(Money money) async {
    final int? moneyId = int.tryParse(money.id.toString());
    if (moneyId != null) {
      await _moneyRepository.deleteMoney(moneyId);
      await _loadMoneyHistory();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Data telah dihapus'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: Data tidak valid'),
        ),
      );
    }
  }
}
