import 'package:flutter/services.dart';

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