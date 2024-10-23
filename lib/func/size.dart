import 'package:appc/func/export.dart';
import 'package:appc/func/session.dart';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

double fullHeight(context) {
  return MediaQuery.of(context).size.height;
}

double fullWidth(context) {
  return MediaQuery.of(context).size.width;
}

double topHeight(context) {
  return MediaQuery.of(context).padding.top;
}

void goTo(BuildContext context, Widget pageToMove) async {
  final List<ConnectivityResult> connectivityResult =
      await (Connectivity().checkConnectivity());

  if (connectivityResult.contains(ConnectivityResult.mobile) ||
      connectivityResult.contains(ConnectivityResult.wifi)) {
    Navigator.of(context).push(createRoute(pageToMove));
  } else {
    showWaitingForInternet(context,pageToMove);
  }
}
// void goTo(BuildContext context, Widget pageToMove) {
//   Navigator.of(context).push(_createRoute(pageToMove));
// }

Route createRoute(Widget pageToMove) {
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
