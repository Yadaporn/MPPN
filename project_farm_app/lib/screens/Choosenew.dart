import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_farm_app/screens/old/chart_page.dart';
import 'package:project_farm_app/screens/chartchili.dart';
import 'package:project_farm_app/screens/chartfah.dart';
import 'package:project_farm_app/screens/chartkaprao.dart';
import 'package:project_farm_app/screens/login_page.dart';
import 'package:project_farm_app/screens/profile_page.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_farm_app/screens/test.dart';
import 'package:flutter/services.dart';


class ChooseChartPageNew extends StatefulWidget {
  const ChooseChartPageNew({super.key});

  @override
  State<ChooseChartPageNew> createState() => _ChooseChartPageNewState();
}

class _ChooseChartPageNewState extends State<ChooseChartPageNew> {
  List typeplant = [
    "แปลงกะเพรา",
    "แปลงพริก",
    "แปลงฟ้าทะลายโจร"
  ];
  List imgs = [
    "กะเพรา.png",
    "พริก.png",
    "ฟ้าทะลายโจร.png"
  ];
  String timeText = "";
  String dateText = "";
  String formatCurrentLiveTime(DateTime time){
    return DateFormat(" HH : mm : ss ").format(time);
  }
  String formatCurrentLiveDate(DateTime date){
    return DateFormat("dd /  M / yyyy").format(date);
  }

  getCureentLiveTime(){
    final DateTime timeNow = DateTime.now();
    final String liveTime = formatCurrentLiveTime(timeNow);
    final String liveDate = formatCurrentLiveDate(timeNow);

    if(this.mounted){
      setState(() {
        timeText = liveTime;
        dateText = liveDate;
      });
    }
  }
  void _launchURL() async {
    var url = 'https://maps.app.goo.gl/1cjoVgnszjiMcK7N8';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'ไม่สามารถเปิดลิ้งค์ได้: $url';
    }
  }
  @override
  void initState(){
    super.initState();
    //time
    timeText = formatCurrentLiveTime(DateTime.now());

    //date
    dateText = formatCurrentLiveDate(DateTime.now());

    Timer.periodic(const Duration(seconds: 1),(timer){
      getCureentLiveTime();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Color(0xFFFFA600),
        title: Text('MPPN 2024 รายงาน',
          style: GoogleFonts.anuphan(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white70,
          ),
        ),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          CircleAvatar(
            backgroundImage: NetworkImage("https://i.natgeofe.com/n/4f5aaece-3300-41a4-b2a8-ed2708a0a27c/domestic-dog_thumb_square.jpg?w=170&h=170"),
          ),
          SizedBox(width: 20), // ให้ระยะห่างกับปุ่มหรือไอคอนถัดไป
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20,),
            Text(
              "กราฟบอกค่าบันทึกของเซนเซอร์ " ,
              style: GoogleFonts.anuphan(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 25),
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("client")
                  .doc(FirebaseAuth.instance.currentUser?.uid)
                  .collection('DATA')
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                var documents = snapshot.data!.docs;

                return Column(
                      children: [
                        SizedBox(height: 5),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChartKaprao(),
                              ),
                            );
                          },
                          child: SizedBox(height: 100,
                            child: Card(
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),color: Colors.white,
                              child: ListTile(
                                leading: CircleAvatar(
                                  radius: 20,
                                  backgroundImage: AssetImage('images/กะเพรา.png'),
                                  // backgroundImage: AssetImage(imagePath), // ใช้สำหรับรูปภาพจาก assets
                                  backgroundColor: Colors.transparent,
                                ),
                                title: Text(
                                  " แปลงกะเพรา",
                                  style: GoogleFonts.anuphan(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,

                                  ),
                                ),
                                subtitle: Text(
                                  "ประจำเดือน: มกราคม",
                                  style: GoogleFonts.anuphan(
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black87,
                                  ),
                                ),


                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChartChili(),
                              ),
                            );
                          },
                          child: SizedBox(height: 100,
                            child: Card(
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),color: Colors.white,
                              child: ListTile(
                                leading: CircleAvatar(
                                  radius: 20,
                                  backgroundImage: AssetImage('images/พริก.png'),
                                  // backgroundImage: AssetImage(imagePath), // ใช้สำหรับรูปภาพจาก assets
                                  backgroundColor: Colors.transparent,
                                ),
                                title: Text(
                                  " แปลงพริก",
                                  style: GoogleFonts.anuphan(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,

                                  ),
                                ),
                                subtitle: Text(
                                  "ประจำเดือน: พฤษจิกายน",
                                  style: GoogleFonts.anuphan(
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black87,
                                  ),
                                ),


                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChartFah(),
                              ),
                            );
                          },
                          child: SizedBox(height: 100,
                            child: Card(
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),color: Colors.white,
                              child: ListTile(
                                leading: CircleAvatar(
                                  radius: 20,
                                  backgroundImage: AssetImage('images/ฟ้าทะลายโจร.png'),
                                  // backgroundImage: AssetImage(imagePath), // ใช้สำหรับรูปภาพจาก assets
                                  backgroundColor: Colors.transparent,
                                ),
                                title: Text(
                                  " แปลงฟ้าทะลายโจร",
                                  style: GoogleFonts.anuphan(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,

                                  ),
                                ),
                                subtitle: Text(
                                  "ประจำเดือน: พฤษจิกายน",
                                  style: GoogleFonts.anuphan(
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black87,
                                  ),
                                ),


                              ),
                            ),
                          ),
                        ),
                      ],


                );
              },
            ),
            //
          ],
        ),
      ),

    );
  }
}



