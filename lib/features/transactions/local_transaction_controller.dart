// ignore: implementation_imports
import 'package:multiple_result/src/result.dart';

import 'package:expenses/database/local_databaseconnector.dart';
import 'package:expenses/features/transactions/controller_model.dart';
import 'package:expenses/locator.dart';
import 'package:expenses/models/transaction.dart';

// [ADD] Matts1vn
//classe para controlar as transacoes no banco de dados local
class LocalTransactionController implements TransactionController {
  @override
  Future<Result<TransactionSuccessStatus, TransactionFailedStatus>>
      addTransaction(String title, double value, DateTime date) async {
    try {
      await locator<LocalDatabaseConnector>().database?.insert("transactions", {
        "title": title,
        "value": value,
        "date":
            "${date.year}-${date.month < 10 ? "0${date.month}" : date.month}-${date.day < 10 ? "0${date.day}" : date.day} ${date.hour}:${date.minute < 10 ? "0${date.minute}" : date.minute}:${date.second < 10 ? "0${date.second}" : date.second}"
      });

      return Result.success(TransactionSuccessStatus());
    } catch (e) {
      return Result.error(TransactionFailedStatus());
    }
  }

  @override
  Future<List<Transaction>> getTransactions() async {
    return (await locator<LocalDatabaseConnector>()
            .database
            ?.query("transactions") as List<Map>)
        .map(
          (e) => Transaction(
            id: e['id'].toString(),
            title: e['title'],
            value: e['value'],
            date: DateTime.parse(e['date']),
          ),
        )
        .toList();
  }

  @override
  Future<Result<TransactionSuccessStatus, TransactionFailedStatus>>
      removeTransaction(String id) async {
    try {
      await locator<LocalDatabaseConnector>().database?.delete(
            "transactions",
            whereArgs: [int.parse(id)],
            where: "id = ?",
          );
      return Result.success(TransactionSuccessStatus());
    } catch (e) {
      return Result.error(TransactionFailedStatus());
    }
  }
}
