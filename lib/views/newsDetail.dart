import 'package:flutter/material.dart';
import 'package:SisKa/utils/colors.dart';
import 'package:SisKa/models/api/api_service.dart';
import 'package:SisKa/models/news.dart';
import 'package:line_icons/line_icons.dart';
import 'package:SisKa/utils/utils.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';

class NewsDetailPage extends StatefulWidget {
  final String? userId;
  const NewsDetailPage({Key? key, this.userId}) : super(key: key);
  _NewsDetailPageState createState() => _NewsDetailPageState();
}

class _NewsDetailPageState extends State<NewsDetailPage> {
  ApiService apiService = new ApiService();
  List<News> listData = <News>[];
  ApiService _apiService = ApiService();
  String? _judul;
  String? _detail;
  String? _foto;
  String? _file;

  void initState() {
    super.initState();
    BackButtonInterceptor.add(myInterceptor);
    loadData();
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo routeInfo) {
    return true;
  }

  void loadData() async {
    final listDataget = await apiService.getNews();
    final News datas = listDataget!
        .singleWhere((datas) => datas.idBerita == widget.userId.toString());
    setState(() {
      listData = listDataget;
      _judul = datas.judulBerita;
      _foto = datas.fotoBerita;
      _file = datas.fileBerita;
    });
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _getkonten(context),
          ],
        ),
      ),
    );
  }

  Widget _getkonten(BuildContext context) {
    return FutureBuilder(
      future: apiService.getNews(),
      builder: (BuildContext context, AsyncSnapshot<List<News>?> snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Stack(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(top: 50.0),
                  height: 100.0,
                  width: 100.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AvailableImages.errorimg,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Text("Terjadi Kesalahan...")
              ],
            ),
          );
        } else if (snapshot.connectionState == ConnectionState.done) {
          final News datas = snapshot.data!.singleWhere(
              (datas) => datas.idBerita == widget.userId.toString());
          return _buildListView(datas, context);
        } else {
          return Center(
            child: CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(Colors.blueAccent),
            ),
          );
        }
      },
    );
  }

  Widget _buildListView(News detail, BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: <Widget>[
        Hero(
          tag: detail.fotoBerita!,
          child: Container(
            padding: EdgeInsets.only(right: 15.0, left: 15.0),
            height: 350.0,
            width: deviceWidth,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(detail.fotoBerita!),
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
        Positioned(
          top: 50.0,
          left: 20.0,
          child: Container(
            height: 35.0,
            width: 35.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey.withOpacity(0.5),
            ),
            child: IconButton(
              icon: Icon(LineIcons.doorClosed, color: Colors.white),
              onPressed: () => Navigator.pop(context),
              iconSize: 20.0,
            ),
          ),
        ),
        Container(
          padding:
              EdgeInsets.only(right: 15.0, left: 15.0, top: 400.0, bottom: 10),
          child: new Column(
            children: <Widget>[
              Text(
                detail.judulBerita!,
                style: TextStyle(
                    fontSize: 16,
                    shadows: [
                      Shadow(
                          color: Colors.black26,
                          offset: Offset(0, 3),
                          blurRadius: 3)
                    ],
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Padding(
          padding:
              EdgeInsets.only(top: 450.0, left: 15.0, right: 15.0, bottom: 10),
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(12.0),
            shadowColor: Colors.white,
            child: Container(
              padding: EdgeInsets.all(15.0),
              width: deviceWidth,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: Colors.white,
              ),
              constraints: BoxConstraints(minHeight: 100.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 2.0,
                  ),
                  new Center(
                    child: SingleChildScrollView(
                      child: HtmlWidget(
                        detail.detailBerita!,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 2.0,
                  ),
                  new Center(
                    child: Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: FlatButton.icon(
                        color: Colors.white,
                        icon: new IconTheme(
                          data: new IconThemeData(color: Colors.blue),
                          child: new Icon(LineIcons.download),
                        ),
                        label: Text(
                          "File Berita",
                          style: new TextStyle(
                            fontSize: 12.0,
                            color: Colors.blue,
                          ),
                        ), //`Text` to display
                        onPressed: () {
                          _launchURL(_file!);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
