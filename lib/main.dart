// Importando os pacotes necessários
import 'package:expenses/components/chart.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'components/transaction_form.dart';
import 'components/transaction_list.dart';
import 'models/transaction.dart';

// Função principal que inicia o aplicativo
main() => runApp(ExpensesApp());

class ExpensesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Retorna um widget MaterialApp que é a raiz do aplicativo
    return MaterialApp(
      home: MyHomePage(), // Define a página inicial do aplicativo
      theme: ThemeData(
        primarySwatch: Colors.purple, // Define a cor primária do tema
        colorScheme: ColorScheme.fromSwatch()
            .copyWith(secondary: Color.fromARGB(255, 128, 0, 0)), // Define a cor secundária do tema
        fontFamily: 'Lato', // Define a fonte padrão do tema
        textTheme: ThemeData.light().textTheme.copyWith(
                titleLarge: TextStyle(
              fontFamily: 'Lato',
              fontSize: 18,
              fontWeight: FontWeight.bold,
            )),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            primary: Colors.white,
            textStyle: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        appBarTheme: AppBarTheme(
          toolbarTextStyle: ThemeData.light().textTheme.titleLarge!.copyWith(
                fontFamily: 'Lato',
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = []; // Lista para armazenar as transações

  // Retorna uma lista das transações dos últimos 7 dias
  List<Transaction> get _recentTransactions {
    return _transactions.where((tr) {
      return tr.date.isAfter(DateTime.now().subtract(
        Duration(days: 7),
      ));
    }).toList();
  }

  // Adiciona uma nova transação à lista
  _addTransaction(String title, double value, DateTime date) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: date,
    );

    setState(() {
      _transactions.add(newTransaction);
    });

    Navigator.of(context).pop();
  }

  // Remove uma transação da lista
  _removeTransaction(String id) {
    setState(() {
      _transactions.removeWhere((tr) => tr.id == id);
      });
  }

  // Abre o formulário de transação em um modal
  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return TransactionForm(_addTransaction);
        },
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 211, 211, 211), // Define a cor de fundo do Scaffold
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 124, 36, 178), // Define a cor de fundo da AppBar
        title: Text(
          'Despesas Pessoais',
          style: TextStyle(fontFamily: 'RobotoSlab'),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _openTransactionFormModal(context),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Chart(_recentTransactions), // Exibe o gráfico de transações
            TransactionList(_transactions, _removeTransaction), // Exibe a lista de transações
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple, // Define a cor de fundo do FloatingActionButton
        child: Icon(Icons.add),
        onPressed: () => _openTransactionFormModal(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
