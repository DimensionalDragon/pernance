import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pernance/models/index.dart';
import 'firebase_options.dart';

import 'package:pernance/routes/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final firebaseIDToken = await FirebaseAuth.instance.currentUser?.getIdToken();
  if (firebaseIDToken != null) {
    RealmProvider().initializeRealm(firebaseIDToken);
  }
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final _appRouter = AppRouter();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _appRouter.config(includePrefixMatches: true),
    );
  }
}
