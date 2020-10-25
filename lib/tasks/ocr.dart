import 'dart:io';

import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';

class Ocr extends StatefulWidget {
  @override
  _OcrState createState() => _OcrState();
}

class _OcrState extends State<Ocr> {
  File pickedfile;
  var imagefile;
  bool imageloaded = false;
  var text = '';

  getimagefromgallery() async {
    var tempstore = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      pickedfile = File(tempstore.path);
      imageloaded = true;
      text = '';
    });
    readtextfromimage();
  }

  readtextfromimage() async {
    FirebaseVisionImage myimage = FirebaseVisionImage.fromFile(pickedfile);
    TextRecognizer textRecognizer = FirebaseVision.instance.textRecognizer();
    VisionText readtext = await textRecognizer.processImage(myimage);
    for (TextBlock block in readtext.blocks) {
      for (TextLine line in block.lines) {
        for (TextElement word in line.elements) {
          setState(() {
            text = text + ' ' + word.text;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          child: Center(
            child: Icon(Icons.check),
          ),
          onPressed: () {
            readtextfromimage();
          }),
      appBar: AppBar(
        actions: [
          IconButton(
              icon: Icon(Icons.camera_alt), onPressed: getimagefromgallery)
        ],
        title: Text('Image to Text', style: GoogleFonts.mada()),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Center(
            child: Column(
              children: [
                Container(
                  height: 350,
                  child: pickedfile != null
                      ? Image.file(pickedfile)
                      : Container(
                          child: Column(
                            children: [
                              Container(
                                height: 250,
                                child: Lottie.asset('assets/images/ocr.json'),
                              ),
                              RaisedButton(
                                onPressed: getimagefromgallery,
                                color: Theme.of(context).primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Text('Select an Image from Gallery',
                                    style: GoogleFonts.mada(
                                        fontSize: 20.0, color: Colors.white)),
                              )
                            ],
                          ),
                        ),
                ),
                Container(
                  padding: EdgeInsets.all(10.0),
                  //padding: EdgeInsets.only(left:10.0, right: 10.0),
                  child: SingleChildScrollView(
                      child: SelectableText(
                    text,
                    style: GoogleFonts.mada(fontSize: 16.0),
                  )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
