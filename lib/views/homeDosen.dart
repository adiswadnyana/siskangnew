import 'package:SisKa/models/notifunread.dart';
import 'package:flutter/material.dart';
import 'package:SisKa/utils/colors.dart';
import 'package:SisKa/views/notifPenerima.dart';
import 'package:SisKa/views/news.dart';
import 'package:SisKa/views/penelitian.dart';
import 'package:SisKa/views/tabs/profile2.dart';
import 'package:SisKa/views/jadwal.dart';
import 'package:SisKa/views/masastudi.dart';
import 'package:badges/badges.dart';
import 'package:line_icons/line_icons.dart';
import 'package:SisKa/models/api/api_service.dart';

class HomePageDosen extends StatefulWidget {
  final int? index;
  const HomePageDosen({Key? key, this.index}) : super(key: key);
  @override
  _HomePageDosenState createState() => _HomePageDosenState();
}

class _HomePageDosenState extends State<HomePageDosen> {
  int _currentIndex = 0;
  ApiService apiService = new ApiService();
  String _jumlahUnread = '0';
  List<NorifUnread> listData = <NorifUnread>[];

  final List<Widget> _pages = [
    MasastudiScreen(),
    NewsScreen(),
    JadwalScreen(),
    PenelitianScreen(),
    NotifPenerimaScreen(),
    Profile2()
  ];

  void initState() {
    super.initState();
    loadData();
    _currentIndex = widget.index!;
  }

  void loadData() async {
    final listData = await apiService.getNotifUnread();

    if (this.mounted) {
      setState(() {
        _jumlahUnread = listData![0].jumlah!;
      });
    }
  }

  void onTabTapped(int index) {
    setState(() {
      loadData();
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
          icon: Icon(Icons.timeline),
          label: 'Masa Studi',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.rss_feed),
          label: 'Berita',
        ),
        BottomNavigationBarItem(
          icon: Icon(LineIcons.calendar),
          label: 'Jadwal',
        ),
        BottomNavigationBarItem(
          icon: Icon(LineIcons.book),
          label: 'Penelitian',
        ),
        _jumlahUnread != '0'
            ? BottomNavigationBarItem(
                icon: Badge(
                  shape: BadgeShape.circle,
                  borderRadius: BorderRadius.circular(100),
                  child: Icon(Icons.notifications),
                  badgeContent: Container(
                    height: 13,
                    width: 13,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.red),
                    child: new Text(
                      _jumlahUnread,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                label: 'Notifikasi',
              )
            : BottomNavigationBarItem(
                icon: Icon(Icons.notifications),
                label: 'Notifikasi',
              ),
        BottomNavigationBarItem(
          icon: Icon(LineIcons.user),
          label: 'Profile',
        )
      ],
    );

    return Scaffold(
      bottomNavigationBar: bottomNavBar,
      body: _pages[_currentIndex],
    );
  }
}
