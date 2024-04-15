import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_farm_app/screens/old/chart_page.dart';
import 'package:project_farm_app/screens/login_page.dart';
import 'package:project_farm_app/screens/profile_page.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_farm_app/screens/test.dart';
import 'package:flutter/services.dart';


class ChooseChartPage extends StatefulWidget {
  const ChooseChartPage({super.key});

  @override
  State<ChooseChartPage> createState() => _ChooseChartPageState();
}

class _ChooseChartPageState extends State<ChooseChartPage> {
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
        title: Text('MPPN 2024',
          style: GoogleFonts.anuphan(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white60,
          ),
        ),
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20,),
            Text(
              "วันที่ " + dateText + "   " + "เวลา" + timeText,
              style: GoogleFonts.anuphan(
                fontSize: 17,
                fontWeight: FontWeight.normal,
              ),
            ),
            SizedBox(height: 5),
            InkWell(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Color(0xFFFFA600),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      spreadRadius: 4,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 30,
                      backgroundImage:
                      AssetImage("images/สวน.png"),
                    ),
                    Text(
                      'ฟาร์มเกษตรสันติราษฎร \n ต.นาวังหิน อ.พนัสนิคม จ.ชลบุรี',
                      style: GoogleFonts.anuphan(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 10),
                    InkWell(
                      child: Icon(
                        CupertinoIcons.map,
                        color: Colors.black87,
                      ),
                      onTap: () => _launchURL(),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
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

                return ListView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: documents.map((document) {
                    final data = document.data() as Map<String, dynamic>;
                    final name = data['NAME'];
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ChartPage(documentId: document.id,
                                      uid_data: document['uid_data'])
                                ));
                          },
                          child: ListTile(
                            leading: Icon(
                              Icons.house,
                              color: Colors.green.shade800,
                              size: 80,
                            ),
                            title: Text(
                              " $name",
                              style: GoogleFonts.anuphan(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                              // "แปลงปลูกที่ 1 : ",
                            ),
                          ),
                        ),
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
