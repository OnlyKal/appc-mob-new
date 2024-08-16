import 'package:appc/func/export.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: backPage(context),
        backgroundColor: Colors.white,
        title: Text(
          "Détails",
          style: TextStyle(color: mainColor, fontWeight: FontWeight.w600),
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
                              onTap: () => payementMobileModal(currentCard),
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: mainColor,
                                      borderRadius: BorderRadius.circular(5)),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 10),
                                  child: const Row(
                                    children: [
                                      Icon(
                                        CupertinoIcons.device_phone_portrait,
                                        size: 18,
                                        color:
                                            Color.fromARGB(255, 197, 198, 208),
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        "PAIEMENT MOBILE",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ],
                                  )),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: mainColor,
                                      borderRadius: BorderRadius.circular(5)),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 10),
                                  child: const Row(
                                    children: [
                                      Icon(
                                        CupertinoIcons.creditcard,
                                        size: 18,
                                        color:
                                            Color.fromARGB(255, 197, 198, 208),
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        " CARTE DE CREDIT ",
                                        style: TextStyle(
                                            color: Colors.white,
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
                            const Text(
                              "TYPE DE LA CARTE",
                              style: TextStyle(fontWeight: FontWeight.w300),
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
                                  "TARIFICATION : USD ${currentCard['current_price'][i]['price']}",
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
                                              tileColor: const Color.fromARGB(
                                                  255, 239, 239, 239),
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
                                              subtitle: SizedBox(
                                                width: fullWidth(context),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    if (currentPrice.isNotEmpty)
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 8.0),
                                                        child: Row(
                                                          children: currentPrice
                                                              .where((price) =>
                                                                  price[
                                                                      'is_current'] ==
                                                                  true)
                                                              .map(
                                                                  (price) =>
                                                                      Container(
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            6),
                                                                        color: const Color
                                                                            .fromARGB(
                                                                            255,
                                                                            167,
                                                                            212,
                                                                            247),
                                                                        child:
                                                                            Text(
                                                                          "USD ${newVal(price['price'])}",
                                                                          style:
                                                                              const TextStyle(fontWeight: FontWeight.w400),
                                                                        ),
                                                                      ))
                                                              .toList(),
                                                        ),
                                                      ),
                                                    Text(
                                                      "Réduction ${cardsList[i]['reduction'].toString()}%",
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color: Colors.black),
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
  payementMobileModal(card) {
    var price = card['current_price']
        .where((element) => element['is_current'] == true)
        .first;

    void checkPayment(payement, useState, card, price) {
      var transaction = {
        "type": "ACHAT CARTE APPC",
        "amount": price.toString(),
        "currency": devise.toString(),
        "status": true.toString(),
        "date": DateTime.now().toIso8601String(),
      };

      checkPaymentBilling(payement['orderNumber']).then((checking) {
        if (checking['code'].toString().contains("0")) {
          createCard(card['id'], transaction).then((card) {
            useState(() => isPaying = false);
            back(context);
            cardSuccessDialod(context,
                'Félicitations, votre commande a été enregistrée, veuillez patienter 24h pour que votre carte APPC vous soit livrée !');
          });
        } else {
          message("Désolé, la transaction n'est pas verifiée..", context);
        }
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
              color: Colors.white,
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
                        "ACHAT CARTE APPC | PAIEMENT MOBILE (${card['name']})",
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w700),
                      ),
                      IconButton(
                          onPressed: () => back(context),
                          icon: const Icon(
                            Icons.close,
                          ))
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Mode de paiement pris en charge :",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
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
                  const Text(
                    "Si vous ne souhaitez pas utiliser ce numéro, veuillez le remplacer par celui qui contient suffisamment d'argent pour payer la carte APPC.",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    keyboardType: TextInputType.number,
                    controller: ctrNumber,
                    maxLength: 12,
                    onChanged: (value) {},
                    decoration: const InputDecoration(
                        labelText:
                            "Le numéro de téléphone doit commencer par 243",
                        hintText:
                            "Le numéro de téléphone doit commencer par 243"),
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
                              payementBilling(ctrNumber.text, "1.0", devise)
                                  // ctrNumber.text, price['price'], devise)
                                  .then((payement) {
                                if (payement['code'].toString().contains("0")) {
                                  checkPayment(
                                      payement, useState, card, price['price']);
                                } else if (payement['code']
                                    .toString()
                                    .contains("0")) {
                                  message(
                                      "Désolé, la transaction a échoué, veuillez réessayer !!",
                                      context);
                                } else {}
                              });
                            } else {
                              message(
                                  "Le numéro doit commencer par 243 et contenir 12 caractères.",
                                  context);
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
                              "VALIDER TRANSACTION (${price['price']} $devise)",
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
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w700),
            ),
          ],
        ));
  }
}
