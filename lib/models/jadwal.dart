import 'dart:convert';

class Jadwal {
  String? idJadwal;
  String? jenisUjian;
  String? nama; 
  String? fotoMhs; 
  String? topik; 
  String? judul; 
  String? pembimbing1;
  String? pembimbing2;
  String? penguji1;
  String? penguji2;
  String? ruangan;
  String? tgl;
  String? waktuMulai;
  String? waktuSelesai;

 

  Jadwal({this.idJadwal, this.jenisUjian, this.nama, this.fotoMhs, this.topik, this.judul,
  this.pembimbing1,this.pembimbing2,this.penguji1,this.penguji2, this.ruangan,this.tgl,
  this.waktuMulai,this.waktuSelesai});
  
   factory Jadwal.fromJson(Map<String, dynamic> map) {
    return Jadwal(
        idJadwal: map["idJadwal"], 
        jenisUjian: map["jenisUjian"], 
        nama: map["nama"],
        fotoMhs: map["fotoMhs"],
        topik: map["topik"],
        judul: map["judul"],
        pembimbing1: map["pembimbing1"],
        pembimbing2: map["pembimbing2"],
        penguji1: map["penguji1"],
        penguji2: map["penguji2"],
        ruangan: map["ruangan"],
        tgl: map["tgl"],
        waktuMulai: map["waktuMulai"],
        waktuSelesai: map["waktuSelesai"],
        );
  }

 
}

List<Jadwal> jadwalFromJson(String jsonData) {
  final  data = json.decode(jsonData);
  return List<Jadwal>.from(data.map((item) => Jadwal.fromJson(item)));
}





