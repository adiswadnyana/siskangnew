import 'dart:convert';

class RegistrasiNew {
  String? jumlah;
  
   

  RegistrasiNew({this.jumlah });

 

  factory RegistrasiNew.fromJson(Map<String, dynamic> map) {
    return RegistrasiNew(
        jumlah: map["jumlah"]);
  }

  

}



List<RegistrasiNew> registrasiNewFromJson(String jsonData) {
  final  data = json.decode(jsonData);
  return List<RegistrasiNew>.from(data.map((item) => RegistrasiNew.fromJson(item)));
}



