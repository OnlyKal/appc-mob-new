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
      appBar: AppBar(
        leading: backPage(context),
        backgroundColor: Colors.white,
        title: Text(
          "Acheter une carte",
          style: TextStyle(color: mainColor, fontWeight: FontWeight.w600),
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
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: Color.fromARGB(255, 206, 206,
                                            206), 
                                        width: 1.0,
                                      ),
                                    ),
                                  ),
                                  child: ListTile(
                                    tileColor: Colors.white,
                                    onTap: () {
                                      goTo(
                                          context,
                                          CardDetail(
                                            card: cardsList[i],
                                          ));
                                    },
                                    title: Text(
                                      converToUpperCase(cardsList[i]['name']),
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
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            if (currentPrice.isNotEmpty)
                                              for (var i = 0;
                                                  i < currentPrice.length;
                                                  i++)
                                                if (currentPrice[i]
                                                        ['is_current'] ==
                                                    true)
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.all(6),
                                                    color: const Color.fromARGB(
                                                        255, 225, 223, 223),
                                                    child: Text(
                                                      "USD ${newVal(currentPrice[0]['price'])}",
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.w400),
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
              })),
    );
  }
}
