import 'package:flutter/material.dart';
import 'package:SisKa/models/api/api_service.dart';
import 'package:SisKa/models/profile.dart';
import 'package:splashscreen/splashscreen.dart';

class Splash extends StatefulWidget {
  Splash({Key? key}) : super(key: key);
  _Splash createState() => _Splash();
}

class _Splash extends State<Splash> {
  List<Profile> listProfile = <Profile>[];
  ApiService apiService = new ApiService();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      apiService.getAuth().then((success) async {
        if (success) {
          apiService.getAuthJab().then((jab) async {
            if (jab == '1') {
              Navigator.pushReplacementNamed(
                context,
                'homeAdmin',
                arguments: 0,
              );
            } else if (jab == '0') {
              Navigator.of(context).pushNamedAndRemoveUntil(
                'home',
                (Route<dynamic> route) => false,
                arguments: 0,
              );
            } else {
              Navigator.pushReplacementNamed(
                context,
                'homeDosen',
                arguments: 0,
              );
            }
          });
        } else {
          print('redirect landing');
          setState(() {
            Navigator.pushReplacementNamed(context, '/');
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
