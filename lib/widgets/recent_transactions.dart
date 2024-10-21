import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:pernance/providers/transactions.dart';
import 'package:pernance/widgets/currency_text.dart';

class RecentTransactions extends ConsumerWidget {
  const RecentTransactions({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recentTransactionsRef = ref.watch(recentTransactionsProvider);
    return recentTransactionsRef.when(
      data: (transactionsData) {
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: transactionsData.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(transactionsData[index].name),
              subtitle: Text(transactionsData[index].categoryName),
              trailing: CurrencyText(amount: transactionsData[index].price, locale: 'id-ID'),
            );
          }
        );
      },
      error: (e, stackTrace) => const Text('An error occured'),
      loading: () => const CircularProgressIndicator()
    );
  }
}