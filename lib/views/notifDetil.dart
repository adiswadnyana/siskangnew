

import 'package:SisKa/models/api/api_service.dart';
import 'package:SisKa/models/Notif.dart';
import 'package:flutter/material.dart';
import 'package:SisKa/models/globalModel.dart';
import 'package:line_icons/line_icons.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:flutter/cupertino.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';



class AktivitasDetilScreen extends StatefulWidget {
  final String? idNt;
  const AktivitasDetilScreen({Key? key, this.idNt}) : super(key: key);
  _AktivitasDetilScreenState createState() => _AktivitasDetilScreenState();
}

class _AktivitasDetilScreenState extends State<AktivitasDetilScreen> {

  final _formKey = GlobalKey<FormState>();
  
 
    final _judul = TextEditingController();
    final _isi = TextEditingController();
    final _tanggal = TextEditingController();
    final _jenis = TextEditingController();
    bool _visibleHapus= true;
    String penerima = '0';
    String sukses = '0';
    String? jabatan;
    String id = "";
    String judulPesan = "";
     Color jenisPesanWarna= Colors.deepOrange;
     IconData? jenisPesanIcon;
    bool _saving = true;
   
   
 
  
  List<Notif>? listNotif = <Notif>[];
  List<Notif> listNotifRow = <Notif>[];
  List<DropdownMenuItem> items = [];
  String? selectedValue;
  ApiService apiService = new ApiService();

  void initState(){
    super.initState();
         BackButtonInterceptor.add(myInterceptor);
    fetchNt();
   // home.HomePage().refreshNotif();
  }
    @override
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }
  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo routeInfo) {
    return true;
  }


  void back() async{
    apiService.getAuth().then((success) async {
        if (success) {
           apiService.getAuthJab().then((jab) async {
             if (jab=='1') {
               setState(() {
                    Navigator.pushReplacementNamed(context, 'homeAdmin',arguments: 3,);
                });
             }else{
                setState(() {
                   Navigator.pushReplacementNamed(context, 'home',arguments: 4,);
                });
             }
            });
    }
    });

  }

  void fetchNt() async{
     CircularProgressIndicator();
     // final SharedPreferences prefs = await SharedPreferences.getInstance();
   jabatan ='1';// prefs.getString('Jabatan');
     apiService.updateread(widget.idNt!);

    listNotif = await apiService.getNotif();
     listNotif!.forEach((item) {
        if(item.idPesan!.toLowerCase().contains(widget.idNt!.toLowerCase())){
          listNotifRow.add(item);
        }
     });
    
    
    if(listNotif!=null){ 
      setState(() {
        String status =  listNotifRow[0].jenisPesan!;
        _judul.text = listNotifRow[0].judul!;
        _isi.text = listNotifRow[0].isi!;
        _tanggal.text = listNotifRow[0].tglKirim!;
        penerima = listNotifRow[0].calon!;
        sukses = listNotifRow[0].sukses!;
        id = listNotifRow[0].idDetil!;
         judulPesan = listNotifRow[0].judul!;
        
        if(status=='0'){
        _jenis.text = "Umum";
        jenisPesanIcon = LineIcons.users;
        jenisPesanWarna =  Colors.blue;
        }else{
        _jenis.text = "Khusus";
        jenisPesanIcon = LineIcons.userSecret;
        jenisPesanWarna =  Colors.red;
        }

       
      _saving= false;
           
      });
    }
  }


  

   void deleteAkt(String id,String judul, BuildContext context) async{
       showDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text("Konfirmasi"),
            content: Text("Yakin notifikasi "+ judul+" "+"?"),
            actions: <Widget>[
      CupertinoDialogAction(
      isDefaultAction: true,
      child: Text("Ya"),
       onPressed: () {
          apiService.deletePesan(id).then((isSuccess) {
         Navigator.pop(context);
               showFlushbar("Informasi","Notifikasi berhasil dihapus, silahkan kembali ke menu notifikasi", LineIcons.checkCircle, Colors.blue, context);
setState(() {
  _visibleHapus= false;
});
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
  


 



  

  @override
  Widget build(BuildContext context) {
    


   final judul = TextFormField(
       controller: _judul,
        readOnly: true,
         maxLines: 2,
      decoration: InputDecoration(
        labelText: 'Judul',
        labelStyle: TextStyle(color: Colors.blue),
        prefixIcon: Icon(
          LineIcons.tag,
          color: Colors.blue,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
        ),
      ),
      keyboardType: TextInputType.text,
      style: TextStyle(color: Colors.black),
      cursorColor: Colors.black,
    );


 

  final head = new Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: <Widget>[
    new Flexible(
      child: TextFormField(
       controller: _tanggal,
       readOnly: true,
      decoration: InputDecoration(
        labelText: 'Tanggal',
        labelStyle: TextStyle(color: Colors.blue),
        prefixIcon: Icon(
          LineIcons.calendarCheckAlt,
          color: Colors.blue,
        ),
        enabledBorder: OutlineInputBorder (
          borderSide: BorderSide(color: Colors.blue),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
        ),
      ),
      keyboardType: TextInputType.text,
      style: TextStyle(color: Colors.black),
      cursorColor: Colors.black,
    ),
    ),
    SizedBox(width: 20.0,),
    new Flexible(
      child:TextFormField(
       controller: _jenis,
        readOnly: true,
      decoration: InputDecoration(
        labelText: 'Jenis',
        labelStyle: TextStyle(color: jenisPesanWarna),
        prefixIcon: Icon(
         jenisPesanIcon,
          color: jenisPesanWarna,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: jenisPesanWarna),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: jenisPesanWarna),
        ),
      ),
      keyboardType: TextInputType.number,
      style: TextStyle(color: Colors.black),
      cursorColor: Colors.black,
    ),
    ),
    
  ],
);


final foot = Visibility(
      visible: _visibleHapus, //Default is true,
      child: 
    Padding(
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
          color: Colors.red ,
          elevation: 10.0,
          shadowColor: Colors.white70,
          child: MaterialButton(
           onPressed: () {
                       deleteAkt(id,judulPesan,context);
                        },
            child: Text(
              'Hapus Notifikasi',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 20.0,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    ),
    );

   // SizedBox(width: 20.0,),
// new Flexible(
//       fit: FlexFit.tight,
//       child: FlatButton(
//                 onPressed: () => {},
//                 color: Colors.transparent,
//                 padding: EdgeInsets.all(10.0),
//                 child: Column( // Replace with a Row for horizontal icon + text
//                   children: <Widget>[
//                     Icon(Icons.verified_user,
//                     color: Colors.green,
//                     size: 40, ),
//                     Text(sukses),
//                   ],
//                 ),
//     ),
//     ),
    
//   ],
// );


    final isi = TextFormField(
       controller: _isi,
        readOnly: true,
       maxLines: 100,
       minLines: 1,
      decoration: InputDecoration(
        labelText: 'Pesan',
        labelStyle: TextStyle(color: Colors.green),
       
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green),
        ),
      ),
      keyboardType: TextInputType.multiline,
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
            head,
            formFieldSpacing,
            judul,
            formFieldSpacing,
            isi,
            formFieldSpacing,
           jabatan=='1'? foot:Text("-")
            
            

             
            
          ],
        ),
      ),
    );
    

    
   

    return Scaffold(
      appBar:AppBar(
        title: Text("Detail Notifikasi"),  
         leading: new IconButton(
          icon: new Icon(Icons.arrow_back),
          onPressed: () => back(),// Navigator.pushReplacementNamed(context, 'home',arguments: 3,),
        ),     
      ),
      body: Scrollbar(
    child: ModalProgressHUD(child:SingleChildScrollView(
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
                   
                  ],
                ),
              )
            ],
          ),
        ),
      ), inAsyncCall: _saving),
    ),
    );
  }
}








