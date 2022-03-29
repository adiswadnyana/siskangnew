import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


String  formatTanggal(String tgl) {
  var tglOri = tgl.split('-');
  var tanggal = tglOri[2];
  var bulan = tglOri[1];
  var tahun = tglOri[0];
String tglGabung = tanggal+'-'+bulan+'-'+tahun;
return tglGabung;
  
}

  void showFlushbar(String title, String message, IconData icon, Color color, BuildContext context ) {
    Flushbar(
      title: title,
      message: message,
      icon: Icon(
        icon,
        size: 28,
        color: color,
      ),
     leftBarIndicatorColor: color,
      duration: Duration(seconds: 3),
    )..show(context);
  }

  

 