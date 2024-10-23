import 'dart:async';
import 'dart:math';

import 'package:appc/func/export.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CardDetail extends StatefulWidget {
  final card;
  const CardDetail({super.key, this.card});
  @override
  State<CardDetail> createState() => _CardDetailState();
}

class _CardDetailState extends State<CardDetail> {
  var currentCard;

  @override
  void initState() {
    setState(() => currentCard = widget.card);
    getSessionDetails().then((user) {
      setState(() => ctrNumber.text = user['phone'].toString());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final lngx = Provider.of<LocalizationProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: backPage(context),
        title: Text(
          lngx.trans("details"),
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          height: fullHeight(context),
          child: Column(
            children: [
              Container(
                height: fullHeight(context) * 0.2,
                padding: const EdgeInsets.all(15),
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                    image: const DecorationImage(
                        image: AssetImage(
                          "assets/bgcard.png",
                        ),
                        opacity: 0.02,
                        fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(10),
                    color: getMembershipColor(currentCard['name'])
                        .withOpacity(0.1)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          backgroundColor:
                              getMembershipColor(currentCard['name']),
                          child: const Icon(
                            Icons.credit_card,
                            color: Colors.white,
                          ),
                        ),
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () =>
                                  payementMobileModal(currentCard, lngx.trans),
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: mainColor,
                                      borderRadius: BorderRadius.circular(5)),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 10),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        CupertinoIcons.device_phone_portrait,
                                        size: 15,
                                        color:
                                            Color.fromARGB(255, 197, 198, 208),
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        lngx.trans("mobile_payment"),
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 11,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ],
                                  )),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              lngx.trans("card_type"),
                              style:
                                  const TextStyle(fontWeight: FontWeight.w300),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                              currentCard['name'].toUpperCase(),
                              style: const TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (var i = 0;
                                i < currentCard['current_price'].length;
                                i++)
                              if (currentCard['current_price'][i]
                                      ['is_current'] ==
                                  true)
                                Text(
                                  "${lngx.trans("pricing")} : USD ${currentCard['current_price'][i]['price']}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w300),
                                ),
                            const SizedBox(
                              height: 4,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                for (var a = 0;
                                    a < currentCard['stars_number'];
                                    a++)
                                  const Icon(
                                    CupertinoIcons.star_fill,
                                    size: 14,
                                    color: Color.fromARGB(255, 215, 152, 6),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Expanded(
                  child: FutureBuilder(
                      future: getAllCardType(),
                      builder: (context, AsyncSnapshot card) {
                        if (card.hasData) {
                          List cardsList = card.data.toList();
                          return SizedBox(
                              height: fullHeight(context),
                              child: cardsList.isEmpty
                                  ? noElementFount(context)
                                  : ListView.builder(
                                      padding:
                                          const EdgeInsets.only(bottom: 200),
                                      itemCount: cardsList.length,
                                      itemBuilder: (context, i) {
                                        List currentPrice = cardsList[i]
                                                ['current_price']
                                            .toList();
                                        return Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 2, horizontal: 2),
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 2, horizontal: 0),
                                          decoration: const BoxDecoration(
                                              border: Border.symmetric(
                                            vertical: BorderSide(
                                                color: Colors.blue, width: 5),
                                          )),
                                          child: ListTile(
                                              tileColor:
                                                  mainColor.withOpacity(0.2),
                                              onTap: () {
                                                setState(() {
                                                  currentCard = cardsList[i];
                                                });
                                              },
                                              title: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    converToUpperCase(
                                                        cardsList[i]['name']),
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  Row(
                                                    children: [
                                                      for (var a = 0;
                                                          a <
                                                              cardsList[i][
                                                                  'stars_number'];
                                                          a++)
                                                        const Icon(
                                                          CupertinoIcons
                                                              .star_fill,
                                                          size: 14,
                                                          color: Color.fromARGB(
                                                              255, 215, 152, 6),
                                                        ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              subtitle: Container(
                                                padding: const EdgeInsets.only(
                                                    top: 8.0),
                                                width: fullWidth(context),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    if (currentPrice.isNotEmpty)
                                                      Row(
                                                        children: currentPrice
                                                            .where((price) =>
                                                                price[
                                                                    'is_current'] ==
                                                                true)
                                                            .map((price) =>
                                                                Container(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          6),
                                                                  color:
                                                                      mainColor,
                                                                  child: Text(
                                                                    "USD ${newVal(price['price'])}",
                                                                    style: const TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontWeight:
                                                                            FontWeight.w400),
                                                                  ),
                                                                ))
                                                            .toList(),
                                                      ),
                                                    Text(
                                                      "${lngx.trans("discount")} ${cardsList[i]['reduction'].toString()}%",
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              )),
                                        );
                                      }));
                        }
                        return loading(context);
                      }))
            ],
          ),
        ),
      ),
    );
  }

  TextEditingController ctrNumber = TextEditingController();
  bool isUsd = true;
  String devise = 'USD';
  bool isPaying = false;
  payementMobileModal(card, lngx) {
    var price = card['current_price']
        .where((element) => element['is_current'] == true)
        .first;

    void checkPayment(payement, useState, card, price) {
      var transaction = {
        "type": "ACHAT CARTE APPC",
        "amount": double.parse(price.toString()),
        "currency": devise.toString(),
        "status": true.toString(),
        "date": DateTime.now().toIso8601String(),
      };

      int time = 0;
      Timer.periodic(const Duration(seconds: 5), (timer) async {
        time += 1;
        checkPaymentBilling(payement['orderNumber']).then((checking) {
          if (checking['transaction']['status'].toString().contains("0")) {
            createCard(card['id'], transaction).then((response) {
              if (response['number'] != null) {
                useState(() => isPaying = false);
                goTo(
                  context,
                  TransactionSuccess(
                      amount: price,
                      type: "ACHAT CARTE APPC",
                      currency: devise,
                      transactionId: response['number']),
                );
              }
              timer.cancel();
              useState(() => isPaying = false);
            });
          } else if (checking['transaction']['status']
              .toString()
              .contains("2")) {
          } else {
            message(lngx("no_verified_account"), context);
            useState(() => isPaying = false);
            timer.cancel();
          }
        });
      });
    }

    showModalBottomSheet(
      isScrollControlled: true,
      shape: roundAlert(),
      context: context,
      isDismissible: false,
      builder: (context) {
        return StatefulBuilder(builder: (context, useState) {
          return Scaffold(
            body: Container(
              // height: 400,

              // color: Colors.white,
              width: fullWidth(context),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${lngx("order_card")} (${card['name']})",
                        style: const TextStyle(
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
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "${lngx("supported_payment_methods")} :",
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w300),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      methodePayment("AIRTEL MONEY"),
                      const SizedBox(
                        width: 6,
                      ),
                      methodePayment("ORANGE MONEY"),
                      const SizedBox(
                        width: 6,
                      ),
                      methodePayment("M-PESA"),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Switch(
                          value: isUsd,
                          onChanged: (value) {
                            useState(() {
                              isUsd = value;
                              value == true ? devise = 'USD' : devise = 'CDF';
                            });
                          }),
                      Text(
                        isUsd == true ? "USD" : "CDF",
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    lngx("replace_number"),
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    keyboardType: TextInputType.number,
                    controller: ctrNumber,
                    maxLength: 12,
                    onChanged: (value) {},
                    decoration: InputDecoration(
                        labelText: lngx("phone_number_must_start_243"),
                        hintText: lngx("phone_number_must_start_243")),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  isPaying == true
                      ? loading(context)
                      : InkWell(
                          onTap: () async {
                            if (ctrNumber.text.startsWith("243") &&
                                ctrNumber.text.length == 12) {
                              useState(() => isPaying = true);
                              payementBilling(
                                      ctrNumber.text, price['price'], devise)
                                  .then((payement) {
                                if (payement['code'].toString().contains("0")) {
                                  checkPayment(
                                      payement, useState, card, price['price']);
                                } else if (payement['code']
                                    .toString()
                                    .contains("0")) {
                                  message(
                                      "${lngx("transaction_failed_retry")} !!",
                                      context);
                                } else {}
                              });
                            } else {
                              message(lngx("phone_number_start_243"), context);
                            }
                          },
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(10)),
                            width: fullHeight(context),
                            child: Center(
                                child: Text(
                              "${lngx("validate_transaction")} (${price['price']} $devise)",
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: Colors.white),
                            )),
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
}

methodePayment(title) {
  return Container(
      decoration: BoxDecoration(
          color: colorRandom(), borderRadius: BorderRadius.circular(2)),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      child: Row(
        children: [
          const Icon(
            CupertinoIcons.square_grid_2x2,
            size: 15,
            color: Color.fromARGB(255, 197, 198, 208),
          ),
          const SizedBox(
            width: 3,
          ),
          Text(
            title,
            style: const TextStyle(
                color: Colors.white, fontSize: 13, fontWeight: FontWeight.w700),
          ),
        ],
      ));
}
