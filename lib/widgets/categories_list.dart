import 'package:flutter/material.dart';
import 'package:powersync/sqlite3.dart' as sqlite;

import 'package:pernance/widgets/currency_text.dart';
import 'package:pernance/models_powersync/category.dart';

class CategoriesList extends StatelessWidget {

  const CategoriesList({super.key, required this.categoriesQueryResult});

  final Future<sqlite.ResultSet> categoriesQueryResult;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: categoriesQueryResult,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        final categories = snapshot.data!.map((row) => Category.fromRow(row)).toList();
        
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
              itemCount: categories.length,
              itemBuilder: (BuildContext context, int index) {
                final percentageOfBudgetSpent = categories[index].spent / categories[index].budget;
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 3,
                        child: InkWell(
                          child: Text(
                            categories[index].name,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: const TextStyle(fontSize: 13),
                          ),
                          onTap: () {
                            print('category tapped:');
                            print(categories[index].name);
                          }
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: CurrencyText(
                          amount: categories[index].spent,
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
                          amount: categories[index].budget,
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
    );
  }
}