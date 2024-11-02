import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pernance/widgets/currency_text.dart';
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
        final budgetAndSpentDifference = totalBudget - overviewData.last.total;

        final now = DateTime.now();
        final currentMonth = now.month.toString().padLeft(2, '0');
        final nextMonth = (now.month + 1).toString().padLeft(2, '0');
        final currentYear = now.year;
        final firstDateOfThisMonth = DateTime.parse('$currentYear-$currentMonth-01 00:00:00');
        final lastDateOfThisMonth = DateTime.parse('$currentYear-$nextMonth-01 00:00:00').subtract(const Duration(days: 1));

        const Duration graphPaddingX = Duration(days: 2);
        const double graphPaddingY = 100000;

        return Card(
          elevation: 3,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: Colors.grey.shade100,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 150,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CurrencyText(
                        amount: budgetAndSpentDifference.abs(),
                        locale: 'id-ID',
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      Text(
                        (budgetAndSpentDifference < 0) ? ' over' : ' under',
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ]
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CurrencyText(
                        amount: totalBudget,
                        locale: 'id-ID',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.grey),
                      ),
                      Text(
                        ' budgeted',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.grey),
                      ),
                    ]
                  ),
                  Expanded(
                    child: SfCartesianChart(
                      primaryXAxis: DateTimeAxis(intervalType: DateTimeIntervalType.days, isVisible: false, minimum: firstDateOfThisMonth.subtract(graphPaddingX), maximum: lastDateOfThisMonth.add(graphPaddingX)),
                      primaryYAxis: NumericAxis(isVisible: false, minimum: -graphPaddingY, maximum: totalBudget.toDouble() + graphPaddingY),
                      margin: EdgeInsets.zero,
                      series: <CartesianSeries>[
                        LineSeries<DayTotalTransaction, DateTime>(
                            dataSource: [
                              DayTotalTransaction(date: firstDateOfThisMonth, total: 0),
                              DayTotalTransaction(date: lastDateOfThisMonth, total: totalBudget),
                            ],
                            pointColorMapper: (data, __) => const Color.fromARGB(255, 223, 223, 223),
                            xValueMapper: (data, __) => data.date,
                            yValueMapper: (data, __) => data.total,
                            animationDuration: 0,
                        ),
                        LineSeries<DayTotalTransaction, DateTime>(
                          dataSource: overviewData,
                          pointColorMapper: (data, __) => (data.total < 0.75 * totalBudget) ? Colors.green : (data.total < 0.9 * totalBudget) ? Colors.yellow : Colors.red,
                          xValueMapper: (data, _) => data.date,
                          yValueMapper: (data, _) => data.total,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      error: (error, stackTrace) => const Text('Something went wrong'),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
