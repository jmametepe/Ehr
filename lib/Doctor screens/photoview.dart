import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';



class PhotoViewer extends StatefulWidget {
final String url;

PhotoViewer({this.url});

  @override
  _PhotoViewerState createState() => _PhotoViewerState();
}

class _PhotoViewerState extends State<PhotoViewer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.black,
      ),
      body: PhotoView(
        imageProvider: NetworkImage(widget.url),
        
      ),
    );
  }
}
