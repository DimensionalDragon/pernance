import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:pernance/models_powersync/index.dart';
import 'package:powersync/sqlite3.dart' as sqlite;

import 'package:pernance/widgets/categories_list.dart';
import 'package:pernance/routes/routes.dart';

@RoutePage()
class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  late Future<sqlite.ResultSet> _data;

  void _updateData() {
    setState(() {
      _data = db.getAll(
        'SELECT categories.*, SUM(IFNULL(transactions.price, 0)) AS spent '
        'FROM categories '
        'LEFT JOIN transactions '
        'ON categories.id = transactions.category_id '
        'GROUP BY categories.id '
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
                  // const CategoriesChart(),
                  const SizedBox(height: 7),
                  OutlinedButton(
                    style: ButtonStyle(
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                        )
                      ),
                    onPressed: () {
                      router.push(AddCategoryRoute(onSubmit: _updateData));
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add),
                        Text('Add Category'),
                      ],
                    )
                  ),
                ]),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Column(
                  children: [CategoriesList(categoriesQueryResult: _data)],
                ),
              )
            )
          ],
        ),
      )
    );
  }
}