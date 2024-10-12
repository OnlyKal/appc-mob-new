import 'dart:async';
import 'package:appc/func/export.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initBackgroundFetch();
  Map<String, dynamic> translations = await loadTranslations();
  runApp(
    MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) =>
                LocalizationProvider(translations)..loadSavedLanguage(),
          ),
          ChangeNotifierProvider(
            create: (context) => ThemeProvider()..loadThemeFromPreferences(),
          ),
        ],
        child:
            Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
          return Consumer<LocalizationProvider>(
              builder: (context, localizationProvider, child) {
            return MaterialApp(
                locale: Locale(localizationProvider.currentLang),
                debugShowCheckedModeBanner: false,
                theme: themeProvider.getTheme(),
                home: const PopScope(canPop: false, child: SplashScreen()));
          });
        })),
  );
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  checkSession() async {
    hideKeyboard();
    NotificationClass.askPermission(context);
    Timer(const Duration(seconds: 3), () async {
      SharedPreferences auth = await SharedPreferences.getInstance();
      var matricule = auth.getString("matricule");
      if (matricule == null || matricule == "") {
        goTo(context, const SignIn());
      } else {
        goTo(context, const PresentationPage());
        // goTo(context, const HomePage());
      }
    });
  }

  @override
  void initState() {
    refresh();
    init();
    checkSession();
    super.initState();
  }

  init() async {
    SharedPreferences session = await SharedPreferences.getInstance();
    var token = session.getString("token");
    var id = session.getString("user_id");

    if (token != null) {
      APPSocket.initSocket();
      socket?.on("emit-new-actuality", (data) {
        List<dynamic> actuality = data.toList();
        var imagename =
            actuality[0]['fields']['image'].toString().replaceAll(" ", "_");
        var imageUrl = "${serveradress}media/news/$imagename";
        NotificationClass.openNotifActuality(actuality[0]['fields']['title'],
            actuality[0]['fields']['message'], imageUrl);
        addNotifCount();
      });

      socket?.on("emit-new-response", (data) {
        List<dynamic> feedback = data.toList();
        var answer = feedback[0]['fields']['answer'];
        var user = feedback[0]['fields']['asked_by'];
        // if (id.toString().contains(user.toString())) {
        NotificationClass.openNotif("Reponse", "Un nouveau message APPC");
        // }
      });
    }
  }

  refresh() {
    setState(() {
      allcards = getUserCards();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                opacity: 0.3,
                image: AssetImage("assets/bgsplash2.png"),
                fit: BoxFit.cover),
          ),
          height: fullHeight(context),
          width: fullWidth(context),
          child: Column(
            children: [
              Container(
                height: fullHeight(context) * 0.62,
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 220,
                  width: 280,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(110),
                    color: Colors.transparent,
                  ),
                  child: Image.asset(
                    height: 200,
                    width: 280,
                    "assets/logo.png",
                    // "assets/giflogo.gif",
                  ),
                ),
              ),
              Expanded(
                  child: Container(
                alignment: Alignment.bottomCenter,
                padding: const EdgeInsets.all(20),
                child: Container(
                  child: const Text(
                    "APPC IT Team©2024",
                    style: TextStyle(color: Color.fromARGB(255, 112, 111, 111)),
                  ),
                ),
              ))
            ],
          ),
        ),
      ),
    );
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
