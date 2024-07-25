import 'dart:convert';
import 'package:appc/api/host.token.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future apigetData(endpoint) async {
  SharedPreferences auth = await SharedPreferences.getInstance();
  var token = auth.getString("token") ?? "";
  var response = await http.get(
    Uri.parse("$serveradress$endpoint"),
    headers: {"Authorization": "Token $token"},
  );
  return response.statusCode != 404 || response.statusCode != 406
      ? jsonDecode(response.body)
      : null;
}

Future apigetDataNoAuth(endpoint) async {
  var response = await http.get(Uri.parse("$serveradress$endpoint"));
  return response.statusCode == 200 ? jsonDecode(response.body) : null;
}

Future apipostData(endpoint, data) async {
  SharedPreferences auth = await SharedPreferences.getInstance();
  var token = auth.getString("token") ?? "";
  var response = await http.post(Uri.parse("$serveradress$endpoint"),
      headers: {"Authorization": "Token $token"}, body: data);
  return response.statusCode != 404 || response.statusCode != 406
      ? jsonDecode(response.body)
      : null;
}

Future apipostDataNoAuth(endpoint, data) async {
  var response =
      await http.post(Uri.parse("$serveradress$endpoint"), body: data);
  print(response.body);
  return response.statusCode != 404 || response.statusCode != 406
      ? jsonDecode(response.body)
      : null;
}
