import "package:powersync/powersync.dart";
import "package:powersync/sqlite3.dart";

const subtransactionSchema = Table(
  'subtransactions',
  [ 
    Column.text('name'),
    Column.integer('price'),
    Column.text('transaction_id'),
    Column.text('created_at'), 
    Column.text('user_id')
  ],
  indexes: [
    Index('transaction', [IndexedColumn('transaction_id')])
  ]
);

class Subtransaction {
  final String id;
  final String name;
  final int price;
  final String transactionId;
  final String createdAt;
  final String userId;

  Subtransaction({
    required this.id,
    required this.name,
    required this.price,
    required this.transactionId,
    required this.createdAt,
    required this.userId,
  });

  factory Subtransaction.fromRow(Row row) {
    return Subtransaction(
      id: row['id'],
      name: row['name'] ?? 'null',
      price: row['price'] ?? 0,
      transactionId: row['transaction_id'] ?? 'null',
      createdAt: row['created_at'] ?? 'null',
      userId: row['user_id'] ?? 'null',
    );
  }
}