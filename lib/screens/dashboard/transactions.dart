import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:pernance/routes/routes.dart';
import 'package:pernance/widgets/transactions_list_section.dart';

@RoutePage()
class TransactionsScreen extends ConsumerStatefulWidget {
  const TransactionsScreen({super.key});

  @override
  ConsumerState<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends ConsumerState<TransactionsScreen> {
  int numberOfWeeksToQuery = 1;

  @override
  Widget build(BuildContext context) {
    final router = AutoRouter.of(context);
    // final transactionsRef = ref.watch(transactionsNotifierProvider);
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
                    children: List.generate(10, (i) {
                      if (i < 7) {
                        final startDate = DateTime.parse(DateTime.now().subtract(Duration(days: i)).toString().split(' ').first);
                        final endDate = DateTime.parse(DateTime.now().subtract(Duration(days: i - 1)).toString().split(' ').first);
                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 1.5),
                          child: TransactionsListSection(
                            startDate: startDate,
                            endDate: endDate,
                            label: (i == 0) ? 'Today' : (i == 1) ? 'Yesterday' : '$i Days Ago',
                          )
                        );
                      }

                      // From here, i starts at 7, increment of i
                      // Is not about days anymore, but weeks,
                      // So "7" means A week ago, "8" means 2 weeks ago, etc.
                      // This calculates how many days to subtract to get
                      // the start and end date of "n weeks ago"
                      final numberOfWeeksAgo = i - 6;
                      final nWeeksAgoStartInDays = 7 * (numberOfWeeksAgo + 1) - 1;
                      final nWeeksAgoEndInDays = 7 * numberOfWeeksAgo - 1;

                      final startDate = DateTime.parse(DateTime.now().subtract(Duration(days: nWeeksAgoStartInDays)).toString().split(' ').first);
                      final endDate = DateTime.parse(DateTime.now().subtract(Duration(days: nWeeksAgoEndInDays)).toString().split(' ').first);

                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 1.5),
                        child: TransactionsListSection(
                          startDate: startDate,
                          endDate: endDate,
                          label: (i == 7) ? 'A Week Ago' : '$i Weeks Ago',
                        )
                      );
                    }),
                    // children: <Widget>[
                    //   for (int i = 0; i < 31; i++)
                    //     Container(
                    //       margin: const EdgeInsets.symmetric(vertical: 1.5),
                    //       child: TransactionsListPerDay(
                    //         transactionDate: DateTime.now().subtract(Duration(days: i))
                    //       )
                    //     ) 
                    // ],
                  ),
                ),
              )
            )
          ],
        ),
      )
    );
  }
}