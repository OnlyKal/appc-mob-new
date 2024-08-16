import 'package:appc/func/export.dart';
import 'package:flutter/cupertino.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future userscard;

  @override
  void initState() {
    getUsercard();
    super.initState();
  }

  // REFRESH CARDS
  getUsercard() => setState(() {
        userscard = getUserCards();
      });

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
          backgroundColor: const Color.fromARGB(255, 238, 237, 237),
          appBar: AppBar(
            backgroundColor: Colors.white,
            leading: InkWell(
              onTap: () => goTo(context, const PresentationPage()),
              child: Image.asset(
                "assets/logo.png",
              ),
            ),
            title: const Text(
              "APPC SERVICES",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const badges.Badge(
                  badgeContent: Text(
                    "2",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  child: Icon(CupertinoIcons.bell),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: SizedBox(
              child: Column(
                children: [
                  FutureBuilder(
                      future: userscard,
                      builder: (context, AsyncSnapshot user) {
                        if (user.hasData) {
                          localListCards = user.data.toList();
                          if (localListCards.isEmpty) {
                            return noCardyet(context);
                          } else {
                            return CarouselSlider(
                              options: CarouselOptions(
                                  height: 220.0,
                                  enlargeCenterPage: true,
                                  enableInfiniteScroll: false),
                              items: localListCards.map((card) {
                                return Builder(
                                  builder: (BuildContext context) {
                                    return Container(
                                      margin: const EdgeInsets.only(top: 10),
                                      child: cardMember(card, context),
                                    );
                                  },
                                );
                              }).toList(),
                            );
                          }
                        }
                        return noCardy(context);
                      }),
                  const SizedBox(height: 5),
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
                            () => goTo(context, const Frequentation())),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.white,
            onPressed: () => goTo(context, const OrderCard()),
            child: const Icon(
              color: Colors.blue,
              CupertinoIcons.creditcard,
            ),
          )),
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
