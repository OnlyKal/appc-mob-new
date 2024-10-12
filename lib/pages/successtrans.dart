import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../func/export.dart';

class TransactionSuccess extends StatelessWidget {
  final double amount;
  final String type;
  final String currency;
  final String transactionId;
  const TransactionSuccess(
      {super.key,
      required this.amount,
      required this.type,
      required this.currency,
      required this.transactionId});

  @override
  Widget build(BuildContext context) {
    final lngx = Provider.of<LocalizationProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: backPage(context),
        title: Text(
          lngx.trans("transaction_details"),
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        actions: [
          TextButton(
              onPressed: () => goTo(context, const HomePage()),
              child: Text(
                lngx.trans("completed"),
                style: TextStyle(
                    color: mainColor,
                    fontSize: 20.5,
                    fontWeight: FontWeight.w600),
              )),
          const SizedBox(
            width: 20,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Icon(
              Icons.check_circle_outline,
              color: Colors.green,
              size: 80.0,
            ),
            const SizedBox(height: 20),
            Text(
              lngx.trans("transaction_successful"),
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              lngx.trans("thanks_transaction_successful"),
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18, color: Colors.grey),
            ),
            const SizedBox(height: 10),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey),
              ),
              child: Column(
                children: [
                  ListTile(
                    title: Text(
                      lngx.trans("type"),
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    trailing: Text(
                      type,
                      style: const TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ),
                  const Divider(),
                  ListTile(
                    title: Text(
                      lngx.trans("transaction_id"),
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    trailing: Text(
                      transactionId,
                      style: const TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ),
                  const Divider(),
                  ListTile(
                    title: Text(
                      lngx.trans("date_time"),
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                    trailing: Text(
                      DateFormat('dd,MM,yyyy hh:mm').format(DateTime.now()),
                      style: const TextStyle(fontSize: 15, color: Colors.grey),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
