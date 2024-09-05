import 'package:flutter/material.dart';
import 'package:realm/realm.dart';

import 'package:pernance/widgets/currency_text.dart';
import 'package:pernance/models/category.dart';
import 'package:pernance/models/transaction.dart';

class TransactionsListPerDay extends StatelessWidget {
  TransactionsListPerDay({super.key});

  final List<FinancialTransaction> transactions = [
    FinancialTransaction(ObjectId(), 'Groceries', 200000, DateTime(2024, 9, 5, 12, 30, 0), category: Category(ObjectId(), 'Food & Drinks', 50000)),
    FinancialTransaction(ObjectId(), 'Headphone', 100000, DateTime(2024, 9, 5, 12, 30, 0), category: Category(ObjectId(), 'Electronics', 50000)),
    FinancialTransaction(ObjectId(), 'WuWa Subscription', 83000, DateTime(2024, 9, 5, 12, 30, 0), category: Category(ObjectId(), 'Entertainment', 50000)),
    FinancialTransaction(ObjectId(), 'Zhengda Chicken', 45000, DateTime(2024, 9, 5, 12, 30, 0), category: Category(ObjectId(), 'Food & Drinks', 50000)),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Text('Today', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey)),
        ListView.builder(
          shrinkWrap: true,
          itemCount: transactions.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: Text(transactions[index].name, overflow: TextOverflow.ellipsis, maxLines: 1),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 1),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20), // Adjust for desired oval shape
                        border: Border.all(
                          color: Colors.blue,
                          width: 0.75,
                        ),
                      ),
                      child: Text(transactions[index].category!.name, textAlign: TextAlign.center, style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.blue)),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: CurrencyText(
                      amount: transactions[index].price,
                      locale: 'id-ID',
                      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
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