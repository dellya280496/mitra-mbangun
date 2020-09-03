import 'package:flutter/material.dart';
import 'package:pinch_zoom_image_last/pinch_zoom_image_last.dart';

class PreviewFoto extends StatelessWidget {
  String urlFoto;

  PreviewFoto({Key key, this.urlFoto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      child: Scaffold(
        backgroundColor: Colors.black45,
        appBar: AppBar(
          backgroundColor: Colors.black45,
          title: Text('Preview'),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.clear,
                color: Colors.white,
              ),
            ),
          ],
        ),
        body: Center(
          child: PinchZoomImage(
            image: Image.network(urlFoto, errorBuilder: (context, urlImage, error) {
              print(error.hashCode);
              return Image.asset('assets/logo.png');
            }),
            zoomedBackgroundColor: Color.fromRGBO(240, 240, 240, 1.0),
            hideStatusBarWhileZooming: true,
            onZoomStart: () {
              print('Zoom started');
            },
            onZoomEnd: () {
              print('Zoom finished');
            },
          ),
        ),
      ),
    );
  }
}
