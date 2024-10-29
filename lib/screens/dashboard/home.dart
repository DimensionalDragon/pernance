import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pernance/widgets/categories_overview.dart';
import 'package:pernance/widgets/overview_chart.dart';
import 'package:pernance/widgets/recent_transactions.dart';

// import 'package:pernance/widgets/categories_list.dart';
// import 'package:pernance/routes/routes.dart';
// import 'package:pernance/widgets/categories_chart.dart';

@RoutePage()
class DashboardHomeScreen extends ConsumerWidget {
  const DashboardHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final router = AutoRouter.of(context);
    return const Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                children: <Widget>[
                  OverviewChart(),
                  SizedBox(height: 15),
                  RecentTransactions(),
                  SizedBox(height: 15),
                  CategoriesOverview(),
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}
