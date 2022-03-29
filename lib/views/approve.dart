import 'package:SisKa/models/api/api_service.dart';
import 'package:SisKa/models/approveReg.dart';
import 'package:SisKa/models/globalModel.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:SisKa/utils/utils.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter/cupertino.dart';

class ApproveScreen extends StatefulWidget {
  final String? idKontrak;
  const ApproveScreen({Key? key, this.idKontrak}) : super(key: key);
  _ApproveScreenState createState() => _ApproveScreenState();
}

class _ApproveScreenState extends State<ApproveScreen> {
  late BuildContext ctx;
  ApiService apiService = new ApiService();
  TextEditingController _textcari = new TextEditingController();
  List<ApproveReg> listData = <ApproveReg>[];
  List<ApproveReg> listDataUse = <ApproveReg>[];
  AssetImage? logoKet;
  String? ket;
  bool activeSearch = false;
  Color? warnaStatus;
  IconData? iconStatus;

  void initState() {
    super.initState();
    ctx = context;
    activeSearch = false;
    loadData();
    _textcari.addListener(() {
      filterData(_textcari.text);
    });
  }

  void filterData(String key) async {
    List<ApproveReg> listDataTemp = <ApproveReg>[];
    if (key.length >= 2) {
      listData.forEach((item) {
        if (item.nama!.toLowerCase().contains(key.toLowerCase()) ||
            item.nama!.toLowerCase().contains(key.toLowerCase())) {
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
    final listDataget = await apiService.getApproveReg();
    setState(() {
      activeSearch = false;
      listData = listDataget!;
    });
  }

  void setuju(String id, String nama, BuildContext context) async {
    showDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text("Konfirmasi"),
            content: Text("Yakin menyetujui registrasi atas nama " + nama),
            actions: <Widget>[
              CupertinoDialogAction(
                  isDefaultAction: true,
                  child: Text("Ya"),
                  onPressed: () {
                    apiService.approveDB(id, "1").then((isSuccess) {
                      setState(() {
                        showFlushbar("Informasi", "Data berhasil disimpan",
                            LineIcons.checkCircle, Colors.green, context);
                      });
                    });
                    Navigator.pushReplacementNamed(
                      context,
                      'homeAdmin',
                      arguments: 4,
                    );
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

  void tolak(String id, String nama, BuildContext context) async {
    showDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text("Konfirmasi"),
            content: Text("Yakin menolak registrasi atas nama " + nama),
            actions: <Widget>[
              CupertinoDialogAction(
                  isDefaultAction: true,
                  child: Text("Ya"),
                  onPressed: () {
                    apiService.approveDB(id, "0").then((isSuccess) {
                      setState(() {
                        showFlushbar("Informasi", "Data berhasil disimpan",
                            LineIcons.checkCircle, Colors.green, context);
                      });
                    });
                    Navigator.pop(context);
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
        future: apiService.getApproveReg(),
        builder:
            (BuildContext context, AsyncSnapshot<List<ApproveReg>?> snapshot) {
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

  Widget _buildListView(List<ApproveReg> aktivitas, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListView.builder(
        itemBuilder: (context, index) {
          ApproveReg jadwals = aktivitas[index];
          return Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Container(
                  width: MediaQuery.of(context).size.width,
                  child: _isi(jadwals, context),
                ),
              ],
            ),
          );
        },
        itemCount: aktivitas.length,
      ),
    );
  }

  Widget _isi(ApproveReg aktivitas, BuildContext context) {
    Widget setuju = _aksisetuju(aktivitas, context);
    Widget tolak = _aksiHapus(aktivitas, context);
    return Slidable(
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          // A SlidableAction can have an icon and/or a label.
          _aksisetuju(aktivitas, context),
          _aksiHapus(aktivitas, context),
        ],
      ),
      child: Container(color: Colors.white, child: _status(aktivitas, context)),
    );
  }

  Widget _aksisetuju(ApproveReg aktivitas, BuildContext context) {
    return SlidableAction(
        label: 'Setujui',
        backgroundColor: Colors.green,
        icon: Icons.check_circle,
        onPressed: (ctx) {
          setuju(aktivitas.id!, aktivitas.nama!, context);
        });
  }

  Widget _aksiHapus(ApproveReg aktivitas, BuildContext context) {
    return SlidableAction(
      label: 'Hapus',
      backgroundColor: Colors.red,
      icon: Icons.delete,
      onPressed: (ctx) => tolak(aktivitas.id!, aktivitas.nama!, context),
    );
  }

  Widget _status(ApproveReg aktivitas, BuildContext context) {
    return ListTile(
      leading: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: 70,
          minHeight: 70,
          maxWidth: 100,
          maxHeight: 100,
        ),
        child: Image.network(aktivitas.foto!, fit: BoxFit.cover),
      ),
      title: Text(aktivitas.nim! + '\n' + aktivitas.nama! + '\n'),
      subtitle: Text(aktivitas.email!),
    );
  }

//NetworkImage("http://194.31.53.130/siska_api/assets/images/no_image.png"),

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
        title: Text("Data Registrasi"),
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
