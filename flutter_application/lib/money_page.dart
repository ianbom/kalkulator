import 'package:flutter/material.dart';
import 'package:flutter_application/gooolebottom.dart';
import 'package:flutter_application/gaguna/history.dart';
import 'package:flutter_application/money_controller.dart';
import 'package:flutter_application/money.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class AddMoneyScreen extends StatefulWidget {
  @override
  _AddMoneyScreenState createState() => _AddMoneyScreenState();
}

class _AddMoneyScreenState extends State<AddMoneyScreen> {
  final _moneyRepository = MoneyRepository();
  int? _income;
  int? _expense;
  int? _target;
  int _selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Calculate',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue.shade600,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Penghasilan',
                prefixIcon: Icon(Icons.attach_money, color: Colors.green),
              ),
              onChanged: (value) {
                setState(() {
                  _income = int.tryParse(value);
                });
              },
            ),
            SizedBox(height: 16.0),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Pengeluaran',
                prefixIcon: Icon(Icons.money_off, color: Colors.red),
              ),
              onChanged: (value) {
                setState(() {
                  _expense = int.tryParse(value);
                });
              },
            ),
            SizedBox(height: 16.0),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Target',
                prefixIcon: Icon(Icons.star, color: Colors.orange),
              ),
              onChanged: (value) {
                setState(() {
                  _target = int.tryParse(value);
                });
              },
            ),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () async {
                final money = Money(
                  income: _income,
                  expense: _expense,
                  target: _target,
                  time: DateTime.now().toIso8601String(),
                );
                await _moneyRepository.createMoney(money);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HistoryScreen()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'Simpan',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
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
}
