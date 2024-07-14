import 'dart:convert';
import 'package:appc/api/host.token.dart';
import 'package:http/http.dart' as http;

Future apigetData(endpoint) async {
  var response = await http.get(Uri.parse("$serveradress$endpoint"));
  return response.statusCode == 200 ? jsonDecode(response.body) : null;
}
