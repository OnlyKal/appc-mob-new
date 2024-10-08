import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../func/export.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back),
          onPressed: () => goTo(context, const HomePage()),
        ),
        backgroundColor: Colors.white,
        title: Text(
          "Notifications",
          style: TextStyle(color: mainColor, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
