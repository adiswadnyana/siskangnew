import 'dart:convert';

class MasaStudiCount {
  String? pengajuan;
  String? proposal;
  String? pratesis;
  String? tesis;
  String? wisuda;

  MasaStudiCount(
      {this.pengajuan, this.proposal, this.pratesis, this.tesis, this.wisuda});

  factory MasaStudiCount.fromJson(Map<String, dynamic> map) {
    return MasaStudiCount(
        pengajuan: map["pengajuan"],
        proposal: map["proposal"],
        pratesis: map["pratesis"],
        tesis: map["tesis"],
        wisuda: map["wisuda"]);
  }
}

List<MasaStudiCount> masaStudiCountFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<MasaStudiCount>.from(
      data.map((item) => MasaStudiCount.fromJson(item)));
}
