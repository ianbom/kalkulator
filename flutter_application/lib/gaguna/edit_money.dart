import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_application/money.dart';
import 'package:flutter_application/money_controller.dart';

class EditMoneyScreen extends StatefulWidget {
  final Money money;
  final Function() onEditComplete; // Callback function

  EditMoneyScreen({required this.money, required this.onEditComplete});

  @override
  _EditMoneyScreenState createState() => _EditMoneyScreenState();
}

class _EditMoneyScreenState extends State<EditMoneyScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _incomeController;
  late TextEditingController _expenseController;
  late TextEditingController _targetController;
  late MoneyRepository _moneyRepository;

  @override
  void initState() {
    super.initState();
    _moneyRepository = MoneyRepository();
    _incomeController =
        TextEditingController(text: widget.money.income?.toString());
    _expenseController =
        TextEditingController(text: widget.money.expense?.toString());
    _targetController =
        TextEditingController(text: widget.money.target?.toString());
  }

  @override
  void dispose() {
    _incomeController.dispose();
    _expenseController.dispose();
    _targetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Money'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _incomeController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Income'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter income';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _expenseController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Expense'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter expense';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _targetController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Target'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter target';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    // Update Money object with new values
                    final updatedMoney = Money(
                      id: widget.money.id,
                      income: int.parse(_incomeController.text),
                      expense: int.parse(_expenseController.text),
                      target: int.parse(_targetController.text),
                      time: widget.money.time,
                      time_target: widget.money.time_target,
                    );
                    // Update data in database
                    await _moneyRepository.updateMoney(updatedMoney);
                    // Close the edit screen
                    Navigator.pop(context);
                    // Call the callback function to reload history screen
                    widget.onEditComplete();
                  }
                },
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
