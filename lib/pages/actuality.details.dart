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

  double fontSize = 14.0;

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
      // backgroundColor: Colors.white,
      appBar: AppBar(
        leading: backPage(context),
        // backgroundColor: Colors.white,
        title: const Text(
          "Actualité détaillée",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        actions: [
          InkWell(
            onTap: () => setState(() => fontSize = 19),
            child: const Text(
              "A",
              style: TextStyle(fontSize: 35),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          InkWell(
            onTap: () => setState(() => fontSize = 17),
            child: const Text(
              "A",
              style: TextStyle(fontSize: 25),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          InkWell(
            onTap: () => setState(() => fontSize = 15),
            child: const Text(
              "A",
              style: TextStyle(fontSize: 18),
            ),
          ),
          const SizedBox(
            width: 20,
          )
        ],
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
                    onTap: () {
                      goTo(
                        context,
                        PhotoViewer(image: actuality['image'].toString()),
                      );
                    },
                    child: Image.network(
                      actuality['image'].toString(),
                      fit: BoxFit.cover,
                      height: 300,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 2, horizontal: 15),
                        child: Row(
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
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 2, horizontal: 15),
                        child: Text(
                          newUtf(actuality['title']),
                          style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      if (actuality['image_attachement'] != null &&
                          actuality['image_attachement'].isNotEmpty)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          // color: Colors.white,
                          width: fullWidth(context),
                          height: 100,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: actuality['image_attachement']
                                .map<Widget>((element) => Container(
                                      height: 100,
                                      width: 100,
                                      margin: const EdgeInsets.only(right: 10),
                                      color: const Color.fromARGB(
                                          255, 224, 224, 224),
                                      child: element != null
                                          ? InkWell(
                                              onTap: () {
                                                goTo(
                                                  context,
                                                  PhotoViewer(
                                                      image: element['image']
                                                          .toString()),
                                                );
                                              },
                                              child: Image.network(
                                                element['image'],
                                                fit: BoxFit.cover,
                                              ),
                                            )
                                          : const Icon(Icons.error),
                                    ))
                                .toList(),
                          ),
                        ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 2, horizontal: 15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              timeAgo(actuality['posted_at']),
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                            const SizedBox(height: 10),
                            htmlWiget(newUtf(actuality['message']), fontSize),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 2, horizontal: 6),
                    child: Row(
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
                                  back(context);
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
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 2, horizontal: 15),
                    child: FutureBuilder(
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
    return comment['parent_comment'] == null
        ? Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 221, 219, 219),
                    borderRadius: BorderRadius.circular(8)),
                margin:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 10,
                          backgroundColor:
                              const Color.fromARGB(255, 62, 62, 62),
                          child: Text(
                            comment['first_name']!
                                .substring(0, 1)
                                .toUpperCase(),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w300),
                              ),
                              Text(
                                timeAgo(comment['created_at']),
                                style: const TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.w600),
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
          )
        : Container();
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
                  margin: const EdgeInsets.only(left: 60, right: 18, top: 1),
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: const Color.fromARGB(255, 242, 241, 241),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 4, right: 8),
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
                            Text(
                              timeAgo(comment['created_at']),
                              style: const TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w600),
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
                        const EdgeInsets.symmetric(horizontal: 18, vertical: 3),
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
                border: InputBorder.none,
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
                  vertical: 40,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
