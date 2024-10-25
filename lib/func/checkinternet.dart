import 'dart:async';
import 'package:appc/func/export.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void showWaitingForInternet(
  BuildContext context,
  pageToMove,
) {
  final lngx = Provider.of<LocalizationProvider>(context,listen: false);
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        title: Text(lngx.trans('waiting_for_internet')),
        content: Row(
          children: [
            const CircularProgressIndicator(),
            const SizedBox(width: 20),
            Text(lngx.trans('check_for_internet'))
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
