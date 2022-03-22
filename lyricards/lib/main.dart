import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:clipboard_manager/clipboard_manager.dart';
import 'package:flushbar/flushbar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:page_transition/page_transition.dart';
import 'dart:io';
import 'about.dart';
import 'logopage.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LogoPage());
  }
}

class FirestoreSlideshow extends StatefulWidget {
  createState() => FirestoreSlideshowState();
}

class FirestoreSlideshowState extends State<FirestoreSlideshow> {
  final PageController ctrl = PageController(viewportFraction: 0.9);

  final Firestore db = Firestore.instance;
  Stream slides;

  String activeTag = 'all';


  // Keep track of current page to avoid unnecessary renders
  int currentPage = 0;

  final FirebaseMessaging _fcm = FirebaseMessaging();

  @override
  void initState() {

    _fcm.subscribeToTopic('allusers');

    _queryDb();

    // Set state when page changes
    ctrl.addListener(() {
      int next = ctrl.page.round();

      if (currentPage != next) {
        setState(() {
          currentPage = next;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: slides,
        initialData: [],
        builder: (context, AsyncSnapshot snap) {
          List slideList = snap.data.toList();

          return PageView.builder(
              controller: ctrl,
              itemCount: slideList.length + 1,
              itemBuilder: (context, int currentIdx) {
                if (currentIdx == 0) {
                  return _buildTagPage();
                } else if (slideList.length >= currentIdx) {
                  // Active page
                  bool active = currentIdx == currentPage;
                  return WillPopScope(
                      onWillPop: (){
                        ctrl.jumpToPage(0);
                      },
                      child:_buildStoryPage(slideList[currentIdx - 1], active));
                }
              });
        });
  }



  Stream _queryDb({String tag = 'abstract'}) {
    // Make a Query
    Query query = db
        .collection('lyrics')
        .where('tags', arrayContains: tag)
        .orderBy('index', descending: true);

    // Map the documents to the data payload
    slides =
        query.snapshots().map((list) => list.documents.map((doc) => doc.data));

    // Update the active tag
    setState(() {
      activeTag = tag;
    });
  }

  _buildStoryPage(Map data, bool active) {
    // Animated Properties
    final double blur = active ? 30 : 0;
    final double offset = active ? 15 : 0;
    final double top = active ? 120 : 200;

    return AnimatedContainer(
        duration: Duration(milliseconds: 1000),
        curve: Curves.easeInOutQuint,
        margin: EdgeInsets.only(top: top, bottom: 50, right: 15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),

            //STATIC CARD COLOR
            //color: Colors.blueGrey[700],

            //GRADIENT CARD COLOR
            gradient: LinearGradient(
              // Where the linear gradient begins and ends
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              // Add one stop for each color. Stops should increase from 0 to 1
              stops: [0.2, 0.4, 0.6, 0.9],

              colors: [
                // Colors are easy thanks to Flutter's Colors class.
                Colors.teal[400],
                Colors.teal,
                Colors.teal[600],
                Colors.teal[700],
              ],
            ),

            //LOADING IMAGE AS CARDS
            //image: DecorationImage(
            //fit: BoxFit.cover,
            //image: NetworkImage(data['img']),
            //),
            boxShadow: [
              BoxShadow(
                  color: Colors.black26,
                  blurRadius: blur,
                  offset: Offset(offset, offset))
            ]),
        child: Container(
          padding: EdgeInsets.only(left: 22, right: 22, top: 100),
          margin: EdgeInsets.only(bottom: 30),
          child: Center(
            child: Column(
              children: <Widget>[
                Expanded(
                    child: Container(
                        child: GestureDetector(
                          child: Column(
                            children: <Widget>[
                              AutoSizeText(
                                data['lines'][0],
                                style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'RobotoSlab',
                                    color: Colors.yellow[100]),
                                maxLines: 1,
                                minFontSize: 10,
                              ),
                              AutoSizeText(
                                data['lines'][1],
                                style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'RobotoSlab',
                                    color: Colors.yellow[100]),
                                maxLines: 1,
                                minFontSize: 10,
                              ),
                              AutoSizeText(
                                data['lines'][2],
                                style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'RobotoSlab',
                                    color: Colors.yellow[100]),
                                maxLines: 1,
                                minFontSize: 10,
                              ),
                              AutoSizeText(
                                data['lines'][3],
                                style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'RobotoSlab',
                                    color: Colors.yellow[100]),
                                maxLines: 1,
                                minFontSize: 10,
                              ),
                              AutoSizeText(
                                data['lines'][4],
                                style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'RobotoSlab',
                                    color: Colors.yellow[100]),
                                maxLines: 1,
                                minFontSize: 10,
                              ),
                              AutoSizeText(
                                data['lines'][5],
                                style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'RobotoSlab',
                                    color: Colors.yellow[100]),
                                maxLines: 1,
                                minFontSize: 10,
                              ),
                              AutoSizeText(
                                data['lines'][6],
                                style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'RobotoSlab',
                                    color: Colors.yellow[100]),
                                maxLines: 1,
                                minFontSize: 10,
                              ),
                              AutoSizeText(
                                data['lines'][7],
                                style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'RobotoSlab',
                                    color: Colors.yellow[100]),
                                maxLines: 1,
                                minFontSize: 10,
                              ),
                            ],
                          ),

                          // THIS PART COPIES THE LYRICS INTO THE CLIPBOARD
                          onLongPress: (){

                            ClipboardManager.copyToClipBoard(
                                data['lines'][0] + ' ' + data['lines'][1] + ' ' +
                                    data['lines'][2] + ' ' + data['lines'][3] + ' ' +
                                    data['lines'][4] + ' ' + data['lines'][5] + ' ' +
                                    data['lines'][6] + ' ' + data['lines'][7]
                            ).then((result) {
                              showFloatingFlushbar(context);
                            });
                          },
                        ))),
                //Container(
                //margin: EdgeInsets.all(10.0),
                //),


                AutoSizeText(
                  data['song'],
                  style: TextStyle(
                      fontSize: 25,
                      fontFamily: 'RobotoSlab',
                      fontWeight: FontWeight.w500,
                      color: Colors.red[50]),
                  maxLines: 1,
                ),
                AutoSizeText(
                  data['artist'],
                  style: TextStyle(
                      fontSize: 17,
                      fontFamily: 'RobotoSlab',
                      fontWeight: FontWeight.w400,
                      color: Colors.red[50]),
                  maxLines: 1,
                ),
              ],
            ),
          ),
        ));
  }

  _buildTagPage() {
    return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: ExactAssetImage('images/backgroundgreen.png'),
            fit: BoxFit.scaleDown,
            alignment: Alignment(-1.0, 1.0),
          ),
        ),
        child:
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Lyricards',
              style: TextStyle(
                  fontSize: 50,
                  fontFamily: 'RobotoSlab',
                  fontWeight: FontWeight.bold),
            ),
            Text('SELECT & SWIPE',
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'RobotoSlab',
                    color: Colors.black26)),

            _buildButton('abstract'),
            _buildButton('happy'),
            _buildButton('sad'),
            _buildButton('love'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      exit(0);
                    }),

              ],),

          ],
        ));
  }

  _buildButton(tag) {
    Color color = tag == activeTag ? Colors.tealAccent[400] : Colors.teal[50];
    return FlatButton(
        color: color,
        child: Text('$tag',
          style: TextStyle(
            fontFamily: 'RobotoSlab',
            fontWeight: FontWeight.w500,
          ),
        ),
        onPressed: () => _queryDb(tag: tag));
  }


}




// THIS SHOWS BEAUTIFUL COPIED TO CLIPBOARD FLUSHBAR
void showFloatingFlushbar(BuildContext context) {
  Flushbar(
    title: 'Voila!',
    message: 'Copied To Clipboard',
    backgroundColor: Colors.tealAccent[700],

    icon: Icon(
      Icons.content_copy,
      size: 28,
      color: Colors.teal[900],
    ),
    leftBarIndicatorColor: Colors.tealAccent,
    duration: Duration(seconds: 3),
  )..show(context);
}

