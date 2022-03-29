import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:SisKa/_routing/routes.dart';
import 'package:SisKa/_routing/router.dart' as router;
import 'package:SisKa/theme.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SIsKA-NG',
      debugShowCheckedModeBanner: false,
      builder: BotToastInit(), //1. call BotToastInit
      navigatorObservers: [BotToastNavigatorObserver()],
      theme: buildThemeData(),
      onGenerateRoute: router.generateRoute,
      initialRoute: splashViewRoute,
    );
  }
}
