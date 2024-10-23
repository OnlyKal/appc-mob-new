import 'dart:async';

import 'package:appc/func/export.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

void showWaitingForInternet(BuildContext context, pageToMove) {
  // Show alert dialog
  showDialog(
    context: context,
    barrierDismissible:
        false, // Prevents dismissing the dialog by tapping outside
    builder: (context) {
      return const AlertDialog(
        title: Text('Waiting for Internet'),
        content: Row(
          children: [
            CircularProgressIndicator(),
            SizedBox(width: 20),
            Text('Checking internet connection...')
          ],
        ),
      );
    },
  );

  Timer? timer;
  timer = Timer.periodic(const Duration(seconds: 3), (timer) async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi)) {
      Navigator.of(context).pop();
      timer.cancel();
      Navigator.of(context).push(createRoute(pageToMove));
    }
  });
}
