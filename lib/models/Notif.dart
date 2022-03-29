import 'dart:convert';

class Notif {
  String? idPesan;
  String? idDetil;
  String? judul;
  String? isi; 
  String? tglKirim; 
  String? jenisPesan; 
  String? sukses; 
  String? gagal;
  String? calon;
  String? isRead;
 

  Notif({
   this.idPesan,
    this.idDetil,
   this.judul,
   this.isi, 
   this.tglKirim,
   this.jenisPesan, 
   this.sukses, 
   this.gagal,
   this.calon,
   this.isRead

  });
  
   factory Notif.fromJson(Map<String, dynamic> map) {
    return Notif(
      idPesan: map["idPesan"],
      idDetil: map["idDetil"],
      judul: map["judul"],
      isi: map["isi"], 
      tglKirim: map["tglKirim"],
      jenisPesan: map["jenisPesan"], 
      sukses: map["sukses"], 
      gagal: map["gagal"],
      calon: map["calon"],
      isRead: map["is_read"],
    );
  }

 
 
}

List<Notif> notifFromJson(String jsonData) {
  final  data = json.decode(jsonData);
  return List<Notif>.from(data.map((item) => Notif.fromJson(item)));
}






