import 'dart:convert';

class ApproveReg {
  String? id;
  String? nim;
  String? nama;
  String? foto;
  String? email;

  ApproveReg({this.id, this.nim, this.nama, this.foto, this.email});

  factory ApproveReg.fromJson(Map<String, dynamic> map) {
    return ApproveReg(
      id: map["Id"],
      nim: map["Nim"],
      nama: map["Nama"],
      foto: map["Foto"],
      email: map["Email"],
    );
  }
}

List<ApproveReg> approveRegFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<ApproveReg>.from(data.map((item) => ApproveReg.fromJson(item)));
}
