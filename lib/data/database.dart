import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'data_model.dart';

class DatabaseHelper with ChangeNotifier {
  static final _databaseName = "MyDatabase.db";
  static final _databaseVersion = 1;

  static final customerTable = 'customers';
  static final customerPos = 'pos';
  static final customerName = 'name';
  static final customerMail = 'mail';
  static final customerBal = 'bal';
  static final customerPhone = 'phone';

  static final transferTable = 'transfers';
  static final transferPos = 'pos';
  static final transferFrom = 'transferFrom';
  static final transferTo = 'transferTo';
  static final amountTransfer = 'amountTransfer';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE IF NOT EXISTS $customerTable ($customerPos INTEGER PRIMARY KEY,$customerName TEXT NOT NULL,$customerMail TEXT NOT NULL,$customerPhone TEXT NOT NULL,$customerBal REAL NOT NULL)");
    await db.execute(
        "CREATE TABLE IF NOT EXISTS $transferTable ($transferPos INTEGER PRIMARY KEY AUTOINCREMENT,$transferFrom TEXT NOT NULL,$transferTo TEXT NOT NULL,$amountTransfer REAL NOT NULL)");
    DATA.forEach((customer) async {
      await db.insert(customerTable, customer.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    });
  }

  Future<int> insertTransfer(Transfer transfer) async {
    Database db = await instance.database;
    return await db.insert(
      transferTable,
      transfer.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Customer>> getCustomers() async {
    Database db = await instance.database;
    final res = await db.query(customerTable);
    List<Customer> list =
        res.isNotEmpty ? res.map((u) => Customer.fromMap(u)).toList() : [];
    return list;
  }

  Future<List<Transfer>> getTransfers() async {
    Database db = await instance.database;
    final res = await db.query(transferTable);

    List<Transfer> list = res.isNotEmpty
        ? res.map((element) => Transfer.fromMap(element)).toList()
        : [];
    return list;
  }

  Future<void> updateUsers(Customer customer) async {
    Database db = await instance.database;
    await db.update(customerTable, customer.toMap(),
        where: '$customerPos = ?', whereArgs: [customer.pos]);
    notifyListeners();
  }

  Future<List<Customer>> getUsersForTransfer(int pos) async {
    Database db = await instance.database;
    String whereString = '$customerPos <> ?';
    List<dynamic> whereArguments = [pos];
    final res = await db.query(customerTable,
        where: whereString, whereArgs: whereArguments);

    List<Customer> list =
        res.isNotEmpty ? res.map((u) => Customer.fromMap(u)).toList() : [];
    return list;
  }
}
