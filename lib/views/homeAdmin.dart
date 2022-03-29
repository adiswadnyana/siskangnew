import 'package:flutter/material.dart';
import 'package:SisKa/utils/colors.dart';
import 'package:SisKa/views/notifPenerima.dart';
import 'package:SisKa/views/news.dart';
import 'package:SisKa/views/penelitian.dart';
import 'package:SisKa/views/approve.dart';
import 'package:SisKa/views/tabs/profile2.dart';
import 'package:SisKa/views/jadwal.dart';
import 'package:line_icons/line_icons.dart';
import 'package:SisKa/models/api/api_service.dart';
import 'package:SisKa/models/notifunread.dart';
import 'package:SisKa/models/registrasiNew.dart';
import 'package:badges/badges.dart';

class HomeAdminPage extends StatefulWidget {
    final int? index;
  const HomeAdminPage({Key? key, this.index}) : super(key: key);
  @override
  _HomeAdminPageState createState() => _HomeAdminPageState();
}

class _HomeAdminPageState extends State<HomeAdminPage> {
  int _currentIndex = 0;
    String _jumlahUnread='0';
    String _jumlahUnreadReg='0';
  List<NorifUnread> listData = <NorifUnread>[];
    List<RegistrasiNew> listDataReg = <RegistrasiNew>[];
  ApiService apiService = new ApiService();
   
  final List<Widget> _pages = [
    NewsScreen(),
    JadwalScreen(),
    PenelitianScreen(),
    NotifPenerimaScreen(),
    ApproveScreen(),
    Profile2()
  ];

   void initState() {
    super.initState();
   loadData() ;
   _currentIndex = widget.index!;
  }

  void loadData() async{
  final listData = await apiService.getNotifUnread();
  final listDataReg = await apiService.getRegistrasiNew();

 if (this.mounted) {
      setState(() {
         _jumlahUnread = listData![0].jumlah!;
          _jumlahUnreadReg = listDataReg![0].jumlah!;
      });
  }
  }


  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    final bottomNavBar = BottomNavigationBar(
      onTap: onTabTapped,
      currentIndex: _currentIndex,
      selectedItemColor: gradientStart,
      unselectedItemColor: Colors.grey.withOpacity(0.4),
      elevation: 25.0,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.rss_feed),
          label:
            'Berita',
            
        ),
        BottomNavigationBarItem(
          icon: Icon(LineIcons.calendar),
          label:
            'Jadwal',
            
        ),
        BottomNavigationBarItem(
          icon: Icon(LineIcons.book),
          label:
            'Penelitian',
            
        ),
         _jumlahUnread!='0'?
        BottomNavigationBarItem(
          icon:  Badge(
            shape: BadgeShape.circle,
            borderRadius: BorderRadius.circular(100),
            child: Icon(Icons.notifications),
            badgeContent: Container(
              height: 13,
              width: 13,
              decoration:
                  BoxDecoration(
                    shape: BoxShape.circle, color: Colors.red
                    ),
                child: new Text(_jumlahUnread , textAlign: TextAlign.center,
                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                ),
                                ),     
            ),
          ),
          label:
            'Notifikasi',
            
        ):  BottomNavigationBarItem(
          icon: Icon(Icons.notifications),
          label:
            'Notifikasi',
            
        ),


        _jumlahUnreadReg!='0'?
        BottomNavigationBarItem(
          icon:  Badge(
            shape: BadgeShape.circle,
            borderRadius: BorderRadius.circular(100),
            child: Icon(LineIcons.checkCircleAlt),
            badgeContent: Container(
              height: 13,
              width: 13,
              decoration:
                  BoxDecoration(
                    shape: BoxShape.circle, color: Colors.red
                    ),
                child: new Text(_jumlahUnreadReg , textAlign: TextAlign.center,
                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                ),
                                ),     
            ),
          ),
          label:
            'Registrasi',
            
        ):  BottomNavigationBarItem(
          icon: Icon(LineIcons.checkCircleAlt),
          label:
            'Registrasi',
            
        ),


        //  BottomNavigationBarItem(
        //   icon: Icon(LineIcons.check_circle_o),
        //   label:
        //     'Registrasi',
        //     style: TextStyle(fontWeight: FontWeight.bold),
        //   ),
        // ),
        BottomNavigationBarItem(
          icon: Icon(LineIcons.user),
          label:
            'Profile',
            
        )
      ],
    );

    return Scaffold(
      bottomNavigationBar: bottomNavBar,
      body: _pages[_currentIndex],
    );
  }
}
