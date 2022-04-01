import 'dart:async';

import 'package:SisKa/models/api/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:SisKa/models/profile.dart';
import 'package:SisKa/models/masaStudi.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:SisKa/utils/colors.dart';
// import 'package:progress_hud/progress_hud.dart';
import 'package:SisKa/_routing/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';


class Profile2 extends StatefulWidget{
  Profile2({Key? key}):super(key: key);
  _Profile2 createState()=>_Profile2();
}

class _Profile2 extends State<Profile2>{
  bool _loading = true;
  String _namaUser ='';
   String _jurusan ='';
    String _jabatan ='';
    String _foto ='';
    String _studiAwal ='';
    String _studiAkhir ='';
     String _sisaStudi ='';
      String _isAdmin ='';
     String _statusPenelitian ='';
   
  List<Profile>? listProfile = [];
  List<MasaStudi>? listMasaStudi = [];
  ApiService apiService = ApiService();

  void initState(){
    super.initState();
    BackButtonInterceptor.add(myInterceptor);
    fetchProfile();
  }
    @override
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }
  FutureOr<bool> myInterceptor(bool stopDefaultButtonEvent , RouteInfo info) {
    return true;
  }


  void fetchProfile() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
     String jabatans ='';
    listProfile = await apiService.getProfiles();
     listMasaStudi = await apiService.getMasaStudi();
    jabatans = await apiService.getAuthJab();
    print(listProfile);
    if(listProfile!=null){ 
      setState(() {
             BotToast.showLoading();
            _namaUser = listProfile![0].nimNama!;
            _jurusan = listProfile![0].namaProdi!; 
            _foto = listProfile![0].foto!;
            _jabatan = jabatans;
            _studiAwal = listMasaStudi![0].tglAwalStudi!; 
            _studiAkhir = listMasaStudi![0].tglAkhirStudi!;
             _sisaStudi = listMasaStudi![0].sisaMasaStudi!;
            _statusPenelitian = listMasaStudi![0].statusPenelitian!; 
            _isAdmin =  prefs.getString('IsAdmin')!;
            BotToast.closeAllLoading();
      });
    }
  }

   void logout( BuildContext context) async{
       showDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: const Text("Konfirmasi"),
            content: const Text("Yakin mau keluar?\n"),
            actions: <Widget>[
      CupertinoDialogAction(
      isDefaultAction: true,
      child: const Text("Ya"),
       onPressed: () {
          apiService.logOut().then((isSuccess) {
          setState(()  {
                Navigator.pushReplacementNamed(context, 'splash');
            });
        });
       }
    ),
              
    Center(
      child: CupertinoDialogAction(
        child: const Text("Batal"),
        onPressed: () { Navigator.pop(context);},
          ),
    ),

            ],
          );
        });
     
  }

   void dismissProgressHUD() {
      setState(() {
        if (_loading) {
          BotToast.closeAllLoading();
        } else {
          BotToast.showLoading();
        }

        _loading = !_loading;
      });
    }

   

  
  Widget build(BuildContext context){
     final hr = const Divider();
      final userImage =   Positioned(
              top: 150.0, // (background container size) - (circle height / 2)
              child:Container(
      height: 90.0,
      width: 90.0,
      decoration: BoxDecoration(
        image: DecorationImage(
          image:  NetworkImage(_foto),
          fit: BoxFit.cover,
        ),
        shape: BoxShape.circle,
      ),
    ),
      );
      
    final secondCard = Padding(
      padding: const EdgeInsets.only(right: 20.0, left: 20.0, bottom: 10.0, top: 50),
      child: SingleChildScrollView(
    child: Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(8.0),
        shadowColor: Colors.white,
        child: Container(
           height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            children: <Widget>[
              _buildUserStats(_namaUser,_jurusan),
              _jabatan=='0'? _buildMasaStudi(_studiAwal,_studiAkhir,_sisaStudi):const Icon(LineIcons.users, color: Colors.transparent,),
              _jabatan=='0'? _buildStatusPenelitian(_statusPenelitian):const Icon(LineIcons.users, color: Colors.transparent,),
hr,
              
               
            _jabatan=='0'? Card(
               child: InkWell(
                child: const ListTile(
                  leading: Icon(LineIcons.lineChart, color: Colors.blue,),
                  title: Text('Timeline', style: TextStyle(color: Colors.blue),),
                  trailing: Icon(Icons.arrow_right, color: Colors.blue,),
                   
                ),
                onTap: () {
                   setState(() { 
                        Navigator.pushNamed(context, timelineViewRoute,
                            arguments: "Mhs", );
                      });
                 },
                ),
              ):Card(
               child: InkWell(
                child: const ListTile(
                  leading: Icon(LineIcons.users, color: Colors.blue,),
                  title: Text('Masa Studi', style: TextStyle(color: Colors.blue),),
                  trailing: Icon(Icons.arrow_right, color: Colors.blue,),
                   
                ),
                onTap: () {
                   setState(() { 
                        Navigator.pushNamed(context,masastudiViewRoute );
                      });
                 },
                ),
              ),
              
             Card(
               child: InkWell(
                child: const ListTile(
                  leading: Icon(LineIcons.barChart, color: Colors.blue,),
                  title: Text('Dashboard', style: TextStyle(color: Colors.blue),),
                  trailing: Icon(Icons.arrow_right, color: Colors.blue,),
                   
                ),
                onTap: () {
                   setState(() { 
                        Navigator.pushNamed(context, dashboardViewRoute);
                      });
                 },
                ),
              ),
             Card(
               child: InkWell(
                child: const ListTile(
                  leading: Icon(LineIcons.cogs, color: Colors.blue,),
                  title: Text('Pengaturan Akun', style: TextStyle(color: Colors.blue),),
                  trailing: Icon(Icons.arrow_right, color: Colors.blue,),
                   
                ),
                onTap: () {
                   setState(() { 
                       Navigator.pushNamed(context, settingProfile);
                      });
                 },
                ),
              ),
              _isAdmin=='1'? Card(
               child: InkWell(
                child: const ListTile(
                  leading: Icon(LineIcons.circleAlt ,color: Colors.green,),
                  title: Text('Ganti Akun', style: TextStyle(color: Colors.green),),
                    trailing: Icon(Icons.arrow_right, color: Colors.green,),
                ),
                onTap: () {
                  setState(() {
                     Navigator.pushNamed(context,userAllViewRoute );
                  });
                 
                 },
                ),
              ):const Icon(LineIcons.users, color: Colors.transparent,),
               Card(
               child: InkWell(
                child: const ListTile(
                  leading: Icon(LineIcons.lock, color: Colors.red,),
                  title: Text('Log Out', style: TextStyle(color: Colors.red),),
                ),
                onTap: () {
                  setState(() {
                     logout(context);
                  });
                 
                 },
                ),
              ),
              

                   
              
              
            ],
          ),
        ),
      ),
    ),
    );


    
    return Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: <Widget>[
          // _progressHUD,
            // background image and bottom contents
            Column(
              children: <Widget>[
                Container(
                          height: 200.0,
                          decoration: const BoxDecoration(
                            gradient: primaryGradient,
                            image: DecorationImage(
                              image: AssetImage('assets/images/LogoUndiksha.png'),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                Expanded(
                  child: Container(
                    color: Colors.white,
                    child: Center(
                      child:  secondCard,
                    ),
                  ),
                )
              ],
            ),
            // Profile image
            userImage,
          ],
        ),
      );
  }
}



 Widget _buildMasaStudi(String studiAwal, String studiAkhir, String sisaStudi ) {
return Padding(
  padding: const EdgeInsets.only(left: 5.0,right: 5.0, bottom: 0,top: 10),
  child: Material(
    elevation: 5.0,
    borderRadius: BorderRadius.circular(5.0),
    child: Container(
      height: 60.0,
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[ 
        const Text(
          'Awal Studi' ,
          style:TextStyle(
      color: Colors.black54,
      fontSize: 14.0,
      fontWeight: FontWeight.bold
    ),
        ),
        Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Stack(
                          children:[
                            const Padding(
                            padding: EdgeInsets.all(0.0),
                          ),
                          SkeletonAnimation(
                            child: Center(
                              child: Text(
                                studiAwal,
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          ]
                        )
        ),
        
      ],
    ),

    
     Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[ 
        const Text(
          'Sisa Masa Studi' ,
          style:TextStyle(
      color: Colors.black54,
      fontSize: 14.0,
      fontWeight: FontWeight.bold
    ),
        ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Stack(
                children:[
                  const Padding(
                  padding: EdgeInsets.all(0.0),
                ),
                SkeletonAnimation(
                  child: Center(
                    child: Text(
                      sisaStudi+' '+'Bulan',
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                ]
              )
            ),
            
      ],
    ),

    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[ 
        const Text(
          'Akhir Studi' ,
          style:TextStyle(
      color: Colors.black54,
      fontSize: 14.0,
      fontWeight: FontWeight.bold
    ),
        ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Stack(
                children:[
                  const Padding(
                  padding: EdgeInsets.all(0.0),
                ),
                SkeletonAnimation(
                  child: Center(
                    child: Text(
                      studiAkhir,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                ]
              )
            ),
      ],
    ),

    
        ],
      ),
    ),
     ),
      );  
 }



 Widget _buildStatusPenelitian(String status ) {
return Padding(
  padding: const EdgeInsets.only(left: 5.0,right: 5.0, bottom: 5,top: 0),
  child: Material(
    elevation: 5.0,
    borderRadius: BorderRadius.circular(5.0),
    child: Container(
      height: 60.0,
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[ 
        const Text(
          'Tahap Akhir Penelitian' ,
          style:TextStyle(
      color: Colors.black54,
      fontSize: 14.0,
      fontWeight: FontWeight.bold
    ),
        ),
        Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Stack(
                          children:[
                            const Padding(
                            padding: EdgeInsets.all(0.0),
                          ),
                          SkeletonAnimation(
                            child: Center(
                              child: Text(
                                status,
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          ]
                        )
        ),
      ],
    ),

    
    
        ],
      ),
    ),
     ),
      );  

 }
    






 Widget _buildUserStats(String name, String jurusan) {
    return Column(
      children: <Widget>[
        Align(
          alignment: Alignment.center,
         child: Text(
          name,
          style: const TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w900,
            fontSize: 15.0,
          ),
        ),
        ),
        Align(
         alignment: Alignment.center,
         child:Text(
          jurusan,
          style: TextStyle(
            color: Colors.grey.withOpacity(0.6),
            fontWeight: FontWeight.w600,
            fontSize: 13.0,
          ),
        ),
        ),
       
      ],
    );
  }

  Widget _buildIconTile(IconData icon, Color color, String title) {
    return ListTile(
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold),),
      leading: Container(
        height: 20.0,
        width: 20.0,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Center(
          child: Icon(
            icon,
            color: Colors.white,
             size: 12,
          ),
        ),
      ),
      trailing: const Icon(LineIcons.chevronCircleLeft),
    );
  }