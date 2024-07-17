import 'package:shared_preferences/shared_preferences.dart';

Future<void> storeUserDetails(
    matricule, name, lastname, email, url, token) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('matricule', matricule);
  await prefs.setString('first_name', name);
  await prefs.setString('last_name', lastname);
  await prefs.setString('email', email);
  await prefs.setString('token', token);
  await prefs.setString('url', url);
}


