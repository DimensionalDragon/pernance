import "package:powersync/powersync.dart";
import 'package:powersync/sqlite3.dart';

const categorySchema = Table(
  'categories',
  [ 
    Column.text('name'),
    Column.integer('budget'),
    Column.text('created_at'), 
    Column.text('user_id')
  ]
);

class Category {
  final String id;
  final String name;
  final int budget;
  final int spent;
  final String createdAt;
  final String userId;

  Category({
    required this.id,
    required this.name,
    required this.budget,
    required this.spent,
    required this.createdAt,
    required this.userId,
  });

  factory Category.fromRow(Row row) {
    return Category(
      id: row['id'],
      name: row['name'] ?? 'null',
      budget: row['budget'] ?? 0,
      spent: row['spent'] ?? 0,
      createdAt: row['created_at'] ?? 'null',
      userId: row['user_id'] ?? 'null',
    );
  }
}