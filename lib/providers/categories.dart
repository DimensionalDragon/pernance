import 'package:pernance/models/category.dart';
import 'package:pernance/models/index.dart';
import 'package:pernance/utils/auth_utils.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'categories.g.dart';

@riverpod
class CategoriesNotifier extends _$CategoriesNotifier {
  @override
  Future<List<Category>> build() async {
    final currentMonth = DateTime.now().month.toString().padLeft(2, '0');
    final currentYear = DateTime.now().year;
    final result = await db.getAll(
      'SELECT categories.*, SUM(IFNULL(monthly_transactions.price, 0)) AS spent '
      'FROM categories '
      "LEFT JOIN (SELECT * FROM transactions WHERE date > ?) AS monthly_transactions "
      'ON categories.id = monthly_transactions.category_id '
      'GROUP BY categories.id ',
      ['$currentYear-$currentMonth-01 00:00:00'], // Only fetch the categories that are in this month
    );
    final categories = result.map((row) => Category.fromRow(row)).toList();
    return categories;
  }

  Future<void> addCategory({required name, required budget}) async {
    await db.execute(
      'INSERT INTO categories(id, name, budget, user_id) VALUES(gen_random_uuid(), ?, ?, ?)',
      [name, budget, await getUserId()]
    );

    ref.invalidateSelf();
    await future;
  }

  Future<void> updateCategory(id, {required name, required budget}) async {
    await db.execute(
      'UPDATE categories SET name = ?, budget = ? WHERE id = ? AND user_id = ?',
      [name, budget, id, await getUserId()],
    );

    ref.invalidateSelf();
    await future;
  }
}
