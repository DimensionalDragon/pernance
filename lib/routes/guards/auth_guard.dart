import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pernance/routes/routes.dart';

class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    final authRouteNames = [LoginRoute.name, RegisterRoute.name];
    final isEnteringAuthPage = authRouteNames.contains(resolver.routeName);
    final authenticated = (FirebaseAuth.instance.currentUser != null);

    if (!authenticated && !isEnteringAuthPage) {
      resolver.redirect(const LoginRoute());
    } else if (isEnteringAuthPage && authenticated) {
      resolver.redirect(const DashboardRoute());
    } else {
      resolver.next(true);
    }
  }
}