import 'package:flutter/material.dart';
import 'package:SisKa/models/penelitian.dart';
import 'package:line_icons/line_icons.dart';

class TimelineModelData {
  final String? name;
  final String? time;
  final String? status;
  final Color? iconBackground;
  final Icon? icon;
  final Icon? backicon;
  const TimelineModelData(
      {this.name,
      this.time,
      this.status,
      this.icon,
      this.backicon,
      this.iconBackground});
}


List<TimelineModelData> timelineFromJson(String jsonData) {
 List<Penelitian> list =  penelitianFromJson(jsonData);
 Penelitian datas =  list[0];
return [
  TimelineModelData(
      name: "Pengajuan Proposal",
      time: datas.tglPengajuanProposal != "Undecided" ? datas.tglPengajuanProposal : "",
      status: datas.statusPengajuanProposal,
      icon: datas.tglPengajuanProposal!="Undecided"? 
                    const Icon(Icons.check,
                    color: Colors.white,
                    size: 25, ):const Icon(LineIcons.times,
                    color: Colors.white,
                    size: 25, ),
      iconBackground: datas.tglPengajuanProposal!="Undecided"? Colors.green:Colors.red
      ),

      TimelineModelData(
      name: "Upload Proposal",
      time: datas.tglPengajuanProposal != "Undecided" ? datas.tglPengajuanProposal : "",
      status: datas.verifikasiKelayakanKroposal,    
      icon: datas.tglPengajuanProposal!="Undecided"? 
                    const Icon(Icons.check,
                    color: Colors.white,
                    size: 25, ):const Icon(LineIcons.times,
                    color: Colors.white,
                    size: 25, ),
      iconBackground: datas.verifikasiKelayakanKroposal!="Undecided"? Colors.green:Colors.red
      ),
 
 
  TimelineModelData(
      name: "Ujian Proposal",
      time: datas.tglVerifikasiUjianProposal != "Undecided" ? datas.tglVerifikasiUjianProposal : "",
      status: datas.statusUjianProposal,
     icon: datas.tglVerifikasiUjianProposal!="Undecided"? 
                    const Icon(Icons.check,
                    color: Colors.white,
                    size: 25, ):const Icon(LineIcons.times,
                    color: Colors.white,
                    size: 25, ),
      iconBackground: datas.tglVerifikasiUjianProposal!="Undecided"? Colors.green:Colors.red
      ),
 
  TimelineModelData(
      name: "Revisi Proposal",
      time: datas.tglVerifikasiRevisiProposal != "Undecided" ? datas.tglVerifikasiRevisiProposal : "",
      status: datas.verifikasiRevisiProposal,
      icon: datas.tglVerifikasiRevisiProposal!="Undecided"? 
                    const Icon(Icons.check,
                    color: Colors.white,
                    size: 25, ):const Icon(LineIcons.times,
                    color: Colors.white,
                    size: 25,
      ),
      iconBackground: datas.tglVerifikasiRevisiProposal!="Undecided"? Colors.green:Colors.red
      ),

    TimelineModelData(
      name: "Upload Pratesis",
      time: datas.tglUploadPratesis != "Undecided" ? datas.tglUploadPratesis : "",
      status: datas.verifikasiPratesisKelayakan,
     icon: datas.tglUploadPratesis!="Undecided"? 
                    const Icon(Icons.check,
                    color: Colors.white,
                    size: 25, ):const Icon(LineIcons.times,
                    color: Colors.white,
                    size: 25,
      ),
      iconBackground: datas.verifikasiPratesisKelayakan!="Undecided"? Colors.green:Colors.red
      ),

     TimelineModelData(
      name: "Ujian Pratesis",
      time: datas.tglStatusPratesisUjian != "Undecided" ? datas.tglStatusPratesisUjian : "",
      status: datas.statusPratesisUjian,
      icon: datas.tglStatusPratesisUjian!="Undecided"? 
                    const Icon(Icons.check,
                    color: Colors.white,
                    size: 25, ):const Icon(LineIcons.times,
                    color: Colors.white,
                    size: 25,
        ),
      iconBackground: datas.tglStatusPratesisUjian!="Undecided"? Colors.green:Colors.red
      ),

      TimelineModelData(
      name: "Revisi Pratesis",
      time: datas.tglStatusPratesisPevisi != "Undecided" ? datas.tglStatusPratesisPevisi : "",
      status: datas.statusPratesisPevisi,
      icon:  datas.tglStatusPratesisPevisi!="Undecided"? 
                    const Icon(Icons.check,
                    color: Colors.white,
                    size: 25, ):const Icon(LineIcons.times,
                    color: Colors.white,
                    size: 25,
        ),
      iconBackground: datas.tglStatusPratesisPevisi!="Undecided"? Colors.green:Colors.red
      ),

      TimelineModelData(
      name: "Upload Tesis",
      time: datas.tglTesisUpload != "Undecided" ? datas.tglTesisUpload : "",
      status: datas.verifikasiTesisKelayakan,
      icon: datas.tglTesisUpload!="Undecided"? 
                    const Icon(Icons.check,
                    color: Colors.white,
                    size: 25, ):const Icon(LineIcons.times,
                    color: Colors.white,
                    size: 25, ),
      iconBackground: datas.tglTesisUpload!="Undecided"? Colors.green:Colors.red
      ),

      TimelineModelData(
      name: "Ujian Tesis ",
      time: datas.tglTesisUjian != "Undecided" ? datas.tglTesisUjian : "",
      status: datas.statusTesisUjian,
      icon: datas.tglTesisUjian!="Undecided"? 
                    const Icon(Icons.check,
                    color: Colors.white,
                   size: 25, ):const Icon(LineIcons.times,
                    color: Colors.white,
                    size: 25, ),
      iconBackground: datas.tglTesisUjian!="Undecided"? Colors.green:Colors.red
      ),

      TimelineModelData(
      name: "Revisi Tesis ",
      time: datas.tglTesisUjian != "Undecided" ? datas.tglTesisUjian : "",
      status: datas.verifikasiTesisRevisi,
      icon: datas.tglTesisUjian!="Undecided"? 
                    const Icon(Icons.check,
                    color: Colors.white,
                    size: 25, ):const Icon(LineIcons.times,
                    color: Colors.white,
                    size: 25, ),
      iconBackground: datas.tglTesisUjian!="Undecided"? Colors.green:Colors.red
      ),

      TimelineModelData(
      name: "Wisuda ",
      time: datas.tglTesisUjian != "Undecided" ? datas.tglTesisUjian : "",
      icon: datas.tglTesisUjian!="Undecided"? 
                    const Icon(Icons.check,
                    color: Colors.white,
                    size: 25, ):const Icon(LineIcons.times,
                    color: Colors.white,
                    size: 25, ),
      iconBackground: datas.tglTesisUjian!="Undecided"? Colors.green:Colors.red
      ),
  
];
}

 