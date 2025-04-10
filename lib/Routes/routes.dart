import 'package:coc_bases/Screens/builder_hall_bases.dart';
import 'package:coc_bases/Screens/home.dart';
import 'package:coc_bases/Screens/layout.dart';
import 'package:coc_bases/Screens/splash.dart';
import 'package:coc_bases/Screens/town_hall_bases.dart';
import 'package:flutter/material.dart';
import 'package:coc_bases/Routes/routes_names.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.splashScreen:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );
      case RouteNames.homeScreen:
        return MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        );
      case RouteNames.townhallScreen:
        return MaterialPageRoute(
          builder: (context) => const TownhallBasesScreen(),
        );
      case RouteNames.builderhallScreen:
        return MaterialPageRoute(
          builder: (context) => const BuilderhallBasesScreen(),
        );
      case RouteNames.layoutScreen:
        return MaterialPageRoute(
          builder: (context) => const LayoutScreen(),
        );

      default:
        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: Center(
              child: Text('No Route Found!'),
            ),
          ),
        );
    }
  }
}
