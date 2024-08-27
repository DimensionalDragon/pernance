import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:pernance/routes/guard.dart';

import 'package:pernance/screens/home.dart';
import 'package:pernance/screens/dashboard.dart';
import 'package:pernance/screens/login.dart';
import 'package:pernance/screens/register.dart';

part 'routes.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {

  @override
  RouteType get defaultRouteType => const RouteType.material(); //.cupertino, .adaptive ..etc
  
  @override
  List<AutoRoute> get routes => [
    // HomeScreen is generated as HomeRoute because
    // of the replaceInRouteName property
    AutoRoute(
      page: HomeRoute.page,
      initial: true,
    ),
    AutoRoute(
      path: '/dashboard',
      page: DashboardRoute.page,
      guards: [AuthGuard()],
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
    // optionally add root guards here
  ];
}