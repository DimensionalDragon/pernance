import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:powersync/sqlite3.dart' as sqlite;

import 'package:pernance/models_powersync/category.dart';

@RoutePage()
class CategoriesChart extends StatelessWidget {
  const CategoriesChart({super.key, required this.categoriesQueryResult});

  final Future<sqlite.ResultSet> categoriesQueryResult;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: categoriesQueryResult,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        final categories = snapshot.data!.map((row) => Category.fromRow(row)).toList();

        return Row(
          children: <Widget>[
            const Expanded(
              child: Column(
                children: <Widget>[
                  Text('Rp 10,000'),
                  Text('Spent this month'),
                ],
              ),
            ),
            Expanded(
              child: SfCircularChart(
                series: <CircularSeries>[
                  DoughnutSeries<Category, String>(
                    dataSource: categories,
                    xValueMapper: (category, _) => category.name,
                    yValueMapper: (category, _) => category.spent,
                  ),
                ],
              ),
            ),
            const Expanded(
              child: Column(
                children: <Widget>[
                  Text('Rp 100,000'),
                  Text('Total budget for this month'),
                ],
              ),
            ),
          ],
        );
      }
    );
  }
}
