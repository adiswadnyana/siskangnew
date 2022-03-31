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
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      apiService.getAuth().then((success) async {
        if (success) {
          apiService.getAuthJab().then((jab) async {
            if (jab == '1') {
              // setState(() {
              // Navigator.pushNamed(context, profileViewRoute);
              Navigator.pushReplacementNamed(
                context,
                'homeAdmin',
                arguments: 0,
              );
              // });
            } else if (jab == '0') {
              // setState(() {
              // Navigator.pushNamed(context, homeAdminViewRoute,);
              Navigator.pushReplacementNamed(
                context,
                'home',
                arguments: 0,
              );
              //Navigator.pushNamed(context, homeAdminViewRoute,arguments: 0, );
              //});
            } else {
              // setState(() {
              // Navigator.pushNamed(context, homeAdminViewRoute,);
              Navigator.pushReplacementNamed(
                context,
                'homeDosen',
                arguments: 0,
              );
              //Navigator.pushNamed(context, homeAdminViewRoute,arguments: 0, );
              //});

            }
          });
        } else {
          print('redirect landing');
          setState(() {
            //Navigator.pushNamed(context, landingViewRoute);
            Navigator.pushReplacementNamed(context, '/');
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
    // return SplashScreen.timer(
    //   seconds: 1,
    //   title: const Text(
    //     'SiSka',
    //     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
    //   ),
    //   loaderColor: Colors.blue,
    //   loadingText: const Text('Loading...'),
    //   loadingTextPadding: const EdgeInsets.only(top: 5.0),
    //   image: Image.asset(
    //     'assets/images/LogoUndiksha.png',
    //   ),
    //   backgroundColor: Colors.white,
    //   photoSize: 100.0,
    // );
  }
}

// class AfterSplash extends StatelessWidget {

//   Widget build(BuildContext context) {
//     checkIfAuthenticated().then((success) {
//       if (success) {
//         Navigator.pushReplacementNamed(context, '/home');
//       } else {
//         Navigator.pushReplacementNamed(context, '/login');
//       }
//     });

//     return Center(
//       child: CircularProgressIndicator(),
//     );
//   }
