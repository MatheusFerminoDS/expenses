import 'package:expenses/database/databaseconector.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

// [ADD] Matts1vn
//classe para se conectar ao banco de dados local usando sqlite
class LocalDatabaseConnector implements DatabaseConnector {
  @override
  Database? database = null;

  @override
  Future<Database?> connect() async {
    // ignore: prefer_conditional_assignment, unnecessary_null_comparison
    if (database == null) {
      database = await openDatabase(
        join(await getDatabasesPath(), "expenses.db"),
        version: 1,
        onCreate: (db, version) async {
          await db.execute("""
          CREATE TABLE transactions(
            id INTEGER PRIMARY KEY, 
            title TEXT,
            value REAL,
            date TEXT
          ) 
          """);
        },
      );

      if (kDebugMode) {
        print("[DB] Conectado!");
      }
    }

    return database;
  }
}
