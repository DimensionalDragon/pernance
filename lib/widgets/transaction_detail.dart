import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:pernance/providers/transactions.dart';
import 'package:pernance/routes/routes.dart';
import 'package:pernance/widgets/currency_text.dart';

class TransactionDetail extends ConsumerWidget {
  const TransactionDetail({super.key, required this.transactionID});

  final String transactionID;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = Navigator.of(context);
    final autoRouter = AutoRouter.of(context);
    final transactionsRef = ref.watch(transactionsNotifierProvider);
    return transactionsRef.when(
      data: (transactionsData) {
        final transaction = transactionsData.firstWhere((transaction) => transaction.id == transactionID);
        return Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(onPressed: () => router.pop(), icon: const Icon(Icons.arrow_back, color: Colors.blue)),
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Delete Confirmation'),
                          content: const Text('Are you sure you want to delete this transaction?'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => router.pop(),
                              child: const Text('No'),
                            ),
                            TextButton(
                              onPressed: () async {
                                await ref.read(transactionsNotifierProvider.notifier).deleteTransaction(transactionID);
                                await autoRouter.navigate(const TransactionsRoute());
                              },
                              child: const Text('Yes'),
                            ),
                          ],
                        );
                      }
                    );
                  },
                  icon: const Icon(Icons.delete, color: Colors.red)
                ),
              ],
            ),
            Column(
              children: <Widget>[
                Text(
                  transaction.name,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                CurrencyText(
                  amount: transaction.price,
                  locale: 'id-ID',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ), // TODO: make this editable
                Text(
                  'Date: ${transaction.date.toString().split(' ')}',
                  style: const TextStyle(fontSize: 12),
                ),
                const Text('More Overview')
              ],
            ),
            const Text('Graphs'),
            const Text('More Infos')
          ]
        );
      },
      error: (error, stackTrace) => const Text('Something went wrong'),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
