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

class TextScalerProvider with ChangeNotifier {
  double textScalex = 0.810;
  double get textScale => textScalex;
  Future<void> loadTextScaleFactor() async {
    final prefs = await SharedPreferences.getInstance();
    textScalex = prefs.getDouble('textScaleFactor') ?? 0.81;
    notifyListeners();
  }

  Future<void> setTextScale(double value) async {
    textScalex = value;
    final prefs = await SharedPreferences.getInstance();
    prefs.setDouble('textScaleFactor', value);
    notifyListeners();
  }
}

ThemeData darkTheme() {
  return ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.blue,
    buttonTheme: const ButtonThemeData(
      buttonColor: Colors.blue,
      textTheme: ButtonTextTheme.primary,
    ),
    colorScheme: const ColorScheme.dark(
      primary: Colors.blue,
      onPrimary: Colors.white,
      secondary: Colors.amber,
      onSecondary: Color.fromARGB(255, 67, 67, 67),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color.fromARGB(255, 67, 67, 67),
      foregroundColor: Colors.white,
    ),
  );
}

ThemeData lightTheme() {
  return ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    buttonTheme: const ButtonThemeData(
      buttonColor: Colors.blue,
      textTheme: ButtonTextTheme.primary,
    ),
    colorScheme: const ColorScheme.light(
      primary: Colors.blue,
      onPrimary: Colors.white,
      secondary: Colors.amber,
      onSecondary: Colors.black,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Colors.blue,
    ),
  );
}

class ThemeProvider extends ChangeNotifier {
  ThemeData _selectedTheme;
  bool _isDarkMode;

  ThemeProvider({bool isDarkMode = false})
      : _isDarkMode = isDarkMode,
        _selectedTheme = isDarkMode ? darkTheme() : lightTheme();

  ThemeData getTheme() => _selectedTheme;

  bool get isDarkMode => _isDarkMode;

  void toggleTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (_isDarkMode) {
      _selectedTheme = lightTheme();
      _isDarkMode = false;
    } else {
      _selectedTheme = darkTheme();
      _isDarkMode = true;
    }
    notifyListeners();
    await prefs.setBool('isDarkMode', _isDarkMode);
  }

  Future<void> loadThemeFromPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool('isDarkMode') ?? false;
    _selectedTheme = _isDarkMode ? darkTheme() : lightTheme();
    notifyListeners();
  }
}
