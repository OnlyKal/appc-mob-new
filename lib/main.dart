import 'dart:async';
import 'package:appc/func/export.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationClass.initializeNotif();
  NotificationClass.openNotifMono("APPC ALERTE",
      "Bienvenue chez APPC SERVICES-DRC, où nous inspirons notre peuple à créer le changement et à oser inventer son avenir. Ensemble, façonnons un futur prometteur pour notre nation. Soyez les artisans de demain");
  initBackgroundFetch();
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: PopScope(canPop: false, child: SplashScreen()),
  ));
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
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/bgsplash2.png"), fit: BoxFit.cover),
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
                  width: 220,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(110),
                    color: Colors.transparent,
                  ),
                  child: Image.asset(
                    "assets/giflogo.gif",
                  ),
                ),
              ),
              Expanded(
                  child: Container(
                alignment: Alignment.bottomCenter,
                padding: const EdgeInsets.all(20),
                child: Container(
                  child: const Text(
                    "APPC SERVICES © 2024",
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
