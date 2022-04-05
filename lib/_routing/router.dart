import 'package:SisKa/views/tabs/profile2.dart';
import 'package:SisKa/views/jadwal.dart';
import 'package:flutter/material.dart';
import 'package:SisKa/_routing/routes.dart';
import 'package:SisKa/views/home.dart';
import 'package:SisKa/views/homeAdmin.dart';
import 'package:SisKa/views/homeDosen.dart';
import 'package:SisKa/views/landing.dart';
import 'package:SisKa/views/login.dart';
import 'package:SisKa/views/notifSend.dart';
import 'package:SisKa/views/register.dart';
import 'package:SisKa/views/reset_password.dart';
import 'package:SisKa/views/timeline.dart';
import 'package:SisKa/views/dashboard.dart';
import 'package:SisKa/views/newsdetail.dart';
import 'package:SisKa/views/notifDetil.dart';
import 'package:SisKa/views/notifPenerima.dart';
import 'package:SisKa/views/settingProfile.dart';
import 'package:SisKa/views/masastudi.dart';
import 'package:SisKa/views/pdf.dart';
import 'package:SisKa/views/userAllSa.dart';

import '../views/splash.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case landingViewRoute:
      return MaterialPageRoute(builder: (context) => LandingPage());
    case homeViewRoute:
      return MaterialPageRoute(
          builder: (context) => HomePage(index: settings.arguments as int));
    case homeAdminViewRoute:
      return MaterialPageRoute(
          builder: (context) =>
              HomeAdminPage(index: settings.arguments as int));
    case homeDosenViewRoute:
      return MaterialPageRoute(
          builder: (context) =>
              HomePageDosen(index: settings.arguments as int));
    case splashViewRoute:
      return MaterialPageRoute(builder: (context) => Splash());
    case profileViewRoute:
      return MaterialPageRoute(builder: (context) => Profile2());
    case loginViewRoute:
      return MaterialPageRoute(builder: (context) => LoginPage());
    case registerViewRoute:
      return MaterialPageRoute(builder: (context) => RegisterPage());
    case jadwalViewRoute:
      return MaterialPageRoute(builder: (context) => JadwalScreen());
    case notifSendViewRoute:
      return MaterialPageRoute(builder: (context) => NotifSendScreen());
    case notifPenerimaViewRoute:
      return MaterialPageRoute(builder: (context) => NotifPenerimaScreen());
    case resetPasswordViewRoute:
      return MaterialPageRoute(builder: (context) => ResetPasswordPage());
    case dashboardViewRoute:
      return MaterialPageRoute(builder: (context) => DashboardScreen());
    case settingProfile:
      return MaterialPageRoute(builder: (context) => SettingProfile());
    case masastudiViewRoute:
      return MaterialPageRoute(builder: (context) => MasastudiScreen());
    case userAllViewRoute:
      return MaterialPageRoute(builder: (context) => UserAllSaScreen());
    case pdfViewRoute:
      return MaterialPageRoute(
          builder: (context) => MyApp(url: settings.arguments as String));
    case timelineViewRoute:
      return MaterialPageRoute(
          builder: (context) =>
              TimelinePage(nim: settings.arguments as String));
    case newsDetailsViewRoute:
      return MaterialPageRoute(
          builder: (context) =>
              NewsDetailPage(userId: settings.arguments as String));
    case notifDetailsViewRoute:
      return MaterialPageRoute(
          builder: (context) =>
              AktivitasDetilScreen(idNt: settings.arguments as String));
    default:
      return MaterialPageRoute(builder: (context) => LandingPage());
  }
}
