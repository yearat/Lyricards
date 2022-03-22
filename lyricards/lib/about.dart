import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:auto_size_text/auto_size_text.dart';
class about extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('About'),
        centerTitle: true,
        backgroundColor: Colors.teal,
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 10),
        child: Column(

          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            AutoSizeText(
              'This application is not used for any kind of professional or business purpose.',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'RobotoSlab',
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
            Padding(padding: EdgeInsets.only(top: 10.0)),
            AutoSizeText(
              'All lyrics are owned by their respected artists.',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'RobotoSlab',
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
            Padding(padding: EdgeInsets.only(top: 10.0)),
            AutoSizeText(
              'Our aim is to showcase beautiful lyrics.',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'RobotoSlab',
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
            Padding(padding: EdgeInsets.only(top: 10.0)),
            AutoSizeText(
              'Developed and Maintained by Lyricards Team.',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'RobotoSlab',
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
            Padding(padding: EdgeInsets.only(top: 10.0)),
            AutoSizeText(
              'For any query and suggestion find us on',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'RobotoSlab',
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
            Padding(padding: EdgeInsets.only(top: 10.0)),
            RichText(
              text: TextSpan(
                  text: 'Facebook',
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'RobotoSlab',
                      fontWeight: FontWeight.w700,
                      color: Colors.blue),
                  recognizer: new TapGestureRecognizer()
                    ..onTap = () { launch('https://facebook.com'); }
              ),
            )
          ],
        ),
      ),
    );
  }
}
