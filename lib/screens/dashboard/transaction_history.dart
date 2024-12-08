import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class TransactionHistoryScreen extends StatelessWidget {
  const TransactionHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                              children: [Text('List of monthly transaction overviews')],
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
  }
}
