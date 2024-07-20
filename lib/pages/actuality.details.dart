// import 'dart:convert';
// import 'package:expandable/expandable.dart';
// import 'package:appc/func/color.dart';
// import 'package:appc/func/export.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
// import 'package:badges/badges.dart' as badges;

// class ActualityCard extends StatefulWidget {
//   final article;
//   const ActualityCard({super.key, this.article});
//   @override
//   State<ActualityCard> createState() => _ActualityCardState();
// }

// class _ActualityCardState extends State<ActualityCard> {
//   var actuality;
//   ScrollController scrollController = ScrollController();
//   @override
//   void initState() {
//     init();
//     refresh();
//     super.initState();
//   }

//   bool isposting = false;
//   refresh() {
//     getOnenews(widget.article['id']).then((news) {
//       (news != null)
//           ? setState(() => actuality = news)
//           : setState(() => actuality = widget.article);
//       ctrollerComent.text = '';
//     });
//   }

//   init() => setState(() => actuality = widget.article);

//   void scrollToPosition(double offset) {
//     scrollController.animateTo(
//       offset,
//       duration: const Duration(milliseconds: 100),
//       curve: Curves.easeInOut,
//     );
//   }

//   bool hideBottomField = false;

//   TextEditingController ctrollerComent = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         leading: backPage(context),
//         // leading: IconButton(
//         //     onPressed: () => goTo(context, const Actualities()),
//         //     icon: const Icon(CupertinoIcons.back)),
//         backgroundColor: Colors.white,
//         title: Text(
//           "Actualité détaillée",
//           style: TextStyle(color: mainColor, fontWeight: FontWeight.w600),
//         ),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: SingleChildScrollView(
//               controller: scrollController,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: <Widget>[
//                   Image.network(
//                     actuality['image'].toString(),
//                     fit: BoxFit.cover,
//                     height: 300,
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(20),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: <Widget>[
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               actuality['category']['name'],
//                               style: const TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             TextButton(
//                               onPressed: () => scrollToPosition(800.0),
//                               child: Row(
//                                 children: [
//                                   badges.Badge(
//                                     badgeContent: Text(
//                                       actuality['comment'].length.toString(),
//                                       style: const TextStyle(
//                                         color: Colors.white,
//                                       ),
//                                     ),
//                                     child:
//                                         const Icon(CupertinoIcons.bubble_left),
//                                   ),
//                                   const SizedBox(
//                                     width: 15,
//                                   ),
//                                   const Text('Commentaires')
//                                 ],
//                               ),
//                             )
//                           ],
//                         ),
//                         Text(
//                           actuality['title'],
//                           style: const TextStyle(
//                             fontSize: 25,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         const SizedBox(height: 10),
//                         Text(
//                           timeAgo(actuality['posted_at']),
//                           style: TextStyle(
//                             color: Colors.grey[600],
//                           ),
//                         ),
//                         const SizedBox(height: 10),
//                         Text(
//                           textAlign: TextAlign.justify,
//                           style: const TextStyle(fontSize: 16),
//                           convertHtmlToText(newVal(actuality['message'])),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Text(
//                       "COMMENTAIRES (${actuality['comment'].length})",
//                       style: const TextStyle(fontWeight: FontWeight.w700),
//                     ),
//                   ),
//                   for (var x = actuality['comment'].length - 1; x >= 0; x--)
//                     commentaireElement(actuality['comment'][x]),
//                   const SizedBox(
//                     height: 100,
//                   )
//                 ],
//               ),
//             ),
//           ),
//           if (hideBottomField == true)
//             KeyboardVisibilityBuilder(
//               builder: (context, isKeyboardVisible) {
//                 return Padding(
//                   padding: EdgeInsets.only(
//                       bottom: isKeyboardVisible
//                           ? MediaQuery.of(context).viewInsets.bottom
//                           : 0),
//                   child: Container(
//                     padding: const EdgeInsets.all(8.0),
//                     color: const Color.fromARGB(255, 76, 75, 75),
//                     child: Row(
//                       children: [
//                         Expanded(
//                           child: TextField(
//                             controller: ctrollerComent,
//                             keyboardType: TextInputType.multiline,
//                             style: const TextStyle(color: Colors.white),
//                             maxLines: null,
//                             decoration: const InputDecoration(
//                               hintText: 'Laisser nous un commentaire',
//                               hintStyle: TextStyle(color: Colors.grey),
//                               border: InputBorder.none,
//                             ),
//                           ),
//                         ),
//                         IconButton(
//                           icon: isposting == true
//                               ? const SizedBox(
//                                   height: 20,
//                                   width: 20,
//                                   child: CircularProgressIndicator(
//                                     color: Colors.white,
//                                   ))
//                               : CircleAvatar(
//                                   backgroundColor: mainColor,
//                                   child: const Icon(CupertinoIcons.paperplane,
//                                       color: Colors.white),
//                                 ),
//                           onPressed: () {
//                             setState(() => isposting = true);
//                             postNewsComment(
//                                     widget.article['id'], ctrollerComent.text)
//                                 .then((comment) {
//                               refresh();
//                               setState(() => isposting = false);
//                             });
//                           },
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//         ],
//       ),
//     );
//   }

//   commentaireElement(actuality) {
//     bool showField = false;

//     return StatefulBuilder(builder: (context, useState) {
//       return Column(
//         children: [
//           ExpandablePanel(
//             header: Container(
//               decoration: const BoxDecoration(
//                 color: Color.fromARGB(255, 255, 255, 255),
//               ),
//               padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
//               child: Column(
//                 children: [
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Icon(
//                         CupertinoIcons.person_alt_circle,
//                         color: mainColor,
//                       ),
//                       const SizedBox(
//                         width: 12,
//                       ),
//                       Expanded(
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             const Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(
//                                   "Ruphin Kamaraje",
//                                   style: TextStyle(
//                                       fontSize: 18,
//                                       fontWeight: FontWeight.w600),
//                                 ),
//                               ],
//                             ),
//                             Text(
//                               newUtf(actuality['message']),
//                               style:
//                                   const TextStyle(fontWeight: FontWeight.w300),
//                             ),
//                             const SizedBox(
//                               height: 6,
//                             ),
//                             const SizedBox(
//                               height: 6,
//                             ),
//                             InkWell(
//                               onTap: () {},
//                               child: Text(
//                                 "Reponses (${actuality['sub_comment'].length})",
//                                 style: TextStyle(
//                                     color: mainColor,
//                                     fontWeight: FontWeight.w600),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//             collapsed: Container(),
//             expanded: Column(
//               crossAxisAlignment: CrossAxisAlignment.end,
//               children: [
//                 for (int a = 0; a < actuality['sub_comment'].length; a++)
//                   subComment(actuality['sub_comment'][a]),
//                 SizedBox(
//                   width: fullWidth(context),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     children: [
//                       TextButton(
//                         onPressed: () => useState(() {
//                           showField = !showField;
//                           hideBottomField = !hideBottomField;
//                         }),
//                         child: Text(
//                           showField == true
//                               ? "Cacher la zone "
//                               : "Ajouter une reponse",
//                           style: TextStyle(
//                               color: mainColor, fontWeight: FontWeight.w600),
//                         ),
//                       ),
//                       if (showField == true)
//                         Container(
//                           width: 250,
//                           color: Colors.grey,
//                           margin: const EdgeInsets.only(right: 10),
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 1,
//                               vertical: 8), // Adding padding to the container
//                           child: const IntrinsicHeight(
//                             child: TextField(
//                               maxLines:
//                                   null, // Allows the TextField to grow vertically
//                               decoration: InputDecoration(
//                                 suffixIcon:
//                                     Icon(CupertinoIcons.paperplane_fill),
//                                 contentPadding:
//                                     EdgeInsets.symmetric(horizontal: 10),
//                                 border: InputBorder.none,
//                               ),
//                             ),
//                           ),
//                         )
//                     ],
//                   ),
//                 )
//               ],
//             ),
//             // tapHeaderToExpand: true,
//             // hasIcon: true,
//           ),
//           // Divider()
//         ],
//       );
//     });
//   }

//   subComment(subcomment) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.end,
//       children: [
//         Container(
//           margin: const EdgeInsets.only(left: 60, right: 7),
//           padding: const EdgeInsets.all(6),
//           decoration: const BoxDecoration(
//               color: Color.fromARGB(255, 248, 248, 248),
//               border: Border(
//                   bottom: BorderSide(
//                       width: 1, color: Color.fromARGB(255, 222, 221, 221)))),
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Padding(
//                 padding: EdgeInsets.all(4.0),
//                 child: Icon(
//                   Icons.circle,
//                   size: 7,
//                 ),
//               ),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text(
//                       "Jean-Claude",
//                       style: TextStyle(fontWeight: FontWeight.w500),
//                     ),
//                     Text(
//                       newUtf(subcomment['message']),
//                       style: const TextStyle(fontWeight: FontWeight.w300),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'dart:convert';
import 'package:expandable/expandable.dart';
import 'package:appc/func/color.dart';
import 'package:appc/func/export.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:badges/badges.dart' as badges;

class ActualityCard extends StatefulWidget {
  final Map<String, dynamic> article; // Specify the type of 'article'

  const ActualityCard({Key? key, required this.article}) : super(key: key);

  @override
  State<ActualityCard> createState() => _ActualityCardState();
}

class _ActualityCardState extends State<ActualityCard> {
  late Map<String, dynamic> actuality; // Define the type and use late keyword
  final ScrollController scrollController = ScrollController();
  final TextEditingController ctrollerComent = TextEditingController();
  bool isPosting = false;
  bool hideBottomField = false;

  @override
  void initState() {
    super.initState();
    init();
    refresh();
  }

  void refresh() {
    getOnenews(widget.article['id']).then((news) {
      setState(() {
        actuality = news ?? widget.article;
        ctrollerComent.clear();
      });
    });
  }

  void init() {
    setState(() {
      actuality = widget.article;
    });
  }

  void scrollToPosition(double offset) {
    scrollController.animateTo(
      offset,
      duration: const Duration(milliseconds: 100),
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
                                  const SizedBox(width: 15),
                                  const Text('Commentaires'),
                                ],
                              ),
                            ),
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
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          convertHtmlToText(newVal(actuality['message'])),
                          textAlign: TextAlign.justify,
                          style: const TextStyle(fontSize: 16),
                        ),
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
                      InkWell(
                          onTap: () {
                            setState(() => hideBottomField = !hideBottomField);
                          },
                          child: Container(
                              margin: EdgeInsets.all(10),
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: mainColor,
                                  borderRadius: BorderRadius.circular(8)),
                              child: const Text(
                                "Commenter",
                                style: TextStyle(color: Colors.white),
                              )))
                    ],
                  ),
                  for (var x = actuality['comment'].length - 1; x >= 0; x--)
                    commentaireElement(actuality['comment'][x]),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
          if (hideBottomField == true)
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
                              hintText: 'Laissez un commentaire',
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: isPosting
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                )
                              : CircleAvatar(
                                  backgroundColor: mainColor,
                                  child: const Icon(CupertinoIcons.paperplane,
                                      color: Colors.white),
                                ),
                          onPressed: () {
                            setState(() => isPosting = true);
                            postNewsComment(
                                    widget.article['id'], ctrollerComent.text)
                                .then((comment) {
                              refresh();
                              setState(() {
                                hideBottomField = false;
                                isPosting = false;
                              });
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

  TextEditingController subCommentCtrl = new TextEditingController();
  Widget commentaireElement(Map<String, dynamic> comment) {
    bool showField = false;
    bool isPostingSub = false;

    return StatefulBuilder(
      builder: (context, useState) {
        return Column(
          children: [
            ExpandablePanel(
              header: Container(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          CupertinoIcons.person_alt_circle,
                          color: mainColor,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Ruphin Kamaraje",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              Text(
                                newUtf(comment['message']),
                                style: const TextStyle(
                                    fontWeight: FontWeight.w300),
                              ),
                              if (comment['sub_comment'].isNotEmpty)
                                const SizedBox(height: 6),
                              if (comment['sub_comment'].isNotEmpty)
                                InkWell(
                                  onTap: () {},
                                  child: Text(
                                    "Réponses (${comment['sub_comment'].length})",
                                    style: TextStyle(
                                        color: mainColor,
                                        fontWeight: FontWeight.w600),
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
              collapsed: Container(),
              expanded: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  for (int a = 0; a < comment['sub_comment'].length; a++)
                    subComment(comment['sub_comment'][a]),
                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            useState(() => showField = !showField);
                          },
                          child: Text(
                            showField
                                ? "Cacher la zone"
                                : "Ajouter une réponse",
                            style: TextStyle(
                                color: mainColor, fontWeight: FontWeight.w600),
                          ),
                        ),
                        if (showField)
                          Container(
                            width: 250,
                            color: const Color.fromARGB(255, 219, 219, 219),
                            margin: const EdgeInsets.only(right: 10),
                            child: IntrinsicHeight(
                              child: TextField(
                                controller: subCommentCtrl,
                                maxLines: null,
                                decoration: InputDecoration(
                                  hintText: "Répondre au commentaire",
                                  suffixIcon: isPostingSub == true
                                      ? CircleAvatar(
                                          backgroundColor: mainColor,
                                          child: const Icon(
                                              CupertinoIcons.paperplane,
                                              color: Colors.white),
                                        )
                                      : IconButton(
                                          onPressed: () {
                                            useState(() => isPostingSub = true);
                                            postNewssubComment(
                                                    widget.article['id'],
                                                    comment['id'],
                                                    subCommentCtrl.text)
                                                .then((comment) {
                                              // refresh();
                                              print(comment);
                                              useState(() {
                                                isPostingSub = false;
                                              });
                                            });
                                          },
                                          icon: const Icon(
                                              CupertinoIcons.paperplane_fill)),
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 3),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget subComment(Map<String, dynamic> subcomment) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 60, right: 7),
          padding: const EdgeInsets.all(6),
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 248, 248, 248),
            border: Border(
              bottom: BorderSide(
                width: 1,
                color: Color.fromARGB(255, 222, 221, 221),
              ),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(4.0),
                child: Icon(
                  Icons.circle,
                  size: 7,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Jean-Claude",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    Text(
                      newUtf(subcomment['message']),
                      style: const TextStyle(fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
