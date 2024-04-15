import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartFah extends StatefulWidget {
  const ChartFah({super.key});

  @override
  State<ChartFah> createState() => _ChartFahState();
}

class _ChartFahState extends State<ChartFah> {
  List val = [
    "value1",
    "value2",
    "value3",
    "value4",
    "value5",
    "value6",
    "value7",
    "value8",
    "value9",
    "value10"
  ];
  List sensors = [
    "sensors1",
    "sensors2",
    "sensors3",
    "sensors4",
    "sensors5",
    "sensors6",
    "sensors7",
    "sensors8",
    "sensors9",
    "sensors10"
  ];
  List SensorsDetailsall = [
    "SensorsDetails1",
    "SensorsDetails2",
    "SensorsDetails3",
    "SensorsDetails4",
    "SensorsDetails5",
    "SensorsDetails6",
    "SensorsDetails7",
    "SensorsDetails8",
    "SensorsDetails9",
    "SensorsDetails10"
  ];
  List<SensorsDetails1> sensors1 = [];
  List<SensorsDetails2> sensors2 = [];
  List<SensorsDetails3> sensors3 = [];
  List<SensorsDetails4> sensors4 = [];
  List<SensorsDetails5> sensors5 = [];
  List<SensorsDetails6> sensors6 = [];
  List<SensorsDetails7> sensors7 = [];
  List<SensorsDetails8> sensors8 = [];
  List<SensorsDetails9> sensors9 = [];
  List<SensorsDetails10> sensors10 = [];
  // List<String> months = ['Apr','May','Jun'];
  // List<int> sensorsCounts = [120, 160, 135, 150];




  //   for (int i = 0; i < months.length; i++) {
  //     sensors.add(SensorsDetails(months[i], sensorsCounts[i] ));
  //   }
  // }
  Future<String> getJsonFromAssets() async {
    return await rootBundle.loadString('assets/data3.json');
  }
  // Future<String> getJsonFromAssets(String uidData) async {
  //   DocumentSnapshot document = await FirebaseFirestore.instance
  //       .collection("client")
  //       .doc(FirebaseAuth.instance.currentUser!.uid)
  //       .collection("DATA")
  //       .doc(uidData) // ใช้พารามิเตอร์ uidData แทน widget.uid_data
  //       .get();
  //
  //   if (document.exists) {
  //     print(document['asset']);
  //     final assetName = document['asset']; // ดึงชื่อของ asset จากเอกสารใน Firestore
  //     return await rootBundle.loadString('assets/data2.json');
  //   } else {
  //     throw Exception('Document not found');
  //   }
  // }


  Future loadSensorsData() async{
    final String jsonString = await getJsonFromAssets();
    final dynamic jsonResponse = json.decode(jsonString);
    for (Map<String, dynamic> i in jsonResponse){
      sensors.add(SensorsDetails1.fromJson(i));
    }
    for (Map<String, dynamic> i in jsonResponse){
      sensors2.add(SensorsDetails2.fromJson(i));
    }
    for (Map<String, dynamic> i in jsonResponse){
      sensors3.add(SensorsDetails3.fromJson(i));
    }
    for (Map<String, dynamic> i in jsonResponse){
      sensors4.add(SensorsDetails4.fromJson(i));
    }
    for (Map<String, dynamic> i in jsonResponse){
      sensors5.add(SensorsDetails5.fromJson(i));
    }
    for (Map<String, dynamic> i in jsonResponse){
      sensors6.add(SensorsDetails6.fromJson(i));
    }
    for (Map<String, dynamic> i in jsonResponse){
      sensors7.add(SensorsDetails7.fromJson(i));
    }
    for (Map<String, dynamic> i in jsonResponse){
      sensors8.add(SensorsDetails8.fromJson(i));
    }
    for (Map<String, dynamic> i in jsonResponse){
      sensors9.add(SensorsDetails9.fromJson(i));
    }
    for (Map<String, dynamic> i in jsonResponse){
      sensors10.add(SensorsDetails10.fromJson(i));
    }
  }



  @override
  void initState() {
    loadSensorsData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Color(0xFFFFA600),
        title: Text('กราฟแสดงเซนเซอร์ แปลงฟ้าทะลายโจร',
          style: GoogleFonts.anuphan(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white70,
          ),),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context); // ใช้ Navigator.pop เพื่อกลับหน้า
            },
            icon: const Icon(Icons.logout),
          ),
        ],

      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("client")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection("DATA")
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: 1,
              itemBuilder: (context, index) {
                return Container(
                  height: 1000,
                  child: Column(
                    children: [
                      Text(
                        'สีแดง : อุณหภูมิโดยรอบ   สีน้ำเงิน : ความชื้นโดยรอบ\n'
                            'สีเขียว : ค่าแสงโดยรอบ   สีเหลือง : ความชิ้นในดิน\n'
                            'สีส้ม : ค่าความนำไฟฟ้าในดิน  สีม่วง : ค่าpHในดิน\n'
                            'สีเขียวเข้ม : ค่าN   สีม่วงน้ำเงิน : ค่าP\n'
                            'สีฟ้า : ค่าK',
                        style: GoogleFonts.anuphan(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 10),
                      Expanded(
                        child: SfCartesianChart(
                          primaryXAxis: CategoryAxis(),
                          series: <CartesianSeries>[
                            LineSeries<SensorsDetails1, String>(
                              dataSource: sensors1,
                              xValueMapper: (SensorsDetails1 details, _) => details.id,
                              yValueMapper: (SensorsDetails1 details, _) => details.value1,
                              color: Colors.red, // กำหนดสีของกราฟ

                            ),
                            LineSeries<SensorsDetails2, String>(
                              dataSource: sensors2,
                              xValueMapper: (SensorsDetails2 details, _) => details.id,
                              yValueMapper: (SensorsDetails2 details, _) => details.value2,
                            ),
                            LineSeries<SensorsDetails3, String>(
                              dataSource: sensors3,
                              xValueMapper: (SensorsDetails3 details, _) => details.id,
                              yValueMapper: (SensorsDetails3 details, _) => details.value3,
                            ),
                            LineSeries<SensorsDetails4, String>(
                              dataSource: sensors4,
                              xValueMapper: (SensorsDetails4 details, _) => details.id,
                              yValueMapper: (SensorsDetails4 details, _) => details.value4,
                            ),
                            LineSeries<SensorsDetails5, String>(
                              dataSource: sensors5,
                              xValueMapper: (SensorsDetails5 details, _) => details.id,
                              yValueMapper: (SensorsDetails5 details, _) => details.value5,
                            ),
                            LineSeries<SensorsDetails6, String>(
                              dataSource: sensors6,
                              xValueMapper: (SensorsDetails6 details, _) => details.id,
                              yValueMapper: (SensorsDetails6 details, _) => details.value6,
                            ),
                            LineSeries<SensorsDetails7, String>(
                              dataSource: sensors7,
                              xValueMapper: (SensorsDetails7 details, _) => details.id,
                              yValueMapper: (SensorsDetails7 details, _) => details.value7,
                            ),
                            LineSeries<SensorsDetails8, String>(
                              dataSource: sensors8,
                              xValueMapper: (SensorsDetails8 details, _) => details.id,
                              yValueMapper: (SensorsDetails8 details, _) => details.value8,
                            ),
                            LineSeries<SensorsDetails9, String>(
                              dataSource: sensors9,
                              xValueMapper: (SensorsDetails9 details, _) => details.id,
                              yValueMapper: (SensorsDetails9 details, _) => details.value9,
                            ),
                            LineSeries<SensorsDetails10, String>(
                              dataSource: sensors10,
                              xValueMapper: (SensorsDetails10 details, _) => details.id,
                              yValueMapper: (SensorsDetails10 details, _) => details.value10,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

class SensorsDetails1 {
  SensorsDetails1(this.id, this.value1);
  final String id;
  final double value1; // เปลี่ยนเป็น double เพื่อรองรับค่าที่มีทศนิยม

  factory SensorsDetails1.fromJson(Map<String, dynamic> parsedJson){
    return SensorsDetails1(
      parsedJson['id'].toString(),
      double.parse(parsedJson['value1'] as String), // แปลงค่าจาก String เป็น double
    );
  }
}
class SensorsDetails2 {
  SensorsDetails2(this.id, this.value2);
  final String id;
  final double value2; // เปลี่ยนเป็น double เพื่อรองรับค่าที่มีทศนิยม

  factory SensorsDetails2.fromJson(Map<String, dynamic> parsedJson){
    return SensorsDetails2(
      parsedJson['id'].toString(),
      double.parse(parsedJson['value2'] as String), // แปลงค่าจาก String เป็น double
    );
  }
}
class SensorsDetails3 {
  SensorsDetails3(this.id, this.value3);
  final String id;
  final double value3; // เปลี่ยนเป็น double เพื่อรองรับค่าที่มีทศนิยม

  factory SensorsDetails3.fromJson(Map<String, dynamic> parsedJson){
    return SensorsDetails3(
      parsedJson['id'].toString(),
      double.parse(parsedJson['value3'] as String), // แปลงค่าจาก String เป็น double
    );
  }
}
class SensorsDetails4 {
  SensorsDetails4(this.id, this.value4);
  final String id;
  final double value4; // เปลี่ยนเป็น double เพื่อรองรับค่าที่มีทศนิยม

  factory SensorsDetails4.fromJson(Map<String, dynamic> parsedJson){
    return SensorsDetails4(
      parsedJson['id'].toString(),
      double.parse(parsedJson['value4'] as String), // แปลงค่าจาก String เป็น double
    );
  }
}
class SensorsDetails5 {
  SensorsDetails5(this.id, this.value5);
  final String id;
  final double value5; // เปลี่ยนเป็น double เพื่อรองรับค่าที่มีทศนิยม

  factory SensorsDetails5.fromJson(Map<String, dynamic> parsedJson){
    return SensorsDetails5(
      parsedJson['id'].toString(),
      double.parse(parsedJson['value5'] as String), // แปลงค่าจาก String เป็น double
    );
  }
}
class SensorsDetails6 {
  SensorsDetails6(this.id, this.value6);
  final String id;
  final double value6; // เปลี่ยนเป็น double เพื่อรองรับค่าที่มีทศนิยม

  factory SensorsDetails6.fromJson(Map<String, dynamic> parsedJson){
    return SensorsDetails6(
      parsedJson['id'].toString(),
      double.parse(parsedJson['value6'] as String), // แปลงค่าจาก String เป็น double
    );
  }
}
class SensorsDetails7 {
  SensorsDetails7(this.id, this.value7);
  final String id;
  final double value7; // เปลี่ยนเป็น double เพื่อรองรับค่าที่มีทศนิยม

  factory SensorsDetails7.fromJson(Map<String, dynamic> parsedJson){
    return SensorsDetails7(
      parsedJson['id'].toString(),
      double.parse(parsedJson['value7'] as String), // แปลงค่าจาก String เป็น double
    );
  }
}
class SensorsDetails8 {
  SensorsDetails8(this.id, this.value8);
  final String id;
  final double value8; // เปลี่ยนเป็น double เพื่อรองรับค่าที่มีทศนิยม

  factory SensorsDetails8.fromJson(Map<String, dynamic> parsedJson){
    return SensorsDetails8(
      parsedJson['id'].toString(),
      double.parse(parsedJson['value8'] as String), // แปลงค่าจาก String เป็น double
    );
  }
}
class SensorsDetails9 {
  SensorsDetails9(this.id, this.value9);
  final String id;
  final double value9; // เปลี่ยนเป็น double เพื่อรองรับค่าที่มีทศนิยม

  factory SensorsDetails9.fromJson(Map<String, dynamic> parsedJson){
    return SensorsDetails9(
      parsedJson['id'].toString(),
      double.parse(parsedJson['value9'] as String), // แปลงค่าจาก String เป็น double
    );
  }
}
class SensorsDetails10 {
  SensorsDetails10(this.id, this.value10);
  final String id;
  final double value10; // เปลี่ยนเป็น double เพื่อรองรับค่าที่มีทศนิยม

  factory SensorsDetails10.fromJson(Map<String, dynamic> parsedJson){
    return SensorsDetails10(
      parsedJson['id'].toString(),
      double.parse(parsedJson['value10'] as String), // แปลงค่าจาก String เป็น double
    );
  }
}
