import 'package:expenses/application/routes.dart';
import 'package:expenses/database/local_databaseconnector.dart';
import 'package:expenses/features/transactions/local_transaction_controller.dart';
import 'package:get_it/get_it.dart';

// [ADD] Matts1vn
GetIt locator = GetIt.asNewInstance();

void setup() {
  locator.registerSingleton<Routes>(Routes());
  locator.registerSingleton<LocalDatabaseConnector>(
    LocalDatabaseConnector(),
  );

  locator.registerSingleton<LocalTransactionController>(
      LocalTransactionController());
}
