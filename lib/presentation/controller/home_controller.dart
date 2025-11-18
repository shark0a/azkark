import 'package:flutter/material.dart';

class HomeController extends ChangeNotifier {
  //next prayer Time controller
  int _nextprayerTimeIndex = 0;
  int get nextprayerTimeIndex => _nextprayerTimeIndex;
  void toggleNextPrayerTimeIndex(int index) {
    _nextprayerTimeIndex = index;
    notifyListeners();
  }
  //BottomNavigationBar

  int _bottomNavigationIndex = 0;
  int get bottomNavigationIndex => _bottomNavigationIndex;
  void toggleBottomNavigationIndex(int index) {
    _bottomNavigationIndex = index;
    notifyListeners();
  }

  //azkar widget handle fav icon click
  // bool _isFavIconClick = false;
  // bool get isFavIconClick => _isFavIconClick;
  // void toggleisFavIconClick() {
  //   _isFavIconClick = !isFavIconClick;
  //   notifyListeners();
  // }
}
