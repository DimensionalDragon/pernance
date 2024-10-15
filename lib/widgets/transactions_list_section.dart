import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:pernance/providers/transactions.dart';
import 'package:pernance/models/transaction.dart';
import 'package:pernance/widgets/currency_text.dart';
import 'package:pernance/widgets/transaction_detail.dart';

class TransactionsListSection extends ConsumerWidget {
  const TransactionsListSection({super.key, required this.startDate, required this.endDate, required this.label, this.transactions});

  final DateTime startDate;
  final DateTime endDate;
  final String label;
  final List<Transaction>? transactions;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactionsRef = ref.watch(transactionsNotifierProvider);
    return transactionsRef.when(
      data: (transactionsData) {
        final List<Transaction> transactions = transactionsData.where((transaction) => (
          transaction.date.isAfter(startDate) && transaction.date.isBefore(endDate.add(const Duration(days: 1))))
        ).toList();
        final dateLabelText = label;

        if (transactions.isEmpty) {
          return const SizedBox(height: 0, width: 0);
        }
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 3),
          child: Column(
            children: <Widget>[
              Text(dateLabelText, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey)),
              const SizedBox(height: 5),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: transactions.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 0),
                    child: InkWell(
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
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          useSafeArea: true,
                          builder: (BuildContext context) => TransactionDetail(transactionID: transactions[index].id),
                        );
                      }
                    ),
                  );
                }
              ),
            ],
          ),
        );
      },
      error: (error, stackTrace) => const SizedBox(),
      loading: () => const SizedBox(),
    );
  }
}