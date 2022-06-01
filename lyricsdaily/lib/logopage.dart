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
import 'main.dart';

// THIS ENTIRE THING IS FOR OPENING LOGO SCREEN
class LogoPage extends StatefulWidget {
  @override
  _LogoPageState createState() => _LogoPageState();
}

class _LogoPageState extends State<LogoPage> {

  //THIS IS FOR SHOWING ARTISTS ON SIDEBAR
  Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
    return ListTile(
        title:
        Container(
          decoration: const BoxDecoration(
            color: Colors.teal,
          ),
          padding: const EdgeInsets.all(4.0),
          child: Text(
            document['name'],
          ),
        )

    );
  }

  @override
  void initState() {
    super.initState();
    // here is the logic
    Future.delayed(Duration(seconds: 1)).then((__) {
      Navigator.push(context, MaterialPageRoute(builder: (_) =>Scaffold(
        drawer: Drawer(
          child: Container(
            color: Colors.white,
            child: ListView(
              children: <Widget>[

                UserAccountsDrawerHeader(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: ExactAssetImage('images/drawerbackground.png')
                      )
                  ),
                ),
                ListTile(
                    title: new Text("About",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'RobotoSlab',
                            color: Colors.black54)),
                    trailing: new Icon(Icons.help),
                    onTap: () {
                      // Navigator.of(context).pop();
                      Navigator.push(context,
                          PageTransition(
                              type: PageTransitionType.fade,
                              child: about()));

                    }
                ),


                //GRABS ARTISTS FOR SIDEBAR


              ],
            ),
          ),
        ),
        body: FirestoreSlideshow(),
        backgroundColor: Colors.white,
      )));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child:
      Center(
          child: Image.asset(
            'images/logoGreen.png',
            height: 150.0 ,
            width: 150.0,
          )),
    ); // this widget stays here for 1 seconds, you can show your app logo here
  }
}