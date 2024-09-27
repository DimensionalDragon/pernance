import 'package:auto_route/auto_route.dart';
import 'package:pernance/models/index.dart';
import 'package:pernance/routes/routes.dart';

class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    final authRouteNames = [LoginRoute.name, RegisterRoute.name];
    final isEnteringAuthPage = authRouteNames.contains(resolver.routeName);
    final authenticated = isLoggedIn();

    if (!authenticated && !isEnteringAuthPage) {
      resolver.redirect(const LoginRoute());
    } else if (isEnteringAuthPage && authenticated) {
      resolver.redirect(const DashboardRoute());
    } else {
      resolver.next(true);
    }
  }
}