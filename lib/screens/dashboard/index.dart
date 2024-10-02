import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:pernance/routes/routes.dart';

@RoutePage()
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: const [
        TransactionsRoute(),
        DashboardHomeRoute(),
        CategoriesRoute(),
      ],
      bottomNavigationBuilder: (_, tabsRouter) {
        return BottomNavigationBar(
          currentIndex: tabsRouter.activeIndex,
          onTap: tabsRouter.setActiveIndex,
          selectedItemColor: Colors.blue,
          items: const [
            BottomNavigationBarItem(label: 'Transactions', icon: Icon(Icons.money)),
            BottomNavigationBarItem(label: 'Home', icon: Icon(Icons.home_filled)),
            BottomNavigationBarItem(label: 'Categories', icon: Icon(Icons.category)),
          ],
        );
      },
    );
  }
}