import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pernance/models/transaction.dart';
import 'package:pernance/providers/transactions.dart';

import 'package:pernance/routes/routes.dart';
import 'package:pernance/utils/date_utils.dart';
import 'package:pernance/widgets/transactions_list_section.dart';

@RoutePage()
class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TransactionsScreenConsumer();
  }
}

class TransactionsScreenConsumer extends ConsumerStatefulWidget {
  const TransactionsScreenConsumer({super.key});

  @override
  ConsumerState<TransactionsScreenConsumer> createState() => _TransactionsScreenConsumerState();
}

class _TransactionsScreenConsumerState extends ConsumerState<TransactionsScreenConsumer> {
  int numberOfWeeksToQuery = 10;

  @override
  Widget build(BuildContext context) {
    final router = AutoRouter.of(context);
    final transactionsRef = ref.watch(groupedTransactionsProvider(7 * numberOfWeeksToQuery));
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                children: <Widget>[
                  // const SearchBar(),
                  const SizedBox(height: 7),
                  OutlinedButton(
                    style: ButtonStyle(
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                      )
                    ),
                    onPressed: () {
                      router.push(const AddTransactionRoute());
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add),
                        Text('Add Transaction'),
                      ],
                    )
                  ),
                ]
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: SingleChildScrollView(
                  child: Column(
                    children: transactionsRef.when(
                      data: (transactionsData) {
                        final List<TransactionsListSection> transactionsSections = [];
                        for (int i = 0; i < 7; i++) {
                          final iDaysAgoDateString = DateTime.now().subtract(Duration(days: i)).toString().split(' ')[0];
                          if(transactionsData.containsKey(iDaysAgoDateString)) {
                            transactionsSections.add(
                              TransactionsListSection(
                                transactions: transactionsData[iDaysAgoDateString]!,
                                label: (i == 0) ? 'Today' : (i == 1) ? 'Yesterday' : '$i Days Ago',
                              )
                            );
                          }
                        }
                        if(numberOfWeeksToQuery <= 1) return transactionsSections;

                        // Start the query for previous weeks, now grouped by week instead of day
                        for(int i = 1; i <= numberOfWeeksToQuery - 1; i++) {
                          final iWeeksAgoEnd = midnightOf(DateTime.now().subtract(Duration(days: 7 * i)));
                          final iWeeksAgoStart = iWeeksAgoEnd.subtract(const Duration(days: 6));

                          List<Transaction> iWeeksAgoTransactions = []; 
                          for(DateTime d = iWeeksAgoEnd; d.isAfter(iWeeksAgoStart); d = d.subtract(const Duration(days: 1))) {
                            if(transactionsData.containsKey(d.toString().split(' ').first)) {
                              iWeeksAgoTransactions.addAll(transactionsData[d.toString().split(' ').first]!);
                            }
                          }

                          transactionsSections.add(
                            TransactionsListSection(
                              transactions: iWeeksAgoTransactions,
                              label: (i == 1) ? 'A Week Ago' : '$i Weeks Ago',
                            )
                          );
                        }
                        return transactionsSections;
                      },
                      error: (e, stackTrace) => [const Text('An error occured')],
                      loading: () => [const CircularProgressIndicator()]
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}