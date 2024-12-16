import 'package:collection/collection.dart';
import 'package:pernance/utils/date_utils.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:pernance/models/index.dart';
import 'package:pernance/models/transaction.dart';
import 'package:pernance/providers/categories.dart';
import 'package:pernance/utils/auth_utils.dart';

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
    final transactions = result.map(Transaction.fromRow).toList();
    return transactions;
  }

  Transaction getTransactionById(String id) {
    // Access the state from build method to here
    final transaction = state.whenOrNull(data: (transactions) => transactions.firstWhere((transaction) => transaction.id == id));
    if(transaction == null) {
      throw Error();
    }
    return transaction;
  }

  Future<void> addTransaction({required name, required price, required categoryId, required date}) async {
    await db.execute(
      'INSERT INTO transactions(id, category_id, name, price, date, user_id) VALUES(gen_random_uuid(), ?, ?, ?, ?, ?)',
      [categoryId, name, price, date.toString(), await getUserId()]
    );

    ref.invalidateSelf();
    ref.invalidate(groupedTransactionsProvider);
    ref.invalidate(cumulativeTotalTransactionProvider);
    ref.invalidate(recentTransactionsProvider);
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

@riverpod
Future<List<Transaction>> recentTransactions(/*RecentTransactionsRef*/ ref) async {
  final result = await db.getAll(
    'SELECT transactions.*, categories.name AS category_name '
    'FROM transactions '
    'LEFT JOIN categories '
    'ON categories.id = transactions.category_id '
    'WHERE transactions.date >= ?'
    'ORDER BY transactions.date DESC ',
    [midnightOf(DateTime.now()).toString()]
  );
  return result.map(Transaction.fromRow).toList();
}

@riverpod
Future<Map<String, List<Transaction>>> groupedTransactions(GroupedTransactionsRef ref, int daysAgo) async {
  final now = midnightOf(DateTime.now());
  final result = await db.getAll(
    'SELECT transactions.*, categories.name AS category_name '
    'FROM transactions '
    'LEFT JOIN categories '
    'ON categories.id = transactions.category_id '
    'WHERE transactions.date > ? '
    'ORDER BY transactions.date DESC ',
    [now.subtract(Duration(days: daysAgo)).toString()],
  );
  final transactions = result.map(Transaction.fromRow).toList();
  final groupedTransactions = groupBy<Transaction, String>(transactions, (transaction) => transaction.date.toString().split(' ')[0]);
  return groupedTransactions;
}

class DayTotalTransaction {
  final DateTime date;
  final int total;

  DayTotalTransaction({required this.date, required this.total});
}

@riverpod
Future<List<DayTotalTransaction>> cumulativeTotalTransaction(CumulativeTotalTransactionRef ref) async {
  final now = DateTime.now();
  final currentMonth = now.month.toString().padLeft(2, '0');
  final currentYear = now.year;
  final firstDayOfThisMonth = getFirstDayOfThisMonth();

  final result = await db.getAll(
    'SELECT SUM(price) AS total, date FROM transactions '
    'WHERE date > ?'
    'GROUP BY date '
    'ORDER BY date ASC ',
    ['$currentYear-$currentMonth-01 00:00:00'],
  );

  List<DayTotalTransaction> computedCumulativeTotal = [];
  int cumulativeTotalTemp = 0;
  for (DateTime d = firstDayOfThisMonth; d.isBefore(now); d = d.add(const Duration(days: 1))) {
    final row = result.firstWhereOrNull((row) => row['date'].split(' ').first == d.toString().split(' ').first);
    if (row != null) {
      cumulativeTotalTemp += row['total'] as int;
    }
    computedCumulativeTotal.add(
      DayTotalTransaction(
        date: d,
        total: cumulativeTotalTemp
      )
    );
  }

  return computedCumulativeTotal;
}

class MonthlyTransaction {
  final DateTime month;
  final List<Transaction> transactions;

  int get totalSpent {
    return transactions.fold(0, (value, element) => value + element.price);
  }

  int get budget {
    return 480000;
  }

  MonthlyTransaction({required this.month, required this.transactions});
}

@riverpod
Future<List<MonthlyTransaction>> monthlyTransactions(ref) async {
  final now = DateTime.now();
  final currentYear = now.year;
  final currentMonth = now.month;

  final result = await db.getAll(
    'SELECT transactions.*, categories.name AS category_name '
    'FROM transactions '
    'LEFT JOIN categories '
    'ON categories.id = transactions.category_id '
    'WHERE transactions.date > ? AND transactions.date < ?'
    'ORDER BY transactions.date DESC ',
    ['$currentYear-01-01 00:00:00', '${currentYear + 1}-01-01 00:00:00'],
  );

  final transactions = result.map(Transaction.fromRow).toList();
  List<MonthlyTransaction> monthlyTransactions = [];
  for (int i = 1; i <= currentMonth; i++) {
    monthlyTransactions.add(
      MonthlyTransaction(
        month: DateTime(currentYear, i),
        transactions: transactions.where((transaction) {
          return transaction.date.isAfter(DateTime(currentYear, i, 1)) && transaction.date.isBefore(DateTime(currentYear, i, 1));
        }).toList(),
    ));
  }
  return monthlyTransactions;
}