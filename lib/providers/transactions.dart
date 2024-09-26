import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:pernance/models_powersync/index.dart';
import 'package:pernance/models_powersync/transaction.dart';
import 'package:pernance/providers/categories.dart';
import 'package:pernance/utils/get_user_id.dart';

part 'transactions.g.dart';

@riverpod
class TransactionsNotifier extends _$TransactionsNotifier {
  @override
  Future<List<Transaction>> build() async {
    final result = await db.getAll(
      'SELECT transactions.*, categories.name AS category_name '
      'FROM transactions '
      'LEFT JOIN categories '
      'ON categories.id = transactions.category_id '
      'ORDER BY transactions.date DESC ',
    );
    final transactions = result.map((row) => Transaction.fromRow(row)).toList();
    return transactions;
  }

  Future<void> addTransaction({required name, required price, required categoryId, required date}) async {
    await db.execute(
       'INSERT INTO transactions(id, category_id, name, price, date, user_id) VALUES(gen_random_uuid(), ?, ?, ?, ?, ?)',
      [categoryId, name, price, date.toString(), await getUserId()]
    );

    ref.invalidateSelf();
    ref.invalidate(categoriesNotifierProvider);
    await future;
  }

  // Future<void> updateTransaction(id, {required name, required budget}) async {
  //   await db.execute(
  //     'UPDATE categories SET name = ?, budget = ? WHERE id = ? AND user_id = ?',
  //     [name, budget, id, await getUserId()],
  //   );
  // }
}
