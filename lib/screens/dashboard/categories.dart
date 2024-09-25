import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:powersync/sqlite3.dart' as sqlite;

import 'package:pernance/widgets/categories_list.dart';
import 'package:pernance/routes/routes.dart';
// import 'package:pernance/models_powersync/index.dart';
import 'package:pernance/widgets/categories_chart.dart';

@RoutePage()
class CategoriesScreen extends ConsumerStatefulWidget {
  const CategoriesScreen({super.key});

  @override
  ConsumerState<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends ConsumerState<CategoriesScreen> {
  // late Future<sqlite.ResultSet> _data;

  // void _updateData() {
  //   setState(() {
  //     final currentMonth = DateTime.now().month.toString().padLeft(2, '0');
  //     final currentYear = DateTime.now().year;
  //     _data = db.getAll(
  //       'SELECT categories.*, SUM(IFNULL(monthly_transactions.price, 0)) AS spent '
  //       'FROM categories '
  //       'LEFT JOIN (SELECT * FROM transactions WHERE date > ?) AS monthly_transactions '
  //       'ON categories.id = monthly_transactions.category_id '
  //       'GROUP BY categories.id ',
  //       [
  //         '$currentYear-$currentMonth-01 00:00:00'
  //       ], // Only fetch the categories that are in this month
  //     );
  //   });
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   _updateData();
  // }

  @override
  Widget build(BuildContext context) {
    final router = AutoRouter.of(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(children: [
                const CategoriesChart(),
                const SizedBox(height: 7),
                OutlinedButton(
                  style: ButtonStyle(
                    shape: WidgetStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                      )
                    )
                  ),
                  onPressed: () {
                    router.push(const AddCategoryRoute());
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.add),
                      Text('Add Category'),
                    ],
                  )
                ),
              ]),
            ),
            const Expanded(
              child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Column(
                children: [CategoriesList()],
              ),
            )),
          ],
        ),
      )
    );
  }
}
