import 'package:appc/func/export.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      print(state);
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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: backPage(context),
        backgroundColor: Colors.white,
        title: Text(
          "Paramètres",
          style: TextStyle(color: mainColor, fontWeight: FontWeight.w600),
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
            )
          ],
        ),
      ),
    );
  }
}
