// ignore_for_file: unnecessary_new

import 'package:flutter/material.dart';
import 'package:SisKa/_routing/routes.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_icons/line_icons.dart';
import 'package:SisKa/models/api/api_service.dart';
import 'package:SisKa/models/prodi.dart';
import 'dart:async';
import 'dart:io';
import 'package:another_flushbar/flushbar.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:flutter/cupertino.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  File? _image;
  final _formKey = GlobalKey<FormState>();
  Prodi? selectedProdi;
  bool _isButtonDisabled = false;
  final _angkatan = TextEditingController();
  final _nama = TextEditingController();
  final _email = TextEditingController();
  final _nim = TextEditingController();
  final _password = TextEditingController();
  final _passwordConf = TextEditingController();
  bool _saving = false;

  List<Prodi> listProdi = <Prodi>[];
  ApiService apiService = new ApiService();

  void initState() {
    super.initState();
    fetchProdi();
  }

  void fetchProdi() async {
    listProdi = (await apiService.getProdi())!;
    if (listProdi != null) {
      setState(() {});
    }
  }

  void showFlushbar(String title, String message, IconData icon, Color color,
      BuildContext context) {
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

  //  void _callPostAPIng() {
  //    _saving= true;
  //    // showInfoFlushbarAktif();
  //       apiService.register(_image, {
  //         'id_prodi':selectedProdi.kode,
  //         'angkatan': _angkatan.text,
  //         'nama': _nama.text,
  //         'email': _email.text,
  //         'nim': _nim.text,
  //         'password': _password.text,
  //         'foto':_image.path,
  //       }).then((isSuccess) {
  //         setState(()  {
  //              if (isSuccess=='1') {
  //                showInfoFlushbarBerhasil();
  //               } else if (isSuccess=='0') {
  //                 showInfoFlushbarSudahDaftar();
  //               }else{
  //                 showInfoFlushbarAktif();
  //               }
  //               _saving= false;
  //           });

  //       });
  //     }

  bool validateStructure(String value) {
    String pattern = r'^(?=.*?[a-z])(?=.*?[0-9])';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }

  bool validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern as String);
    if (!regex.hasMatch(value))
      return false;
    else
      return true;
  }

  void simpan(BuildContext context) async {
    String image;
    if (_image != null) {
      image = _image!.path;
    } else {
      image = 'user.png';
    }
    bool passwordalpha = validateStructure(_password.text);
    bool validEmail = validateEmail(_email.text);
    print(validEmail);
    if (passwordalpha == false || _password.text.length < 6) {
      showFlushbar(
          "Perhatian",
          "Password minimal 6 karakter, harus ada huruf dan angka",
          LineIcons.exclamationCircle,
          Colors.orange,
          context);
    } else if (_password.text == "") {
      showFlushbar("Perhatian", "Password masih kosong",
          LineIcons.exclamationCircle, Colors.orange, context);
    } else if (validEmail == false) {
      showFlushbar("Perhatian", "Email tidak valid",
          LineIcons.exclamationCircle, Colors.orange, context);
    } else {
      if (_password.text != _passwordConf.text) {
        showFlushbar("Perhatian", "Konfirmasi password tidak cocok",
            LineIcons.exclamationCircle, Colors.orange, context);
      } else {
        showDialog(
            context: context,
            builder: (context) {
              return CupertinoAlertDialog(
                title: Text("Konfirmasi"),
                content: Text("Yakin menyimpan data?"),
                actions: <Widget>[
                  CupertinoDialogAction(
                      isDefaultAction: true,
                      child: Text("Ya"),
                      onPressed: () {
                        //ini
                        Navigator.pop(context);
                        _saving = true;
                        apiService.register(_image!, {
                          'id_prodi': selectedProdi!.kode,
                          'angkatan': _angkatan.text,
                          'nama': _nama.text,
                          'email': _email.text,
                          'nim': _nim.text,
                          'password': _password.text,
                          'foto': _image!.path,
                        }).then((isSuccess) {
                          setState(() {
                            if (isSuccess == '1') {
                              showInfoFlushbarBerhasil();
                            } else if (isSuccess == '0') {
                              showInfoFlushbarSudahDaftar();
                            } else {
                              showInfoFlushbarAktif();
                            }
                            _saving = false;
                          });
                        });
                      }),
                  CupertinoDialogAction(
                    child: Text("Batal"),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              );
            });
      }
    }
  }

  Future getImage() async {
    final picker = ImagePicker();
    final image = await picker.getImage(
      source: ImageSource.gallery,
      imageQuality: 60,
    );
    setState(() {
      _image = File(image!.path);
    });
  }

  void showInfoFlushbarBerhasil() {
    Flushbar(
      title: 'Registrasi Berhasil',
      message: 'Akun Anda Akan Aktif Setelah Disetujui',
      icon: Icon(
        Icons.info_outline,
        size: 28,
        color: Colors.blue.shade300,
      ),
      mainButton: FlatButton(
        onPressed: () {
          Navigator.pushNamed(context, landingViewRoute);
        },
        child: Text(
          "Menu Utama",
          style: TextStyle(color: Colors.blue.shade300),
        ),
      ),
      leftBarIndicatorColor: Colors.blue.shade300,
      duration: Duration(seconds: 3),
    )..show(context);
  }

  void showInfoFlushbarSudahDaftar() {
    Flushbar(
      title: 'NIM Anda Sudah Terdaftar',
      message: 'Mohon Menunggu Persetujuan',
      icon: Icon(
        Icons.warning,
        size: 28,
        color: Colors.yellowAccent,
      ),
      mainButton: FlatButton(
        onPressed: () {
          Navigator.pushNamed(context, landingViewRoute);
        },
        child: Text(
          "Menu Utama",
          style: TextStyle(color: Colors.yellowAccent),
        ),
      ),
      leftBarIndicatorColor: Colors.yellowAccent,
      duration: Duration(seconds: 3),
    )..show(context);
  }

  void showInfoFlushbarAktif() {
    Flushbar(
      title: 'Akun Anda Sudah Aktif',
      message: 'Silahkan Menuju Halaman Login',
      icon: Icon(
        Icons.check_circle,
        size: 28,
        color: Colors.greenAccent,
      ),
      mainButton: FlatButton(
        onPressed: () {
          Navigator.pushNamed(context, loginViewRoute);
        },
        child: Text(
          "Login",
          style: TextStyle(color: Colors.greenAccent),
        ),
      ),
      leftBarIndicatorColor: Colors.greenAccent,
      duration: Duration(seconds: 3),
    )..show(context);
  }

  @override
  Widget build(BuildContext context) {
    final appBar = Padding(
      padding: EdgeInsets.only(bottom: 40.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          )
        ],
      ),
    );

    final dopdownProfile = Container(
      width: MediaQuery.of(context).size.width,
      child: DropdownButton<Prodi>(
        hint: Text(
          'Pilih Prodi',
          style: TextStyle(
            color: (Colors.blue[300])!,
          ),
        ),
        underline: Container(
          height: 1.0,
          decoration: const BoxDecoration(
              border:
                  Border(bottom: BorderSide(color: Colors.blue, width: 0.0))),
        ),
        isExpanded: true,
        value: selectedProdi,
        onChanged: (Prodi? newValue) {
          setState(() {
            selectedProdi = newValue;
          });
        },
        items: listProdi.map((Prodi prodi) {
          return new DropdownMenuItem<Prodi>(
            value: prodi,
            child: new Text(
              prodi.nama!,
              // ignore: prefer_const_constructors
              style: new TextStyle(color: Colors.black),
            ),
          );
        }).toList(),
      ),
    );
    final passwordField = TextFormField(
      controller: _password,
      decoration: InputDecoration(
        labelText: 'Password',
        labelStyle: TextStyle(color: (Colors.blue[300])!),
        prefixIcon: Icon(
          LineIcons.lock,
          color: (Colors.blue[300])!,
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: ((Colors.blue[300])!)),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: ((Colors.blue[300])!)),
        ),
      ),
      keyboardType: TextInputType.text,
      style: TextStyle(color: Colors.black),
      cursorColor: Colors.black,
      obscureText: true,
    );

    final angkatanField = TextFormField(
      controller: _angkatan,
      decoration: InputDecoration(
        labelText: 'Angkatan',
        labelStyle: TextStyle(color: (Colors.blue[300])!),
        prefixIcon: Icon(
          LineIcons.home,
          color: (Colors.blue[300])!,
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: (Colors.blue[300])!),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: (Colors.blue[300])!),
        ),
      ),
      keyboardType: TextInputType.text,
      style: TextStyle(color: Colors.black),
      cursorColor: Colors.black,
    );

    final namaField = TextFormField(
      controller: _nama,
      decoration: InputDecoration(
        labelText: 'Nama Lengkap',
        labelStyle: TextStyle(color: (Colors.blue[300])!),
        prefixIcon: Icon(
          LineIcons.user,
          color: (Colors.blue[300])!,
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: (Colors.blue[300])!),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: (Colors.blue[300])!),
        ),
      ),
      keyboardType: TextInputType.text,
      style: TextStyle(color: Colors.black),
      cursorColor: Colors.black,
    );

    final emailField = TextFormField(
      controller: _email,
      decoration: InputDecoration(
        labelText: 'Email',
        labelStyle: TextStyle(color: (Colors.blue[300])!),
        prefixIcon: Icon(
          LineIcons.at,
          color: (Colors.blue[300])!,
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: (Colors.blue[300])!),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: (Colors.blue[300])!),
        ),
      ),
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(color: Colors.black),
      cursorColor: Colors.black,
    );

    final nimField = TextFormField(
      controller: _nim,
      decoration: InputDecoration(
        labelText: 'NIM',
        labelStyle: TextStyle(color: (Colors.blue[300])!),
        prefixIcon: Icon(
          LineIcons.list,
          color: (Colors.blue[300])!,
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: (Colors.blue[300])!),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: (Colors.blue[300])!),
        ),
      ),
      keyboardType: TextInputType.text,
      style: TextStyle(color: Colors.black),
      cursorColor: Colors.black,
    );

    final passwordConfField = TextFormField(
      controller: _passwordConf,
      decoration: InputDecoration(
        labelText: 'Konfirmasi password',
        labelStyle: TextStyle(color: (Colors.blue[300])!),
        prefixIcon: Icon(
          Icons.lock,
          color: (Colors.blue[300])!,
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: (Colors.blue[300])!),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: (Colors.blue[300])!),
        ),
      ),
      keyboardType: TextInputType.text,
      style: TextStyle(color: Colors.black),
      cursorColor: Colors.black,
      obscureText: true,
    );

    final formFieldSpacing = SizedBox(
      height: 15.0,
    );

    final foto = FloatingActionButton(
      onPressed: getImage,
      tooltip: 'Pilih Foto',
      child: Icon(Icons.add_a_photo),
    );

    final fotoadd = Container(
      height: 200.0,
      width: 200.0,
      child: Center(
        child: _image == null
            ? Text('Tidak Ada Foto Dipilih.')
            : Image.file(_image!),
      ),
    );

    final registerForm = Padding(
      padding: EdgeInsets.only(top: 30.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            dopdownProfile,
            formFieldSpacing,
            angkatanField,
            formFieldSpacing,
            namaField,
            formFieldSpacing,
            emailField,
            formFieldSpacing,
            nimField,
            formFieldSpacing,
            passwordField,
            formFieldSpacing,
            passwordConfField,
            formFieldSpacing,
            _image == null ? Text('Tidak Ada Foto Dipilih.') : fotoadd,
            formFieldSpacing,
            foto
          ],
        ),
      ),
    );

    final submitBtn = Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: Container(
        margin: EdgeInsets.only(top: 10.0, bottom: 20.0),
        height: 60.0,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7.0),
          border: Border.all(color: Colors.white),
        ),
        child: Material(
          borderRadius: BorderRadius.circular(7.0),
          color: Colors.lightBlue,
          elevation: 10.0,
          shadowColor: Colors.white70,
          child: MaterialButton(
            onPressed: () {
              simpan(context);
            },
            child: Text(
              'DAFTAR',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 20.0,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("Registrasi"),
      ),
      body: ModalProgressHUD(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(top: 10.0),
              child: Column(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(left: 30.0, right: 30.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[registerForm, submitBtn],
                    ),
                  )
                ],
              ),
            ),
          ),
          inAsyncCall: _saving),
    );
  }
}
