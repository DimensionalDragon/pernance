import 'package:flutter/material.dart';

import 'package:pernance/widgets/currency_text.dart';
import 'package:pernance/models_powersync/category.dart';

class CategoriesList extends StatelessWidget {

  const CategoriesList({super.key, required this.categoriesData});

  final List<Category> categoriesData;

  @override
  Widget build(BuildContext context) {
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
                        print('category tapped:');
                        print(categoriesData[index].name);
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
  }
}