import 'package:flutter/material.dart';
import 'package:SisKa/_routing/routes.dart';
import 'package:SisKa/utils/colors.dart';
import 'package:SisKa/models/api/api_service.dart';
import 'package:SisKa/models/profile.dart';
import 'package:SisKa/models/globalModel.dart';
import 'package:line_icons/line_icons.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Response {
  final String? status;
  final String? message;

  Response({this.status, this.message});

  factory Response.fromJson(Map<String, dynamic> json) {
    return Response(
      status: json['status'],
      message: json['message'],
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  ApiService _apiService = ApiService();
  final _username = TextEditingController();
  final _password = TextEditingController();
  String _response = '';
  bool _saving = false;

  Profile? profile;

  void initState() {
    super.initState();
  }

  // fungsi untuk kirim http post
  Future<Response> post(url, var body) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return http.post(url, body: body).then((http.Response response) {
      if (response.body == null) {
        throw new Exception("Error while fetching data");
      }

      Map<String, dynamic> user = jsonDecode(response.body);
      prefs.setString('KodeUser', '${user['Kode_userKin']}');
      prefs.setString('NamaUser', '${user['Nama_userKin']}');
      final nama1 = '${user['NamaUser']}';
      print(nama1);
      final nama = prefs.getString('NamaUser');
      print(nama);
      return Response.fromJson(json.decode(response.body));
    });
  }

  void _callPostAPIng() {
    setState(() {
      _saving = true;
    });
    _apiService
        .login({'username': _username.text, 'password': _password.text}).then(
            (isSuccess) {
      if (isSuccess) {
        setState(() {
          _saving = false;
          Navigator.pushNamed(context, splashViewRoute);
        });
      } else {
        setState(() {
          _saving = false;
        });

        showFlushbar("Perhatian", "Username atau paswword salah",
            LineIcons.skullCrossbones, Colors.orange, context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Change Status Bar Color
    final pageTitle = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Login",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 45.0,
          ),
        ),
        Text(
          "Silahkan Masukkan Username dan Password!",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
            fontWeight: FontWeight.w500,
          ),
        )
      ],
    );

    final emailField = TextFormField(
      controller: _username,
      decoration: InputDecoration(
        labelText: 'Username',
        labelStyle: TextStyle(color: Colors.white),
        prefixIcon: Icon(
          LineIcons.user,
          color: Colors.white,
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(color: Colors.white),
      cursorColor: Colors.white,
    );

    final passwordField = TextFormField(
      controller: _password,
      decoration: InputDecoration(
        labelText: 'Password',
        labelStyle: TextStyle(color: Colors.white),
        prefixIcon: Icon(
          LineIcons.lock,
          color: Colors.white,
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
      keyboardType: TextInputType.text,
      style: TextStyle(color: Colors.white),
      cursorColor: Colors.white,
      obscureText: true,
    );

    final loginForm = Padding(
      padding: EdgeInsets.only(top: 30.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[emailField, passwordField],
        ),
      ),
    );

    final loginBtn = Container(
      margin: EdgeInsets.only(top: 40.0),
      height: 60.0,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7.0),
        border: Border.all(color: Colors.white),
        color: Colors.white,
      ),
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () {
          _callPostAPIng();
        },
        color: Colors.white,
        shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(7.0),
        ),
        child: Text(
          'LOGIN',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 20.0,
          ),
        ),
      ),
    );

    return Scaffold(
      body: ModalProgressHUD(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(top: 50.0, left: 30.0, right: 30.0),
              decoration: BoxDecoration(gradient: primaryGradient),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[pageTitle, loginForm, loginBtn],
              ),
            ),
          ),
          inAsyncCall: _saving),
    );
  }
}
