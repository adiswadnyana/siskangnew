import 'dart:convert';

class Profile {
  String? id;
  String? nama;
  String? nim;
  String? idProdi;
  String? namaProdi;
  String? email;
  String? foto;
  String? username;
  String? password;
  String? nimNama;
  String? noTelp;
   

  Profile({this.id , this.nama, this.nim, this.idProdi, this.namaProdi, this.email,
          this.foto,  this.username,  this.password,  this.nimNama,  this.noTelp});

 

  factory Profile.fromJson(Map<String, dynamic> map) {
    return Profile(
        id: map["Id"], nama: map["Nama"], nim: map["Nim"], idProdi: map["Id_prodi"],namaProdi: map["Nama_prodi"],
        email: map["Email"],foto: map["Foto"],username: map["Username"],password: map["Password"],
        nimNama: map["Nim_Nama"], noTelp: map["no_telp"]);
  }

  Map<String, dynamic> toJson() {
    return {"Id":id, "Nama":nama, "Nim":nim, "Id_prodi":idProdi, "Nama_prodi":namaProdi,
              "Email":email,"Foto":foto,"Username":username,"Password":password,
              "Nim_Nama":nimNama
              };
  }

  @override
  String toString() {
    return 'Profile{id: $id, nama: $nama, nim: $nim, idProdi: $idProdi,namaProdi: $namaProdi, email: $email,foto: $foto,username: $username,nimNama: $nimNama, }';
  }

}



List<Profile> profileFromJson(String jsonData) {
  final  data = json.decode(jsonData);
  return List<Profile>.from(data.map((item) => Profile.fromJson(item)));
}



List<String> dataUser(String jsonData) {
  final data = json.decode(jsonData);
  return data;
}

String profileToJson(Profile data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}
