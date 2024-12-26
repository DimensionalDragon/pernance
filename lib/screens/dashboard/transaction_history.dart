import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pernance/providers/transactions.dart';
import 'package:pernance/utils/date_utils.dart';

@RoutePage()
class TransactionHistoryScreen extends StatelessWidget {
  const TransactionHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TransactionHistory();
  }
}

class TransactionHistory extends ConsumerWidget {
  const TransactionHistory({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final router = Navigator.of(context);
    // final autoRouter = AutoRouter.of(context);
    final monthlyTransactionsRef = ref.watch(monthlyTransactionsProvider);

    return monthlyTransactionsRef.when(
      data: (monthlyTransactions) {
        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Scaffold(
                    body: SafeArea(
                      child: Column(
                        children: <Widget>[
                          const Text('Transaction History'),
                          const SizedBox(height: 7),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                              child: SingleChildScrollView(
                                child: Column(
                                  children: monthlyTransactions.map((monthlyTransaction) {
                                    return Row(
                                      children: [
                                        Text(getMonthName(monthlyTransaction.month)),
                                        Text('Budget: ${monthlyTransaction.budget}'),
                                        Text('Spent: ${monthlyTransaction.totalSpent}'),
                                        LinearProgressIndicator(
                                          value: monthlyTransaction.totalSpent / monthlyTransaction.budget,
                                          backgroundColor: Colors.grey,
                                          valueColor: AlwaysStoppedAnimation(monthlyTransaction.totalSpent / monthlyTransaction.budget <= 0.25 ? Colors.lightGreen : monthlyTransaction.totalSpent / monthlyTransaction.budget <= 0.75 ? Colors.yellow : Colors.red),
                                          minHeight: 8,
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                      ],
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ),
                  ),
                ),
              ],
            ),
          ),
        );  
      },
      error: (error, stackTrace) => const Text('Something went wrong'),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
