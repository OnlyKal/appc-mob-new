import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalizationProvider with ChangeNotifier {
  final Map<String, dynamic> _localizedValues;
  String _currentLang = "fr";

  LocalizationProvider(this._localizedValues);

  String get currentLang => _currentLang;

  Map<String, dynamic> get localizedValues => _localizedValues;

  Future<void> changeLanguage(String langCode) async {
    _currentLang = langCode;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("current-lng", langCode);
    notifyListeners();
  }

  Future<void> loadSavedLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _currentLang = prefs.getString("current-lng") ?? "fr";
    notifyListeners();
  }

  String trans(String key) {
    return _localizedValues[_currentLang]?[key] ?? key;
  }
}
