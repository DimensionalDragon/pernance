import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:pernance/routes/routes.dart';

@RoutePage()
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter.tabBar(
      routes: const [
        TransactionsRoute(),
        DashboardHomeRoute(),
        CategoriesRoute(),
      ],
      builder: (context, child, controller) {
        final tabsRouter = AutoTabsRouter.of(context);
        return Scaffold(
          body: child,
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: tabsRouter.activeIndex,
            onTap: tabsRouter.setActiveIndex,
            selectedItemColor: Colors.blue,
            items: const [
              BottomNavigationBarItem(label: 'Transactions', icon: Icon(Icons.money)),
              BottomNavigationBarItem(label: 'Home', icon: Icon(Icons.home_filled)),
              BottomNavigationBarItem(label: 'Categories', icon: Icon(Icons.category)),
            ],
          ),
        );
      },
    );
  }
}