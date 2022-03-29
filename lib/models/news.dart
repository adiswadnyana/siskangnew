import 'dart:convert';

class News {
  String? idBerita;
  String? judulBerita;
  String? detailBerita; 
  String? fotoBerita; 
  String? fileBerita; 
  String? tglBerita; 
  String? statusBerita;
 

  News({this.idBerita, this.judulBerita, this.detailBerita, this.fotoBerita, this.fileBerita, this.tglBerita,this.statusBerita});
  
   factory News.fromJson(Map<String, dynamic> map) {
    return News(
        idBerita: map["idBerita"], judulBerita: map["judulBerita"], detailBerita: map["detailBerita"], fotoBerita: map["fotoBerita"], fileBerita: map["fileBerita"],tglBerita: map["tglBerita"],statusBerita: map["statusBerita"]);
  }

  Map<String, dynamic> toJson() {
    return {"idBerita": idBerita, "judulBerita":judulBerita, "detailBerita":detailBerita,"fotoBerita":fotoBerita,"fileBerita":fileBerita, "tglBerita":tglBerita,"statusBerita":statusBerita};
  }

  @override
  String toString() {
    return 'News{idBerita: $idBerita, judulBerita: $judulBerita, detailBerita: $detailBerita, fotoBerita: $fotoBerita,fileBerita: $fileBerita,tglBerita: $statusBerita,tglBerita: $statusBerita}';
  }
}

List<News> newsFromJson(String jsonData) {
  final  data = json.decode(jsonData);
  return List<News>.from(data.map((item) => News.fromJson(item)));
}



List<News> dataNews(String jsonData) {
  final data = json.decode(jsonData);
  return data;
}

String newstooJson(News data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}


