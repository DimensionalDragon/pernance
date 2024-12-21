import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pernance/providers/transactions.dart';

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
    final router = Navigator.of(context);
    final autoRouter = AutoRouter.of(context);
    final monthlyTransactionsRef = ref.watch(monthlyTransactionsProvider);

    return monthlyTransactionsRef.when(
      data: (monthlyTransactions) {
        return const Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Scaffold(
                    body: SafeArea(
                      child: Column(
                        children: [
                          Text('Transaction History'),
                          SizedBox(height: 7),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text('December'),
                                        Text('Budget: x'),
                                        Text('Spent: y'),
                                        Text('Progress Bar'),
                                      ],
                                    ),
                                  ],
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
