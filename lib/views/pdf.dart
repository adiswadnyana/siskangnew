import 'package:flutter/material.dart';
import 'package:SisKa/models/penelitian.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  final String? url;
  const MyApp({Key? key, this.url}) : super(key: key);
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isLoading = true;
  List<Penelitian> listData = <Penelitian>[];
  String _url = '';

  @override
  void initState() {
    super.initState();
    _url = widget.url!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Lihat Dokumen'),
        ),
        body: Container(
            child: SfPdfViewer.network(_url,
                pageLayoutMode: PdfPageLayoutMode.single)));
  }
}
