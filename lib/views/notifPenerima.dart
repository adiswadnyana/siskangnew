import 'package:SisKa/_routing/routes.dart';
import 'package:SisKa/models/api/api_service.dart';
import 'package:SisKa/models/Notif.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:SisKa/utils/utils.dart';
import 'package:SisKa/views/demo.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:SisKa/notificationservice/local_notification_service.dart';

class NotifPenerimaScreen extends StatefulWidget {
  @override
  NotifPenerimaScreen({Key? key}) : super(key: key);
  _NotifPenerimaScreenState createState() => _NotifPenerimaScreenState();
}

class PushNotification {
  PushNotification({
    this.title,
    this.body,
  });
  String? title;
  String? body;
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
  String messageTitle = "Empty";
  String notificationAlert = "alert";
  String deviceTokenToSendPushNotification = "";
  List notifications = [];
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  void initState() {
    super.initState();

    // 1. This method call when app in terminated state and you get a notification
    // when you click on notification app open from terminated state and you can get notification data in this method

    FirebaseMessaging.instance.getInitialMessage().then(
      (message) {
        print("FirebaseMessaging.instance.getInitialMessage");
        if (message != null) {
          print("New Notification");
          if (message.data['_id'] != null) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => Demo(
                  id: message.data['_id'],
                ),
              ),
            );
          }
        }
      },
    );

    // 2. This method only call when App in forground it mean app must be opened
    FirebaseMessaging.onMessage.listen(
      (message) {
        print("FirebaseMessaging.onMessage.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data11 ${message.data}");
          LocalNotificationService.createanddisplaynotification(message);
        }
      },
    );

    // 3. This method only call when App in background and not terminated(not closed)
    FirebaseMessaging.onMessageOpenedApp.listen(
      (message) {
        print("FirebaseMessaging.onMessageOpenedApp.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data22 ${message.data['_id']}");
        }
      },
    );
  }

  Future<void> getDeviceTokenToSendNotification() async {
    final FirebaseMessaging _fcm = FirebaseMessaging.instance;
    final token = await _fcm.getToken();
    deviceTokenToSendPushNotification = token.toString();
    print("Token Value $deviceTokenToSendPushNotification");
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

  Future<void> onSetupFirebaseMessaging() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    print('User granted permission: ${settings.authorizationStatus}');
  }

  void listenForeground() {
    FirebaseMessaging.onMessage.listen((message) {
      if (message.notification != null) {
        setState(() {
          notifications.add(message.notification);
        });
        LocalNotificationService.createanddisplaynotification(message);
      }
    });
  }

  Widget build(BuildContext context) {
    getDeviceTokenToSendNotification();
    onSetupFirebaseMessaging();
    listenForeground();
    return Scaffold(
      appBar: _appBar(),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            elevation: 1.0,
            child: ListTile(
              leading: Icon(
                Icons.notifications,
                color: Colors.purple[300],
                size: 35.0,
              ),
              title: Text(
                notifications[index].title,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                notifications[index].body,
                style: TextStyle(
                  fontSize: 12.0,
                ),
              ),
            ),
          );
        },
      ),
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
