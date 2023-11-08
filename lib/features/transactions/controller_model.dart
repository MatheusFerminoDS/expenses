import 'package:expenses/models/transaction.dart';
import 'package:multiple_result/multiple_result.dart';

// [ADD] Matts1vn
//modelo do controlador, tambem implementar ela caso crie novos controladores para novos conectores
abstract class TransactionController {
  Future<Result<TransactionSuccessStatus, TransactionFailedStatus>>
      addTransaction(String title, double value, DateTime date);
  Future<Result<TransactionSuccessStatus, TransactionFailedStatus>>
      removeTransaction(String id);

  Future<List<Transaction>> getTransactions();
}

class TransactionSuccessStatus {}

class TransactionFailedStatus {}
