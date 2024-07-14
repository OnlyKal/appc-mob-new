import 'package:flutter/material.dart';

double fullHeight(context) {
  return MediaQuery.of(context).size.height;
}

double fullWidth(context) {
  return MediaQuery.of(context).size.width;
}

double topHeight(context) {
  return MediaQuery.of(context).padding.top;
}


void goTo(context, page) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => page));
}
