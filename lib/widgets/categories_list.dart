import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pernance/providers/categories.dart';

import 'package:pernance/widgets/currency_text.dart';

class CategoriesList extends ConsumerWidget {

  const CategoriesList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesRef = ref.watch(categoriesNotifierProvider);
    return categoriesRef.when(
      data: (categoriesData) {
        return Column(
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 3, horizontal: 0),
              child: Row(
                children: <Widget>[
                  Expanded(flex: 3, child: SizedBox()),
                  Expanded(
                    flex: 3,
                    child: Text('SPENT', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.grey), textAlign: TextAlign.center),
                  ),
                  Expanded(flex: 2, child: SizedBox()),
                  Expanded(
                    flex: 3,
                    child: Text('BUDGET', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.grey), textAlign: TextAlign.end),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5),
            ListView.builder(
              shrinkWrap: true,
              itemCount: categoriesData.length,
              itemBuilder: (BuildContext context, int index) {
                final percentageOfBudgetSpent = categoriesData[index].spent / categoriesData[index].budget;
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 3,
                        child: InkWell(
                          child: Text(
                            categoriesData[index].name,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: const TextStyle(fontSize: 13),
                          ),
                          onTap: () {
                            showModalBottomSheet(context: context, builder: (context) => Text(categoriesData[index].name));
                          }
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: CurrencyText(
                          amount: categoriesData[index].spent,
                          locale: 'id-ID',
                          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: LinearProgressIndicator(
                          value: percentageOfBudgetSpent,
                          backgroundColor: Colors.grey,
                          valueColor: AlwaysStoppedAnimation(percentageOfBudgetSpent <= 0.25 ? Colors.lightGreen : percentageOfBudgetSpent <= 0.75 ? Colors.yellow : Colors.red),
                          minHeight: 8,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: CurrencyText(
                          amount: categoriesData[index].budget,
                          locale: 'id-ID',
                          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  ),
                );
              }
            ),
          ],
        );
      },
      error: (error, stackTrace) => const Text('Something went wrong'),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}