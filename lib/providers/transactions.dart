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

class DayTotalTransaction {
  final DateTime date;
  final int total;

  DayTotalTransaction({required this.date, required this.total});
}

@riverpod
Future<List<DayTotalTransaction>> cumulativeTotalTransaction() async {
  final currentMonth = DateTime.now().month.toString().padLeft(2, '0');
  final currentYear = DateTime.now().year;
  final result = await db.getAll(
    'SELECT SUM(price), date AS total FROM transactions '
    'WHERE date > ?'
    'GROUP BY date '
    'ORDER BY date ASC ',
    ['$currentYear-$currentMonth-01 00:00:00'],
  );

  List<DayTotalTransaction> computedCumulativeTotal = [];
  int cumulativeTotalTemp = 0;
  for (int i = 0; i < result.length; i++) {
    cumulativeTotalTemp += int.parse(result[i]['total']);
    computedCumulativeTotal.add(DayTotalTransaction(date: DateTime.parse(result[i]['date']), total: cumulativeTotalTemp));
  }
  return computedCumulativeTotal;
}
