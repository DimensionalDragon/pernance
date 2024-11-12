import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:auto_route/auto_route.dart';
import 'package:uuid/uuid.dart';

import 'package:pernance/routes/routes.dart';
import 'package:pernance/providers/categories.dart';
import 'package:pernance/models/category.dart';
import 'package:pernance/widgets/currency_text.dart';

class CategoriesOverview extends ConsumerWidget {
  const CategoriesOverview({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = AutoRouter.of(context);
    final categoriesRef = ref.watch(categoriesNotifierProvider);
    return categoriesRef.when(
      data: (categoriesData) {
        final List<Category> categories = List.from(categoriesData);
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    'Categories Overview',
                    style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () => router.navigate(const CategoriesRoute()),
                    style: ButtonStyle(padding: WidgetStateProperty.all<EdgeInsets>(const EdgeInsets.symmetric(horizontal: 3))),
                    child: const Text('View All >'),
                  ),
                ]
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: categories.map((category) {
                      final chartCategories = [category]; // Start with just the category
                      /* If total spent in this category is less than budgeted, create a dummy "no color" category */
                      if (category.budget - category.spent > 0) {
                        final dummyEmptyCategory = Category(
                          id: const Uuid().v4(),
                          name: '',
                          budget: 0,
                          spent: category.budget - category.spent,
                          createdAt: DateTime.now().toString(),
                          userId: const Uuid().v4()
                        );
                        chartCategories.add(dummyEmptyCategory);
                      }
              
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 60,
                              width: 60,
                              child: SfCircularChart(
                                margin: EdgeInsets.zero,
                                series: <CircularSeries>[
                                  DoughnutSeries<Category, String>(
                                      dataSource: chartCategories,
                                      pointColorMapper: (c, _) => c.name == '' ? const Color.fromARGB(255, 223, 223, 223) : Colors.green,
                                      xValueMapper: (c, _) => c.name,
                                      yValueMapper: (c, _) => c.spent,
                                      innerRadius: '75%',
                                      animationDuration: 0),
                                ],
                              ),
                            ),
                            Text(
                              category.name,
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                            ),
                            Row(
                              children: <Widget>[
                                CurrencyText(
                                  amount: (category.budget - category.spent).abs(),
                                  locale: 'id-ID',
                                  style: const TextStyle(fontSize: 11),
                                ),
                                Text(
                                  category.spent < category.budget ? ' under' : ' over',
                                  style: const TextStyle(fontSize: 11),
                                ),
                              ]
                            ),
                          ]
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ],
        );
      },
      error: (error, stackTrace) => const Text('Something went wrong'),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
