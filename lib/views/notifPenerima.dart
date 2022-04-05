import 'package:SisKa/_routing/routes.dart';
import 'package:SisKa/models/api/api_service.dart';
import 'package:SisKa/models/Notif.dart';
import 'package:flutter/material.dart';
import 'package:SisKa/utils/utils.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';

class NotifPenerimaScreen extends StatefulWidget {
  @override
  NotifPenerimaScreen({Key? key}) : super(key: key);
  _NotifPenerimaScreenState createState() => _NotifPenerimaScreenState();
}

class _NotifPenerimaScreenState extends State<NotifPenerimaScreen> {
  late BuildContext ctx;
  ApiService apiService = new ApiService();
  TextEditingController _textcari = new TextEditingController();
  List<Notif> listData = <Notif>[];
  List<Notif> listDataUse = <Notif>[];
  AssetImage? logoKet;
  String? ket;
  String? jabatan;
  bool activeSearch = false;

  void initState() {
    super.initState();
    ctx = context;
    BackButtonInterceptor.add(myInterceptor);
    activeSearch = false;
    loadData();
    _textcari.addListener(() {
      filterData(_textcari.text);
    });
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo routeInfo) {
    return true;
  }

  void filterData(String key) async {
    List<Notif> listDataTemp = <Notif>[];
    if (key.length >= 2) {
      listData.forEach((item) {
        if (item.judul!.toLowerCase().contains(key.toLowerCase()) ||
            item.tglKirim!.toLowerCase().contains(key.toLowerCase())) {
          listDataTemp.add(item);
        }
      });
    }
    setState(() {
      listDataUse.clear();
      listDataUse = listDataTemp;
    });
  }

  void loadData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    jabatan = prefs.getString('Jabatan');
    final listDataget = await apiService.getNotif();
    // home.HomePage().refreshNotif();
    if (this.mounted) {
      setState(() {
        activeSearch = false;
        listData = listDataget!;
      });
    }
  }

  void reset() async {
    setState(() {
      activeSearch = false;
      _textcari.clear();
    });
  }

  Future<Null> _refresh() async {
    setState(() {
      activeSearch = false;
    });

    return null;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Scrollbar(
        child: RefreshIndicator(
          child: _getkonten(context),
          onRefresh: _refresh,
        ),
      ),
      floatingActionButton: jabatan == '1'
          ? FloatingActionButton(
              onPressed: () {
                setState(() {
                  Navigator.pushNamed(context, notifSendViewRoute);
                });
              },
              child: Icon(LineIcons.plus),
              backgroundColor: Colors.green,
            )
          : null,
    );
  }

  Widget _getkonten(BuildContext context) {
    return SafeArea(
      child: FutureBuilder(
        future: apiService.getNotif(),
        builder: (BuildContext context, AsyncSnapshot<List<Notif>?> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Stack(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.only(top: 50.0),
                    height: 270.0,
                    width: 280.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AvailableImages.errorimg,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  new Container(
                    padding: const EdgeInsets.only(top: 270.0),
                    height: 290.0,
                    width: 250.0,
                    child: new Text(
                      'Terjadi Kesalahan, coba lagi nanti..',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            if (activeSearch) {
              // listDataUse = listDataTemp;
              logoKet = AvailableImages.notfoundimg;
              ket = "Data Tidak Ditemukan..";
            } else {
              listDataUse = snapshot.data!;
              logoKet = AvailableImages.nodata;
              ket = "Tidak Ada Data..";
            }
            if (listDataUse.length == 0) {
              return Center(
                child: Stack(
                  children: <Widget>[
                    Center(
                      child: Stack(
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.only(top: 50.0),
                            height: 270.0,
                            width: 280.0,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AvailableImages.nodata,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          new Container(
                            padding: const EdgeInsets.only(top: 270.0),
                            height: 290.0,
                            width: 250.0,
                            child: new Text(
                              'Tidak Ada Data..',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return _buildListView(listDataUse, context);
            }
          } else {
            return Center(
              child: CircularProgressIndicator(
                valueColor:
                    new AlwaysStoppedAnimation<Color>(Colors.blueAccent),
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildListView(List<Notif> notif, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListView.builder(
        itemBuilder: (context, index) {
          Notif notifs = notif[index];
          return new Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
              child: new Card(
                  elevation: 1.0,
                  color: notifs.isRead == '0'
                      ? Colors.lightBlue[50]
                      : Colors.white,
                  child: new ListTile(
                    leading: _jenisPesan(notifs),
                    title: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new Flexible(
                          child: new Container(
                            padding: new EdgeInsets.only(right: 20.0),
                            child: new Text(
                              notifs.judul!,
                              overflow: TextOverflow.ellipsis,
                              style: new TextStyle(
                                fontSize: 14.0,
                                color: new Color(0xFF212121),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        new Text(
                          notifs.tglKirim!,
                          textAlign: TextAlign.end,
                          style:
                              new TextStyle(color: Colors.grey, fontSize: 10.0),
                        ),
                      ],
                    ),
                    subtitle: new Container(
                      height: 50.0,
                      padding: const EdgeInsets.only(top: 5.0),
                      child: new GestureDetector(
                        onTap: () {
                          setState(() {
                            Navigator.pushNamed(
                              context,
                              notifDetailsViewRoute,
                              arguments: notifs.idPesan,
                            );
                          });
                        },
                        child: new Text(
                          notifs.isi!,
                          overflow: TextOverflow.clip,
                          style:
                              new TextStyle(color: Colors.grey, fontSize: 15.0),
                        ),
                      ),
                    ),
                  )));
        },
        itemCount: notif.length,
      ),
    );
  }

  Widget _jenisPesan(Notif notif) {
    if (notif.jenisPesan == '0') {
      return Icon(
        LineIcons.envelopeOpen,
        color: Colors.blue,
        size: 40,
      );
    } else {
      return Icon(
        LineIcons.envelopeOpen,
        color: Colors.red,
        size: 40,
      );
    }
  }

  PreferredSizeWidget _appBar() {
    if (activeSearch) {
      return AppBar(
        leading: Icon(Icons.search),
        title: TextFormField(
          controller: _textcari,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            contentPadding:
                const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(20.7),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(20.7),
            ),
          ),
        ),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.close), onPressed: () => reset())
        ],
      );
    } else {
      return AppBar(
        title: Text("Notifikasi"),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () => setState(() => activeSearch = true),
          ),
        ],
      );
    }
  }
}
