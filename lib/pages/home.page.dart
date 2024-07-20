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
  void initState() {
    super.initState();
  }

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
                      return CarouselSlider(
                        options: CarouselOptions(
                            height: 220.0,
                            enlargeCenterPage: true,
                            enableInfiniteScroll: false),
                        items: localListCards.map((card) {
                          return Builder(
                            builder: (BuildContext context) {
                              return cardMember(card, context);
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
