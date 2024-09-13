import "package:powersync/powersync.dart";

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
  final String name;
  final int budget;
  final int spent;
  final String createdAt;
  final String userId;

  Category({
    required this.name,
    required this.budget,
    required this.spent,
    required this.createdAt,
    required this.userId,
  });

  factory Category.fromRow(row) {
    return Category(
      name: row['name'] as String,
      budget: row['budget'] as int,
      spent: row['spent'] as int,
      createdAt: row['created_at'] as String,
      userId: row['user_id'] as String,
    );
  }
}