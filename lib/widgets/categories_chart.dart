import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pernance/providers/categories.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:uuid/uuid.dart';

import 'package:pernance/models/category.dart';
import 'package:pernance/widgets/currency_text.dart';

class CategoriesChart extends ConsumerWidget {
  const CategoriesChart({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesRef = ref.watch(categoriesNotifierProvider);
    return categoriesRef.when(
      data: (categoriesData) {
        final List<Category> categories = List.from(categoriesData);
        final totalSpent = categories.fold(0, (total, current) => total + current.spent);
        const totalBudget = 480000;
        if (totalBudget - totalSpent > 0) {
          final dummyEmptyCategory = Category(
            id: const Uuid().v4(),
            name: '',
            budget: 0,
            spent: totalBudget - totalSpent,
            createdAt: DateTime.now().toString(),
            userId: const Uuid().v4()
          );
          categories.add(dummyEmptyCategory);
        }

        return Card(
          elevation: 3,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: Colors.grey.shade100,
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: <Widget>[
                      CurrencyText(
                        locale: 'id-ID',
                        amount: totalSpent,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      Text(
                        'Spent this month',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: SizedBox(
                  height: 100,
                  child: SfCircularChart(
                    margin: EdgeInsets.zero,
                    series: <CircularSeries>[
                      DoughnutSeries(
                          dataSource: const ['dummy'],
                          pointColorMapper: (_, __) => const Color.fromARGB(255, 223, 223, 223),
                          xValueMapper: (s, __) => s,
                          yValueMapper: (_, __) => 100,
                          innerRadius: '75%',
                          animationDuration: 0),
                      DoughnutSeries<Category, String>(
                        dataSource: categories,
                        pointColorMapper: (category, _) => category.name == '' ? Colors.transparent : null,
                        xValueMapper: (category, _) => category.name,
                        yValueMapper: (category, _) => category.spent,
                        innerRadius: '75%',
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: <Widget>[
                      CurrencyText(
                        locale: 'id-ID',
                        amount: totalBudget,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      Text(
                        "This month's budget",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
      error: (error, stackTrace) => const Text('Something went wrong'),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
