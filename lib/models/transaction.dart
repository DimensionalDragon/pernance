import "package:powersync/powersync.dart";
import "package:powersync/sqlite3.dart";

const transactionSchema = Table(
  'transactions',
  [ 
    Column.text('name'),
    Column.text('category_id'),
    Column.integer('price'),
    Column.text('date'),
    Column.text('created_at'), 
    Column.text('user_id')
  ],
  indexes: [
    Index('category', [IndexedColumn('category_id')])
  ]
);

class Transaction {
  final String id;
  final String name;
  final String categoryId;
  final String categoryName;
  final int price;
  final DateTime date;
  final String createdAt;
  final String userId;

  Transaction({
    required this.id,
    required this.name,
    required this.categoryId,
    required this.categoryName,
    required this.price,
    required this.date,
    required this.createdAt,
    required this.userId,
  });

  factory Transaction.fromRow(Row row) {
    return Transaction(
      id: row['id'],
      name: row['name'] ?? 'null',
      categoryId: row['category_id'] ?? 'null',
      categoryName: row['category_name'] ?? 'null',
      price: row['price'] ?? 0,
      date: DateTime.parse(row['date']),
      createdAt: row['created_at'] ?? 'null',
      userId: row['user_id'] ?? 'null',
    );
  }
}