import 'package:coc_bases/Provider/provider.dart';
import 'package:coc_bases/Routes/routes.dart';
import 'package:coc_bases/Routes/routes_names.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppProvider()),
        ChangeNotifierProvider(create: (_) => BannerProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: RouteNames.splashScreen,
        onGenerateRoute: Routes.generateRoute,
      ),
    );
  }
}
