// import 'package:SisKa/models/api/api_service.dart';
// import 'package:SisKa/models/masaStudi.dart';
// import 'package:SisKa/models/profile.dart';
// import 'package:flutter/material.dart';
// import 'package:line_icons/line_icons.dart';
// import 'package:SisKa/utils/utils.dart';
// import 'package:skeleton_text/skeleton_text.dart';
// import 'package:floating_ribbon/floating_ribbon.dart';


// class MasastudiScreen extends StatefulWidget {
//   @override
//   MasastudiScreen({Key key}):super(key: key);
//   _MasastudiScreenState createState() => _MasastudiScreenState();
  
// }

// class _MasastudiScreenState extends State<MasastudiScreen> {
//   BuildContext context;
//   ApiService apiService = new ApiService();
//   TextEditingController _textcari = new TextEditingController();
//   List<MasaStudi> listData = new List<MasaStudi>();
//   List<MasaStudi> listDataUse = new List<MasaStudi>();
//   AssetImage logoKet;
//   String ket;
//   bool activeSearch=false;

//  void initState() {
//     super.initState();
//     activeSearch=false;
//    loadData() ;
//    _textcari.addListener(() {
//         filterData(_textcari.text) ;
//         });
//   }

//  void filterData(String key) async{
//     List<MasaStudi> listDataTemp = new List<MasaStudi>();
//     if(key.length >=2){
//       listData.forEach((item) {
//         if(item.nama.toLowerCase().contains(key.toLowerCase()) || item.nama .toLowerCase().contains(key.toLowerCase()) ){
//           listDataTemp.add(item);
//         }
//      });
//     }
//     setState(() {
//       listDataUse.clear();
//       listDataUse =  listDataTemp;
//     });
      

//    }

//  void loadData() async{
//   final listDataget = await apiService.getMasaStudi();
//   if (this.mounted) {
//       setState(() {
//          activeSearch= false;
//          listData = listDataget;
//       });
//   }
//   }

//   void reset() async{
//       setState(() {
//          activeSearch= false;
//          _textcari.clear();
//       });
//   }

//   Future<Null> _refresh() async {
//     setState(() { 
//          activeSearch= false;
//       });
    
//     return null;
//   }

//   Widget build(BuildContext context) {

//      return Scaffold(
//           appBar:_appBar(),
//             body: RefreshIndicator(
//         child: _getkonten(context),
//         onRefresh: _refresh,
//       ),
 
//   );
//   }

// Widget _getkonten( BuildContext context) {
//     return SafeArea(
//       child: FutureBuilder(
//         future: apiService.getMasaStudi(),
//         builder: (BuildContext context, AsyncSnapshot<List<MasaStudi>> snapshot) {
//            if (snapshot.hasError) {
//              return Center(
//               child: Stack(
//           children:<Widget>[
//                  Container(
//                     padding: const EdgeInsets.only(top: 50.0),
//                     height: 270.0,
//                     width: 280.0,
//                     decoration: BoxDecoration(
//                       image: DecorationImage(
//                         image: AvailableImages.errorimg,
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
                
//                    new Container(
//                       padding: const EdgeInsets.only(top: 270.0),
//                     height: 290.0,
//                     width: 250.0,
//                         child: new Text('Terjadi Kesalahan, coba lagi nanti..' , textAlign: TextAlign.center,),
//                       ),
//              ],
//             ),
//             );
//           } else if (snapshot.connectionState == ConnectionState.done) {
//                 if(activeSearch){
//                   // listDataUse = listDataTemp;
//                    logoKet = AvailableImages.notfoundimg;
//                    ket="Data Tidak Ditemukan..";
//                   }else{
//                     listDataUse = snapshot.data;
//                     logoKet = AvailableImages.nodata;
//                     ket="Tidak Ada Data..";
//                   }
//               if(listDataUse.length == 0){
//                  return Center(
//               child:  Stack(
//           children:<Widget>[
//                  Container(
//                   padding: const EdgeInsets.only(top: 50.0),
//                     height: 100.0,
//                     width: 100.0,
//                     decoration: 
//                      BoxDecoration(
//                       image: DecorationImage(
//                         image: logoKet,
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                   Text(ket) 
//              ],
//             ),
//             ); 
//               }else{
//                     return  _buildListView(listDataUse, context);
//               }
            
          
//           }  else {
//             return Center(
//               child: CircularProgressIndicator(
//                  valueColor: new AlwaysStoppedAnimation<Color>(Colors.blueAccent),
//               ),
//             );
//           }
//         },
//       ),
//     );
  
//   }



//    Widget _buildListView(List<MasaStudi> jadwal, BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
//       child: ListView.builder(
//         itemBuilder: (context, index) {
//           MasaStudi jadwals = jadwal[index];
//           return Padding(
//             padding: const EdgeInsets.only(top: 5.0),
//               child: Padding(
//                 padding: const EdgeInsets.all(5.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
                    
//                     new Container(
//                    // height: 150.0,
//                     width: MediaQuery.of(context).size.width,
                    
//                     child: Stack(
//                       children: <Widget>[
//                         Padding(
//                           padding: const EdgeInsets.only(left: 5.0,right: 5.0),
//                           child: Material(
//                             elevation: 5.0,
//                             borderRadius: BorderRadius.circular(14.0),
//                             child: Container(
//                               padding: EdgeInsets.only(top: 40.0),
//                              // height: 150.0,
//                               width: MediaQuery.of(context).size.width,
//                               decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius: BorderRadius.circular(14.0),
//                               ),
//                              child: _isi(jadwals),
//               ),
//             ),
//           ),
// _jenisUjian(jadwals), 
//         ],
//       ),
//     ), 


    

//                   ],
//                 ),
//               ),
            
//           );
        
//         },
//         itemCount: jadwal.length,
//       ),
//     );
//   }


//   Widget _isi(MasaStudi jadwal) {
//        return ExpansionTile(
//         initiallyExpanded: true,
//         leading: Hero(
//           tag: NetworkImage(jadwal.foto),
//           child: Material(
//             elevation: 2.0,
//             borderRadius: BorderRadius.circular(14.0),
//             child: Container(
//               height: 50.0,
//               width: 50.0,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(14.0),
//                 image: DecorationImage(
//                   image:NetworkImage(jadwal.foto),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//           ),
//         ),    
//               title: Column(
//             children: <Widget>[  
//                 new  Padding(
//                 padding: const EdgeInsets.all(5.0),
//                 child:   Text(
//                             jadwal.nama,
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 13
//                             ),
//                           )
//                           ),  
                      
//                     ],
//                   ),
//                   children: <Widget>[
                    
                    
//                     new  Padding(
//                         padding: const EdgeInsets.all(5.0),
//                         child:  Column(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                         children: <Widget>[
//                            Padding(
//   padding: const EdgeInsets.only( bottom: 5,top: 10),
//   child: Material(
//     elevation: 2.0,
//     borderRadius: BorderRadius.circular(5.0),
//     child: Container(
//       height: 60.0,
//       decoration: BoxDecoration(
//         color: Colors.white,
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: <Widget>[
//     Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: <Widget>[ 
//         Text(
//           'Awal Studi' ,
//           style:TextStyle(
//       color: Colors.black54,
//       fontSize: 14.0,
//       fontWeight: FontWeight.bold
//     ),
//         ),
//         Padding(
//                         padding: const EdgeInsets.all(5.0),
//                         child: FloatingRibbon(
//                           height: 25,
//                           width: 100,
//                           childHeight: 0,
//                           childWidth: 100,
//                           ribbonSwatch: Colors.green,
                          
//                           child: Padding(
//                             padding: const EdgeInsets.all(0.0),
//                           ),
//                           ribbon:  Center(
//                               child: Text(
//                                 jadwal.tglAwalStudi,
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                 ),
//                                 textAlign: TextAlign.center,
//                               ),
//                             ),
                          
                         
//                         )
//         ),
//       ],
//     ),

    
//      Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: <Widget>[ 
//         Text(
//           'Sisa Masa Studi' ,
//           style:TextStyle(
//       color: Colors.black54,
//       fontSize: 14.0,
//       fontWeight: FontWeight.bold
//     ),
//         ),
//             Padding(
//               padding: const EdgeInsets.all(5.0),
//               child: FloatingRibbon(
//                 height: 25,
//                 width: 100,
//                 childHeight: 0,
//                 childWidth: 100,
//                 ribbonSwatch: Colors.orange,
                
//                 child: Padding(
//                   padding: const EdgeInsets.all(0.0),
//                 ),
//                 ribbon:  Center(
//                     child: Text(
//                       jadwal.sisaMasaStudi+' '+'Bulan',
//                       style: TextStyle(
//                         color: Colors.white,
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                   ),
//               )
//             ),
//       ],
//     ),

//     Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: <Widget>[ 
//         Text(
//           'Akhir Studi' ,
//           style:TextStyle(
//       color: Colors.black54,
//       fontSize: 14.0,
//       fontWeight: FontWeight.bold
//     ),
//         ),
//             Padding(
//               padding: const EdgeInsets.all(5.0),
//               child: FloatingRibbon(
//                 height: 25,
//                 width: 100,
//                 childHeight: 0,
//                 childWidth: 100,
//                 ribbonSwatch: Colors.red,
                
//                 child: Padding(
//                   padding: const EdgeInsets.all(0.0),
//                 ),
//                 ribbon: Center(
//                     child: Text(
//                       jadwal.tglAkhirStudi,
//                       style: TextStyle(
//                         color: Colors.white,
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                   ),
               
//               )
//             ),
//       ],
//     ),
    

//         ],
//       ),
//     ),
//      ),
//       ),
           
//              Row(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: <Widget>[
//           Align(
//                             alignment: Alignment.centerLeft,
//                             child:FlatButton.icon(
//                               color: Colors.transparent,
//                               icon: new IconTheme(
//                                   data: new IconThemeData(
//                                       color: Colors.blue), 
//                                   child: new Icon(LineIcons.list_alt),
//                               ), 
//                               label: Text(jadwal.statusPenelitian, 
//                               style: new TextStyle(
//                                       fontSize: 12.0,
//                                       color: Colors.black,
//                                       ),), //`Text` to display
//                               onPressed: () {},
//                             ),
//                              ),
//         ],
//       ), 
//        new Divider(
//             color: Colors.black,
//           ),  

//        Row(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: <Widget>[
//                             Align(
//                             alignment: Alignment.centerLeft,
//                             child:FlatButton.icon(
//                               color: Colors.transparent,
//                               icon: new IconTheme(
//                                   data: new IconThemeData(
//                                       color: Colors.blue), 
//                                   child: new Icon(LineIcons.phone),
//                               ), 
//                               label: Text(jadwal.notelp, 
//                               style: new TextStyle(
//                                       fontSize: 12.0,
//                                       color: Colors.black,
//                                       ),), //`Text` to display
//                               onPressed: () {},
//                             ),
//                              ),
//         ],
//       ),
//  new Divider(
//             color: Colors.black,
//           ),
//        Row(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: <Widget>[
//                              Align(
//                             alignment: Alignment.center,
//                             child:FlatButton.icon(
//                               color: Colors.transparent,
//                               icon: new IconTheme(
//                                   data: new IconThemeData(
//                                       color: Colors.blue), 
//                                   child: new Icon(LineIcons.at),
//                               ), 
//                               label: Text(jadwal.email, 
//                               style: new TextStyle(
//                                       fontSize: 12.0,
//                                       color: Colors.black,
//                                       ),), //`Text` to display
//                               onPressed: () {},
//                             ),
//                              ),

    
    
//         ],
//       ),          

//                         ],
//                       )
//                 ),
//             ],
//               ); 
// }


//  Widget _buildStatusPenelitian(MasaStudi status ) {
// return Padding(
//   padding: const EdgeInsets.only(left: 5.0,right: 5.0, bottom: 5,top: 0),
//   child: Material(
//     elevation: 5.0,
//     borderRadius: BorderRadius.circular(5.0),
//     child: Container(
//       height: 60.0,
//       decoration: BoxDecoration(
//         color: Colors.transparent,
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: <Widget>[
//           Align(
//                             alignment: Alignment.centerLeft,
//                             child:FlatButton.icon(
//                               color: Colors.transparent,
//                               icon: new IconTheme(
//                                   data: new IconThemeData(
//                                       color: Colors.blue), 
//                                   child: new Icon(LineIcons.line_chart),
//                               ), 
//                               label: Text(status.statusPenelitian, 
//                               style: new TextStyle(
//                                       fontSize: 12.0,
//                                       color: Colors.black,
//                                       ),), //`Text` to display
//                               onPressed: () {},
//                             ),
//                              ),
//                             Align(
//                             alignment: Alignment.centerLeft,
//                             child:FlatButton.icon(
//                               color: Colors.transparent,
//                               icon: new IconTheme(
//                                   data: new IconThemeData(
//                                       color: Colors.blue), 
//                                   child: new Icon(LineIcons.phone),
//                               ), 
//                               label: Text(status.notelp, 
//                               style: new TextStyle(
//                                       fontSize: 12.0,
//                                       color: Colors.black,
//                                       ),), //`Text` to display
//                               onPressed: () {},
//                             ),
//                              ),

//                              Align(
//                             alignment: Alignment.centerLeft,
//                             child:FlatButton.icon(
//                               color: Colors.transparent,
//                               icon: new IconTheme(
//                                   data: new IconThemeData(
//                                       color: Colors.blue), 
//                                   child: new Icon(LineIcons.at),
//                               ), 
//                               label: Text(status.email, 
//                               style: new TextStyle(
//                                       fontSize: 12.0,
//                                       color: Colors.black,
//                                       ),), //`Text` to display
//                               onPressed: () {},
//                             ),
//                              ),

    
    
//         ],
//       ),
//     ),
//      ),
//       );  

//  }


// Widget _jenisUjian(MasaStudi jadwal) {
//   Color jenisUjian;
//   if(jadwal.status=='Lewat Masa Studi'){
//     jenisUjian = Colors.red;
//   }else{
//     jenisUjian = Colors.green;
//   }
//        return new Positioned(
//                     left: 20.0,
//                     top: 12.0,
//                           child: FloatingRibbon(
//                           height: 25,
//                           width: 150,
//                           childHeight: 50,
//                           childWidth: 50,
//                           ribbonSwatch: jenisUjian,
//                           ribbonShadowSwatch :jenisUjian,
                          
//                           child: Padding(
//                             padding: const EdgeInsets.all(0.0),
//                           ),
//                           ribbon: SkeletonAnimation(
//                             child: Center(
//                               child: Text(
//                                 jadwal.status,
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                 ),
//                                 textAlign: TextAlign.center,
//                               ),
//                             ),
//                           ),
//                           shadowHeight: 10,
//                         )
//                   ); 
      

// }

//   PreferredSizeWidget _appBar() {
//     if (activeSearch) {
//       return AppBar(
//         leading: Icon(Icons.search),
//         title: TextFormField(
//           controller: _textcari,
//            decoration: InputDecoration(
             
//       filled: true,
//       fillColor: Colors.white,
//       contentPadding:
//           const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
//       focusedBorder: OutlineInputBorder(
//         borderSide: BorderSide(color: Colors.white),
//         borderRadius: BorderRadius.circular(20.7),
//       ),
//       enabledBorder: UnderlineInputBorder(
//         borderSide: BorderSide(color: Colors.white),
//         borderRadius: BorderRadius.circular(20.7),
//       ),
//     ),
//         ),
//         actions: <Widget>[
//           IconButton(
//             icon: Icon(Icons.close),
//            onPressed: () => reset() 
//           )
//         ],
//       );
//     } else {
//       return AppBar(
//         title: Text("Masa Studi"),
//         automaticallyImplyLeading: true,
//         actions: <Widget>[
//           IconButton(
//             icon: Icon(Icons.search),
//             onPressed: () => setState( () => activeSearch = true),
//           ),
//         ],
//       );
//     }
//   }






// }


  
  




  
  

 