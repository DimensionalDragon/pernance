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

// class _HomePageState extends State<HomePage> {
//   final PageController _pageController = PageController();
//   int _currentIndex = 0;

//   void _onPageChanged(int index) {
//     setState(() { _currentIndex = index; });
//   }
    
//   void _onTap(int index) {
//     _pageController.jumpToPage(index);
//   }

//   @override Widget build(BuildContext context) {
//     return Scaffold(
//       body: PageView(
//         controller: _pageController,
//         onPageChanged: _onPageChanged,
//         children: [ const TransactionsRoute(), SettingsRoute().buildPage(context), ProfileRoute().buildPage(context)],
//       ),

//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _currentIndex,
//         onTap: _onTap,
//         items: const [
//           BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
//           BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
//           BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile')
//         ]
//       )
//     );
//   }
// }