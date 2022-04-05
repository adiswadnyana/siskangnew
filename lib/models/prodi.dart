import 'dart:convert';

class Prodi {
  String? kode;
  String? nama;
  String? jenjang;

  Prodi({
    this.kode,
    this.nama,
    this.jenjang,
  });

  factory Prodi.fromJson(Map<String, dynamic> map) {
    return Prodi(kode: map["Kode"], nama: map["Nama"], jenjang: map["Jenjang"]);
  }

  Map<String, dynamic> toJson() {
    return {"Id": kode, "Nama": nama, "Nim": jenjang};
  }

  @override
  String toString() {
    return 'Profile{kode: $kode, nama: $nama, jenjang: $jenjang}';
  }
}

List<Prodi> prodiFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<Prodi>.from(data.map((item) => Prodi.fromJson(item)));
}

List<String> dataUser(String jsonData) {
  final data = json.decode(jsonData);
  return data;
}

String prodioJson(Prodi data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}
