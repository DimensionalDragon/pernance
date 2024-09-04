import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:pernance/routes/guards/auth_guard.dart';

import 'package:pernance/screens/home.dart';
import 'package:pernance/screens/dashboard/index.dart';
import 'package:pernance/screens/login.dart';
import 'package:pernance/screens/register.dart';
import 'package:pernance/screens/dashboard/transactions.dart';
import 'package:pernance/screens/dashboard/categories.dart';

part 'routes.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {

  @override
  RouteType get defaultRouteType => const RouteType.material(); //.cupertino, .adaptive ..etc
  
  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: HomeRoute.page,
      initial: true,
    ),
    AutoRoute(
      path: '/dashboard',
      page: DashboardRoute.page,
      children: [
        RedirectRoute(path: '', redirectTo: 'transactions'),
        AutoRoute(path: 'transactions', page: TransactionsRoute.page),
        AutoRoute(path: 'categories', page: CategoriesRoute.page),
      ]
    ),
    AutoRoute(
      path: '/auth/login',
      page: LoginRoute.page,
    ),
    AutoRoute(
      path: '/auth/register',
      page: RegisterRoute.page,
    ),
  ];

  @override
  List<AutoRouteGuard> get guards => [
    AuthGuard(),   
  ];
}