import 'dart:async';
import 'dart:convert';
import 'package:SisKa/models/api/api_service.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:back_button_interceptor/back_button_interceptor.dart';

class DashboardScreen extends StatefulWidget {
  @override
  DashboardScreen({Key? key}) : super(key: key);
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late BuildContext ctx;
  ApiService apiService = ApiService();
  List<Pengajuan> listPengajuan = <Pengajuan>[];
  List<PenelitianDash> listProposal = <PenelitianDash>[];
  List<PenelitianDash> listPratesis = <PenelitianDash>[];
  List<PenelitianDash> listTesis = <PenelitianDash>[];
  List<MhsDash> listMhsAktif = <MhsDash>[];
  List<MhsDash> listMhsNonAktif = <MhsDash>[];
  List<Topik> listTopik = <Topik>[];
  List<PembimbingDash> listPembimbing = <PembimbingDash>[];

  void initState() {
    super.initState();
    ctx = context;
    BackButtonInterceptor.add(myInterceptor);
    fetchData();
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  FutureOr<bool> myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    return true;
  }

  void fetchData() async {
    final listPengajuantemp = await apiService.getDashPengajuan();
    final listProposaltemp = await apiService.getDashProposal();
    final listPratesistemp = await apiService.getDashPratesis();
    final listtesistemp = await apiService.getDashTesis();
    final listMhsAktiftemp = await apiService.getDashMhsAktif();
    final listMhsNonAktiftemp = await apiService.getDashMhsNonAktif();
    final listTopiktemp = await apiService.getDashTopik();
    final listPembimbingtemp = await apiService.getDashPembimbing();
    if (this.mounted) {
      setState(() {
        listPengajuan = listPengajuantemp!;
        listProposal = listProposaltemp!;
        listPratesis = listPratesistemp!;
        listTesis = listtesistemp!;
        listMhsAktif = listMhsAktiftemp!;
        listMhsNonAktif = listMhsNonAktiftemp!;
        listTopik = listTopiktemp!;
        listPembimbing = listPembimbingtemp!;
      });
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: ListView(children: <Widget>[
        Container(
          child: Container(
            child: Column(children: <Widget>[
              SizedBox(
                height: 15.0,
              ),
              _getkontenJumlahMhs(context),
              SizedBox(
                height: 15.0,
              ),
              _getkonten(context),
              SizedBox(
                height: 15.0,
              ),
              _getkontenJenjangPenelitian(context),
              SizedBox(
                height: 15.0,
              ),
              _getkontenTopik(context),
              SizedBox(
                height: 15.0,
              ),
              _getkontenPembimbing(context),
            ]),
          ),
        ),
      ]),
    );
  }

  Widget _getkonten(BuildContext context) {
    return Container(
      height: 300.0,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 5.0, right: 5.0),
            child: Material(
              elevation: 5.0,
              borderRadius: BorderRadius.circular(14.0),
              child: Container(
                padding: EdgeInsets.only(top: 10.0),
                // height: 150.0,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14.0),
                ),
                child: HorizontalBarLabelChart.withSampleData(listPengajuan),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getkontenJenjangPenelitian(BuildContext context) {
    return Container(
      height: 550.0,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 5.0, right: 5.0),
            child: Material(
              elevation: 5.0,
              borderRadius: BorderRadius.circular(14.0),
              child: Container(
                padding: EdgeInsets.only(top: 10.0),
                // height: 150.0,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14.0),
                ),
                child: HorizontalPatternForwardHatchBarChart.withSampleData(
                    listProposal, listPratesis, listTesis),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getkontenJumlahMhs(BuildContext context) {
    return Container(
      height: 300.0,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 5.0, right: 5.0),
            child: Material(
              elevation: 5.0,
              borderRadius: BorderRadius.circular(14.0),
              child: Container(
                padding: EdgeInsets.only(top: 10.0),
                // height: 150.0,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14.0),
                ),
                child:
                    MhsDashboard.withSampleData(listMhsAktif, listMhsNonAktif),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getkontenTopik(BuildContext context) {
    return Container(
      height: 550.0,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 5.0, right: 5.0),
            child: Material(
              elevation: 5.0,
              borderRadius: BorderRadius.circular(14.0),
              child: Container(
                padding: EdgeInsets.only(top: 10.0),
                // height: 150.0,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14.0),
                ),
                child: TopikPenelitian.withSampleData(listTopik),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getkontenPembimbing(BuildContext context) {
    return Container(
      height: 550.0,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 5.0, right: 5.0),
            child: Material(
              elevation: 5.0,
              borderRadius: BorderRadius.circular(14.0),
              child: Container(
                padding: EdgeInsets.only(top: 10.0),
                // height: 150.0,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14.0),
                ),
                child: Pembimbing.withSampleData(listPembimbing),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Horizontal bar chart with bar label renderer example and hidden domain axis.

class HorizontalBarLabelChart extends StatelessWidget {
  final List<charts.Series<dynamic, String>> seriesList;
  final bool? animate;

  HorizontalBarLabelChart(this.seriesList, {this.animate});

  /// Creates a [BarChart] with sample data and no transition.
  factory HorizontalBarLabelChart.withSampleData(List<Pengajuan> listdata) {
    return HorizontalBarLabelChart(
      createPengajuan(listdata),
      // Disable animations for image tests.
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return charts.BarChart(
      seriesList,
      animate: animate,
      vertical: false,
      behaviors: [
        charts.ChartTitle('Penelitian',
            behaviorPosition: charts.BehaviorPosition.top,
            titleOutsideJustification: charts.OutsideJustification.middle,
            innerPadding: 10),
      ],
      barRendererDecorator: charts.BarLabelDecorator<String>(),
      // Hide domain axis.
      domainAxis: charts.OrdinalAxisSpec(renderSpec: charts.NoneRenderSpec()),
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<Pengajuan, String>> createPengajuan(
      List<Pengajuan> listdata) {
    final data = listdata;

    return [
      charts.Series<Pengajuan, String>(
          id: 'Pengajuan',
          domainFn: (Pengajuan sales, _) => sales.year!,
          measureFn: (Pengajuan sales, _) => sales.sales,
          data: data,
          // Set a label accessor to control the text of the bar label.
          labelAccessorFn: (Pengajuan sales, _) =>
              '${sales.year}:' + ' ${sales.sales.toString()}')
    ];
  }
}

/// Sample ordinal data type.
class Pengajuan {
  final String? year;
  final int? sales;

  Pengajuan({this.year, this.sales});
  factory Pengajuan.fromJson(Map<String, dynamic> map) {
    return Pengajuan(
      year: map["angkatan"],
      sales: int.parse(map["total"]),
    );
  }
}

List<Pengajuan> pengajuanFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<Pengajuan>.from(data.map((item) => Pengajuan.fromJson(item)));
}

class HorizontalPatternForwardHatchBarChart extends StatelessWidget {
  final List<charts.Series<dynamic, String>> seriesList;
  final bool? animate;

  HorizontalPatternForwardHatchBarChart(this.seriesList, {this.animate});

  factory HorizontalPatternForwardHatchBarChart.withSampleData(
      List<PenelitianDash> listProposal,
      List<PenelitianDash> listPratesis,
      List<PenelitianDash> listTesis) {
    return HorizontalPatternForwardHatchBarChart(
      _createSampleData(listProposal, listPratesis, listTesis),
      // Disable animations for image tests.
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return charts.BarChart(
      seriesList,
      animate: animate,
      barGroupingType: charts.BarGroupingType.grouped,
      vertical: false,
      defaultInteractions: true,
      behaviors: [
        charts.SeriesLegend(position: charts.BehaviorPosition.bottom),
        charts.ChartTitle('Tahapan Penelitian',
            behaviorPosition: charts.BehaviorPosition.top,
            titleOutsideJustification: charts.OutsideJustification.middle,
            // Set a larger inner padding than the default (10) to avoid
            // rendering the text too close to the top measure axis tick label.
            // The top tick label may extend upwards into the top margin region
            // if it is located at the top of the draw area.
            innerPadding: 10),
      ],
      barRendererDecorator: charts.BarLabelDecorator<String>(),
      // Hide domain axis.
    );
  }

  /// Create series list with multiple series
  static List<charts.Series<PenelitianDash, String>> _createSampleData(
      List<PenelitianDash> listProposal,
      List<PenelitianDash> listPratesis,
      List<PenelitianDash> listTesis) {
    final proposalData = listProposal;

    final pratesisData = listPratesis;

    final tesisData = listTesis;

    return [
      charts.Series<PenelitianDash, String>(
          id: 'Proposal',
          domainFn: (PenelitianDash sales, _) => sales.year!,
          measureFn: (PenelitianDash sales, _) => sales.sales,
          data: proposalData,
          colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
          labelAccessorFn: (PenelitianDash sales, _) =>
              '${sales.sales.toString()}'),
      charts.Series<PenelitianDash, String>(
          id: 'Pratesis',
          domainFn: (PenelitianDash sales, _) => sales.year!,
          measureFn: (PenelitianDash sales, _) => sales.sales,
          data: pratesisData,
          colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
          labelAccessorFn: (PenelitianDash sales, _) =>
              '${sales.sales.toString()}'),
      charts.Series<PenelitianDash, String>(
          id: 'Tesis',
          domainFn: (PenelitianDash sales, _) => sales.year!,
          measureFn: (PenelitianDash sales, _) => sales.sales,
          data: tesisData,
          colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
          labelAccessorFn: (PenelitianDash sales, _) =>
              '${sales.sales.toString()}'),
    ];
  }
}

/// Sample ordinal data type.
class PenelitianDash {
  final String? year;
  final int? sales;

  PenelitianDash({this.year, this.sales});
  factory PenelitianDash.fromJson(Map<String, dynamic> map) {
    return PenelitianDash(
      year: map["angkatan"],
      sales: int.parse(map["total"]),
    );
  }
}

List<PenelitianDash> penelitianDashFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<PenelitianDash>.from(
      data.map((item) => PenelitianDash.fromJson(item)));
}

class MhsDashboard extends StatelessWidget {
  final List<charts.Series<dynamic, String>> seriesList;
  final bool? animate;

  MhsDashboard(this.seriesList, {this.animate});

  factory MhsDashboard.withSampleData(
      List<MhsDash> listAktif, List<MhsDash> listNonAktif) {
    return MhsDashboard(
      _createSampleData(listAktif, listNonAktif),
      // Disable animations for image tests.
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return charts.BarChart(
      seriesList,
      animate: animate,
      barGroupingType: charts.BarGroupingType.grouped,
      vertical: false,
      defaultInteractions: true,
      behaviors: [
        charts.SeriesLegend(position: charts.BehaviorPosition.bottom),
        charts.ChartTitle('Jumlah Mahasiswa',
            behaviorPosition: charts.BehaviorPosition.top,
            titleOutsideJustification: charts.OutsideJustification.middle,
            // Set a larger inner padding than the default (10) to avoid
            // rendering the text too close to the top measure axis tick label.
            // The top tick label may extend upwards into the top margin region
            // if it is located at the top of the draw area.
            innerPadding: 10),
      ],
      barRendererDecorator: charts.BarLabelDecorator<String>(),
      // Hide domain axis.
    );
  }

  /// Create series list with multiple series
  static List<charts.Series<MhsDash, String>> _createSampleData(
      List<MhsDash> listAktif, List<MhsDash> listNonAktif) {
    final proposalData = listAktif;

    final pratesisData = listNonAktif;

    return [
      charts.Series<MhsDash, String>(
          id: 'Aktif',
          domainFn: (MhsDash sales, _) => sales.year!,
          measureFn: (MhsDash sales, _) => sales.sales,
          data: proposalData,
          colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
          labelAccessorFn: (MhsDash sales, _) => '${sales.sales.toString()}'),
      charts.Series<MhsDash, String>(
          id: 'Tidak Aktif',
          domainFn: (MhsDash sales, _) => sales.year!,
          measureFn: (MhsDash sales, _) => sales.sales,
          data: pratesisData,
          colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
          labelAccessorFn: (MhsDash sales, _) => '${sales.sales.toString()}'),
    ];
  }
}

/// Sample ordinal data type.
class MhsDash {
  final String? year;
  final int? sales;

  MhsDash({this.year, this.sales});
  factory MhsDash.fromJson(Map<String, dynamic> map) {
    return MhsDash(
      year: map["angkatan"],
      sales: int.parse(map["total"]),
    );
  }
}

List<MhsDash> mhsDashFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<MhsDash>.from(data.map((item) => MhsDash.fromJson(item)));
}

//chart topik penelitian
class TopikPenelitian extends StatelessWidget {
  final List<charts.Series<dynamic, String>> seriesList;
  final bool? animate;

  TopikPenelitian(this.seriesList, {this.animate});

  /// Creates a [BarChart] with sample data and no transition.
  factory TopikPenelitian.withSampleData(List<Topik> listdata) {
    return TopikPenelitian(
      createTopik(listdata),
      // Disable animations for image tests.
      animate: false,
    );
  }

  // [BarLabelDecorator] will automatically position the label
  // inside the bar if the label will fit. If the label will not fit and the
  // area outside of the bar is larger than the bar, it will draw outside of the
  // bar. Labels can always display inside or outside using [LabelPosition].
  //
  // Text style for inside / outside can be controlled independently by setting
  // [insideLabelStyleSpec] and [outsideLabelStyleSpec].
  @override
  Widget build(BuildContext context) {
    return charts.BarChart(
      seriesList,
      animate: animate,
      vertical: false,
      behaviors: [
        charts.ChartTitle('Topik Penelitian',
            behaviorPosition: charts.BehaviorPosition.top,
            titleOutsideJustification: charts.OutsideJustification.middle,
            // Set a larger inner padding than the default (10) to avoid
            // rendering the text too close to the top measure axis tick label.
            // The top tick label may extend upwards into the top margin region
            // if it is located at the top of the draw area.
            innerPadding: 10),
      ],
      barRendererDecorator: charts.BarLabelDecorator<String>(),
      // Hide domain axis.
      domainAxis: charts.OrdinalAxisSpec(renderSpec: charts.NoneRenderSpec()),
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<Topik, String>> createTopik(List<Topik> listdata) {
    final data = listdata;

    return [
      charts.Series<Topik, String>(
          id: 'Penelitian',
          domainFn: (Topik sales, _) => sales.year!,
          measureFn: (Topik sales, _) => sales.sales,
          data: data,
          // Set a label accessor to control the text of the bar label.
          labelAccessorFn: (Topik sales, _) =>
              '${sales.year}:' + ' ${sales.sales.toString()}')
    ];
  }
}

/// Sample ordinal data type.
class Topik {
  final String? year;
  final int? sales;

  Topik({this.year, this.sales});
  factory Topik.fromJson(Map<String, dynamic> map) {
    return Topik(
      year: map["topik"],
      sales: int.parse(map["total"]),
    );
  }
}

List<Topik> topikFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<Topik>.from(data.map((item) => Topik.fromJson(item)));
}

//chart Pembimbing penelitian
class Pembimbing extends StatelessWidget {
  final List<charts.Series<dynamic, String>> seriesList;
  final bool? animate;

  Pembimbing(this.seriesList, {this.animate});

  /// Creates a [BarChart] with sample data and no transition.
  factory Pembimbing.withSampleData(List<PembimbingDash> listdata) {
    return Pembimbing(
      createPembimbing(listdata),
      // Disable animations for image tests.
      animate: false,
    );
  }

  // [BarLabelDecorator] will automatically position the label
  // inside the bar if the label will fit. If the label will not fit and the
  // area outside of the bar is larger than the bar, it will draw outside of the
  // bar. Labels can always display inside or outside using [LabelPosition].
  //
  // Text style for inside / outside can be controlled independently by setting
  // [insideLabelStyleSpec] and [outsideLabelStyleSpec].
  @override
  Widget build(BuildContext context) {
    return charts.BarChart(
      seriesList,
      animate: animate,
      vertical: false,
      behaviors: [
        charts.ChartTitle('Pembimbing I',
            behaviorPosition: charts.BehaviorPosition.top,
            titleOutsideJustification: charts.OutsideJustification.middle,
            // Set a larger inner padding than the default (10) to avoid
            // rendering the text too close to the top measure axis tick label.
            // The top tick label may extend upwards into the top margin region
            // if it is located at the top of the draw area.
            innerPadding: 10),
      ],
      barRendererDecorator: charts.BarLabelDecorator<String>(),
      // Hide domain axis.
      domainAxis: charts.OrdinalAxisSpec(renderSpec: charts.NoneRenderSpec()),
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<PembimbingDash, String>> createPembimbing(
      List<PembimbingDash> listdata) {
    final data = listdata;

    return [
      charts.Series<PembimbingDash, String>(
          id: 'Pembimbing',
          domainFn: (PembimbingDash sales, _) => sales.year!,
          measureFn: (PembimbingDash sales, _) => sales.sales,
          data: data,
          // Set a label accessor to control the text of the bar label.
          labelAccessorFn: (PembimbingDash sales, _) =>
              '${sales.year}:' + ' ${sales.sales.toString()}')
    ];
  }
}

/// Sample ordinal data type.
class PembimbingDash {
  final String? year;
  final int? sales;

  PembimbingDash({this.year, this.sales});
  factory PembimbingDash.fromJson(Map<String, dynamic> map) {
    return PembimbingDash(
      year: map["nama"],
      sales: int.parse(map["total"]),
    );
  }
}

List<PembimbingDash> pembimbingFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<PembimbingDash>.from(
      data.map((item) => PembimbingDash.fromJson(item)));
}
