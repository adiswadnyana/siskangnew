import 'dart:convert';

class Penelitian {

  String? foto;
  String? judul;
  String? nama;
  String? angkatan;
  String? nim;
  String? topik;
  String? pembimbing1;
  String? pembimbing2;
  String? tglPengajuanProposal;
  String? statusPengajuanProposal;
  String? tglUploadProposal;
  String? verifikasiKelayakanKroposal;
  String? tglVerifikasiKelayakanProposal;
  String? verifikasiUjianProposal;
  String? tglVerifikasiUjianProposal;
  String? statusUjianProposal;
  String? verifikasiRevisiProposal;
  String? tglVerifikasiRevisiProposal;
  String? tglUploadPratesis;
  String? verifikasiPratesisKelayakan;
  String? tglVerifikasiPratesisKelayakan;
  String? statusPratesisUjian;
  String? tglStatusPratesisUjian;
  String? statusPratesisPevisi;
  String? tglStatusPratesisPevisi;
  String? tglTesisUpload;
  String? verifikasiTesisKelayakan;
  String? tglVerifikasiTesisKelayakan;
  String? tglTesisUjian;
  String? statusTesisUjian;
  String? verifikasiTesis;
  String? verifikasiTesisRevisi;
  String? tahapPenelitian;
  String? statusPenelitian;
  String? fileProposal;
  String? fileTesis;
   

 

  Penelitian({
  this.foto,
  this.judul,
  this.nama,
  this.angkatan,
  this.nim,
  this.topik,
  this.pembimbing1,
  this.pembimbing2,
  this.tglPengajuanProposal,
  this.statusPengajuanProposal,
  this.tglUploadProposal,
  this.verifikasiKelayakanKroposal,
  this.tglVerifikasiKelayakanProposal,
  this.verifikasiUjianProposal,
  this.tglVerifikasiUjianProposal,
  this.statusUjianProposal,
  this.verifikasiRevisiProposal,
  this.tglVerifikasiRevisiProposal,
  this.tglUploadPratesis,
  this.verifikasiPratesisKelayakan,
  this.tglVerifikasiPratesisKelayakan,
  this.statusPratesisUjian,
  this.tglStatusPratesisUjian,
  this.statusPratesisPevisi,
  this.tglStatusPratesisPevisi,
  this.tglTesisUpload,
  this.verifikasiTesisKelayakan,
  this.tglVerifikasiTesisKelayakan,
  this.tglTesisUjian,
  this.statusTesisUjian,
  this.verifikasiTesis,
  this.verifikasiTesisRevisi,
  this.tahapPenelitian,
  this.statusPenelitian,
  this.fileProposal,
  this.fileTesis,
  });
  
   factory Penelitian.fromJson(Map<String, dynamic> map) {
    return Penelitian(
    foto: map["foto"], 
    judul: map["judul"], 
    nama: map["nama"], 
    angkatan: map["angkatan"], 
    nim: map["nim"], 
    topik: map["topik"], 
    pembimbing1: map["pembimbing1"], 
    pembimbing2: map["pembimbing2"], 
    tglPengajuanProposal: map["tglPengajuanProposal"], 
    statusPengajuanProposal: map["statusPengajuanProposal"], 
    tglUploadProposal: map["tglUploadProposal"], 
    verifikasiKelayakanKroposal: map["verifikasiKelayakanKroposal"], 
    tglVerifikasiKelayakanProposal: map["tglVerifikasiKelayakanProposal"], 
    verifikasiUjianProposal: map["verifikasiUjianProposal"], 
    tglVerifikasiUjianProposal: map["tglVerifikasiUjianProposal"], 
    statusUjianProposal: map["statusUjianProposal"], 
    verifikasiRevisiProposal: map["verifikasiRevisiProposal"], 
    tglVerifikasiRevisiProposal: map["tglVerifikasiRevisiProposal"], 
    tglUploadPratesis: map["tglUploadPratesis"], 
    verifikasiPratesisKelayakan: map["verifikasiPratesisKelayakan"], 
    tglVerifikasiPratesisKelayakan: map["tglVerifikasiPratesisKelayakan"], 
    statusPratesisUjian: map["statusPratesisUjian"], 
    tglStatusPratesisUjian: map["tglStatusPratesisUjian"], 
    statusPratesisPevisi: map["statusPratesisPevisi"], 
    tglStatusPratesisPevisi: map["tglStatusPratesisPevisi"], 
    tglTesisUpload: map["tglTesisUpload"], 
    verifikasiTesisKelayakan: map["verifikasiTesisKelayakan"], 
    tglVerifikasiTesisKelayakan: map["tglVerifikasiTesisKelayakan"], 
    tglTesisUjian: map["tglTesisUjian"], 
    statusTesisUjian: map["statusTesisUjian"], 
    verifikasiTesis: map["verifikasiTesis"], 
    tahapPenelitian: map["tahapPenelitian"], 
    verifikasiTesisRevisi: map["verifikasiTesisRevisi"], 
    statusPenelitian: map["statusPenelitian"],
    fileProposal: map["file_proposal"],
    fileTesis: map["file_tesis"], 
  );
  }

 
}

List<Penelitian> penelitianFromJson(String jsonData) {
  final  data = json.decode(jsonData);
  return List<Penelitian>.from(data.map((item) => Penelitian.fromJson(item)));
}





