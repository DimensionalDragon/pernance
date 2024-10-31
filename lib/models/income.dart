import "package:powersync/powersync.dart";
import "package:powersync/sqlite3.dart";

const incomeSchema = Table(
  'incomes',
  [
    Column.integer('amount'),
    Column.text('date'),
    Column.text('created_at'), 
    Column.text('user_id')
  ],
);

class Income {
  final String id;
  final int amount;
  final DateTime date;
  final String createdAt;
  final String userId;

  Income({
    required this.id,
    required this.amount,
    required this.date,
    required this.createdAt,
    required this.userId,
  });

  factory Income.fromRow(Row row) {
    return Income(
      id: row['id'],
      amount: row['price'] ?? 0,
      date: DateTime.parse(row['date']),
      createdAt: row['created_at'] ?? 'null',
      userId: row['user_id'] ?? 'null',
    );
  }
}