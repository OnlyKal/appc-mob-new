import 'package:appc/func/export.dart';
import 'package:flutter/material.dart';

class ActualityCard extends StatefulWidget {
  final article;
  const ActualityCard({super.key, this.article});

  @override
  State<ActualityCard> createState() => _ActualityCardState();
}

class _ActualityCardState extends State<ActualityCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: backPage(context),
        backgroundColor: Colors.white,
        title: Text(
          "Actualité détaillée",
          style: TextStyle(color: mainColor, fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Image.network(
              widget.article['image'],
              fit: BoxFit.cover,
              height: 300,
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widget.article['title'],
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    timeAgo(widget.article['posted_at']),
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    textAlign: TextAlign.justify,
                    style: const TextStyle(fontSize: 16),
                    convertHtmlToText(newVal(widget.article['message'])),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
