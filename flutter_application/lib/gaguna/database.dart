import 'package:flutter_application/money.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  DatabaseHelper._init();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('453.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $tableMoney( 
            ${MoneyFields.columnId} INTEGER PRIMARY KEY AUTOINCREMENT, 
            ${MoneyFields.columnIncome} INTEGER, 
            ${MoneyFields.columnExpense} INTEGER, 
            ${MoneyFields.columnTarget} INTEGER, 
            ${MoneyFields.columnTime} TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
            ${MoneyFields.columnTimeTarget} INTEGER

          )
    ''');
  }
}
