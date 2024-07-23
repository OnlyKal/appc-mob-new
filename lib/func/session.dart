import 'package:appc/func/size.dart';
import 'package:appc/pages/signin.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> storeUserDetails(
    matricule, name, lastname, email, phone, url, token, function) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('matricule', matricule);
  await prefs.setString('first_name', name);
  await prefs.setString('last_name', lastname);
  await prefs.setString('email', email);
  await prefs.setString('phone', phone);
  await prefs.setString('token', token);
  await prefs.setString('url', url);
  await prefs.setString('function', function);
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
    'function': prefs.getString('function') ?? ''
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
        await prefs.remove("matricule");
        await prefs.remove("phone");
        await prefs.remove("email");
        await prefs.remove("token");
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
