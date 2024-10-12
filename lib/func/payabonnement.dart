import 'dart:math';
import 'package:appc/func/export.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

TextEditingController ctrNumberPhone = TextEditingController();
TextEditingController ctrQty = TextEditingController();
bool isUsd = true;
String devise = 'USD';
bool isPaying = false;

payAbonnement(context, card, lngx) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  ctrNumberPhone.text = prefs.getString("phone")!;
  ctrQty.text = 1.toString();

  var price = card['card']['current_subscription_price']
      .where((element) => element['is_current'] == true)
      .first;

  var transaction = {
    "type": "ABONNEMENT",
    "amount": double.parse(price['price'].toString()),
    "currency": devise.toString(),
    "status": true.toString(),
    "date": DateTime.now().toIso8601String(),
  };

  showModalBottomSheet(
    isScrollControlled: true,
    shape: roundAlert(),
    context: context,
    isDismissible: false,
    builder: (context) {
      return StatefulBuilder(builder: (context, useState) {
        return Scaffold(
          body: Container(
            // color: Colors.white,
            width: fullWidth(context),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 50),
            child: Column(
              children: [
                Container(
                  // color: mainColor,
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        lngx("subscription_mobile_payment"),
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w700),
                      ),
                      IconButton(
                          onPressed: () => back(context),
                          icon: const Icon(
                            Icons.cancel,
                            color: Colors.red,
                          ))
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  lngx("supported_payment_methods"),
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w300),
                ),
                const SizedBox(height: 8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    methodePayment("AIRTEL MONEY"),
                    const SizedBox(width: 6),
                    methodePayment("ORANGE MONEY"),
                    const SizedBox(width: 6),
                    methodePayment("M-PESA"),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Switch(
                      value: isUsd,
                      onChanged: (value) {
                        useState(() {
                          isUsd = value;
                          devise = isUsd ? 'USD' : 'CDF';
                        });
                      },
                    ),
                    Text(
                      isUsd ? "USD" : "CDF",
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  lngx("replace_number"),
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w400),
                ),
                const SizedBox(height: 10),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: ctrNumberPhone,
                  maxLength: 12,
                  onChanged: (value) {},
                  decoration: InputDecoration(
                    labelText: lngx("phone_number_must_start_243"),
                    hintText: lngx("phone_number_must_start_243"),
                  ),
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: ctrQty,
                  maxLength: 2,
                  onChanged: (value) {},
                  decoration: InputDecoration(
                    labelText: lngx("number_of_months"),
                    hintText: lngx("number_of_months"),
                  ),
                ),
                const SizedBox(height: 20),
                isPaying == true
                    ? loading(context)
                    : InkWell(
                        onTap: () async {
                          if (ctrNumberPhone.text.startsWith("243") &&
                              ctrNumberPhone.text.length == 12) {
                            useState(() => isPaying = true);

                            payementBilling(
                                    ctrNumberPhone.text, price['price'], devise)
                                .then((payement) {
                              if (payement['code'].toString() == "0") {
                                if (payement['code'].toString().contains("0")) {
                                  int time = 0;
                                  Timer.periodic(const Duration(seconds: 5),
                                      (timer) async {
                                    time += 1;
                                    checkPaymentBilling(payement['orderNumber'])
                                        .then((checking) {
                                      if (checking['transaction']['status']
                                          .toString()
                                          .contains("0")) {
                                        buyAbonnement(card['number'],
                                                ctrQty.text, transaction)
                                            .then((response) {
                                          //                 print(response);
                                          if (response['transaction_date'] !=
                                              null) {
                                            useState(() => isPaying = false);
                                            goTo(
                                              context,
                                              TransactionSuccess(
                                                  amount: price['price'],
                                                  type: transaction['type']
                                                      .toString(),
                                                  currency: devise,
                                                  transactionId:
                                                      "${Random().nextInt(1000)}APPC"),
                                            );

                                            timer.cancel();
                                            useState(() => isPaying = false);
                                          } else {
                                            message(
                                                lngx(
                                                    "transaction_failed_retry"),
                                                context);
                                          }
                                        });
                                      } else if (checking['transaction']
                                              ['status']
                                          .toString()
                                          .contains("2")) {
                                      } else {
                                        message(
                                            lngx("transaction_not_verified"),
                                            context);
                                        useState(() => isPaying = false);
                                        timer.cancel();
                                      }
                                    });
                                  });
                                }
                              }
                            });
                          } else {
                            message(
                                lngx(
                                    "transaction_phone_number_start_243not_verified"),
                                context);
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 30),
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(8)),
                          child: Text(
                            lngx("validate_transaction"),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
              ],
            ),
          ),
        );
      });
    },
  );
}
