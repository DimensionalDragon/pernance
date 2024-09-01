import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pernance/routes/routes.dart';

class AuthGuard extends AutoRouteGuard {
  final bool authenticated = true;

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null) {
        router.push(const LoginRoute());
      } else {
        resolver.next(true);
      }
    });
  }
}