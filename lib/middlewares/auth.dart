import 'package:flutter/material.dart';
import 'package:pernance/screens/home.dart';

Future<bool> isUserAuthenticated() {
  // Simulate authentication check
  return Future.delayed(const Duration(seconds: 2), () => true);
}

class AuthGuard extends StatelessWidget {
  final Widget child;
  const AuthGuard({super.key, required this.child});
  
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: isUserAuthenticated(), // Your authentication check
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(); // Show a loading indicator
        } else if (snapshot.hasData && snapshot.data == true) {
          return child; // User is authenticated, show the protected route
        } else {
          return const HomeScreen(title: 'Home'); // User is not authenticated, redirect to login
        }
      },
    );
  }
}
