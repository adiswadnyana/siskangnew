
import 'package:flutter/material.dart';
import 'package:SisKa/models/globalModel.dart';
import 'package:line_icons/line_icons.dart';
import 'package:SisKa/models/api/api_service.dart';
import 'package:SisKa/models/prodi.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:flutter/cupertino.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';



class NotifSendScreen extends StatefulWidget {
 
  const NotifSendScreen({Key? key}) : super(key: key);
  _NotifSendScreenState createState() => _NotifSendScreenState();
}

class _NotifSendScreenState extends State<NotifSendScreen> {
  final _formKey = GlobalKey<FormState>();
  Prodi? selectedProdi;
 
  final _judul = TextEditingController();
   final _isi = TextEditingController();
   final _kriteria = TextEditingController();
     bool _saving = false;
   
 
  
  List<DropdownMenuItem> items = [];
  String? selectedValue;
  ApiService apiService = new ApiService();

  void initState(){
    super.initState();
     BackButtonInterceptor.add(myInterceptor);
  }
  @override
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }
  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo routeInfo) {
    return true;
  }
  

  void reset() {
     setState(() {
          _saving= false;
          _judul.clear();
          _isi.clear();
          _kriteria.clear();
     });

  }
   void _callPostAPIng( BuildContext context) async { 
      setState(() {
      // _saving= true;
     });
     if(selectedValue==null){
       showFlushbar("Perhatian","Kriteria belum dipilih", LineIcons.exclamationCircle, Colors.orange, context);
     }else  if(_judul.text==null  ){
        showFlushbar("Perhatian","Judul masih kosong", LineIcons.exclamationCircle, Colors.orange, context);
     }else  if(_isi.text==null ){
        showFlushbar("Perhatian","Pesan masih kosong", LineIcons.exclamationCircle, Colors.orange, context);
     }else{

       showDialog(
                context: context,
                builder: (context) {
                  return CupertinoAlertDialog(
                    title: Text("Konfirmasi"),
                    content: Text("Yakin mau mengirim pesan?"),
                    actions: <Widget>[
              CupertinoDialogAction(
              isDefaultAction: true,
              child: Text("Ya"),
              onPressed: () {
              //ini
               Navigator.pop(context);
              _saving= true;
           apiService.notifSend(_judul.text, _isi.text,selectedValue! ).then((isSuccess) {
          // setState(()  {
               if (isSuccess) {
      setState(()  {
         _saving= false;
  // Navigator.pop(context);
  showFlushbar("Informasi","Notifikasi berhasil dikirim", LineIcons.checkCircleAlt, Colors.green, context);
        reset();
          });
                }else{
 //      _saving= false;
 // showFlushbar("Informasi","Terjadi kesalahan", LineIcons.warning, Colors.red, context);
                  
                }
            // });
         
        });

              }
            ),
                      
            CupertinoDialogAction(
              child: Text("Batal"),
              onPressed: () { Navigator.pop(context);},
                ),

                    ],
                  );
                });

       
          
    
     }
  } 


  

  

  @override
  Widget build(BuildContext context) {
    
  

    final kriteria = DropdownButton<String>(
          items: [
            DropdownMenuItem<String>(
              child: Text('Semua Kriteria'),
              value: 'Semua Kriteria',
            ),
            DropdownMenuItem<String>(
              child: Text('Dosen'),
              value: 'Dosen',
            ),
            DropdownMenuItem<String>(
              child: Text('Mahasiwa'),
              value: 'Mahasiswa',
            ),
          ],
          onChanged: (String? value) {
            setState(() {
              selectedValue= value;
            });
          },
          hint: Text('Pilih Kriteria Penerima'),
          value: selectedValue,
          isExpanded: true,
        );

final juudl = TextFormField(
       controller: _judul,
      decoration: InputDecoration(
        labelText: 'Judul Pesan',
        labelStyle: TextStyle(color: Colors.blue),
        prefixIcon: Icon(
          LineIcons.tag,
          color: Colors.blue,
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
        ),
      ),
      keyboardType: TextInputType.text,
      style: TextStyle(color: Colors.black),
      cursorColor: Colors.black,
    );
  
  final isi = TextFormField(
       controller: _isi,
      decoration: InputDecoration(
        labelText: 'Isi Pesan',
        labelStyle: TextStyle(color: Colors.blue),
        prefixIcon: Icon(
          LineIcons.list,
          color: Colors.blue,
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
        ),
      ),
      keyboardType: TextInputType.text,
      style: TextStyle(color: Colors.black),
      cursorColor: Colors.black,
    );
   

 

  
   
   
   

    final formFieldSpacing = SizedBox(
      height: 15.0,
    );

    


    

    final registerForm = Padding(
      padding: EdgeInsets.only(top: 30.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            kriteria,
            formFieldSpacing,
             juudl,
             formFieldSpacing,
            isi,
            formFieldSpacing,
            
          ],
        ),
      ),
    );

    
    final submitBtn = Padding(
      padding: EdgeInsets.only(bottom: 10.0),
      child: Container(
        margin: EdgeInsets.only( bottom: 20.0),
        height: 60.0,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7.0),
          border: Border.all(color: Colors.white),
        ),
        child: Material(
          borderRadius: BorderRadius.circular(7.0),
          color: Colors.lightBlue ,
          elevation: 10.0,
          shadowColor: Colors.white70,
          child: MaterialButton(
           onPressed: () {
                      _callPostAPIng(context);
                        },
            child: Text(
              'KIRIM',
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
      appBar:AppBar(
        title: Text("Kirim Notifikasi"),       
      ),
      body: ModalProgressHUD(child:SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 10.0),
          child: Column(
            children: <Widget>[
              Container(
                 width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(left: 30.0, right: 30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    registerForm,
                    submitBtn
                  ],
                ),
              )
            ],
          ),
        ),
      ), inAsyncCall: _saving),
    );
  }


}
