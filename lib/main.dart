import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:pernance/models_powersync/index.dart';
import 'package:pernance/routes/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await openDatabase();
  runApp(ProviderScope(child: MyApp()));
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
