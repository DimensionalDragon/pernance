import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:powersync/sqlite3.dart' as sqlite;

import 'package:pernance/models_powersync/index.dart';
import 'package:pernance/routes/routes.dart';
import 'package:pernance/widgets/transactions_list_per_day.dart';

@RoutePage()
class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  late Future<sqlite.ResultSet> _data;

  void _updateData() {
    setState(() {
      _data = db.getAll(
        'SELECT transactions.*, categories.name AS category_name '
        'FROM transactions '
        'LEFT JOIN categories '
        'ON categories.id = transactions.category_id '
        'ORDER BY transactions.date DESC '
      );
    });
  }

  @override
  void initState() {
    super.initState();
    _updateData();
  }

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
                children: [
                  // const SearchBar(),
                  const SizedBox(height: 7),
                  OutlinedButton(
                    style: ButtonStyle(
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                        )
                      ),
                    onPressed: () {
                      router.push(AddTransactionRoute(onSubmit: _updateData));
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add),
                        Text('Add Transaction'),
                      ],
                    )
                  ),
                ]),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Column(
                  children: [
                    for (int i = 0; i < 10; i++) 
                      TransactionsListPerDay(
                        transactionsQueryResult: _data,
                        transactionDate: DateTime.now().subtract(Duration(days: i))
                      )
                  ],
                ),
              )
            )
          ],
        ),
      )
    );
  }
}