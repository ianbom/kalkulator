import 'package:flutter_application/money.dart';
import 'package:flutter_application/gaguna/database.dart';

class MoneyRepository {
  final dbHelper = DatabaseHelper.instance;

  // Create
  Future<int> createMoney(Money money) async {
    final db = await dbHelper.database;
    return await db.insert(tableMoney, money.toMap());
  }

  // Read
  Future<List<Money>> getAllMoney() async {
    final db = await dbHelper.database;
    final maps = await db.query(tableMoney);
    return List.generate(maps.length, (i) => Money.fromMap(maps[i]));
  }

  Future<Money?> getMoney(int id) async {
    final db = await dbHelper.database;
    final maps = await db.query(
      tableMoney,
      where: '${MoneyFields.columnId} = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return Money.fromMap(maps.first);
    }
    return null;
  }

  // Update
  Future<int> updateMoney(Money money) async {
    final db = await dbHelper.database;
    return await db.update(
      tableMoney,
      money.toMap(),
      where: '${MoneyFields.columnId} = ?',
      whereArgs: [money.id],
    );
  }

  // Delete
  Future<int> deleteMoney(int id) async {
    final db = await dbHelper.database;
    return await db.delete(
      tableMoney,
      where: '${MoneyFields.columnId} = ?',
      whereArgs: [id],
    );
  }

  Future<Money?> calculateEstimatedMonths(Money money) async {
    if (money.income! < money.expense!) {
      print("Can't reach the target because the expense is more than income");
      return null;
    }

    final int savingsPerMonth = money.income! - money.expense!;
    final int monthsToSave = (money.target! / savingsPerMonth).ceil();
    final Money updatedMoney = Money(
      id: money.id,
      income: money.income,
      expense: money.expense,
      target: money.target,
      time: money.time,
      time_target: monthsToSave,
    );

    return updatedMoney;
  }
}
