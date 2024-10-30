import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:pernance/providers/transactions.dart';
import 'package:pernance/routes/routes.dart';
import 'package:pernance/widgets/currency_text.dart';

class RecentTransactions extends ConsumerWidget {
  const RecentTransactions({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = AutoRouter.of(context);
    final recentTransactionsRef = ref.watch(recentTransactionsProvider);
    return recentTransactionsRef.when(
      data: (transactionsData) {
        if (transactionsData.isEmpty) {
          return const SizedBox();
        }
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    'Transactions for today',
                    style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () => router.navigate(const TransactionsRoute()),
                    style: ButtonStyle(padding: WidgetStateProperty.all<EdgeInsets>(const EdgeInsets.symmetric(horizontal: 3))),
                    child: const Text('View All >'),
                  ),
                ]
              ),
            ),
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: transactionsData.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(transactionsData[index].name),
                    subtitle: Text(transactionsData[index].categoryName),
                    trailing: CurrencyText(
                      amount: transactionsData[index].price,
                      locale: 'id-ID',
                      style: const TextStyle(fontSize: 15),
                    ),
                  );
                }
              ),
            )
          ],
        );
      },
      error: (e, stackTrace) => const Text('An error occured'),
      loading: () => const CircularProgressIndicator()
    );
  }
}