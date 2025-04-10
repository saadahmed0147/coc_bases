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
