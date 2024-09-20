import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:pernance/models_powersync/category.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

@RoutePage()
class CategoriesChart extends StatelessWidget {
  const CategoriesChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        const Expanded(
          child: Column(
            children: <Widget>[
              Text('Info 1'),
            ],
          ),
        ),
        Expanded(
          child: SfCircularChart(
            series: <CircularSeries>[
              DoughnutSeries<Category, String>(
                // dataSource: categories,
                xValueMapper: (category, _) => category.name,
                yValueMapper: (category, _) => category.spent,
              ),
            ],
          ),
        ),
        const Expanded(
          child: Column(
            children: <Widget>[
              Text('Info 2'),
            ],
          ),
        ),
      ],
    );
  }
}