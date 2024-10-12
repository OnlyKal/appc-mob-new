import 'package:appc/func/export.dart';
import 'package:flutter/cupertino.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future userscard;
  late Future notificationsCount;

  @override
  void initState() {
    getUsercard();
    super.initState();
  }

  // REFRESH CARDS
  getUsercard() {
    setState(() {
      userscard = getUserCards();
      notificationsCount = getNotifCount();
    });

    socket?.on("emit-new-actuality", (data) {
      setState(() {
        notificationsCount = getNotifCount();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final lngx = Provider.of<LocalizationProvider>(context);
    return PopScope(
      canPop: false,
      child: Scaffold(
          appBar: AppBar(
            leading: InkWell(
              onTap: () => goTo(context, const PresentationPage()),
              child: Image.asset(
                "assets/logo.png",
              ),
            ),
            title: Text(
              lngx.trans("dashboard"),
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            actions: [
              IconButton(
                onPressed: () async {
                  await clearNotifCount();
                  goTo(context, const NotificationPage());
                },
                icon: badges.Badge(
                  badgeContent: FutureBuilder(
                      future: notificationsCount,
                      builder: (context, AsyncSnapshot notif) {
                        print(notif.data);
                        if (notif.hasData) {
                          return Text(
                            notif.data.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          );
                        }
                        return const Text(
                          "0",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        );
                      }),
                  child: const Icon(CupertinoIcons.bell),
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
                                      child:
                                          cardMember(card, context, lngx.trans),
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
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.all(13),
                    child: Column(
                      children: [
                        optionElement(
                            lngx.trans("cards"),
                            lngx.trans("order_new_card"),
                            CupertinoIcons.creditcard,
                            () => goTo(context, const OrderCard())),
                        const Divider(
                          color: Colors.grey,
                        ),
                        optionElement(
                            lngx.trans("profile"),
                            lngx.trans("manage_member_account"),
                            CupertinoIcons.person,
                            () => goTo(context, const ProfilePage())),
                        const Divider(
                          color: Colors.grey,
                        ),
                        optionElement(
                            lngx.trans("news"),
                            lngx.trans("news_desc"),
                            CupertinoIcons.news,
                            () => goTo(context, const Actualities())),
                        const Divider(
                          color: Colors.grey,
                        ),
                        optionElement(
                            lngx.trans("discussion"),
                            lngx.trans("discover_more"),
                            CupertinoIcons.bubble_middle_bottom,
                            () => goTo(context, const QuestionsReponses())),
                        const Divider(
                          color: Colors.grey,
                        ),
                        optionElement(
                            lngx.trans("usage_statistics"),
                            lngx.trans("manage_member_account"),
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
            onPressed: () => goTo(context, const OrderCard()),
            child: const Icon(
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
