import 'package:coc_bases/Model/builderhall_model.dart';
import 'package:coc_bases/Model/townhall_model.dart';
import 'package:coc_bases/Screens/Bases/builder_hall_bases.dart';
import 'package:coc_bases/Screens/home.dart';
import 'package:coc_bases/Screens/Layouts/builderhall_layout.dart';
import 'package:coc_bases/Screens/splash.dart';
import 'package:coc_bases/Screens/Bases/town_hall_bases.dart';
import 'package:coc_bases/Screens/Layouts/townhall_layout.dart';
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
      case RouteNames.builderhallLayoutScreen:
        final builderhall = settings.arguments as BuilderModel;
        return MaterialPageRoute(
          builder: (context) => BuilderhallLayoutScreen(hall: builderhall),
        );
      case RouteNames.townhallLayoutScreen:
        final townhall = settings.arguments as TownhallModel;
        return MaterialPageRoute(
          builder: (context) => TownhallLayoutScreen(
            hall: townhall,
          ),
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
