import 'package:appc/func/export.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:badges/badges.dart' as badges;

class ActualityCard extends StatefulWidget {
  final article;
  const ActualityCard({super.key, this.article});
  @override
  State<ActualityCard> createState() => _ActualityCardState();
}

class _ActualityCardState extends State<ActualityCard> {
  var actuality;
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    init();
    refresh();
    super.initState();
  }

  bool isposting = false;
  refresh() {
    getOnenews(widget.article['id']).then((news) {
      (news != null)
          ? setState(() => actuality = news)
          : setState(() => actuality = widget.article);
      ctrollerComent.text = '';
    });
  }

  init() => setState(() => actuality = widget.article);

  void scrollToPosition(double offset) {
    scrollController.animateTo(
      offset,
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeInOut,
    );
  }

  TextEditingController ctrollerComent = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: backPage(context),
        // leading: IconButton(
        //     onPressed: () => goTo(context, const Actualities()),
        //     icon: const Icon(CupertinoIcons.back)),
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
                  Image.network(
                    actuality['image'].toString(),
                    fit: BoxFit.cover,
                    height: 300,
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
                              onPressed: () => scrollToPosition(800.0),
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
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  const Text('Commentairess')
                                ],
                              ),
                            )
                          ],
                        ),
                        Text(
                          actuality['title'],
                          style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          timeAgo(actuality['posted_at']),
                          style: TextStyle(
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          textAlign: TextAlign.justify,
                          style: const TextStyle(fontSize: 16),
                          convertHtmlToText(newVal(actuality['message'])),
                        ),
                      ],
                    ),
                  ),
                  for (var x = 0; x < actuality['comment'].length; x++)
                    Container(
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 255, 255, 255),
                          border: Border(
                              bottom: BorderSide(color: Colors.black12))),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 15),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const CircleAvatar(
                                child: Icon(CupertinoIcons.person),
                              ),
                              const SizedBox(
                                width: 12,
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Utilisateur 00$x",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      actuality['comment'][x]['message'],
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(
                    height: 100,
                  )
                ],
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
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  color: const Color.fromARGB(255, 76, 75, 75),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: ctrollerComent,
                          keyboardType: TextInputType.multiline,
                          style: const TextStyle(color: Colors.white),
                          maxLines: null,
                          decoration: const InputDecoration(
                            hintText: 'Laisser nous un commentaire',
                            hintStyle: TextStyle(color: Colors.grey),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: isposting == true
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ))
                            : CircleAvatar(
                                backgroundColor: mainColor,
                                child: const Icon(CupertinoIcons.paperplane,
                                    color: Colors.white),
                              ),
                        onPressed: () {
                          setState(() => isposting = true);
                          postNewsComment(
                                  widget.article['id'], ctrollerComent.text)
                              .then((comment) {
                            refresh();
                            setState(() => isposting = false);
                          });
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
