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

// void goTo(context, page) {
//   Navigator.push(context, MaterialPageRoute(builder: (context) => page));
// }

void goTo(BuildContext context, Widget pageToMove) {
  Navigator.of(context).push(_createRoute(pageToMove));
}

Route _createRoute(Widget pageToMove) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => pageToMove,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.ease;
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

void back(context) {
  Navigator.pop(context, true);
}

void printData(data) {
  debugPrint(data.toString());
}
