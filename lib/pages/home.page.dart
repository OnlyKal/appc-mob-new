import 'package:appc/func/export.dart';
import 'package:flutter/cupertino.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 231, 230, 230),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 231, 230, 230),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: fullHeight(context),
          child: Column(
            children: [
              FutureBuilder(
                  future: getUserCards(),
                  builder: (context, AsyncSnapshot user) {
                    if (user.hasData) {
                       localListCards = user.data.toList();
                      // print(localListCards);
                      return CarouselSlider(
                        options: CarouselOptions(
                            height: 220.0,
                            enlargeCenterPage: true,
                            enableInfiniteScroll: false),
                        items: localListCards.map((card) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Stack(
                                children: [
                                  Container(
                                      padding: const EdgeInsets.all(13),
                                      width: fullWidth(context),
                                      decoration: BoxDecoration(
                                          color: getMembershipColor(
                                              card['card']['name']),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          image: const DecorationImage(
                                              image: AssetImage(
                                                "assets/bgcard.png",
                                              ),
                                              opacity: 0.1,
                                              fit: BoxFit.cover)),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  for (var i = 0;
                                                      i <
                                                          card['card']
                                                              ['stars_number'];
                                                      i++)
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
                                          Text(
                                            card['number'] ?? '',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w800,
                                                fontSize: 21,
                                                color: Colors.white,
                                                letterSpacing: 2.2),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Text(
                                                    "Titulaire",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w300),
                                                  ),
                                                  FutureBuilder(
                                                      future:
                                                          getSessionDetails(),
                                                      builder: (context,
                                                          AsyncSnapshot
                                                              session) {
                                                        if (session.hasData) {
                                                          return Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                converToUpperCase(
                                                                    "${session.data['first_name'] ?? ''} ${session.data['last_name'] ?? ''}"),
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700),
                                                              ),
                                                              Text(
                                                                "${session.data['function'] ?? 'Compte Professionel'}",
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w300),
                                                              ),
                                                            ],
                                                          );
                                                        }
                                                        return Container();
                                                      })
                                                ],
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Text(
                                                    "VALIDITE",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w300),
                                                  ),
                                                  Text(
                                                    "${card['wallet'][0]['stock']} Jours",
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      )),
                                  Positioned(
                                      child: Container(
                                    height: 220,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 13),
                                    alignment: Alignment.topRight,
                                    decoration: const BoxDecoration(
                                        image: DecorationImage(
                                            opacity: 0.5,
                                            image:
                                                AssetImage("assets/logo.png"))),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              printData("jello");
                                            },
                                            icon: const Icon(
                                              CupertinoIcons.qrcode_viewfinder,
                                              size: 32,
                                              color: Colors.white,
                                            )),
                                        InkWell(
                                          onTap: () {
                                            print(card);
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 5, horizontal: 10),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(3),
                                                color: Colors.white),
                                            child: const Text(
                                              "PAYER ABONNEMENT",
                                              style: TextStyle(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ))
                                ],
                              );
                            },
                          );
                        }).toList(),
                      );
                    }
                    return noCardyet();
                  }),
              const SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(13),
                child: Column(
                  children: [
                    // optionElement("Abonnement", "Gestions des abonnements",
                    //     CupertinoIcons.square_line_vertical_square, () {}),
                    // const Divider(),
                    optionElement(
                        "Cartes",
                        "Passer une commande d'une nouvelle carte",
                        CupertinoIcons.creditcard,
                        () => goTo(context, const OrderCard())),
                    const Divider(),
                    optionElement(
                        "Profile",
                        "Gestions votre compte membre APPC",
                        CupertinoIcons.person,
                        () => goTo(context, const ProfilePage())),
                    const Divider(),
                    optionElement(
                        "Actualités",
                        "Les actualités sur toutes les plateformes APPC",
                        CupertinoIcons.news,
                        () => goTo(context, const Actualities())),
                    const Divider(),
                    optionElement(
                        "Q&A",
                        "Decouvrer plus sur les services APPC",
                        CupertinoIcons.question,
                        () => goTo(context, const QuestionsReponses())),
                    const Divider(),
                    optionElement(
                        "Statistique",
                        "Contrôle de la fréquence d'utilisation",
                        CupertinoIcons.chart_bar_alt_fill,
                        () {}),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  optionElement(title, subtitle, icon, event) {
    return ListTile(
      onTap: event,
      splashColor: Colors.grey,
      leading: CircleAvatar(
        backgroundColor: colorRandom(),
        child: Icon(
          icon,
          color: Colors.white,
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(color: Colors.grey),
      ),
    );
  }
}
