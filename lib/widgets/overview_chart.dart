import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:pernance/providers/transactions.dart';

class OverviewChart extends ConsumerWidget {
  const OverviewChart({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final overviewRef = ref.watch(cumulativeTotalTransactionProvider);
    return overviewRef.when(
      data: (overviewData) {
        const totalBudget = 480000;

        final now = DateTime.now();
        final currentMonth = now.month.toString().padLeft(2, '0');
        final nextMonth = (now.month + 1).toString().padLeft(2, '0');
        final currentYear = now.year;
        final firstDateOfThisMonth = DateTime.parse('$currentYear-$currentMonth-01 00:00:00');
        final lastDateOfThisMonth = DateTime.parse('$currentYear-$nextMonth-01 00:00:00').subtract(const Duration(days: 1));

        return Card(
          elevation: 3,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: Colors.grey.shade100,
          child: SizedBox(
            height: 100,
            child: SfCartesianChart(
              primaryXAxis: const DateTimeAxis(intervalType: DateTimeIntervalType.days),
              margin: EdgeInsets.zero,
              series: <CartesianSeries>[
                LineSeries<DayTotalTransaction, DateTime>(
                    dataSource: [
                      DayTotalTransaction(date: firstDateOfThisMonth, total: 0),
                      DayTotalTransaction(date: lastDateOfThisMonth, total: totalBudget),
                    ],
                    pointColorMapper: (_, __) => const Color.fromARGB(255, 223, 223, 223),
                    xValueMapper: (data, __) => data.date,
                    yValueMapper: (data, __) => data.total,
                    animationDuration: 0,
                ),
                // LineSeries<DayTotalTransaction, DateTime>(
                //   dataSource: overviewData,
                //   pointColorMapper: (_, __) => const Color.fromARGB(255, 50, 50, 50),
                //   xValueMapper: (data, _) => data.date,
                //   yValueMapper: (data, _) => data.total,
                // ),
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
