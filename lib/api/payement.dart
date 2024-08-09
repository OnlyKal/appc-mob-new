import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

var flexTokenApi =
    "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJcL2xvZ2luIiwicm9sZXMiOlsiTUVSQ0hBTlQiXSwiZXhwIjoxNzg1MDY4OTEyLCJzdWIiOiIzNzY5ZWYxMWQyYzk2NmFmOGUyYjQwMzFjYmNlNDAwZSJ9.rNkjqRxQkSkowXLa73-DeuHarnTqJgYQMYOASnA2Wcg";
Future payementBilling(numberPhone, amount, devise) async {
  const String url = 'https://backend.flexpay.cd/api/rest/v1/paymentService';
  SharedPreferences session = await SharedPreferences.getInstance();
  final Map<String, dynamic> paymentData = {
    "merchant": "APPC_SERVICE",
    "type": "1",
    "phone": numberPhone.toString(),
    "reference": session.getString("matricule"),
    "amount": amount.toString(),
    "currency": devise.toString(),
    "callbackUrl": "https://abcd.efgh.cd"
  };
  final response = await http.post(
    Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': flexTokenApi
    },
    body: jsonEncode(paymentData),
  );

  var data = json.decode(response.body);
  return response.statusCode != 200 ? null : data;
}

Future checkPaymentBilling(orderNumber) async {
  print(orderNumber);
  final response = await http.get(
    Uri.parse('https://backend.flexpay.cd/api/rest/v1/check/$orderNumber'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': flexTokenApi
    },
  );

  var data = json.decode(response.body);
  return data;
}
