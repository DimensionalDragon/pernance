import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:pernance/widgets/transactions_list_per_day.dart';

@RoutePage()
class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
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
                      print('add transaction button pressed');
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
                  children: [TransactionsListPerDay()],
                ),
              )
            )
          ],
        ),
      )
    );
  }
}