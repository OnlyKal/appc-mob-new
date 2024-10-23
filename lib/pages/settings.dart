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

  double _valueSlide = 0.0;
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final lngx = Provider.of<LocalizationProvider>(context);
    final textScalerProvider = Provider.of<TextScalerProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: backPage(context),
        title: Text(
          lngx.trans("settings"),
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              leading: const Icon(CupertinoIcons.bell),
              title: Text(lngx.trans("notifications"),
                  style: const TextStyle(fontWeight: FontWeight.w600)),
              subtitle: Text(
                lngx.trans("toggle_notifications"),
              ),
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
              title: Text(lngx.trans("dark_mode"),
                  style: const TextStyle(fontWeight: FontWeight.w600)),
              subtitle: Text(lngx.trans("toggle_theme")),
              trailing: Switch(
                  value: themeProvider.isDarkMode,
                  onChanged: (value) async {
                    themeProvider.toggleTheme();
                  }),
            ),
            InkWell(
              onTap: () => changeLan(lngx.changeLanguage, lngx.trans),
              child: ListTile(
                leading: const Icon(CupertinoIcons.globe),
                title: Text(lngx.trans("customize_language"),
                    style: const TextStyle(fontWeight: FontWeight.w600)),
                subtitle: Text(lngx.trans("change_language")),
                trailing: const Icon(CupertinoIcons.forward),
              ),
            ),
            InkWell(
              onTap: () => changeLan(lngx.changeLanguage, lngx.trans),
              child: ListTile(
                leading: const Icon(CupertinoIcons.globe),
                title: Text(
                    "${lngx.trans("change_fontsize")} ${textScalerProvider.textScale.toStringAsFixed(1)}",
                    style: const TextStyle(fontWeight: FontWeight.w600)),
                subtitle: Slider(
                  min: 0.0,
                  max: 1.3,
                  activeColor: Colors.purple,
                  inactiveColor: Colors.purple.shade100,
                  thumbColor: Colors.pink,
                  value: textScalerProvider.textScale,
                  onChanged: (value) {
                    setState(() {
                      _valueSlide = value;
                      textScalerProvider.setTextScale(_valueSlide);
                    });
                  },
                ),
                // subtitle: Container(
                //     width: fullWidth(context) * 0.6,
                // child: ListView(
                //   children: [
                //     for (var scale in [1.0, 0.8, 0.6, 0.5, 1.1])
                //       ElevatedButton(
                //         onPressed: () {
                //           textScalerProvider
                //               .setTextScale(scale); // Adjust text scale
                //         },
                //         child: Text('Scale: ${scale.toString()}'),
                //       ),
                //   ],
                // )
                // ),
                // trailing: const Icon(CupertinoIcons.forward),
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
              ListTile(
                leading: const Text(
                  '🇨🇩  LINGALA',
                  style: TextStyle(fontSize: 17),
                ),
                trailing: InkWell(
                    onTap: () {
                      lngx("ln");
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
              child: Text(trans("cancel")),
            ),
          ],
        );
      },
    );
  }
}
