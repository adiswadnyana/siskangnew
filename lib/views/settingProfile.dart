import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_icons/line_icons.dart';
import 'package:SisKa/models/api/api_service.dart';
import 'package:SisKa/models/prodi.dart';
import 'dart:async';
import 'dart:io';
import 'package:another_flushbar/flushbar.dart';
import 'package:SisKa/models/profile.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';

class SettingProfile extends StatefulWidget {
  @override
  _SettingProfileState createState() => _SettingProfileState();
}

class _SettingProfileState extends State<SettingProfile> {
  File? _image;
  final _formKey = GlobalKey<FormState>();
  Prodi? selectedProdi;
  // bool _isButtonDisabled = false;
  //  final _angkatan = TextEditingController();
  final _nama = TextEditingController();
  // final _email = TextEditingController();
  final _nim = TextEditingController();
  final _noTelp = TextEditingController();
  final _password = TextEditingController();
  final _passwordLama = TextEditingController();
  final _passwordbaru = TextEditingController();
  final _passwordConf = TextEditingController();
  String _foto = '';
  bool _saving = false;

  List<Prodi> listProdi = <Prodi>[];
  ApiService apiService = new ApiService();
  List<Profile> listProfile = <Profile>[];

  void initState() {
    super.initState();
    BackButtonInterceptor.add(myInterceptor);
    fetchProdi();
    fetchProfile();
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo routeInfo) {
    return true;
  }

  void fetchProfile() async {
    listProfile = (await apiService.getProfiles())!;
    if (listProfile != null) {
      setState(() {
        _passwordLama.text = listProfile[0].password!;
        _nama.text = listProfile[0].nimNama!;
        _foto = listProfile[0].foto!;
        _nim.text = listProfile[0].nim!;
        _noTelp.text = listProfile[0].noTelp!;
      });
    }
  }

  void fetchProdi() async {
    listProdi = (await apiService.getProdi())!;
    print(listProdi);
    if (listProdi != null) {
      setState(() {});
    }
  }

  void logout(BuildContext context) async {
    apiService.logOut().then((isSuccess) {
      setState(() {
        Navigator.pushReplacementNamed(context, 'splash');
      });
    });
  }

  bool validateStructure(String value) {
    // String  pattern = r'^(?=.*?[a-z])(?=.*?[0-9])';
    String pattern = r'^(?=.*?[a-zA-Z])(?=.*?[0-9])';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }

  bool validateStructure2(String value) {
    // String pattern = r'^[0-9]*$';
    String pattern = r'^(?=.*?[0-9])';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }

  void simpan(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final passwordlama = prefs.getString('PasswordPlain');
    String image;
    if (_image != null) {
      image = _image!.path;
    } else {
      image = 'user.png';
    }

    bool passwordalpha = validateStructure(_passwordbaru.text);
    bool noTelpNum = validateStructure2(_noTelp.text);

    if (_password.text != passwordlama) {
      showFlushbar("Perhatian", "Password lama salah",
          LineIcons.exclamationCircle, Colors.orange, context);
    } else {
      if (_noTelp.text == "" || noTelpNum == false) {
        showFlushbar("Perhatian", "Nomor telepon tidak valid",
            LineIcons.exclamationCircle, Colors.orange, context);
      } else if (_passwordbaru.text == "" && _passwordConf.text == "") {
        showDialog(
            context: context,
            builder: (context) {
              return CupertinoAlertDialog(
                title: Text("Konfirmasi"),
                content: Text("Yakin mengubah data?"),
                actions: <Widget>[
                  CupertinoDialogAction(
                      isDefaultAction: true,
                      child: Text("Ya"),
                      onPressed: () {
                        apiService.settingProfile(_image!, {
                          'password': _password.text,
                          'foto': image,
                          'no_telp': _noTelp.text,
                        }).then((isSuccess) {
                          setState(() {});
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
      } else if (passwordalpha == false || _passwordbaru.text.length < 6) {
        showFlushbar(
            "Perhatian",
            "Password minimal 6 karakter, harus ada huruf dan angka",
            LineIcons.exclamationCircle,
            Colors.orange,
            context);
      } else if (_passwordbaru.text != _passwordConf.text) {
        showFlushbar("Perhatian", "Konformasi password baru tidak cocok",
            LineIcons.exclamationCircle, Colors.orange, context);
      } else if (_noTelp.text != "" &&
          noTelpNum == true &&
          _passwordbaru.text == _passwordConf.text) {
        showDialog(
            context: context,
            builder: (context) {
              return CupertinoAlertDialog(
                title: Text("Konfirmasi"),
                content:
                    Text("Yakin mengubah data?\nPerlu login ulang setelah ini"),
                actions: <Widget>[
                  CupertinoDialogAction(
                      isDefaultAction: true,
                      child: Text("Ya"),
                      onPressed: () {
                        apiService.settingProfile(_image!, {
                          'password': _passwordConf.text,
                          'foto': image,
                          'no_telp': _noTelp.text,
                        }).then((isSuccess) {
                          logout(context);
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

    //  if(_password.text != passwordlama){
    //   showFlushbar("Perhatian","Password lama salah", LineIcons.exclamationCircle, Colors.orange, context);
    // } else  if(passwordalpha==false || _password.text.length <6 ) {
    //   showFlushbar("Perhatian","Password minimal 6 karakter, harus ada huruf dan angka", LineIcons.warning, Colors.orange, context);
    // }else if(_passwordbaru.text!=_passwordConf.text){
    //   showFlushbar("Perhatian","Konformasi password baru tidak cocok", LineIcons.warning, Colors.orange, context);
    // }else{
    //   showDialog(
    //       context: context,
    //       builder: (context) {
    //         return CupertinoAlertDialog(
    //           title: Text("Konfirmasi"),
    //           content: Text("Yakin mengubah data? Login ulang setelah proses ini"),
    //           actions: <Widget>[
    //             CupertinoDialogAction(
    //                 isDefaultAction: true,
    //                 child: Text("Ya"),
    //                 onPressed: () {
    //                   apiService.settingProfile(_image, {
    //                     'password': _passwordConf.text,
    //                     'foto':image,
    //                     'no_telp':_noTelp,
    //                   }).then((isSuccess) {
    //                     logout(context);
    //
    //                   });
    //                 }
    //             ),
    //
    //             CupertinoDialogAction(
    //               child: Text("Batal"),
    //               onPressed: () { Navigator.pop(context);},
    //             ),
    //
    //           ],
    //         );
    //       });
    // }
  }

  //  void _callPostAPIng() {
  //       apiService.settingProfile(_image, {
  //         'password': _passwordConf.text,
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
  //           });

  //       });
  //     }

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

  @override
  Widget build(BuildContext context) {
    final passwordField = TextFormField(
      controller: _password,
      decoration: InputDecoration(
        labelText: 'Password Lama',
        labelStyle: TextStyle(color: (Colors.blue[300])!),
        prefixIcon: Icon(
          Icons.lock_open,
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

    final passwordbaru = TextFormField(
      controller: _passwordbaru,
      decoration: InputDecoration(
        labelText: 'Password Baru',
        labelStyle: TextStyle(color: (Colors.blue[300])!),
        prefixIcon: Icon(
          LineIcons.lock,
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

    final namaField = TextFormField(
      controller: _nama,
      readOnly: true,
      decoration: InputDecoration(
        labelText: 'Nama Lengkap',
        labelStyle: TextStyle(color: (Colors.blue[300])!),
        prefixIcon: Icon(
          LineIcons.user,
          color: (Colors.blue[300])!,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: (Colors.blue[300])!),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: (Colors.blue[300])!),
        ),
      ),
      keyboardType: TextInputType.text,
      style: TextStyle(color: Colors.black),
      cursorColor: Colors.black,
    );

    final telpField = TextFormField(
      controller: _noTelp,
      readOnly: false,
      decoration: InputDecoration(
        labelText: 'No Telp',
        labelStyle: TextStyle(color: (Colors.blue[300])!),
        prefixIcon: Icon(
          LineIcons.phone,
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

    final nimField = TextFormField(
      controller: _nim,
      readOnly: true,
      decoration: InputDecoration(
        labelText: 'NIM',
        labelStyle: TextStyle(color: (Colors.blue[300])!),
        prefixIcon: Icon(
          LineIcons.list,
          color: (Colors.blue[300])!,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: (Colors.blue[300])!),
        ),
        focusedBorder: OutlineInputBorder(
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
        labelText: 'Konfirmasi password baru',
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

    final fotolama = Container(
      height: 100.0,
      width: 100.0,
      child: Container(
        height: 90.0,
        width: 90.0,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(_foto),
            fit: BoxFit.cover,
          ),
          shape: BoxShape.circle,
        ),
      ),
    );

    final registerForm = Padding(
      padding: EdgeInsets.only(top: 30.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            formFieldSpacing,
            nimField,
            formFieldSpacing,
            namaField,
            formFieldSpacing,
            telpField,
            formFieldSpacing,
            passwordField,
            formFieldSpacing,
            passwordbaru,
            formFieldSpacing,
            passwordConfField,
            formFieldSpacing,
            fotolama,
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
              'SIMPAN',
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
        title: Text("Pengaturan Akun"),
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
