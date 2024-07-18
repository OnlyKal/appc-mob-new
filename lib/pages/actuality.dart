import 'package:appc/func/export.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:skeletonizer/skeletonizer.dart';

class Actualities extends StatefulWidget {
  const Actualities({super.key});

  @override
  State<Actualities> createState() => _ActualitiesState();
}

class _ActualitiesState extends State<Actualities> {
  late Future allnews;
  int limit = 20;
  int page = 1;

  @override
  void initState() {
    initNews(limit, page);
    super.initState();
  }

  initNews(l, p) => allnews = getAllnews(l, p);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 240, 240, 240),
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => goTo(context, const Actualities()),
            icon: const Icon(CupertinoIcons.back)),
        backgroundColor: Colors.white,
        title: Text(
          "Nos Actualités",
          style: TextStyle(color: mainColor, fontWeight: FontWeight.w600),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: FutureBuilder(
                  future: allnews,
                  builder: (context, AsyncSnapshot news) {
                    if (news.hasData) {
                      List actualityList = news.data['data'].reversed.toList();
                      return SizedBox(
                        height: fullHeight(context),
                        child: Skeletonizer(
                          enabled: false,
                          child: ListView.builder(
                              itemCount: actualityList.length,
                              itemBuilder: (context, i) {
                                var imageUrl = actualityList[i]['image'];
                                return InkWell(
                                  onTap: () => goTo(context,
                                      ActualityCard(article: actualityList[i])),
                                  child: Container(
                                    width: fullHeight(context),
                                    margin: const EdgeInsets.only(bottom: 4),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 100,
                                          width: 150,
                                          decoration: BoxDecoration(
                                              color: const Color.fromARGB(
                                                  255, 72, 72, 72),
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: imageUrl == null
                                                      ? const AssetImage(
                                                          "assets/bgCard.png")
                                                      : NetworkImage(
                                                          imageUrl))),
                                        ),
                                        Expanded(
                                          child: Container(
                                            color: Colors.white,
                                            padding: const EdgeInsets.only(
                                                left: 10, right: 10),
                                            height: 100,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  children: [
                                                    Text(
                                                      actualityList[i]['title'],
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      "${convertHtmlToText(newVal(actualityList[i]['message'])).toString().substring(0, 54)}...",
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.w300),
                                                    ),
                                                  ],
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 3),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Icon(
                                                            CupertinoIcons
                                                                .bubble_middle_bottom,
                                                            size: 12,
                                                          ),
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          Text(
                                                            actualityList[i]
                                                                    ['comment']
                                                                .length
                                                                .toString(),
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                          ),
                                                        ],
                                                      ),
                                                      Text(
                                                        timeAgo(actualityList[i]
                                                            ['posted_at']),
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        ),
                      );
                    }
                    return loading(context);
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
