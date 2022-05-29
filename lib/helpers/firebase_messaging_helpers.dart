import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';

class FCM {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final dataCtrl = StreamController<String>.broadcast();
  final titleCtrl = StreamController<String>.broadcast();
  final bodyCtrl = StreamController<String>.broadcast();

  setNotifications() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
        alert: true, badge: true, sound: true, provisional: false);
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("user granted permission");
      foregroundNotification();
      backgroundNotification();
    }

    final token = _firebaseMessaging
        .getToken()
        .then((value) => print("FCM Token : $value"));
  }

  foregroundNotification() {
    FirebaseMessaging.onMessage.listen((event) {
      print("foregroundNotification");
      if (event.data.isEmpty) {
        dataCtrl.sink.add("event.data");
      }

      if (event.notification != null) {
        titleCtrl.sink.add(event.notification!.title!);
        bodyCtrl.sink.add(event.notification!.body!);
      }
    });
  }

  backgroundNotification() {
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      print("backgroundNotification");
      if (event.data.isEmpty) {
        dataCtrl.sink.add("event.data");
      }

      if (event.notification != null) {
        titleCtrl.sink.add(event.notification!.title!);
        bodyCtrl.sink.add(event.notification!.body!);
      }
    });
  }

  terminateNotification() async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      print("terminateNotification");
      if (initialMessage.data.isNotEmpty) {
        dataCtrl.sink.add("initialMessage.data");
      }

      if (initialMessage.notification != null) {
        titleCtrl.sink.add(initialMessage.notification!.title!);
        bodyCtrl.sink.add(initialMessage.notification!.body!);
      }
    }
  }

  @override
  void dispose() {
    dataCtrl.close();
    titleCtrl.close();
    bodyCtrl.close();
  }
}
