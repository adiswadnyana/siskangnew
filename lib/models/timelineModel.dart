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


//   return [
//   TimelineModelData(
//       name: "Proposal Submission",
//       time: datas.tglPengajuanProposal,
//       status: datas.statusPengajuanProposal,
//       icon: Icon(LineIcons.book, color: Colors.white),
//       backicon: datas.tglPengajuanProposal!="Undecided"? 
//                     Icon(Icons.check,
//                     color: Colors.green,
//                     size: 40, ):Icon(LineIcons.times,
//                     color: Colors.red,
//                     size: 40, ),
//       iconBackground: Colors.cyan
//       ),

//       TimelineModelData(
//       name: "Proposal File Upload",
//       time: datas.tglUploadProposal,  
//        status: datas.verifikasiKelayakanKroposal,    
//       icon: Icon(LineIcons.book, color: Colors.white),
//       backicon: datas.tglPengajuanProposal!="Undecided"? 
//                     Icon(Icons.check,
//                     color: Colors.green,
//                     size: 40, ):Icon(LineIcons.times,
//                     color: Colors.red,
//                     size: 40, ),
//       iconBackground: Colors.cyan
//       ),
 
 
//   TimelineModelData(
//       name: "Proposal Examination",
//       time: datas.tglVerifikasiUjianProposal,
//       status: datas.statusUjianProposal,
//      icon: Icon(
//         LineIcons.userSecret,
//         color: Colors.white,
//       ),
//       backicon: datas.tglVerifikasiUjianProposal!="Undecided"? 
//                     Icon(Icons.check,
//                     color: Colors.green,
//                     size: 40, ):Icon(LineIcons.times,
//                     color: Colors.red,
//                     size: 40, ),
//       iconBackground: Colors.green
//       ),
 
//   TimelineModelData(
//       name: "Proposal Revision",
//       time: datas.tglVerifikasiRevisiProposal,
//       status: datas.verifikasiRevisiProposal,
//      icon: Icon(
//         LineIcons.edit,
//         color: Colors.white,
//       ),
//       backicon: datas.tglVerifikasiRevisiProposal!="Undecided"? 
//                     Icon(Icons.check,
//                     color: Colors.green,
//                     size: 40, ):Icon(LineIcons.times,
//                     color: Colors.red,
//                     size: 40, ),
//       iconBackground: Colors.orange
//       ),

//     TimelineModelData(
//       name: "Pre-Thesis File Upload",
//       time: datas.tglUploadPratesis,
//       status: datas.verifikasiPratesisKelayakan,
//      icon: Icon(
//         LineIcons.book,
//         color: Colors.white,
//       ),
//       backicon: datas.tglUploadPratesis!="Undecided"? 
//                     Icon(Icons.check,
//                     color: Colors.green,
//                     size: 40, ):Icon(LineIcons.times,
//                     color: Colors.red,
//                     size: 40, ),
//       iconBackground: Colors.cyan
//       ),

//      TimelineModelData(
//       name: "Pre-Thesis Examination",
//       time: datas.tglStatusPratesisUjian,
//       status: datas.statusPratesisUjian,
//       icon: Icon(
//           LineIcons.userSecret,
//           color: Colors.white,
//         ),
//       backicon: datas.tglStatusPratesisUjian!="Undecided"? 
//                     Icon(Icons.check,
//                     color: Colors.green,
//                     size: 40, ):Icon(LineIcons.times,
//                     color: Colors.red,
//                     size: 40, ),
//       iconBackground: Colors.green
//       ),

//       TimelineModelData(
//       name: "Pre-Thesis Revision",
//       time: datas.tglStatusPratesisPevisi,
//       status: datas.statusPratesisPevisi,
//       icon: Icon(
//           LineIcons.edit,
//           color: Colors.white,
//         ),
//       backicon: datas.tglStatusPratesisPevisi!="Undecided"? 
//                     Icon(Icons.check,
//                     color: Colors.green,
//                     size: 40, ):Icon(LineIcons.times,
//                     color: Colors.red,
//                     size: 40, ),
//       iconBackground: Colors.orange
//       ),

//       TimelineModelData(
//       name: "Thesis File Upload",
//       time: datas.tglTesisUpload,
//       status: datas.verifikasiTesisKelayakan,
//       icon: Icon(
//           LineIcons.book,
//           color: Colors.white,
//         ),
//       backicon: datas.tglTesisUpload!="Undecided"? 
//                     Icon(Icons.check,
//                     color: Colors.green,
//                     size: 40, ):Icon(LineIcons.times,
//                     color: Colors.red,
//                     size: 40, ),
//       iconBackground: Colors.cyan
//       ),

//       TimelineModelData(
//       name: "Thesis Examination ",
//       time: datas.tglTesisUjian,
//       status: datas.statusTesisUjian,
//       icon: Icon(
//           LineIcons.userSecret,
//           color: Colors.white,
//         ),
//       backicon: datas.tglTesisUjian!="Undecided"? 
//                     Icon(Icons.check,
//                     color: Colors.green,
//                    size: 40, ):Icon(LineIcons.times,
//                     color: Colors.red,
//                     size: 40, ),
//       iconBackground: Colors.green
//       ),

//       TimelineModelData(
//       name: "Thesis Revision ",
//       time: datas.tglTesisUjian,
//       status: datas.verifikasiTesisRevisi,
//       icon: Icon(
//           LineIcons.edit,
//           color: Colors.white,
//         ),
//       backicon: datas.tglTesisUjian!="Undecided"? 
//                     Icon(Icons.check,
//                     color: Colors.green,
//                     size: 40, ):Icon(LineIcons.times,
//                     color: Colors.red,
//                     size: 40, ),
//       iconBackground: Colors.orange
//       ),

//       TimelineModelData(
//       name: "Graduation ",
//       time: datas.tglTesisUjian,
//       status: "Passed",
//       icon: Icon(
//           LineIcons.graduation_cap,
//           color: Colors.white,
//         ),
//       backicon: datas.tglTesisUjian!="Undecided"? 
//                     Icon(Icons.check,
//                     color: Colors.green,
//                     size: 40, ):Icon(LineIcons.times,
//                     color: Colors.red,
//                     size: 40, ),
//       iconBackground: Colors.blue
//       ),
  
// ];


  return [
  TimelineModelData(
      name: "Pengajuan Proposal",
      time: datas.tglPengajuanProposal,
      status: datas.statusPengajuanProposal,
      icon: Icon(LineIcons.book, color: Colors.white),
      backicon: datas.tglPengajuanProposal!="Belum Ditentukan"? 
                    Icon(Icons.check,
                    color: Colors.green,
                    size: 40, ):Icon(LineIcons.times,
                    color: Colors.red,
                    size: 40, ),
      iconBackground: Colors.cyan
      ),

      TimelineModelData(
      name: "Upload Proposal",
      time: datas.tglUploadProposal,  
       status: datas.verifikasiKelayakanKroposal,    
      icon: Icon(LineIcons.book, color: Colors.white),
      backicon: datas.tglPengajuanProposal!="Belum Ditentukan"? 
                    Icon(Icons.check,
                    color: Colors.green,
                    size: 40, ):Icon(LineIcons.times,
                    color: Colors.red,
                    size: 40, ),
      iconBackground: Colors.cyan
      ),
 
 
  TimelineModelData(
      name: "Ujian Proposal",
      time: datas.tglVerifikasiUjianProposal,
      status: datas.statusUjianProposal,
     icon: Icon(
        LineIcons.userSecret,
        color: Colors.white,
      ),
      backicon: datas.tglVerifikasiUjianProposal!="Belum Ditentukan"? 
                    Icon(Icons.check,
                    color: Colors.green,
                    size: 40, ):Icon(LineIcons.times,
                    color: Colors.red,
                    size: 40, ),
      iconBackground: Colors.green
      ),
 
  TimelineModelData(
      name: "Revisi Proposal",
      time: datas.tglVerifikasiRevisiProposal,
      status: datas.verifikasiRevisiProposal,
     icon: Icon(
        LineIcons.edit,
        color: Colors.white,
      ),
      backicon: datas.tglVerifikasiRevisiProposal!="Belum Ditentukan"? 
                    Icon(Icons.check,
                    color: Colors.green,
                    size: 40, ):Icon(LineIcons.times,
                    color: Colors.red,
                    size: 40, ),
      iconBackground: Colors.orange
      ),

    TimelineModelData(
      name: "Upload Pratesis",
      time: datas.tglUploadPratesis,
      status: datas.verifikasiPratesisKelayakan,
     icon: Icon(
        LineIcons.book,
        color: Colors.white,
      ),
      backicon: datas.tglUploadPratesis!="Belum Ditentukan"? 
                    Icon(Icons.check,
                    color: Colors.green,
                    size: 40, ):Icon(LineIcons.times,
                    color: Colors.red,
                    size: 40, ),
      iconBackground: Colors.cyan
      ),

     TimelineModelData(
      name: "Ujian Pratesis",
      time: datas.tglStatusPratesisUjian,
      status: datas.statusPratesisUjian,
      icon: Icon(
          LineIcons.userSecret,
          color: Colors.white,
        ),
      backicon: datas.tglStatusPratesisUjian!="Belum Ditentukan"? 
                    Icon(Icons.check,
                    color: Colors.green,
                    size: 40, ):Icon(LineIcons.times,
                    color: Colors.red,
                    size: 40, ),
      iconBackground: Colors.green
      ),

      TimelineModelData(
      name: "Revisi Pratesis",
      time: datas.tglStatusPratesisPevisi,
      status: datas.statusPratesisPevisi,
      icon: Icon(
          LineIcons.edit,
          color: Colors.white,
        ),
      backicon: datas.tglStatusPratesisPevisi!="Belum Ditentukan"? 
                    Icon(Icons.check,
                    color: Colors.green,
                    size: 40, ):Icon(LineIcons.times,
                    color: Colors.red,
                    size: 40, ),
      iconBackground: Colors.orange
      ),

      TimelineModelData(
      name: "Upload Tesis",
      time: datas.tglTesisUpload,
      status: datas.verifikasiTesisKelayakan,
      icon: Icon(
          LineIcons.book,
          color: Colors.white,
        ),
      backicon: datas.tglTesisUpload!="Belum Ditentukan"? 
                    Icon(Icons.check,
                    color: Colors.green,
                    size: 40, ):Icon(LineIcons.times,
                    color: Colors.red,
                    size: 40, ),
      iconBackground: Colors.cyan
      ),

      TimelineModelData(
      name: "Ujian Tesis ",
      time: datas.tglTesisUjian,
      status: datas.statusTesisUjian,
      icon: Icon(
          LineIcons.userSecret,
          color: Colors.white,
        ),
      backicon: datas.tglTesisUjian!="Belum Ditentukan"? 
                    Icon(Icons.check,
                    color: Colors.green,
                   size: 40, ):Icon(LineIcons.times,
                    color: Colors.red,
                    size: 40, ),
      iconBackground: Colors.green
      ),

      TimelineModelData(
      name: "Revisi Tesis ",
      time: datas.tglTesisUjian,
      status: datas.verifikasiTesisRevisi,
      icon: Icon(
          LineIcons.edit,
          color: Colors.white,
        ),
      backicon: datas.tglTesisUjian!="Belum Ditentukan"? 
                    Icon(Icons.check,
                    color: Colors.green,
                    size: 40, ):Icon(LineIcons.times,
                    color: Colors.red,
                    size: 40, ),
      iconBackground: Colors.orange
      ),

      TimelineModelData(
      name: "Wisuda ",
      time: datas.tglTesisUjian,
      status: "Lulus",
      icon: Icon(
          LineIcons.graduationCap,
          color: Colors.white,
        ),
      backicon: datas.tglTesisUjian!="Belum Ditentukan"? 
                    Icon(Icons.check,
                    color: Colors.green,
                    size: 40, ):Icon(LineIcons.times,
                    color: Colors.red,
                    size: 40, ),
      iconBackground: Colors.blue
      ),
  
];
}

 