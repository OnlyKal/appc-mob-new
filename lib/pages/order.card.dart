import 'package:appc/func/export.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrderCard extends StatefulWidget {
  const OrderCard({super.key});

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color.fromARGB(255, 242, 242, 242),
      appBar: AppBar(
        leading: backPage(context),
        // backgroundColor: Colors.white,
        title: const Text(
          "Acheter une carte",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
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
                              padding: const EdgeInsets.only(bottom: 200),
                              itemCount: cardsList.length,
                              itemBuilder: (context, i) {
                                List currentPrice =
                                    cardsList[i]['current_price'].toList();
                                return Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 2, horizontal: 2),
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 2, horizontal: 5),
                                  decoration: const BoxDecoration(
                                      border: Border.symmetric(
                                    vertical: BorderSide(
                                        color: Colors.blue, width: 5),
                                  )),
                                  child: ListTile(
                                      tileColor: mainColor.withOpacity(0.2),
                                      onTap: () {
                                        goTo(
                                            context,
                                            CardDetail(
                                              card: cardsList[i],
                                            ));
                                      },
                                      title: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            converToUpperCase(
                                                cardsList[i]['name']),
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Row(
                                            children: [
                                              for (var a = 0;
                                                  a <
                                                      cardsList[i]
                                                          ['stars_number'];
                                                  a++)
                                                const Icon(
                                                  CupertinoIcons.star_fill,
                                                  size: 14,
                                                  color: Color.fromARGB(
                                                      255, 215, 152, 6),
                                                ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      subtitle: Container(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        width: fullWidth(context),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            if (currentPrice.isNotEmpty)
                                              Row(
                                                children: currentPrice
                                                    .where((price) =>
                                                        price['is_current'] ==
                                                        true)
                                                    .map((price) => Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(6),
                                                          color: const Color
                                                              .fromARGB(255,
                                                              167, 212, 247),
                                                          child: Text(
                                                            "USD ${newVal(price['price'])}",
                                                            style: const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                          ),
                                                        ))
                                                    .toList(),
                                              ),
                                            Text(
                                              "Réduction ${cardsList[i]['reduction'].toString()}%",
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w700,
                                              ),
                                            )
                                          ],
                                        ),
                                      )),
                                );
                              }));
                }
                return loading(context);
              })),
    );
  }
}
