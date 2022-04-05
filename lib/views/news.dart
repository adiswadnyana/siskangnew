import 'package:SisKa/models/api/api_service.dart';
import 'package:SisKa/models/news.dart';
import 'package:flutter/material.dart';
import 'package:SisKa/_routing/routes.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:SisKa/utils/utils.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

class NewsScreen extends StatefulWidget {
  @override
  NewsScreen({Key? key}) : super(key: key);
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  // final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  TextEditingController _textcari = new TextEditingController();
  ApiService apiService = new ApiService();
  List<News> listData = <News>[];
  List<News> listDataUse = <News>[];
  AssetImage? logoKet;
  String? ket;
  bool activeSearch = false;

  void initState() {
    super.initState();
    BackButtonInterceptor.add(myInterceptor);
    activeSearch = false;
    fetchNews();
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

  void fetchNews() async {
    //     _firebaseMessaging.getToken().then((token){
    //       apiService.updateToken(token!);
    //       });

    //   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //    print("onMessage: $message");
    //   });
    // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    //    print("onResume: $message");
    // });
  }

  void filterData(String key) async {
    List<News> listDataTemp = <News>[];
    if (key.length >= 2) {
      listData.forEach((item) {
        if (item.judulBerita!.toLowerCase().contains(key.toLowerCase()) ||
            item.tglBerita!.toLowerCase().contains(key.toLowerCase())) {
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
    final listDataget = await apiService.getNews();
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
        future: apiService.getNews(),
        builder: (BuildContext context, AsyncSnapshot<List<News>?> snapshot) {
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

  Widget _buildListView(List<News> newss, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
      child: ListView.builder(
        itemBuilder: (context, index) {
          News news = newss[index];
          return Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(top: 10.0),
                    height: 200.0,
                    width: MediaQuery.of(context).size.width,
                    child: Stack(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 5.0),
                          child: Material(
                            elevation: 5.0,
                            borderRadius: BorderRadius.circular(14.0),
                            child: Container(
                              padding: EdgeInsets.only(top: 20.0, left: 100.0),
                              height: 200.0,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(14.0),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(height: 8),
                                  Flexible(
                                    child: RichText(
                                      // overflow: TextOverflow.visible,
                                      strutStyle: StrutStyle(fontSize: 12.0),
                                      text: TextSpan(
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16.0),
                                          text: news.judulBerita),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Container(
                                    height: 105.0,
                                    width: MediaQuery.of(context).size.width,
                                    child: new GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            Navigator.pushNamed(
                                              context,
                                              newsDetailsViewRoute,
                                              arguments: news.idBerita,
                                            );
                                          });
                                        },
                                        child: HtmlWidget(news.detailBerita!)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 0,
                          top: 15.0,
                          child: InkWell(
                            onTap: () => setState(() {
                              Navigator.pushNamed(
                                context,
                                newsDetailsViewRoute,
                                arguments: news.idBerita,
                              );
                            }),
                            child: Hero(
                              tag: NetworkImage(news.fotoBerita!),
                              child: Material(
                                elevation: 2.0,
                                borderRadius: BorderRadius.circular(10.0),
                                child: Container(
                                  height: 100.0,
                                  width: 100.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14.0),
                                    image: DecorationImage(
                                      image: NetworkImage(news.fotoBerita!),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        _hotnews(news),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        itemCount: newss.length,
      ),
    );
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
        title: Text("Berita"),
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

  Widget _hotnews(News news) {
    return new Positioned(
      right: 5.0,
      top: 5.0,
      child: Text(
        news.tglBerita!,
        style: TextStyle(
          color: Colors.grey.withOpacity(0.6),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
