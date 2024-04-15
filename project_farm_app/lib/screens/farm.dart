import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_farm_app/screens/login_page.dart';
import 'package:project_farm_app/screens/profile_page.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_farm_app/screens/test.dart';
import 'package:flutter/services.dart';


class FarmPage extends StatefulWidget {
  const FarmPage({super.key});

  @override
  State<FarmPage> createState() => _FarmPageState();
}

class _FarmPageState extends State<FarmPage> {
  final currentUser = FirebaseAuth.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user;
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
    return DateFormat(" HH: mm: ss ").format(time);
  }
  String formatCurrentLiveDate(DateTime date){
    return DateFormat("dd/ M/ yyyy").format(date);
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
        title: Text('MPPN 2024',
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

            SizedBox(height: 15),
            SizedBox(height: 10),
            FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance
                  .collection('client')
                  .doc(FirebaseAuth.instance.currentUser?.uid)
                  .get(),
              builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text("เกิดข้อผิดพลาดในการโหลดข้อมูล");
                }
                if (snapshot.hasData && snapshot.data!.exists) {
                  Map<String, dynamic>? data = snapshot.data?.data() as Map<String, dynamic>;
                  return Text(
                    "ยินดีต้อนรับ คุณ ${data?['name']}",
                    style: GoogleFonts.anuphan(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                } else {
                  return Text("กำลังโหลดข้อมูล...");
                }
              },
            ),
            SizedBox(height: 20,),
            Text(
              "วันที่ " + dateText + "   " + "เวลา" + timeText,
              style: GoogleFonts.anuphan(
                fontSize: 17,
                fontWeight: FontWeight.normal,
              ),
            ),
            SizedBox(height: 10),
            InkWell(
              onTap: () {},
              child: Container(
                width: 2500,
                padding: EdgeInsets.fromLTRB(10, 20, 30, 20),
                decoration: BoxDecoration(
                  color: Color(0xFFFFA600),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 30,
                          backgroundImage: AssetImage("images/สวน.png"),
                        ),
                        Text(
                          'ฟาร์มเกษตรสันติราษฎร \n ต.นาวังหิน อ.พนัสนิคม จ.ชลบุรี',
                          style: GoogleFonts.anuphan(
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () => _launchURL(),
                      child: Icon(
                        size: 45,
                        CupertinoIcons.location_solid,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 15),
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
                  children: documents.map((document) {
                    final data = document.data() as Map<String, dynamic>;
                    final name = data['NAME'];
                    final file = data['FILE'];
                    final location= data['LOCATION'];
                    final date = data['DATE'];
                    Timestamp startDate = data?['createAt']; // ดึง Timestamp จาก Firestore
                    DateTime createdAt = startDate.toDate(); // แปลง Timestamp เป็น DateTime
                    int year = createdAt.year; // ดึงปี
                    int month = createdAt.month; // ดึงเดือน
                    int day = createdAt.day; // ดึงวัน


                    return Column(
                      children: [
                        SizedBox(height: 5),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TestPage(
                                  documentId: document.id,
                                  uid_data: document['uid_data'],
                                ),
                              ),
                            );
                          },
                          child: SizedBox(height: 100,
                            child: Card(
                              elevation: 10,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),color: Colors.white,
                              child: ListTile(
                                leading: CircleAvatar(
                                  radius: 20,
                                  backgroundImage: AssetImage('images/$file'),
                                  // backgroundImage: AssetImage(imagePath), // ใช้สำหรับรูปภาพจาก assets
                                  backgroundColor: Colors.transparent,
                                ),
                                title: Text(
                                  " $name",
                                  style: GoogleFonts.anuphan(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(
                                "$location \n $day/ $month/ $year",
                                  style: GoogleFonts.anuphan(
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                  ),
                              ),


                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                      ],
                    );
                  }).toList(),
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


// GridView.builder(
// gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
// crossAxisCount: 2,
// ),
// itemCount: 3,
// shrinkWrap: true,
// physics: NeverScrollableScrollPhysics(),
// itemBuilder: (context, index) {
// return InkWell(
// onTap: () {
// Navigator.push(
// context,
// MaterialPageRoute(builder: (context) => TestPage()),
// );
// },
// child: Container(
// margin: EdgeInsets.all(10),
// padding: EdgeInsets.symmetric(vertical: 15),
// decoration: BoxDecoration(
// color: Colors.white,
// borderRadius: BorderRadius.circular(10),
// boxShadow: [
// BoxShadow(
// color: Colors.black12,
// blurRadius: 4,
// spreadRadius: 2,
// ),
// ],
// ),
// child: Column(
// mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// children: [
// CircleAvatar(
// backgroundColor: Colors.white,
// radius: 35,
// backgroundImage:
// AssetImage("images/${imgs[index]}"),
// ),
// Text(
// "$name",
// style: TextStyle(
// fontFamily: 'Prompt-Bold',
// fontSize: 18,
// fontWeight: FontWeight.w500,
// color: Colors.black54,
// ),
// )
// ],
// ),
// ),
// );
// },
// ),
