import 'package:expenses/components/chart.dart';
import 'package:expenses/components/transaction_form.dart';
import 'package:expenses/components/transaction_list.dart';
import 'package:expenses/features/transactions/local_transaction_controller.dart';
import 'package:expenses/locator.dart';
import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';

// [MODIFIED] Matts1vn
// mudei o corpo das funcoes para usarem o banco de dados offline e tambem
// adicionei o futurebuilder para ele recuperar as informacoes do banco de dados
// e atribuir a variavel _transactions

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Transaction> _transactions = []; // Lista para armazenar as transações

  // Retorna uma lista das transações dos últimos 7 dias
  List<Transaction> get _recentTransactions {
    return _transactions.where((tr) {
      return tr.date.isAfter(DateTime.now().subtract(
        const Duration(days: 7),
      ));
    }).toList();
  }

  // Adiciona uma nova transação à lista
  _addTransaction(String title, double value, DateTime date) async {
    await locator<LocalTransactionController>().addTransaction(
      title,
      value,
      date,
    );

    setState(() {});

    Navigator.of(context).pop();
  }

  // Remove uma transação da lista
  _removeTransaction(String id) async {
    await locator<LocalTransactionController>().removeTransaction(id);

    setState(() {});
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
      backgroundColor: const Color.fromARGB(
          255, 211, 211, 211), // Define a cor de fundo do Scaffold
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(
            255, 124, 36, 178), // Define a cor de fundo da AppBar
        title: const Text(
          'Despesas Pessoais',
          style: TextStyle(fontFamily: 'RobotoSlab'),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _openTransactionFormModal(context),
          ),
        ],
      ),
      body: FutureBuilder(
        future: locator<LocalTransactionController>().getTransactions(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            _transactions = snapshot.data as List<Transaction>;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Chart(_recentTransactions), // Exibe o gráfico de transações
                  TransactionList(_transactions,
                      _removeTransaction), // Exibe a lista de transações
                ],
              ),
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor:
            Colors.deepPurple, // Define a cor de fundo do FloatingActionButton
        child: const Icon(Icons.add),
        onPressed: () => _openTransactionFormModal(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
