import 'dart:convert';

class MasaStudi {
  String? nim;
  String? nama;
  String? foto; 
  String? tglAwalStudi; 
  String? tglAkhirStudi; 
  String? sisaMasaStudi; 
  String? status; 
  String? statusPenelitian; 
  String? email; 
  String? notelp; 

 

  MasaStudi({this.nim, this.nama,this.foto, this.tglAwalStudi, this.tglAkhirStudi, this.sisaMasaStudi,this.status,this.statusPenelitian,this.email,this.notelp});
  
   factory MasaStudi.fromJson(Map<String, dynamic> map) {
    return MasaStudi(
        nim: map["Nim"], 
        nama: map["Nama"],
        foto: map["Foto"],
        tglAwalStudi: map["tglAwalStudi"],
        tglAkhirStudi: map["tglAkhirStudi"],
        sisaMasaStudi: map["sisaMasaStudi"],
        status: map["Status"],
        statusPenelitian: map["status_penelitian"],
        email: map["Email"],
        notelp: map["no_telp"]
        );
  }

 
}

List<MasaStudi> masaStudiFromJson(String jsonData) {
  final  data = json.decode(jsonData);
  return List<MasaStudi>.from(data.map((item) => MasaStudi.fromJson(item)));
}





