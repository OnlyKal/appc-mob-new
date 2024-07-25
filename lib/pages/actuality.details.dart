import 'package:appc/func/color.dart';
import 'package:appc/func/export.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:badges/badges.dart' as badges;

class NewsDetailPage extends StatefulWidget {
  final Map<String, dynamic> article;

  const NewsDetailPage({Key? key, required this.article}) : super(key: key);

  @override
  State<NewsDetailPage> createState() => _NewsDetailPageState();
}

class _NewsDetailPageState extends State<NewsDetailPage> {
  late Map<String, dynamic> actuality;
  final ScrollController scrollController = ScrollController();
  final TextEditingController ctrollerComent = TextEditingController();
  bool isPosting = false;
  bool hideBottomField = false;
  late Future commentaSync;

  @override
  void initState() {
    super.initState();
    actuality = widget.article;
    refresh();
  }

  void refresh() {
    getNewsDetails(widget.article['id']).then((news) {
      setState(() {
        actuality = news ?? widget.article;
        ctrollerComent.clear();
      });
    });
    refreshComent();
  }

  void refreshComent() {
    setState(() {
      commentaSync = getCommentNews(widget.article['id']);
    });
  }

  void scrollToPosition(double offset, int time) {
    scrollController.animateTo(
      offset,
      duration: Duration(milliseconds: time),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: backPage(context),
        backgroundColor: Colors.white,
        title: Text(
          "Actualité détaillée",
          style: TextStyle(color: mainColor, fontWeight: FontWeight.w600),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  InkWell(
                    onTap: () => goTo(
                      context,
                      PhotoViewer(image: actuality['image'].toString()),
                    ),
                    child: Image.network(
                      actuality['image'].toString(),
                      fit: BoxFit.cover,
                      height: 300,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              actuality['category']['name'],
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextButton(
                              onPressed: () => scrollToPosition(800.0, 100),
                              child: Row(
                                children: [
                                  badges.Badge(
                                    badgeContent: Text(
                                      actuality['comment'].length.toString(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    child:
                                        const Icon(CupertinoIcons.bubble_left),
                                  ),
                                  const SizedBox(width: 15),
                                  const Text('Commentaires'),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Text(
                          newUtf(actuality['title']),
                          style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          timeAgo(actuality['posted_at']),
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                        const SizedBox(height: 10),
                        htmlWiget(newUtf(actuality['message'])),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "COMMENTAIRES (${actuality['comment'].length})",
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          commenterZone('Laissez un commentaire', () {
                            if (ctrollerComent.text.isNotEmpty) {
                              setState(() => isPosting = true);
                              postNewsComment(
                                widget.article['id'],
                                ctrollerComent.text,
                              ).then((_) {
                                refresh();
                                setState(() {
                                  hideBottomField = false;
                                  isPosting = false;
                                });
                              });
                            } else {
                              message(
                                  "Veuillez entrer un commentaire", context);
                            }
                          }, ctrollerComent);
                        },
                        child: Row(
                          children: [
                            if (isPosting == true)
                              const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 1,
                                  )),
                            Text(
                              "Commenter",
                              style: TextStyle(color: mainColor),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  FutureBuilder(
                    future: commentaSync,
                    builder: (context, AsyncSnapshot comment) {
                      if (comment.hasData) {
                        List commentairesList = comment.data.toList();
                        return Column(
                          children: commentairesList.reversed
                              .map<Widget>((c) => commentaireElement(c))
                              .toList(),
                        );
                      }
                      return const Text("Aucune donnée");
                    },
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget commentaireElement(Map<String, dynamic> comment) {
    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 255, 255, 255),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 10,
                    backgroundColor: const Color.fromARGB(255, 62, 62, 62),
                    child: Text(
                      comment['first_name']!.substring(0, 1).toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 9,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${comment['first_name'] ?? ''} ${comment['last_name'] ?? ''}",
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          newUtf(comment['message']),
                          style: const TextStyle(fontWeight: FontWeight.w300),
                        ),
                        if (comment['sub_comment'].isNotEmpty)
                          const SizedBox(height: 6),
                        if (comment['sub_comment'].isNotEmpty)
                          InkWell(
                            onTap: () {
                              // Handle showing sub-comments
                            },
                            child: Text(
                              comment['sub_comment'].length == 1
                                  ? "Réponse (${comment['sub_comment'].length})"
                                  : "Réponses (${comment['sub_comment'].length})",
                              style: TextStyle(
                                color: mainColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        subComment(comment),
      ],
    );
  }

  TextEditingController subCommentCtrl = TextEditingController();
  bool showField = false;
  bool isPostingSub = false;
  void closeEd() {
    setState(() {
      showField == false;
    });
  }

  Widget subComment(comment) {
    return StatefulBuilder(builder: (context, useState) {
      return Column(
        children: [
          for (int a = 0; a < comment['sub_comment'].length; a++)
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 60, right: 7, top: 0.6),
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: const Color.fromARGB(255, 231, 229, 229),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: CircleAvatar(
                          radius: 8,
                          backgroundColor:
                              const Color.fromARGB(255, 106, 138, 157),
                          child: Text(
                            comment['sub_comment'][a]['first_name']!
                                .substring(0, 1)
                                .toUpperCase(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 6,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${comment['sub_comment'][a]['first_name'] ?? ''} ${comment['sub_comment'][a]['last_name'] ?? ''}",
                              style:
                                  const TextStyle(fontWeight: FontWeight.w500),
                            ),
                            Text(
                              newUtf(comment['sub_comment'][a]['message']),
                              style:
                                  const TextStyle(fontWeight: FontWeight.w300),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    commenterZone("Répondre au commentaire", () {
                      if (subCommentCtrl.text.isNotEmpty) {
                        setState(() => isPostingSub = true);
                        postNewssubComment(
                          widget.article['id'],
                          comment['id'],
                          subCommentCtrl.text,
                        ).then((_) {
                          setState(() {
                            refreshComent();
                            isPostingSub = false;
                            subCommentCtrl.clear();
                            back(context);
                          });
                        });
                      } else {
                        message("Veuillez entrer une réponse", context);
                      }
                    }, subCommentCtrl);
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 13, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        if (isPostingSub)
                          const SizedBox(
                            height: 10,
                            width: 10,
                            child: CircularProgressIndicator(
                              strokeWidth: 1,
                            ),
                          ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          showField ? "Cacher la zone" : "Répondre",
                          style: TextStyle(
                            color: mainColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    });
  }

  void commenterZone(hint, event, controller) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: roundAlert(),
      builder: (context) {
        return Container(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: IntrinsicHeight(
            child: TextField(
              controller: controller,
              maxLines: null,
              decoration: InputDecoration(
                hintText: hint,
                suffixIcon: isPostingSub
                    ? CircleAvatar(
                        backgroundColor: Theme.of(context).primaryColor,
                        child: const Icon(
                          CupertinoIcons.paperplane,
                          color: Colors.white,
                        ),
                      )
                    : IconButton(
                        onPressed: event,
                        icon: Icon(
                          size: isPostingSub == false ? 18 : 1,
                          CupertinoIcons.paperplane_fill,
                        ),
                      ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 3,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
