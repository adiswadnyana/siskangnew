// ignore_for_file: unnecessary_new

import 'package:SisKa/_routing/routes.dart';
import 'package:SisKa/models/api/api_service.dart';
import 'package:SisKa/models/Notif.dart';
import 'package:SisKa/notificationservice/local_notification_service.dart';
import 'package:SisKa/views/demo.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:SisKa/utils/utils.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';

class NotifPenerimaScreen extends StatefulWidget {
  @override
  NotifPenerimaScreen({Key? key}) : super(key: key);
  _NotifPenerimaScreenState createState() => _NotifPenerimaScreenState();
}

class PushNotification {
  PushNotification({
    this.title,
    this.body,
  });
  String? title;
  String? body;
}

class _NotifPenerimaScreenState extends State<NotifPenerimaScreen> {
  late BuildContext ctx;
  ApiService apiService = new ApiService();
  TextEditingController _textcari = new TextEditingController();
  bool activeSearch = false;
  String deviceTokenToSendPushNotification = "";
  List notifications = [];

  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  void initState() {
    super.initState();

    // 1. This method call when app in terminated state and you get a notification
    // when you click on notification app open from terminated state and you can get notification data in this method

    FirebaseMessaging.instance.getInitialMessage().then(
      (message) {
        print("FirebaseMessaging.instance.getInitialMessage");
        if (message != null) {
          print("New Notification");
          if (message.data['_id'] != null) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => Demo(
                  id: message.data['_id'],
                ),
              ),
            );
          }
        }
      },
    );

    // 2. This method only call when App in forground it mean app must be opened
    FirebaseMessaging.onMessage.listen(
      (message) {
        if (message.notification != null) {
          setState(() {
            notifications.add(message.notification);
          });
          LocalNotificationService.createanddisplaynotification(message);
        }
      },
    );

    // 3. This method only call when App in background and not terminated(not closed)
    FirebaseMessaging.onMessageOpenedApp.listen(
      (message) {
        // print("FirebaseMessaging.onMessageOpenedApp.listen");
        // if (message.notification != null) {
        //   print(message.notification!.title);
        //   print(message.notification!.body);
        //   print("message.data22 ${message.data['_id']}");
        // }
      },
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            elevation: 1.0,
            child: ListTile(
              leading: Icon(
                Icons.notifications,
                color: Colors.purple[300],
                size: 35.0,
              ),
              title: Text(
                notifications[index].title.toString(),
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14.0,
                  color: Color(0xFF212121),
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(notifications[index].body.toString(),
                  overflow: TextOverflow.clip,
                  style: TextStyle(color: Colors.grey, fontSize: 15.0)),
            ),
          );

          // Padding(
          //     padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
          //     child: new Card(
          //       elevation: 1.0,
          //       child: Column(
          //         children: [
          //           Text(notifications[index].title.toString()),
          //           Text(notifications[index].body.toString()),
          //         ],
          //       ),
          //     ));
        },
      ),
    );
  }

  Widget _jenisPesan(Notif notif) {
    if (notif.jenisPesan == '0') {
      return Icon(
        LineIcons.envelopeOpen,
        color: Colors.blue,
        size: 40,
      );
    } else {
      return Icon(
        LineIcons.envelopeOpen,
        color: Colors.red,
        size: 40,
      );
    }
  }

  PreferredSizeWidget _appBar() {
    if (activeSearch) {
      return AppBar(
        leading: Icon(Icons.search),
        title: TextFormField(
          controller: _textcari,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            contentPadding:
                const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(20.7),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(20.7),
            ),
          ),
        ),
      );
    } else {
      return AppBar(
        title: Text("Notifikasi"),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () => setState(() => activeSearch = true),
          ),
        ],
      );
    }
  }
}
