import 'package:flutter/material.dart';
import 'package:pernance/models/index.dart';
// import 'package:realm/realm.dart';

import 'package:pernance/widgets/currency_text.dart';
import 'package:pernance/models/category.dart';

class CategoriesList extends StatelessWidget {
  CategoriesList({super.key});

  // final List<Category> categories = [
  //   Category(ObjectId(), 'Food & Drinks', 50000),
  //   Category(ObjectId(), 'Electronics', 50000),
  //   Category(ObjectId(), 'Entertainment', 50000),
  // ];

  @override
  Widget build(BuildContext context) {
    final categories = RealmProvider().realm.all<Category>();
    return Column(
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 3, horizontal: 0),
          child: Row(
            children: <Widget>[
              Expanded(flex: 4, child: SizedBox()),
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
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 4,
                    child: Text(categories[index].name, overflow: TextOverflow.ellipsis, maxLines: 1),
                  ),
                  Expanded(
                    flex: 3,
                    child: CurrencyText(
                      amount: categories[index].budget, // should be "spent"
                      locale: 'id-ID',
                      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const Expanded(
                    flex: 2,
                    child: Text('ProgressBar'),
                  ),
                  Expanded(
                    flex: 3,
                    child: CurrencyText(
                      amount: categories[index].budget,
                      locale: 'id-ID',
                      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
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