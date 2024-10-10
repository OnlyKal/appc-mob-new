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
      // backgroundColor: const Color.fromARGB(255, 240, 240, 240),
      appBar: AppBar(
        leading: backPage(context),
        // backgroundColor: Colors.white,
        title: const Text(
          "Nos Actualités",
          style: TextStyle(fontWeight: FontWeight.w600),
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
                              padding:
                                  const EdgeInsetsDirectional.only(bottom: 200),
                              itemCount: actualityList.length,
                              itemBuilder: (context, i) {
                                var imageUrl = actualityList[i]['image'];
                                return InkWell(
                                  onTap: () {
                                    // print(actualityList[i]);
                                    goTo(
                                        context,
                                        NewsDetailPage(
                                            article: actualityList[i]));
                                  },
                                  child: Container(
                                    width: fullHeight(context),
                                    decoration: const BoxDecoration(
                                        // color: Colors.white,
                                        ),
                                    padding: const EdgeInsets.all(6),
                                    margin: const EdgeInsets.only(bottom: 2),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 100,
                                          width: 150,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(7),
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
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: Container(
                                            // color: Colors.white,
                                            height: 100,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  newUtf(actualityList[i]
                                                                  ['title'])
                                                              .length <=
                                                          110
                                                      ? newUtf(actualityList[i]
                                                          ['title'])
                                                      : "${newUtf(actualityList[i]['title']).toString().substring(0, 130)}...",
                                                  style: const TextStyle(
                                                      fontSize: 16.6,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  timeAgo(actualityList[i]
                                                      ['posted_at']),
                                                  style: const TextStyle(
                                                      fontSize: 11,
                                                      fontWeight:
                                                          FontWeight.w400),
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
