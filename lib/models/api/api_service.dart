// ignore_for_file: unnecessary_new

import 'package:SisKa/models/profile.dart';
import 'package:SisKa/models/prodi.dart';
import 'package:SisKa/models/news.dart';
import 'package:SisKa/models/jadwal.dart';
import 'package:SisKa/models/approveReg.dart';
import 'package:SisKa/models/Notif.dart';
import 'package:SisKa/models/penelitian.dart';
import 'package:SisKa/models/timelineModel.dart';
import 'package:SisKa/models/notifUnread.dart';
import 'package:SisKa/models/registrasiNew.dart';
import 'package:SisKa/models/masaStudi.dart';
import 'package:SisKa/models/masaStudiCount.dart';
import 'package:SisKa/models/userAll.dart';
import 'package:SisKa/views/dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:http/http.dart' show Client;
import 'package:http/http.dart' as http;
import 'package:async/async.dart';

class ApiService {
//final String baseUrl = "https://siskangv6.project-symphony.com";
//final String baseUrl = "http://194.31.53.130/siska_api/index.php";
  final String baseUrl = "http://siska-ng.tech/";

  Client client = Client();

  Future<bool> login(var data) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final url = Uri.parse("$baseUrl/Siska_api/login");
    final response = await client.post(url, body: data);
    if (response.body == "null") {
      return false;
    } else {
      Map<String, dynamic>? user = jsonDecode(response.body);
      if (user != null) {
        final jabatan = '${user['jabatan']}';
        if (jabatan == '1') {
          prefs.setString('IsAdmin', '1');
        } else {
          prefs.setString('IsAdmin', '0');
        }
        final namaus = prefs.setString('Nama', '${user['Nama']}!');
        print(namaus);
        prefs.setString('Nama', '${user['Nama']}');
        prefs.setString('Nim', '${user['Nim']}');
        prefs.setString('Id_prodi', '${user['Id_prodi']}');
        prefs.setString('Kode_prodi', '${user['Kode_prodi']}');
        prefs.setString('Email', '${user['Email']}');
        prefs.setString('Foto', '${user['Foto']}');
        prefs.setString('Username', '${user['Username']}');
        prefs.setString('Password', '${user['Password']}');
        prefs.setString('PasswordPlain', '${user['Passwordplain']}');
        prefs.setString('Nim_Nama', '${user['Nim_Nama']}');
        prefs.setString('Jabatan', '${user['jabatan']}');

        return true;
      } else {
        return false;
      }
    }
  }

  Future<bool> loginSa(var data) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final url = Uri.parse("$baseUrl/Siska_api/login_superadmin");
    final response = await client.post(url, body: data);
    if (response.body == "null") {
      return false;
    } else {
      await prefs.clear();
      Map<String, dynamic> user = jsonDecode(response.body);
      final nama = '${user['Nama']}!';
      print(nama);
      final namaus = prefs.setString('Nama', '${user['Nama']}!');
      print(namaus);
      prefs.setString('Nama', '${user['Nama']}');
      prefs.setString('Nim', '${user['Nim']}');
      prefs.setString('Id_prodi', '${user['Id_prodi']}');
      prefs.setString('Kode_prodi', '${user['Kode_prodi']}');
      prefs.setString('Email', '${user['Email']}');
      prefs.setString('Foto', '${user['Foto']}');
      prefs.setString('Username', '${user['Username']}');
      prefs.setString('Password', '${user['Password']}');
      prefs.setString('PasswordPlain', '${user['Passwordplain']}');
      prefs.setString('Nim_Nama', '${user['Nim_Nama']}');
      prefs.setString('Jabatan', '${user['jabatan']}');
      prefs.setString('IsAdmin', '1');
      return true;
    }
  }

  Future<String> register(File imageFile, var data) async {
    var stream =
        new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    // var stream  = new http.ByteStream(imageFile.openRead()); stream.cast();
    var length = await imageFile.length();
    var uri = Uri.parse("$baseUrl/Siska_api/upload_foto");
    var request = new http.MultipartRequest("POST", uri);
    var multipartFile = new http.MultipartFile('file', stream, length,
        filename: basename(imageFile.path));
    request.files.add(multipartFile);
    var response = await request.send();
    final respStr = await response.stream.bytesToString();

    Map<String, dynamic> user = data;
    final dataAdd = {
      'id_prodi': '${user['Kode_prodi']}',
      'angkatan': '${user['angkatan']}',
      'nama': '${user['nama']}',
      'email': '${user['email']}',
      'nim': '${user['nim']}',
      'password': '${user['password']}',
      'foto': respStr,
    };

    final url = Uri.parse("$baseUrl/Siska_api/registerAddDB");
    final responseAdd = await client.post(url, body: dataAdd);
    String status = jsonDecode(responseAdd.body);
    return status;
  }

  Future<List<Profile>?> getProfiles() async {
    var client = new http.Client();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final data = {
      'username': prefs.getString('Username'),
      'password': prefs.getString('PasswordPlain')
    };
    final url = Uri.parse("$baseUrl/Siska_api/login_profile");

    final response = await client.post(url, body: data);
    if (response.statusCode == 200) {
      client.close();
      return profileFromJson(response.body);
    } else {
      client.close();
      return null;
    }
  }

  Future<bool> getAuth() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final id = prefs.getString('Nama');
    if (id != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> approveDB(String id, String status) async {
    var client = new http.Client();
    final data = {'id': id, 'status': status};
    final url = Uri.parse("$baseUrl/Siska_api/ApproveregisterAddDB");

    final response = await client.post(url, body: data);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<String> getAuthJab() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final jab = prefs.getString('Jabatan');
    return jab!;
  }

  Future<bool> logOut() async {
    var client = new http.Client();
    final prefs = await SharedPreferences.getInstance();
    final data = {
      'jabatan': prefs.getString('Jabatan'),
      'nim': prefs.getString('Nim'),
      'token': 'LogOut'
    };
    final url = Uri.parse(
        "$baseUrl/https://siska-ng.tech/Siska_api/ApproveregisterAddDB");
    final response = await client.post(url, body: data);
    if (response.statusCode == 200) {
      await prefs.clear();
      client.close();
      return true;
    } else {
      await prefs.clear();
      client.close();
      return false;
    }
  }

  Future<bool> deletePesan(String idDetil) async {
    var client = new http.Client();
    final prefs = await SharedPreferences.getInstance();
    final data = {'id_detil': idDetil};
    final url = Uri.parse("$baseUrl/Siska_api/delete_pesan");
    final response = await client.post(url, body: data);
    if (response.statusCode == 200) {
      // await prefs.clear();
      client.close();
      return true;
    } else {
      return false;
    }
  }

  Future<List<UserAll>?> getUserAll(String jabatan) async {
    var client = new http.Client();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String idProdi = prefs.getString('Id_prodi')!;
    if (idProdi != null) {
      final data = {
        'id_prodi': prefs.getString('Id_prodi'),
        'jabatan': jabatan
      };
      final url = Uri.parse("$baseUrl/Siska_api/get_user_all");
      final response = await client.post(url, body: data);
      if (response.statusCode == 200) {
        //
        if (response.body == "0") {
          return [];
        } else {
          return userAllFromJson(response.body);
        }
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  Future<List<ApproveReg>?> getApproveReg() async {
    var client = new http.Client();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String idProdi = prefs.getString('Id_prodi')!;
    if (idProdi != null) {
      final data = {'id_prodi': prefs.getString('Id_prodi')};
      final url = Uri.parse("$baseUrl/Siska_api/get_user_all");
      final response = await client.post(
          Uri.parse("$baseUrl/Siska_api/get_registrasi_by_prodi"),
          body: data);
      String tes = response.body.replaceAll(" ", "");
      print(tes);
      if (response.statusCode == 200) {
        //
        if (response.body == "0") {
          return [];
        } else {
          return approveRegFromJson(response.body);
        }
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  Future<List<Prodi>?> getProdi() async {
    final data = {'Aktif': 'Aktif'};
    final url = Uri.parse("$baseUrl/Siska_api/get_user_all");
    final response = await client
        .post(Uri.parse("$baseUrl/Siska_api/get_prodi_all"), body: data);
    if (response.statusCode == 200) {
      return prodiFromJson(response.body);
    } else {
      return null;
    }
  }

  Future<bool> createProfile(Profile data) async {
    final url = Uri.parse("$baseUrl/api/profile");
    final response = await client.post(
      url,
      headers: {"content-type": "application/json"},
      body: profileToJson(data),
    );
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateProfile(Profile data) async {
    final url = Uri.parse("$baseUrl/api/profile/${data.id}");
    final response = await client.put(
      url,
      headers: {"content-type": "application/json"},
      body: profileToJson(data),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteProfile(int id) async {
    final url = Uri.parse("$baseUrl/api/profile/$id");
    final response = await client.delete(
      url,
      headers: {"content-type": "application/json"},
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<News>?> getNews() async {
    var client = new http.Client();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final data = {'id_prodi': prefs.getString('Id_prodi')};
    final url = Uri.parse("$baseUrl/Siska_api/get_user_all");
    final response =
        await client.post(Uri.parse("$baseUrl/Siska_api/getNews"), body: data);
    print(response.body);
    if (response.statusCode == 200) {
      client.close();
      if (response.body == "0") {
        return [];
      } else {
        return newsFromJson(response.body);
      }
    } else {
      return null;
    }
  }

  Future<List<Penelitian>?> getPenelitian() async {
    var client = new http.Client();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final data = {
      'id_prodi': prefs.getString('Id_prodi'),
      'nim': prefs.getString('Nim'),
    };
    final url = Uri.parse("$baseUrl/Siska_api/get_user_all");
    final response = await client.post(
        Uri.parse("$baseUrl/Siska_api/get_timeline_penelitian"),
        body: data);
    print(response.body);
    if (response.statusCode == 200) {
      client.close();
      if (response.body == "0") {
        return [];
      } else {
        return penelitianFromJson(response.body);
      }
    } else {
      return null;
    }
  }

  Future<List<TimelineModelData>?> getTimeline(String idPen) async {
    var client = new http.Client();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String nim = "-";
    if (idPen == "Mhs") {
      nim = prefs.getString('Nim')!;
    } else {
      nim = idPen;
    }
    final data = {'nim': nim};
    final url = Uri.parse("$baseUrl/Siska_api/get_user_all");
    final response = await client.post(
        Uri.parse("$baseUrl/Siska_api/get_timeline_penelitian_by_nim"),
        body: data);
    print(response.body);
    if (response.statusCode == 200) {
      client.close();
      return timelineFromJson(response.body);
    } else {
      return null;
    }
  }

  Future<List<Jadwal>?> getJadwal() async {
    var client = new http.Client();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final data = {
      'id_prodi': prefs.getString('Id_prodi'),
      'nim': prefs.getString('Nim'),
    };
    final url = Uri.parse("$baseUrl/Siska_api/get_user_all");
    final response = await client
        .post(Uri.parse("$baseUrl/Siska_api/getJadwal"), body: data);

    print(response.body);
    if (response.statusCode == 200) {
      client.close();
      if (response.body == "0") {
        return [];
      } else {
        return jadwalFromJson(response.body);
      }
    } else {
      return null;
    }
  }

  Future<bool> updateToken(String token) async {
    var client = new http.Client();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final data = {
      'jabatan': prefs.getString('Jabatan'),
      'nim': prefs.getString('Nim'),
      'token': token
    };
    final url = Uri.parse("$baseUrl/Siska_api/token_update");
    final response = await client.post(url, body: data);
    print(response.body);
    if (response.statusCode == 200) {
      client.close();
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateread(String idPesan) async {
    var client = new http.Client();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final data = {'nim': prefs.getString('Nim'), 'id_pesan': idPesan};

    final url = Uri.parse("$baseUrl/Siska_api/read_pesan");
    final response = await client.post(url, body: data);
    if (response.statusCode == 200) {
      client.close();
      return true;
    } else {
      return false;
    }
  }

  Future<List<Notif>?> getNotif() async {
    var client = new http.Client();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String idProdi = prefs.getString('Id_prodi')!;
    if (idProdi != null) {
      final data = {
        'id_prodi': prefs.getString('Id_prodi'),
        'nim': prefs.getString('Nim'),
      };
      final url = Uri.parse("$baseUrl/Siska_api/get_notif_penerima");
      final response = await client.post(url, body: data);
      if (response.statusCode == 200) {
        client.close();
        if (response.body == "0") {
          return [];
        } else {
          return notifFromJson(response.body);
        }
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  Future<List<MasaStudi>?> getMasaStudi() async {
    var client = new http.Client();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final data = {
      'id_prodi': prefs.getString('Id_prodi'),
      'nim': prefs.getString('Nim'),
      'jabatan': prefs.getString('Jabatan')
    };
    final url = Uri.parse("$baseUrl/Siska_api/get_masa_studi");
    final response = await client.post(url, body: data);
    if (response.statusCode == 200) {
      client.close();
      return masaStudiFromJson(response.body);
    } else {
      return null;
    }
  }

  Future<List<MasaStudiCount>?> getMasaStudiCount() async {
    var client = new http.Client();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final data = {
      'id_prodi': prefs.getString('Id_prodi'),
      'nim': prefs.getString('Nim'),
      'jabatan': prefs.getString('Jabatan')
    };
    final url = Uri.parse("$baseUrl/Siska_api/get_masa_studi_dosen_count");
    final response = await client.post(url, body: data);
    if (response.statusCode == 200) {
      client.close();
      return masaStudiCountFromJson(response.body);
    } else {
      return null;
    }
  }

  Future<List<NorifUnread>?> getNotifUnread() async {
    var client = new http.Client();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final data = {
      'nim': prefs.getString('Nim'),
    };
    final url = Uri.parse("$baseUrl/Siska_api/get_notif_penerima_unread");
    final response = await client.post(url, body: data);
    if (response.statusCode == 200) {
      client.close();
      return norifUnreadFromJson(response.body);
    } else {
      return null;
    }
  }

  Future<List<RegistrasiNew>?> getRegistrasiNew() async {
    var client = new http.Client();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final data = {
      'nim': prefs.getString('Nim'),
    };
    final url = Uri.parse("$baseUrl/Siska_api/get_registrasi_new");
    final response = await client.post(url, body: data);
    if (response.statusCode == 200) {
      client.close();
      return registrasiNewFromJson(response.body);
    } else {
      return null;
    }
  }

  Future<List<Pengajuan>?> getDashPengajuan() async {
    var client = new http.Client();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final data = {
      'id_prodi': prefs.getString('Id_prodi'),
    };
    final url = Uri.parse("$baseUrl/Siska_api/get_mhs_pengajuan_by_angkatan");
    final response = await client.post(url, body: data);
    if (response.statusCode == 200) {
      client.close();
      return pengajuanFromJson(response.body);
    } else {
      return null;
    }
  }

  Future<List<PenelitianDash>?> getDashProposal() async {
    var client = new http.Client();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final data = {
      'id_prodi': prefs.getString('Id_prodi'),
    };
    final url = Uri.parse("$baseUrl/Siska_api/get_mhs_proposal_by_angkatan");
    final response = await client.post(url, body: data);
    if (response.statusCode == 200) {
      client.close();
      return penelitianDashFromJson(response.body);
    } else {
      return null;
    }
  }

  Future<List<PenelitianDash>?> getDashPratesis() async {
    var client = new http.Client();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final data = {
      'id_prodi': prefs.getString('Id_prodi'),
    };
    final url = Uri.parse("$baseUrl/Siska_api/get_mhs_pratesis_by_angkatan");
    final response = await client.post(url, body: data);
    if (response.statusCode == 200) {
      client.close();
      return penelitianDashFromJson(response.body);
    } else {
      return null;
    }
  }

  Future<List<PenelitianDash>?> getDashTesis() async {
    var client = new http.Client();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final data = {
      'id_prodi': prefs.getString('Id_prodi'),
    };
    final url = Uri.parse("$baseUrl/Siska_api/get_mhs_tesis_by_angkatan");
    final response = await client.post(url, body: data);
    if (response.statusCode == 200) {
      client.close();
      return penelitianDashFromJson(response.body);
    } else {
      return null;
    }
  }

  Future<List<MhsDash>?> getDashMhsAktif() async {
    var client = new http.Client();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final data = {
      'id_prodi': prefs.getString('Id_prodi'),
    };
    final url = Uri.parse("$baseUrl/Siska_api/get_mhs_aktif_by_angkatan");
    final response = await client.post(url, body: data);
    if (response.statusCode == 200) {
      client.close();
      return mhsDashFromJson(response.body);
    } else {
      return null;
    }
  }

  Future<List<MhsDash>?> getDashMhsNonAktif() async {
    var client = new http.Client();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final data = {
      'id_prodi': prefs.getString('Id_prodi'),
    };
    final url = Uri.parse("$baseUrl/Siska_api/get_mhs_tidakaktif_by_angkatan");
    final response = await client.post(url, body: data);
    if (response.statusCode == 200) {
      client.close();
      return mhsDashFromJson(response.body);
    } else {
      return null;
    }
  }

  Future<List<Topik>?> getDashTopik() async {
    var client = new http.Client();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final data = {
      'id_prodi': prefs.getString('Id_prodi'),
    };
    final url = Uri.parse("$baseUrl/Siska_api/get_topik_penelitian");
    final response = await client.post(url, body: data);
    if (response.statusCode == 200) {
      client.close();
      return topikFromJson(response.body);
    } else {
      return null;
    }
  }

  Future<List<PembimbingDash>?> getDashPembimbing() async {
    var client = new http.Client();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final data = {
      'id_prodi': prefs.getString('Id_prodi'),
    };
    final url = Uri.parse("$baseUrl/Siska_api/get_total_pembimbing_1");
    final response = await client.post(url, body: data);
    if (response.statusCode == 200) {
      client.close();
      return pembimbingFromJson(response.body);
    } else {
      return null;
    }
  }

  Future<bool> notifSend(String judul, String isi, String kriteria) async {
    var client = new http.Client();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final data = {
      'id_prodi': prefs.getString('Id_prodi'),
      'id_admin': prefs.getString('Nim'),
      'judul': judul,
      'isi': isi,
      'kriteria': kriteria
    };
    final url = Uri.parse("$baseUrl/Siska_api/kirim_pesan");
    final response = await client.post(url, body: data);
    if (response.statusCode == 200) {
      client.close();
      return true;
    } else {
      return false;
    }
  }

  Future<String> settingProfile(File imageFile, var data) async {
    print(data);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> user = data;
    if (imageFile != null) {
      var stream = new http.ByteStream(Stream.castFrom(imageFile.openRead()));
      var length = await imageFile.length();
      var uri = Uri.parse("$baseUrl/Siska_api/upload_foto");
      var request = new http.MultipartRequest("POST", uri);
      var multipartFile = new http.MultipartFile('file', stream, length,
          filename: basename(imageFile.path));
      request.files.add(multipartFile);
      var response = await request.send();
      final respStr = await response.stream.bytesToString();
      final dataAdd = {
        'jabatan': prefs.getString('Jabatan'),
        'nim': prefs.getString('Nim'),
        'password': '${user['password']}',
        'no_telp': '${user['no_telp']}',
        'foto': respStr,
      };
      final url = Uri.parse("$baseUrl/Siska_api/settingProfileAddDB");
      final responseAdd = await client.post(url, body: dataAdd);
      String status = jsonDecode(responseAdd.body);
      return status;
    } else {
      final respStr = '${user['foto']}';
      final dataAdd = {
        'jabatan': prefs.getString('Jabatan'),
        'nim': prefs.getString('Nim'),
        'password': '${user['password']}',
        'no_telp': '${user['no_telp']}',
        'foto': respStr,
      };
      final url = Uri.parse("$baseUrl/Siska_api/settingProfileAddDB");
      final responseAdd = await client.post(url, body: dataAdd);
      String status = jsonDecode(responseAdd.body);
      return status;
    }
  }
}
