import 'package:appc/func/export.dart';
import 'package:appc/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool isSwidhed = false;

  @override
  void initState() {
    enableNoti().then((state) {
      if (state == 'enable') {
        setState(() {
          isSwidhed = true;
        });
      } else {
        setState(() {
          isSwidhed = false;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final lngx = Provider.of<LocalizationProvider>(context);

    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
        leading: backPage(context),
        // backgroundColor: Colors.white,

        title: const Text(
          "Paramètres",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              leading: const Icon(CupertinoIcons.bell),
              title: const Text("Notification",
                  style: TextStyle(fontWeight: FontWeight.w600)),
              subtitle: const Text("Activer/Désactiver les notifications"),
              trailing: Switch(
                  value: isSwidhed,
                  onChanged: (value) async {
                    setState(() => isSwidhed = value);
                    SharedPreferences notif =
                        await SharedPreferences.getInstance();
                    if (value == true) {
                      notif.setString("state-notif", "enable");
                    } else {
                      notif.setString("state-notif", "desable");
                    }
                  }),
            ),
            ListTile(
              leading: themeProvider.isDarkMode == false
                  ? const Icon(
                      CupertinoIcons.sun_dust_fill,
                      color: Colors.amber,
                    )
                  : const Icon(
                      CupertinoIcons.moon,
                      color: Colors.grey,
                    ),
              title: const Text("Mode Sombre",
                  style: TextStyle(fontWeight: FontWeight.w600)),
              subtitle: const Text("Activer/Désactiver le thème"),
              trailing: Switch(
                  value: themeProvider.isDarkMode,
                  onChanged: (value) async {
                    themeProvider.toggleTheme();
                  }),
            ),
            InkWell(
              onTap: () => changeLan(lngx.changeLanguage, lngx.trans),
              child: const ListTile(
                leading: Icon(CupertinoIcons.globe),
                title: Text("Changer langue ",
                    style: TextStyle(fontWeight: FontWeight.w600)),
                subtitle: Text("Personnaliser la langue"),
                trailing: Icon(CupertinoIcons.forward),
              ),
            )
          ],
        ),
      ),
    );
  }

  changeLan(lngx, trans) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: roundAlert(),
          title: Text(trans("language")),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Text(
                  '🇫🇷  FRANCAIS',
                  style: TextStyle(fontSize: 17),
                ),
                trailing: InkWell(
                    onTap: () {
                      lngx("fr");
                      back(context);
                    },
                    child: const Icon(CupertinoIcons.forward)),
              ),
              ListTile(
                leading: const Text(
                  '🇬🇧  ENGLISH',
                  style: TextStyle(fontSize: 17),
                ),
                trailing: InkWell(
                    onTap: () {
                      lngx("en");
                      back(context);
                    },
                    child: const Icon(CupertinoIcons.forward)),
              ),
              ListTile(
                leading: const Text(
                  '🇹🇿  SWAHILI',
                  style: TextStyle(fontSize: 17),
                ),
                trailing: InkWell(
                    onTap: () {
                      lngx("sw");
                      back(context);
                    },
                    child: const Icon(CupertinoIcons.forward)),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('ANNULER'),
            ),
          ],
        );
      },
    );
  }
}
