import 'dart:convert';

class News2 {
  String? idBerita;
  String? judulBerita;
  String? detailBerita; 
  String? fotoBerita; 
  String? fileBerita; 
  String? tglBerita; 
  String? statusBerita;
  
   

  News2({this.idBerita, this.judulBerita, this.detailBerita, this.fotoBerita, this.fileBerita, this.tglBerita,this.statusBerita});

 

  factory News2.fromJson(Map<String, dynamic> map) {
    return News2(
        idBerita: map["idBerita"], judulBerita: map["judulBerita"], detailBerita: map["detailBerita"], fotoBerita: map["fotoBerita"], fileBerita: map["fileBerita"],tglBerita: map["tglBerita"],statusBerita: map["statusBerita"]);
  }

  Map<String, dynamic> toJson() {
    return {"idBerita":idBerita, "judulBerita": judulBerita, "detailBerita":detailBerita,"fotoBerita":fotoBerita,"fileBerita":fileBerita,"tglBerita":tglBerita,"statusBerita":statusBerita};
  }


  @override
  String toString() {
    return 'News{idBerita: $idBerita, judulBerita: $judulBerita, detailBerita: $detailBerita, fotoBerita: $fotoBerita,fileBerita: $fileBerita,tglBerita: $statusBerita,tglBerita: $statusBerita}';
  }

}



List<News2> newsFromJson(String jsonData) {
  final  data = json.decode(jsonData);
  return List<News2>.from(data.map((item) => News2.fromJson(item)));
}



List<String> dataUser(String jsonData) {
  final data = json.decode(jsonData);
  return data;
}

String newsioJson(News2 data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}
