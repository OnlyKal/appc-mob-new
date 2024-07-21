import 'package:appc/func/export.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class PhotoViewer extends StatefulWidget {
  final String image;
  const PhotoViewer({super.key, required this.image});
  @override
  State<PhotoViewer> createState() => _PhotoViewerState();
}

class _PhotoViewerState extends State<PhotoViewer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: backPage(context),
        backgroundColor: Colors.white,
        title: Text(
          "",
          style: TextStyle(color: mainColor, fontWeight: FontWeight.w600),
        ),
      ),
      body: PhotoView(
        imageProvider: NetworkImage(widget.image.toString()),
      ),
    );
  }
}
