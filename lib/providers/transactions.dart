// import 'package:collection/collection.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:pernance/models/index.dart';
import 'package:pernance/models/transaction.dart';
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

  Future<void> addTransaction(
      {required name,
      required price,
      required categoryId,
      required date}) async {
    await db.execute(
        'INSERT INTO transactions(id, category_id, name, price, date, user_id) VALUES(gen_random_uuid(), ?, ?, ?, ?, ?)',
        [categoryId, name, price, date.toString(), await getUserId()]);

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

  Future<void> deleteTransaction(id) async {
    await db.execute('DELETE FROM transactions WHERE id = ?', [id]);

    ref.invalidateSelf();
    ref.invalidate(categoriesNotifierProvider);
    await future;
  }
}

// @riverpod
// Future<Map<String, List<Transaction>>> groupedTransactions() async {
//   final result = await db.getAll(
//       'SELECT transactions.*, categories.name AS category_name '
//       'FROM transactions '
//       'LEFT JOIN categories '
//       'ON categories.id = transactions.category_id '
//       'ORDER BY transactions.date DESC ',
//     );
//     final transactions = result.map((row) => Transaction.fromRow(row)).toList();
//     final groupedTransactions = groupBy(transactions, (transaction) => transaction.date.toString().split(' ').first);
//     return groupedTransactions;
// }

@riverpod
Future<Map<DateTime, int>> cumulativeTotalTransaction() async {
  final currentMonth = DateTime.now().month.toString().padLeft(2, '0');
  final currentYear = DateTime.now().year;
  final result = await db.getAll(
    'SELECT SUM(price), date AS total FROM transactions '
    'WHERE date > ?'
    'GROUP BY date '
    'ORDER BY date ASC ',
    ['$currentYear-$currentMonth-01 00:00:00'],
  );

  Map<DateTime, int> computedCumulativeTotal = {};
  int tempCumulativeTotal = 0;
  for(final row in result) {
    tempCumulativeTotal += row['total'] as int;
    computedCumulativeTotal[DateTime.parse(row['date'])] = tempCumulativeTotal;
  }
  
  // for(int i = 1; i < computedAccumulativeTotal.length; i++) {
  //   computedAccumulativeTotal[i] += computedAccumulativeTotal[i - 1];
  // }

  return computedCumulativeTotal;
}
