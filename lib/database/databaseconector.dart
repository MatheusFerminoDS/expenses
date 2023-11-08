import 'package:sqflite/sqflite.dart';

// [ADD] Matts1vn
//classe modelo do conector, implementar ela caso queria criar mais conectores, via api por exemplo
abstract class DatabaseConnector {
  Database? database;
  Future<void> connect();
}
