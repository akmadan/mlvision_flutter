import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lifeai/tasks/ocr.dart';
import 'package:lifeai/tasks/speechtotext.dart';
import 'package:lifeai/tasks/texttospeech.dart';
import 'package:lottie/lottie.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> heading = ['Image to Text', 'Speech to Text', 'Text to Speech'];
  List<String> images = [
    'assets/images/font.png',
    'assets/images/mic.png',
    'assets/images/speaking.png'
  ];
  List<Widget> locations = [Ocr(), SpeechScreen(), TexttoSpeech()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'LifeAI',
          style: GoogleFonts.mada(),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Container(
              height: 300,
              child: Lottie.asset('assets/images/home1.json'),
            ),
            Expanded(
              child: GridView.builder(
                //reverse: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemCount: heading.length,
                itemBuilder: (context, index) {
                  return Container(
                    height: 200,
                    padding: EdgeInsets.only(
                        left: 10, top: 10, right: 10.0, bottom: 10.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      elevation: 10.0,
                      child: InkWell(
                        splashColor: Colors.grey,
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => locations[index]));
                        },
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 60,
                                child: Image.asset(images[index]),
                              ),
                              Padding(padding: EdgeInsets.only(top: 20.0)),
                              Container(
                                child: Text(
                                  heading[index],
                                  style: GoogleFonts.mada(
                                    fontSize: 16.0,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
