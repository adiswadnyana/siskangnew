import 'dart:convert';

class UserAll {
  String? id;
  String? nama; 
  String? jabatan;
  String? username;
  String? foto;
   

 

  UserAll({this.id, this.nama, this.jabatan, this.username,this.foto});
  
   factory UserAll.fromJson(Map<String, dynamic> map) {
    return UserAll(
        id: map["Id"], 
        nama: map["Nama"], 
        jabatan: map["Jabatan"],
        username: map["Username"],
        foto: map["Foto"],
        );
  }

 
}

List<UserAll> userAllFromJson(String jsonData) {
  final  data = json.decode(jsonData);
  return List<UserAll>.from(data.map((item) => UserAll.fromJson(item)));
}





