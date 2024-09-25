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

  Future<void> addCategory({required name, required price, required categoryId}) async {
    await db.execute(
      'INSERT INTO transactions(id, name, price, category_id, user_id) VALUES(gen_random_uuid(), ?, ?, ?, ?)',
      [name, price, categoryId, await getUserId()]
    );

    ref.invalidateSelf();
    ref.invalidate(categoriesNotifierProvider);
    await future;
  }

  // Future<void> updateCategory(id, {required name, required budget}) async {
  //   await db.execute(
  //     'UPDATE categories SET name = ?, budget = ? WHERE id = ? AND user_id = ?',
  //     [name, budget, id, await getUserId()],
  //   );
  // }
}
