import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pernance/providers/transactions.dart';
import 'package:pernance/widgets/currency_text.dart';

class TransactionDetail extends ConsumerWidget {
  const TransactionDetail({super.key, required this.transactionID});

  final String transactionID;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = AutoRouter.of(context);
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(onPressed: () => router.back(), icon: const Icon(Icons.arrow_back, color: Colors.blue)),
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
                          onPressed: () => router.back(),
                          child: const Text('No'),
                        ),
                        TextButton(
                          onPressed: () async {
                            await ref.read(transactionsNotifierProvider.notifier).deleteTransaction(transactionID);
                            router.back();
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
        const Row(
          children: <Widget>[
            CurrencyText(amount: 16000), // TODO: make this editable
            Text('Overview')
          ],
        ),
        const Text('Graphs'),
        const Text('More Infos')
      ]
    );
  }
}
