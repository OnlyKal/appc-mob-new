import 'package:appc/func/size.dart';
import 'package:appc/main.dart';
import 'package:appc/pages/signin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> storeUserDetails(id, matricule, name, lastname, email, phone, url,
    token, function, image) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('matricule', matricule);
  await prefs.setString('first_name', name);
  await prefs.setString('last_name', lastname);
  await prefs.setString('email', email);
  await prefs.setString('phone', phone);
  await prefs.setString('token', token);
  await prefs.setString('url', url);
  await prefs.setString('function', function);
  await prefs.setString("image", image);
  await prefs.setString("user_id", id);
}

Future getSessionDetails() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return {
    'matricule': prefs.getString('matricule') ?? '',
    'first_name': prefs.getString('first_name') ?? '',
    'last_name': prefs.getString('last_name') ?? '',
    'email': prefs.getString('email') ?? '',
    'phone': prefs.getString('phone') ?? '',
    'token': prefs.getString('token') ?? '',
    'url': prefs.getString('url') ?? '',
    'function': prefs.getString('function') ?? '',
    'user_id': prefs.getString('user_id') ?? ''
  };
}

Future getImageSession() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return {
    'image': prefs.getString('image') ?? '',
  };
}

void logout(context) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final snackBar = SnackBar(
    content: const Text('Confirmation de la déconnexion...'),
    action: SnackBarAction(
      label: 'OK',
      onPressed: () async {
        await prefs.clear();
        goTo(context, const SignIn());
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Déconnecté avec succès')),
        );
      },
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}


message(stringMessage, context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(stringMessage)),
  );
}

Future enableNoti() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString("state-notif");
}

Future enableMode() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString("theme-mode");
}

Future<void> addNotifCount() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  int count = (prefs.getInt("count-notif") ?? 0) + 1;
  prefs.setInt("count-notif", count);
}

Future getNotifCount() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getInt("count-notif") ?? 0;
}

Future clearNotifCount() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.setInt("count-notif", 0);
}
