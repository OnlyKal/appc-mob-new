import 'package:appc/func/export.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class Actualities extends StatefulWidget {
  const Actualities({super.key});

  @override
  State<Actualities> createState() => _ActualitiesState();
}

class _ActualitiesState extends State<Actualities> {
  late Future allnews;

  List questionData = [
    {
      "question": "Qui est le président de la RDC ici à Mangurujipa ?",
      "response":
          "Quelle est la capitale de la République Démocratique du Congo ?",
      "status": true
    },
    {
      "question":
          "Quelle est la capitale de la République Démocratique du Congo ?",
      "response":
          "Quelle est la capitale de la République Démocratique du Congo ?",
      "status": false
    },
    {
      "question": "Quel est le plus grand fleuve de la RDC ?",
      "response": "Le plus grand fleuve de la RDC est le fleuve Congo.",
      "status": true
    },
    {
      "question": "Quelle est la langue officielle de la RDC ?",
      "response": "La langue officielle de la RDC est le français.",
      "status": true
    },
    {
      "question":
          "Quels sont les principaux produits d'exportation de la RDC ?",
      "response":
          "Les principaux produits d'exportation de la RDC sont le cuivre, le cobalt, le café, et le pétrole.",
      "status": true
    },
    {
      "question": "Quelle est la langue officielle de la RDC ?",
      "response": "La langue officielle de la RDC est le français.",
      "status": true
    },
    {
      "question":
          "Quels sont les principaux produits d'exportation de la RDC ?",
      "response":
          "Les principaux produits d'exportation de la RDC sont le cuivre, le cobalt, le café, et le pétrole.",
      "status": true
    },
    {
      "question": "Quelle est la langue officielle de la RDC ?",
      "response": "La langue officielle de la RDC est le français.",
      "status": true
    },
    {
      "question":
          "Quels sont les principaux produits d'exportation de la RDC ?",
      "response":
          "Les principaux produits d'exportation de la RDC sont le cuivre, le cobalt, le café, et le pétrole.",
      "status": true
    },
    {
      "question": "Quelle est la langue officielle de la RDC ?",
      "response": "La langue officielle de la RDC est le français.",
      "status": true
    },
    {
      "question": "ikkk les principaux produits d'exportation de la RDC ?",
      "response":
          "Les principaux produits d'exportation de la RDC sont le cuivre, le cobalt, le café, et le pétrole.",
      "status": true
    }
  ];

  int limit = 1;
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        leading: backPage(context),
        backgroundColor: mainColor,
        title: const Text(
          "Nos Actualités",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: FutureBuilder(
                  future: allnews,
                  builder: (context, AsyncSnapshot news) {
                    print(news.data);
                    if (news.hasData) {
                      return SizedBox(
                        height: fullHeight(context),
                        child: Skeletonizer(
                          child: ListView.builder(
                              reverse: true,
                              itemCount: questionData.length,
                              itemBuilder: (context, i) {
                                return ListTile(
                                  isThreeLine: true,
                                  trailing: Container(
                                    height: 100,
                                    width: 100,
                                    decoration: const BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 230, 230, 230)),
                                  ),
                                  title: Text(
                                    questionData[i]['question'],
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        questionData[i]['response'].length > 100
                                            ? "${questionData[i]['response'].substring(0, 100)}..."
                                            : questionData[i]['response'] ?? "",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w300),
                                      ),
                                      const Row(
                                        children: [
                                          Icon(
                                            CupertinoIcons.bubble_middle_bottom,
                                            size: 12,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            '10',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                      const Divider()
                                    ],
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
