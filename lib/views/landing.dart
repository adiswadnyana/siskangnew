import 'package:flutter/material.dart';
import 'package:SisKa/_routing/routes.dart';
import 'package:SisKa/utils/colors.dart';
import 'package:SisKa/utils/utils.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final logo = Container(
      height: 100.0,
      width: 100.0,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AvailableImages.appLogo,
          fit: BoxFit.cover,
        ),
      ),
    );

    final appName = Column(
      children: const <Widget>[
        Text(
          AppConfig.appName,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 18.0,
          ),
          textAlign: TextAlign.center,
        ),
        Text(
          AppConfig.appTagline,
          style: TextStyle(
            color: Colors.white,
            fontSize: 15.0,
            fontWeight: FontWeight.w500
          ),
          textAlign: TextAlign.center,
        )
      ],
    );

    // final loginBtn = InkWell(
    //   onTap: () => Navigator.pushNamed(context, loginViewRoute),
    //   child: Container(
    //     height: 60.0,
    //     width: MediaQuery.of(context).size.width,
    //     decoration: BoxDecoration(
    //       borderRadius: BorderRadius.circular(7.0),
    //       border: Border.all(color: Colors.white),
    //       color: Colors.white,
    //     ),
    //     child: Center(
    //       child: Text(
    //         'LOGIN',
    //         style: TextStyle(
    //           fontWeight: FontWeight.w600,
    //           fontSize: 20.0,
    //           color: Colors.white,
    //         ),
    //       ),
    //     ),
    //   ),
    // );

      final loginBtn = Container(
      height: 60.0,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7.0),
        border: Border.all(color: Colors.white),
        color: Colors.white,
      ),
      child: ElevatedButton(
        onPressed: () => Navigator.pushNamed(context, loginViewRoute),
        style: ElevatedButton.styleFrom(primary: Colors.white, shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(7.0))),
        child: const Text(
          'MASUK',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 15.0,
            color: Colors.black
          ),
        ),
      ),
    );


    final registerBtn = Container(
      height: 60.0,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7.0),
        border: Border.all(color: Colors.white),
        color: Colors.white,
      ),
      child: ElevatedButton(
        onPressed: () => Navigator.pushNamed(context, registerViewRoute),
        style: ElevatedButton.styleFrom(primary: Colors.white, shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(7.0))),
        child: const Text(
          'DAFTAR',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 15.0,
            color: Colors.black,
          ),
        ),
      ),
    );

    final buttons = Padding(
      padding: EdgeInsets.only(
        top: 80.0,
        bottom: 30.0,
        left: 30.0,
        right: 30.0,
      ),
      child: Column(
        children: <Widget>[loginBtn, 
        SizedBox(height: 20.0), 
        registerBtn,
        SizedBox(height: 20.0),
        Text(
          '',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.white,
            fontSize: 10.0,
          ),
        ),],
      ),
    );

    return Scaffold(
      body: Container(
        child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 70.0),
              decoration: BoxDecoration(gradient: primaryGradient),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: <Widget>[logo, appName, buttons],
              ),
            ),
            Positioned(
              bottom: 0,
              child: Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Container(
                  height: 300.0,
                  width: MediaQuery.of(context).size.width,
                  // decoration: BoxDecoration(
                  //   image: DecorationImage(
                  //     image: AvailableImages.homePage,
                  //     fit: BoxFit.contain,
                  //   ),
                  // ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
