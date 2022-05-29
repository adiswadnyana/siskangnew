import 'package:SisKa/notificationservice/local_notification_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:SisKa/app.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  print(message.data.toString());
  print(message.notification!.title);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: "AIzaSyA0v-tY6Mx9wTzt2eQlIvV9CC76D_MLZ64",
        appId: "1:831061067882:android:ae1ac084ed3c252869e213",
        messagingSenderId: "831061067882",
        projectId: "siskanew-95c55"),
  );
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  LocalNotificationService.initialize();
  runApp(App());
}
