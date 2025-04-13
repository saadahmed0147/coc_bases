import 'package:coc_bases/Data/builderhall_data.dart';
import 'package:coc_bases/Data/townhall_data.dart';
import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier {}

class BannerProvider with ChangeNotifier {
  bool _isClicked = false;

  bool get isClicked => _isClicked;

  void toggleClick() {
    _isClicked = !_isClicked;
    notifyListeners();
  }
}

class TownhallProvider with ChangeNotifier {
  // Initial list of townhalls
  final List<dynamic> _townhalls = townHalls;

  List<dynamic> get townhalls => _townhalls;
}

class BuilderhallProvider with ChangeNotifier {
  // Initial list of builderhalls
  final List<dynamic> _builderhalls = builderHalls;

  List<dynamic> get builderhalls => _builderhalls;
}
