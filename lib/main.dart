// Importando os pacotes necessários
import 'package:expenses/database/local_databaseconnector.dart';
import 'package:expenses/locator.dart';
import 'package:expenses/root.dart';
import 'package:flutter/material.dart';

// Função principal que inicia o aplicativo
main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setup();
  await locator<LocalDatabaseConnector>().connect();
  runApp(const ExpensesApp());
}
