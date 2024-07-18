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
    print(widget.card);
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
                        GestureDetector(
                          onTap: () {
                            showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text(
                                      "ACHAT CARTE APPC",
                                      style: TextStyle(
                                          fontSize: 19,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    content: SizedBox(
                                      width: fullWidth(context),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "Méthodes de paiement acceptées",
                                            style: TextStyle(
                                                fontSize: 19,
                                                fontWeight: FontWeight.w300),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              Image.asset(
                                                "assets/airtel.png",
                                                height: 40,
                                              ),
                                              const SizedBox(
                                                width: 8,
                                              ),
                                              Image.asset(
                                                "assets/orange.png",
                                                height: 40,
                                              ),
                                              const SizedBox(
                                                width: 8,
                                              ),
                                              Image.asset(
                                                "assets/mpsa.png",
                                                height: 40,
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    actions: [],
                                  );
                                });
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  color: mainColor,
                                  borderRadius: BorderRadius.circular(5)),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              child: const Text(
                                "COMMANDER",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700),
                              )),
                        )
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
                                          decoration: const BoxDecoration(
                                            border: Border(
                                              bottom: BorderSide(
                                                color: Color.fromARGB(
                                                    255,
                                                    206,
                                                    206,
                                                    206), // Color of the border
                                                width:
                                                    1.0, // Width of the border
                                              ),
                                            ),
                                          ),
                                          child: ListTile(
                                            tileColor: const Color.fromARGB(
                                                255, 239, 239, 239),
                                            onTap: () {
                                              print(cardsList[i]);
                                              setState(() {
                                                print(cardsList[i]);
                                                currentCard = cardsList[i];
                                              });
                                            },
                                            title: Text(
                                              converToUpperCase(
                                                  cardsList[i]['name']),
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            subtitle: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const SizedBox(
                                                  height: 10,
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
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  children: [
                                                    if (currentPrice.isNotEmpty)
                                                      for (var i = 0;
                                                          i <
                                                              currentPrice
                                                                  .length;
                                                          i++)
                                                        if (currentPrice[i][
                                                                'is_current'] ==
                                                            true)
                                                          Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(6),
                                                            color: const Color
                                                                .fromARGB(255,
                                                                225, 223, 223),
                                                            child: Text(
                                                              "USD ${newVal(currentPrice[0]['price'])}",
                                                              style: const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400),
                                                            ),
                                                          ),
                                                  ],
                                                ),
                                                // const Divider()
                                              ],
                                            ),
                                          ),
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
}
