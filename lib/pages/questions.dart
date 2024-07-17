import 'package:appc/func/export.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class QuestionsReponses extends StatefulWidget {
  const QuestionsReponses({super.key});

  @override
  State<QuestionsReponses> createState() => _QuestionsReponsesState();
}

class _QuestionsReponsesState extends State<QuestionsReponses> {
  List questionData = [
    {
      "question": "Qui est le président de la RDC ici à Mangurujipa ?",
      "response": null,
      "status": false
    },
    {
      "question":
          "Quelle est la capitale de la République Démocratique du Congo ?",
      "response": "",
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        leading: backPage(context),
        backgroundColor: mainColor,
        title: const Text(
          "Section Q&A",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: SizedBox(
                height: fullHeight(context),
                child: questionData.isEmpty
                    ? noElementFount(context)
                    : ListView.builder(
                        reverse: true,
                        itemCount: questionData.length,
                        itemBuilder: (context, i) {
                          return ListTile(
                            trailing: Icon(
                              CupertinoIcons.circle_filled,
                              size: 10,
                              color: questionData[i]['status'] == true
                                  ? Colors.green
                                  : const Color.fromARGB(255, 179, 179, 179),
                            ),
                            title: Text(
                              questionData[i]['question'],
                              style:
                                  const TextStyle(fontWeight: FontWeight.w600),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  questionData[i]['response'] ?? '',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w300),
                                ),
                                const Row(
                                  children: [
                                    Icon(
                                      CupertinoIcons.time,
                                      size: 12,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      'Il y a 4 jours',
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
            ),
          ),
          KeyboardVisibilityBuilder(
            builder: (context, isKeyboardVisible) {
              return Padding(
                padding: EdgeInsets.only(
                    bottom: isKeyboardVisible
                        ? MediaQuery.of(context).viewInsets.bottom
                        : 0),
                child: BottomSheet(
                  onClosing: () {},
                  builder: (context) {
                    return Container(
                      padding: const EdgeInsets.all(8.0),
                      color: const Color.fromARGB(255, 76, 75, 75),
                      child: Row(
                        children: [
                          const Expanded(
                            child: TextField(
                              keyboardType: TextInputType.multiline,
                              style: TextStyle(color: Colors.white),
                              maxLines: null,
                              decoration: InputDecoration(
                                hintText: 'Écrivez votre question ici...',
                                hintStyle: TextStyle(color: Colors.grey),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: CircleAvatar(
                              backgroundColor: mainColor,
                              child: const Icon(CupertinoIcons.paperplane,
                                  color: Colors.white),
                            ),
                            onPressed: () {
                              // Logique pour envoyer la question
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
