import 'package:flutter/material.dart';
import 'package:pernance/models_powersync/transaction.dart';
import 'package:pernance/utils/is_same_date.dart';
import 'package:powersync/sqlite3.dart' as sqlite;

import 'package:pernance/widgets/currency_text.dart';

class TransactionsListPerDay extends StatelessWidget {
  const TransactionsListPerDay({super.key, required this.transactionsQueryResult, required this.transactionDate});

  final Future<sqlite.ResultSet> transactionsQueryResult;
  final DateTime transactionDate;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: transactionsQueryResult,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(height: 0, width: 0);
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        final transactions = snapshot.data!.map((row) => Transaction.fromRow(row)).where((transaction) => isSameDate(transactionDate, transaction.date)).toList();
        final manyDaysAgo = DateTime.now().difference(transactionDate).inDays;
        final dateLabelText = manyDaysAgo == 0 ? 'Today' : manyDaysAgo == 1 ? 'Yesterday' : manyDaysAgo <= 7 ? '$manyDaysAgo Days Ago' : '${transactionDate.day}/${transactionDate.month}/${transactionDate.year}';

        if (transactions.isEmpty) {
          return const SizedBox(height: 0, width: 0);
        }

        return Column(
          children: <Widget>[
            Text(dateLabelText, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey)),
            const SizedBox(height: 5),
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
                          child: Text(
                            transactions[index].categoryName,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue
                            ),
                          ),
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
    );
  }
}