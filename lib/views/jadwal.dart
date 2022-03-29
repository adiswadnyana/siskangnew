import 'package:SisKa/models/api/api_service.dart';
import 'package:SisKa/models/jadwal.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:SisKa/utils/utils.dart';
import 'package:skeleton_text/skeleton_text.dart';
// import 'package:floating_ribbon/floating_ribbon.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';

class JadwalScreen extends StatefulWidget {
  @override
  JadwalScreen({Key? key}) : super(key: key);
  _JadwalScreenState createState() => _JadwalScreenState();
}

class _JadwalScreenState extends State<JadwalScreen> {
  late BuildContext ctx;
  ApiService apiService = new ApiService();
  TextEditingController _textcari = new TextEditingController();
  List<Jadwal> listData = <Jadwal>[];
  List<Jadwal> listDataUse = <Jadwal>[];
  AssetImage? logoKet;
  String ket='';
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

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    return true;
  }

  void filterData(String key) async {
    List<Jadwal> listDataTemp = <Jadwal>[];
    if (key.length >= 2) {
      listData.forEach((item) {
        if (item.nama!.toLowerCase().contains(key.toLowerCase()) ||
            item.tgl!.toLowerCase().contains(key.toLowerCase())) {
          listDataTemp.add(item);
        }
      });
    }
    setState(() {
      if (listDataTemp.length > 0) {
        listDataUse.clear();
        listDataUse = listDataTemp;
      }
    });
  }

  void loadData() async {
    final listDataget = await apiService.getJadwal();
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
    );
  }

  Widget _getkonten(BuildContext context) {
    return SafeArea(
      child: FutureBuilder(
        future: apiService.getJadwal(),
        builder: (BuildContext context, AsyncSnapshot<List<Jadwal>?> snapshot) {
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

  Widget _buildListView(List<Jadwal> jadwal, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListView.builder(
        itemBuilder: (context, index) {
          Jadwal jadwals = jadwal[index];
          return Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Container(
                    // height: 150.0,
                    width: MediaQuery.of(context).size.width,

                    child: Stack(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                          child: Material(
                            elevation: 5.0,
                            borderRadius: BorderRadius.circular(14.0),
                            child: Container(
                              padding: EdgeInsets.only(top: 40.0),
                              // height: 150.0,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(14.0),
                              ),
                              child: _isi(jadwals),
                            ),
                          ),
                        ),
                        new Positioned(
                          left: 15.0,
                          top: 7.0,
                          child: new IconTheme(
                            data: new IconThemeData(
                                color: Colors.black.withOpacity(0.9)),
                            child: new Icon(LineIcons.calendar),
                          ),
                        ),
                        _tgl(jadwals),
                        _jenisUjian(jadwals),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        itemCount: jadwal.length,
      ),
    );
  }

  Widget _isi(Jadwal jadwal) {
    return ExpansionTile(
      initiallyExpanded: true,
      leading: Hero(
        tag: NetworkImage(jadwal.fotoMhs!),
        child: Material(
          elevation: 2.0,
          borderRadius: BorderRadius.circular(14.0),
          child: Container(
            height: 50.0,
            width: 50.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14.0),
              image: DecorationImage(
                image: NetworkImage(jadwal.fotoMhs!),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
      title: Column(
        children: <Widget>[
          new Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                jadwal.nama!,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
              )),
        ],
      ),
      children: <Widget>[
        new Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Align(
                  alignment: Alignment.center,
                  child: Container(
                      child: Text(
                    jadwal.judul!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  )),
                ),
                new Divider(
                  color: Colors.black,
                ),
                new Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: FlatButton.icon(
                          color: Colors.transparent,
                          icon: new IconTheme(
                            data: new IconThemeData(color: Colors.blue),
                            child: new Icon(LineIcons.users),
                          ),
                          label: Text(
                            jadwal.pembimbing1! + '\n' + jadwal.pembimbing2!,
                            style: new TextStyle(
                              fontSize: 12.0,
                              color: Colors.black,
                            ),
                          ), //`Text` to display
                          onPressed: () {},
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: FlatButton.icon(
                          color: Colors.transparent,
                          icon: new IconTheme(
                            data: new IconThemeData(color: Colors.red),
                            child: new Icon(LineIcons.edit),
                          ),
                          label: Text(
                            jadwal.penguji1! + '\n' + jadwal.penguji2!,
                            style: new TextStyle(
                              fontSize: 12.0,
                              color: Colors.black,
                            ),
                          ), //`Text` to display
                          onPressed: () {},
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: FlatButton.icon(
                          color: Colors.transparent,
                          icon: new IconTheme(
                            data: new IconThemeData(color: Colors.green),
                            child: new Icon(LineIcons.clockAlt),
                          ),
                          label: Text(
                            jadwal.waktuMulai! + '\n' + jadwal.waktuSelesai!,
                            style: new TextStyle(
                              fontSize: 12.0,
                              color: Colors.black,
                            ),
                          ), //`Text` to display
                          onPressed: () {},
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: FlatButton.icon(
                          color: Colors.transparent,
                          icon: new IconTheme(
                            data: new IconThemeData(color: Colors.brown),
                            child: new Icon(LineIcons.home),
                          ),
                          label: Text(
                            jadwal.ruangan!,
                            style: new TextStyle(
                              fontSize: 12.0,
                              color: Colors.black,
                            ),
                          ), //`Text` to display
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )),
      ],
    );
  }

  Widget _tgl(Jadwal jadwal) {
    return new Positioned(
      left: 40.0,
      top: 12.0,
      child: Text(
        jadwal.tgl!,
        style: TextStyle(
          color: Colors.black.withOpacity(0.9),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _jenisUjian(Jadwal jadwal) {
    Color jenisUjian;
    if (jadwal.jenisUjian == 'Ujian Proposal') {
      jenisUjian = Colors.green;
    } else if (jadwal.jenisUjian == 'Ujian Pratesis') {
      jenisUjian = Colors.blue;
    } else {
      jenisUjian = Colors.red;
    }
    return new Positioned(
        right: 20.0,
        top: 12.0,
        child: Stack(children: [
          Padding(
            padding: const EdgeInsets.all(0.0),
          ),
          Center(
            child: Text(
              jadwal.jenisUjian!,
              style: TextStyle(
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ]));
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
        title: Text("Jadwal"),
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
