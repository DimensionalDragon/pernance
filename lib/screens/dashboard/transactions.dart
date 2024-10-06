import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';

import 'package:pernance/routes/routes.dart';
import 'package:pernance/widgets/transactions_list_per_day.dart';

@RoutePage()
class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  @override
  Widget build(BuildContext context) {
    final router = AutoRouter.of(context);

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
                    children: <Widget>[
                      for (int i = 0; i < 31; i++)
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 1.5),
                          child: TransactionsListPerDay(
                            transactionDate: DateTime.now().subtract(Duration(days: i))
                          )
                        ) 
                    ],
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