import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pernance/routes/routes.dart';

class AuthGuard extends AutoRouteGuard {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    _auth.userChanges().listen((User? user) {
      print(resolver.route.name);
      final authRouteNames = [LoginRoute.name, RegisterRoute.name];
      final isEnteringAuthPage = authRouteNames.contains(resolver.route.name);
      final authenticated = (user != null);
      if (!authenticated && isEnteringAuthPage) {
        resolver.next(true);
      } else if (authenticated && !isEnteringAuthPage) {
        resolver.next(true);
      } else if (!authenticated) {
        resolver.redirect(const LoginRoute());
      } else {
        resolver.redirect(const DashboardRoute());
      }
      // if (user != null) {
      //   resolver.next(true);
      // } else {
      //   resolver.redirect(const LoginRoute());
      // }
    });
    // final authRouteNames = [LoginRoute.name, RegisterRoute.name];
    // final isEnteringAuthPage = authRouteNames.contains(router.current.name);
    // print('Guard working...');

    // if (_authenticated && isEnteringAuthPage) {
    //   print('redirect to dashboard');
    //   resolver.redirect(const DashboardRoute());
    // } else if (_authenticated || isEnteringAuthPage) {
    //   print('no redirect');
    //   resolver.next(true);
    // } else {
    //   print('redirect to login');
    //   resolver.redirect(const LoginRoute());
    // }
  }
}