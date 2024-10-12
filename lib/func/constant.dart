import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:html/parser.dart' as html_parser;
import 'package:html/dom.dart' as html_dom;
import 'package:get_time_ago/get_time_ago.dart';

converToUpperCase(word) {
  return word.toUpperCase();
}

Future<Map<String, dynamic>> loadTranslations() async {
  String jsonString = await rootBundle.loadString('assets/translations.json');
  return json.decode(jsonString);
}

hideKeyboard() => SystemChannels.textInput.invokeMethod('TextInput.hide');

String newVal(dynamic value) {
  if (value == null || value == "" || value == "null") {
    return "";
  }
  return value.toString();
}

String convertHtmlToText(String htmlContent) {
  html_dom.Document document = html_parser.parse(htmlContent);
  return document.body?.text ?? '';
}

String timeAgo(tmsp) {
  String time = '';
  if (tmsp != null) {
    DateTime convertedTimestamp = DateTime.parse(tmsp);
    time = GetTimeAgo.parse(convertedTimestamp, locale: 'fr');
  }
  return time.toString();
}

newUtf(encodedString) {
  List<int> bytes = encodedString.codeUnits;
  String decodedString = utf8.decode(bytes);
  return decodedString;
}

String convertirJours(int jours, lngx) {
  int annee = 0;
  int mois = 0;
  int joursRestants = jours;
  if (jours >= 365) {
    annee = jours ~/ 365;
    joursRestants = jours % 365;
  }

  if (joursRestants >= 30) {
    mois = joursRestants ~/ 30;
    joursRestants = joursRestants % 30;
  }

  String resultat = "";
  if (annee > 0) {
    resultat += "$annee ${annee == 1 ? lngx("year") : '${lngx("year")}s'}, ";
  }
  if (mois > 0) {
    resultat +=
        "$mois ${mois == 1 ? '${lngx("month")}' : '${lngx("month")}s '}, ";
  }
  resultat +=
      "$joursRestants ${joursRestants == 1 ? '${lngx("day")}' : '${lngx("day")}s'}";

  return resultat;
}
