import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:share/share.dart';

class FullImage extends StatefulWidget {

  String imagePath;
  FullImage(this.imagePath);
  @override
  _FullImageState createState() => _FullImageState();
}

class _FullImageState extends State<FullImage> {
  Color _themeColor=Colors.greenAccent[700];
  @override
  Widget build(BuildContext context) {
    void _onLoading(bool t, String str) {
      if (t) {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return SimpleDialog(
                children: <Widget>[
                  Center(
                    child: Container(
                        padding: EdgeInsets.all(10.0),
                        child: CircularProgressIndicator()),
                  ),
                ],
              );
            });
      } else {
        Navigator.pop(context);
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: SimpleDialog(
                  children: <Widget>[
                    Center(
                      child: Container(
                        padding: EdgeInsets.all(15.0),
                        child: Column(
                          children: <Widget>[
                            Text(
                              "Image Saved in Gallery",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            
                            SizedBox(height: 20,),
                            MaterialButton(
                              child: Text("OK"),
                              color: _themeColor,
                              textColor: Colors.white,
                              onPressed: () => Navigator.pop(context),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            });
      }
    }
    return Hero(
      tag: widget.imagePath,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: _themeColor,
          actions: [
            IconButton(
              onPressed: () async {
                _onLoading(true, "");

                Uri myUri = Uri.parse(widget.imagePath);
                File originalImageFile = new File.fromUri(myUri);
                Uint8List bytes;
                await originalImageFile.readAsBytes().then((value) {
                  bytes = Uint8List.fromList(value);
                  print('reading of bytes is completed');
                }).catchError((onError) {
                  print('Exception Error while reading audio from path:' +
                      onError.toString());
                });
                final result =
                await ImageGallerySaver.saveImage(Uint8List.fromList(bytes));
                print(result);
                _onLoading(false,
                    "If Image not available in gallery\n\nYou can find all images at");
              },
              icon: Icon(Icons.download_sharp,size:30),
            ),
            IconButton(
              onPressed: (){

                print("Sharing");
                Share.shareFiles([widget.imagePath]);

              },
              icon: Icon(Icons.share_outlined,size: 25,),
            ),
            SizedBox(width: 10,)
          ],
        ),
        body: Center(
          child: Image.file(
            File(widget.imagePath),
          ),
        ),

      ),
    );
  }
}
