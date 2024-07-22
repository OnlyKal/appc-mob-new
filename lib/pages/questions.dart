import 'package:appc/func/color.dart';
import 'package:appc/func/constant.dart';
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
  List questionData = [];

  late Future questions;
  TextEditingController questionController = TextEditingController();
  bool isResponding = false;

  @override
  void initState() {
    refresh();
    super.initState();
  }

  refresh() {
    getUserQuestions().then((data) {
      setState(() {
        if (data != null) {
          setState(() {
            questionData = data.reversed.toList();
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: backPage(context),
        backgroundColor: Colors.white,
        title: Text(
          "Section FAQ s",
          style: TextStyle(color: mainColor, fontWeight: FontWeight.w600),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: SizedBox(
                  height: fullHeight(context),
                  child: FutureBuilder(
                      future: getUserQuestions(),
                      builder: (context, question) {
                        if (question.hasData) {
                          return questionData.isEmpty
                              ? noElementFount(context)
                              : ListView.builder(
                                  itemCount: questionData.length,
                                  itemBuilder: (context, i) {
                                    return Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 1),
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(3),
                                        color: const Color.fromARGB(
                                            255, 236, 236, 236),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            newUtf(
                                                "Q$i. ${questionData[i]['question']}"),
                                            style: TextStyle(
                                                color: questionData[i][
                                                            'already_answered'] ==
                                                        false
                                                    ? Colors.grey
                                                    : Colors.black,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          const SizedBox(
                                            height: 7,
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                questionData[i][
                                                            'already_answered'] ==
                                                        true
                                                    ? Icons.check_circle
                                                    : Icons.timelapse_rounded,
                                                size: 13,
                                                color: questionData[i][
                                                            'already_answered'] ==
                                                        false
                                                    ? Colors.black
                                                    : Colors.green,
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Text(timeAgo(questionData[i]
                                                  ['created_at'])),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 7,
                                          ),
                                          if (questionData[i]
                                                  ['already_answered'] ==
                                              true)
                                            Container(
                                              padding: const EdgeInsets.all(7),
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(6)),
                                              child: Text(
                                                "R. ${newUtf(questionData[i]['answer'] ?? '')}",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    color: mainColor),
                                              ),
                                            ),
                                        ],
                                      ),
                                    );
                                  });
                        }
                        return loading(context);
                      })),
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
                          Expanded(
                            child: TextField(
                              controller: questionController,
                              keyboardType: TextInputType.multiline,
                              style: const TextStyle(color: Colors.white),
                              maxLines: null,
                              decoration: const InputDecoration(
                                hintText: 'Écrivez votre question ici...',
                                hintStyle: TextStyle(color: Colors.grey),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          isResponding == true
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                )
                              : IconButton(
                                  icon: CircleAvatar(
                                    backgroundColor: mainColor,
                                    child: const Icon(CupertinoIcons.paperplane,
                                        color: Colors.white),
                                  ),
                                  onPressed: () {
                                    setState(() => isResponding = true);
                                    postAddQuestion(questionController.text)
                                        .then((question) {
                                      setState(() => isResponding = false);
                                      refresh();
                                      questionController.text = "";
                                    });
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
