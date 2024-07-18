import 'package:flutter/services.dart';
import 'package:html/parser.dart' as html_parser;
import 'package:html/dom.dart' as html_dom;
import 'package:get_time_ago/get_time_ago.dart';

converToUpperCase(word){
  return word.toUpperCase();
}
hideKeyboard()=>SystemChannels.textInput.invokeMethod('TextInput.hide');
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


