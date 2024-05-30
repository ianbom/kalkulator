import 'package:intl/intl.dart';
import 'package:flutter_application/money.dart';
import 'package:flutter_application/money_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/money_page.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _moneyRepository = MoneyRepository();
  Money? _currentMoney; // Declare a nullable Money object

  @override
  void initState() {
    super.initState();
    _loadCurrentMoney();
  }

  Future<void> _loadCurrentMoney() async {
    final money =
        await _moneyRepository.getMoney(1); // Retrieve the first Money object
    setState(() {
      _currentMoney = money;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('flutter_application'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Ringkasan flutter_application',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            if (_currentMoney != null) // Check if _currentMoney is not null
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Target: ${_currentMoney?.target?.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'Penghasilan: ${_currentMoney?.income?.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 14.0),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'Pengeluaran: ${_currentMoney?.expense?.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 14.0),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'Sekarang: ${DateFormat('dd-MM-yy').format(DateTime.now())}',
                    style: TextStyle(fontSize: 14.0),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'Waktu Target: ${DateFormat('dd-MM-yy').format(DateTime.parse(_currentMoney?.time ?? ''))}',
                    style: TextStyle(fontSize: 14.0),
                  ),
                ],
              )
            else
              Center(
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddMoneyScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
