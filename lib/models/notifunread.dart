import 'dart:convert';

class NorifUnread {
  String? jumlah;
  
   

  NorifUnread({this.jumlah });

 

  factory NorifUnread.fromJson(Map<String, dynamic> map) {
    return NorifUnread(
        jumlah: map["jumlah"]);
  }

  

}



List<NorifUnread> norifUnreadFromJson(String jsonData) {
  final  data = json.decode(jsonData);
  return List<NorifUnread>.from(data.map((item) => NorifUnread.fromJson(item)));
}



