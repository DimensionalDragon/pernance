import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pernance/providers/categories.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:pernance/models/category.dart';
import 'package:pernance/widgets/currency_text.dart';

class CategoriesOverview extends ConsumerWidget {
  const CategoriesOverview({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesRef = ref.watch(categoriesNotifierProvider);
    return categoriesRef.when(
      data: (categoriesData) {
        final List<Category> categories = List.from(categoriesData);
        // final totalSpent = categories.fold(0, (total, current) => total + current.spent);
        // final categoryBudget = categories.map((category) => category.budget);

        // if (categoryBudget - totalSpent > 0) {
        //   final dummyEmptyCategory = Category(
        //     id: const Uuid().v4(),
        //     name: '',
        //     budget: 0,
        //     spent: categoryBudget - totalSpent,
        //     createdAt: DateTime.now().toString(),
        //     userId: const Uuid().v4()
        //   );
        //   categories.add(dummyEmptyCategory);
        // }

        return Card(
          elevation: 3,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: Colors.grey.shade100,
          child: Row(
            children: categories.map((category) {
              return Column(
                children: [
                  Text(category.name),
                  CurrencyText(amount: category.budget, locale: 'id-ID'),
                ]
              );
            }).toList(),
          ),
        );
      },
      error: (error, stackTrace) => const Text('Something went wrong'),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
