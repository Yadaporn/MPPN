import 'dart:developer';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_farm_app/screens/farm.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project_farm_app/animations/fade_in.dart';
import 'package:project_farm_app/screens/profile_page.dart';
import 'package:project_farm_app/widgets/app_card.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../widgets/increasing_text.dart';
import '../widgets/progress_with_text.dart';

class TestPage extends StatefulWidget {
  final String uid_data;
  final String documentId;
  // final String documentId;
  // const TestPage({Key? key, required this.documentId}) : super(key: key);
  const TestPage({super.key,
    required this.documentId,
    required this.uid_data,});
  // const TestPage({super.key,required this.documentId});


  @override
  State<TestPage> createState() => TestPageState();
}

class TestPageState extends State<TestPage> {

  final currentUser = FirebaseAuth.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user;
  final DatabaseReference _lightRef =
  FirebaseDatabase.instance.reference().child('light');
  final DatabaseReference _waterRef =
  FirebaseDatabase.instance.reference().child('water');
  final DatabaseReference _ferzRef =
  FirebaseDatabase.instance.reference().child('ferz');
  bool _isLightOn = false;
  bool _isWaterOn = false;
  bool _isFerzOn = false;
  @override
  void initState() {

    if (auth.currentUser != null)
    {
      user= auth.currentUser;
    }
    // Set initial value here or load it from Firestore
  }
  final DocumentReference _dataRef = FirebaseFirestore.instance
      .collection("client")
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection("DATA")
      .doc();

  void _toggleLight() {
    _lightRef.set(!_isLightOn);
    setState(() {
      _isLightOn = !_isLightOn;
    });
  }
  void _toggleWater() {
    _waterRef.set(!_isWaterOn);
    setState(() {
      _isWaterOn = !_isWaterOn;
    });
  }
  void _toggleFerz() {
    // สลับค่าเปิด-ปิดของปุ๋ยน้ำใน Firestore
    bool ferzValue = !_isFerzOn; // สลับค่า _isFerzOn เพื่อให้ได้ค่าตรงกับเงื่อนไข
    _dataRef.update({'ferz': ferzValue ? 1 : 0}).then((_) {
      setState(() {
        _isFerzOn = ferzValue;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double w = (MediaQuery.sizeOf(context).width / 2) - 35;
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
            const SizedBox(height: 10),
            FadeInAnimation(
              delay: 1,
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Text(
                        "หน้าแสดงข้อมูลเซนเซอร์ และ\n ควบคุมเซนเซอร์",style: GoogleFonts.anuphan(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                    ],

                  ),



                ],
              ),
            ),

            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("client")
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .collection("DATA")
                  .doc(widget.uid_data)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final data = snapshot.data;
                  final name1 = data?['NAME'] ?? '';
                  final location = data?['LOCATION'] ?? '';
                  final uidData = data?['uid_data']?? ''; // ดึง uid_data ของแต่ละรายการ
                  final tempValue = data?['ANBTEMP']; // เข้าถึงข้อมูล TEMP จาก Firestore
                  final tempValue2 = double.parse(tempValue);
                  double percentwater = tempValue2/100;// คำนวณเปอร์เซ็นต์
                  final soilhumid = data?['SOILHUMID'];// เข้าถึงข้อมูล LED จาก Firestore
                  final soilhumid2 = double.parse(soilhumid);
                  double percentsoilhumid = soilhumid2/100;
                  final surhumid = data?['SURHUMID'];
                  final surhumid2 = double.parse(surhumid);
                  double percentsurhumid = surhumid2/100;
                  final soiltemp = data?['SOILTEMP'];
                  final soiltemp2 = double.parse(soiltemp);
                  double percentsoiltemp = soiltemp2/100;
                  final surlight = data?['SURLIGHT'];
                  final surlight2 = double.parse(surlight);
                  double percentsurlight = surlight2/1000;
                  final soilelec = data?['SOILELEC'];
                  final soilelec2 = double.parse(soilelec);
                  double percentsoilelec = soilelec2/100;
                  final soilph = data?['SOILPH'];
                  final soilph2 = double.parse(soilph);
                  double percentsoilph = soilph2/14;
                  final n = data?['N'];
                  final n2 = double.parse(n);
                  double percentn = n2/1000;
                  final p = data?['P'];
                  final p2 = double.parse(p);
                  double percentp = p2/1000;
                  final k = data?['K'];
                  final k2 = double.parse(k);
                  double percentk = k2/1000;
                  final ledvalue = data?['LED'];
                  final watervalue = data?['WATER'];

                  //amptemp
                  Color progressColor;
                  if (percentwater <= 0.2) {
                    progressColor = Colors.blue;
                  } else if (percentwater <= 0.5) {
                    progressColor = Colors.lightGreen;
                  } else if (percentwater <= 0.8) {
                    progressColor = Colors.yellow;
                  }else {
                    progressColor = Colors.red;
                  }
                  //soiltemp
                  Color progressColor2;
                  if (percentsoiltemp <= 0.2) {
                    progressColor2 = Colors.blue;
                  } else if (percentsoiltemp <= 0.5) {
                    progressColor2 = Colors.lightGreen;
                  } else if (percentsoiltemp <= 0.8) {
                    progressColor2 = Colors.yellow;
                  }else {
                    progressColor2 = Colors.red;
                  }
                  //surhumid
                  Color progressColor3;
                  if (percentsurhumid <= 0.2) {
                    progressColor3 = Colors.orange;
                  } else if (percentsurhumid <= 0.5) {
                    progressColor3 = Colors.lightGreen;
                  } else {
                    progressColor3 = Colors.blue;
                  }
                  //soilhumid
                  Color progressColor4;
                  if (percentsoilhumid <= 0.2) {
                    progressColor4 = Colors.orange;
                  } else if (percentsoilhumid <= 0.5) {
                    progressColor4 = Colors.lightGreen;
                  } else {
                    progressColor4 = Colors.blue;
                  }
                  //surlight
                  Color progressColor5;
                  if (percentsurlight <= 0.2) {
                    progressColor5 = Colors.blue;
                  } else if (percentsurlight <= 0.5) {
                    progressColor5 = Colors.orange;
                  } else {
                    progressColor5 = Colors.red;
                  }
                  //soilelec
                  Color progressColor6;
                  if (percentsoilelec <= 0.2) {
                    progressColor6 = Colors.blue;
                  } else if (percentsoilelec <= 0.5) {
                    progressColor6 = Colors.lightGreen;
                  } else if (percentsoilelec <= 0.8) {
                    progressColor6= Colors.yellow;
                  }else {
                    progressColor6 = Colors.red;
                  }
                  //ph
                  Color progressColor7;
                  if (percentsoilph <= 0.2) {
                    progressColor7 = Colors.blue;
                  } else if (percentsoilph <= 0.5) {
                    progressColor7 = Colors.lightGreen;
                  } else if (percentsoilph <= 0.8) {
                    progressColor7 = Colors.yellow;
                  }else {
                    progressColor7 = Colors.red;
                  }
                  //n
                  Color progressColor8;
                  if (percentn <= 0.2) {
                    progressColor8 = Colors.blue;
                  } else if (percentn <= 0.5) {
                    progressColor8 = Colors.lightGreen;
                  } else if (percentn <= 0.8) {
                    progressColor8 = Colors.yellow;
                  }else {
                    progressColor8 = Colors.red;
                  }
                  //p
                  Color progressColor9;
                  if (percentp <= 0.2) {
                    progressColor9 = Colors.blue;
                  } else if (percentp <= 0.5) {
                    progressColor9 = Colors.lightGreen;
                  } else if (percentp <= 0.8) {
                    progressColor9 = Colors.yellow;
                  }else {
                    progressColor9 = Colors.red;
                  }
                  //k
                  Color progressColor10;
                  if (percentk <= 0.2) {
                    progressColor10 = Colors.blue;
                  } else if (percentk <= 0.5) {
                    progressColor10 = Colors.lightGreen;
                  } else if (percentk <= 0.8) {
                    progressColor10 = Colors.yellow;
                  }else {
                    progressColor10 = Colors.red;
                  }




                DateTime now = DateTime.now();

                  Timestamp startDate = data?['createAt']; // ดึง Timestamp จาก Firestore
                  DateTime createdAt = startDate.toDate(); // แปลง Timestamp เป็น DateTime

// แปลง startDate เป็น DateTime ก่อนที่จะคำนวณความแตกต่างของวัน
                  int differenceInDays = now.difference(createdAt).inDays;

                  // print('วันที่สร้าง: $createdAt');
                  // print('จำนวนวันระหว่างวันที่: $differenceInDays วัน');

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: w,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FadeInAnimation(
                                delay: 1.0, // ค่า delay ของ animation (หน่วงเวลาก่อนที่ animation จะเริ่ม)
                                child: Container(
                                  width: 200,
                                  height: 40,
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.lightBlueAccent,
                                    border: Border.all(color: Colors.lightBlueAccent,),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    'ปลูกเป็นเวลา $differenceInDays วัน',
                                    style: GoogleFonts.anuphan(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),

                              //button
                              const SizedBox(height: 5),

                              FadeInAnimation(
                                delay: 1.5,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 15), // เพิ่ม padding ด้านบนที่ต้องการ
                                  child: AppCard(
                                    height: 200,
                                    child: Row(
                                      children: [
                                        Column(

                                          // crossAxisAlignment: CrossAxisAlignment.center,
                                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [

                                            Text(
                                              'อุณหภูมิโดยรอบ',
                                              style: GoogleFonts.anuphan(
                                                fontSize: 20,
                                                fontWeight: FontWeight.normal,
                                                color: Colors.black87,
                                              ),
                                            ),
                                            // Spacer(),
                                            SizedBox(height: 10),
                                            CircularPercentIndicator(
                                              radius: 60,
                                              lineWidth: 20,
                                              backgroundColor: Colors.grey.shade300,
                                              progressColor: progressColor, // ไม่ใช้งาน progressColor แล้ว
                                              animation: true,
                                              animationDuration: 2000,
                                              circularStrokeCap: CircularStrokeCap.round,
                                              percent: percentwater,
                                              center: OverflowBox(
                                                maxWidth: double.infinity,
                                                alignment: Alignment.center,
                                                child: Text(
                                                  '$tempValue °C',
                                                  style: GoogleFonts.anuphan(
                                                    fontSize: 30,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black87,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),

                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(height: 30),
                              FadeInAnimation(
                                delay: 2.5,
                                child: AppCard(
                                  height: 200,
                                  child: Row(
                                    children: [
                                      Column(
                                        children: [
                                           Text(
                                            'อุณหภูมิในดิน',
                                            style: GoogleFonts.anuphan(
                                            fontSize: 20,
                                            fontWeight: FontWeight.normal,
                                              color: Colors.black87,
                                          ),
                                          ),

                                          // Spacer(),
                                          SizedBox(height: 10),
                                          CircularPercentIndicator(
                                            radius: 60,
                                            lineWidth: 20,
                                            backgroundColor: Colors.grey.shade300,
                                            progressColor: progressColor2, // ไม่ใช้งาน progressColor แล้ว
                                            animation: true,
                                            animationDuration: 2000,
                                            circularStrokeCap: CircularStrokeCap.round,
                                            percent: percentsoiltemp,
                                            center: OverflowBox(
                                              maxWidth: double.infinity,
                                              alignment: Alignment.center,
                                              child: Text(
                                                '$soiltemp °C',
                                                style: GoogleFonts.anuphan(
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black87,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 30),
                              FadeInAnimation(
                                delay: 3,
                                child: AppCard(
                                  height: 200,
                                  child: Row(
                                    children: [
                                      Column(
                                        children: [
                                          Text(
                                            'ความชื้นโดยรอบ',
                                            style: GoogleFonts.anuphan(
                                              fontSize: 20,
                                              fontWeight: FontWeight.normal,
                                              color: Colors.black87,
                                            ),
                                          ),

                                          // Spacer(),
                                          SizedBox(height: 10),
                                          CircularPercentIndicator(
                                            radius: 60,
                                            lineWidth: 20,
                                            backgroundColor: Colors.grey.shade300,
                                            progressColor: progressColor3, // ไม่ใช้งาน progressColor แล้ว
                                            animation: true,
                                            animationDuration: 2000,
                                            circularStrokeCap: CircularStrokeCap.round,
                                            percent: percentsurhumid,
                                            center: OverflowBox(
                                              maxWidth: double.infinity,
                                              alignment: Alignment.center,
                                              child: Text(
                                                '$surhumid %',
                                                style: GoogleFonts.anuphan(
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black87,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 30),
                              FadeInAnimation(
                                delay: 3.5,
                                child: AppCard(
                                  height: 200,
                                  child: Row(
                                    children: [
                                      Column(
                                        children: [
                                          Text(
                                            'ความชื้นในดิน',
                                            style: GoogleFonts.anuphan(
                                              fontSize: 20,
                                              fontWeight: FontWeight.normal,
                                              color: Colors.black87,
                                            ),
                                          ),

                                          // Spacer(),
                                          SizedBox(height: 10),
                                          CircularPercentIndicator(
                                            radius: 60,
                                            lineWidth: 20,
                                            backgroundColor: Colors.grey.shade300,
                                            progressColor: progressColor4, // ไม่ใช้งาน progressColor แล้ว
                                            animation: true,
                                            animationDuration: 2000,
                                            circularStrokeCap: CircularStrokeCap.round,
                                            percent: percentsoilhumid,
                                            center: OverflowBox(
                                              maxWidth: double.infinity,
                                              alignment: Alignment.center,
                                              child: Text(
                                                '$soilhumid  %',
                                                style: GoogleFonts.anuphan(
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black87,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 30),
                              FadeInAnimation(
                                delay: 4,
                                child: AppCard(
                                  height: 200,
                                  child: Row(
                                    children: [
                                      Column(
                                        children: [
                                          Text(
                                            'แสงโดยรอบ',
                                            style: GoogleFonts.anuphan(
                                              fontSize: 20,
                                              fontWeight: FontWeight.normal,
                                              color: Colors.black87,
                                            ),
                                          ),

                                          // Spacer(),
                                          SizedBox(height: 10),
                                          CircularPercentIndicator(
                                            radius: 60,
                                            lineWidth: 20,
                                            backgroundColor: Colors.grey.shade300,
                                            progressColor: progressColor5, // ไม่ใช้งาน progressColor แล้ว
                                            animation: true,
                                            animationDuration: 2000,
                                            circularStrokeCap: CircularStrokeCap.round,
                                            percent: percentsurlight,
                                            center: OverflowBox(
                                              maxWidth: double.infinity,
                                              alignment: Alignment.center,
                                              child: Text(
                                                '$surlight  Lux',
                                                style: GoogleFonts.anuphan(
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black87,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 20.0),
                              Text(
                                'น้ำ ${_isWaterOn ? 'เปิด' : 'ปิด'}',style: GoogleFonts.anuphan(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                              ),
                              ElevatedButton(
                                onPressed: _toggleWater,
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<Color>(
                                    _isWaterOn ? Colors.redAccent: Colors.lightGreen, // สีของปุ่มเป็นแดงเมื่อเปิดและเขียวเมื่อปิด
                                  ),
                                ),
                                child: Text(
                                  _isWaterOn ? 'ปิด' : 'เปิด',
                                  style: GoogleFonts.anuphan(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              SizedBox(height: 20.0),
                              Text(
                                'แสงเสริม  ${_isLightOn ? 'เปิด' : 'ปิด'}',style: GoogleFonts.anuphan(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                              ),
                              ElevatedButton(
                                onPressed: _toggleLight,
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<Color>(
                                    _isLightOn ? Colors.redAccent: Colors.lightGreen, // สีของปุ่มเป็นแดงเมื่อเปิดและเขียวเมื่อปิด
                                  ),
                                ),
                                child: Text(
                                  _isLightOn ? 'ปิด' : 'เปิด',
                                  style: GoogleFonts.anuphan(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),

                        SizedBox(
                          width: w,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FadeInAnimation(
                                delay: 1.0, // ค่า delay ของ animation (หน่วงเวลาก่อนที่ animation จะเริ่ม)
                                child: Container(
                                  width: 150,
                                  height: 40,
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.lightGreen,
                                    border: Border.all(color: Colors.lightGreen,),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    ' $name1',
                                    style: GoogleFonts.anuphan(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            FadeInAnimation(
                            delay: 1.5,
                            child: Padding(
                              padding: const EdgeInsets.only(top:20), // เพิ่ม padding ด้านบนที่ต้องการ
                              child: AppCard(
                                height: 200,
                                child: Row(
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          'ค่า EC ในดิน',
                                          style: GoogleFonts.anuphan(
                                            fontSize: 20,
                                            fontWeight: FontWeight.normal,
                                            color: Colors.black87,
                                          ),
                                        ),

                                        // Spacer(),
                                        SizedBox(height: 10),
                                        CircularPercentIndicator(
                                          radius: 60,
                                          lineWidth: 20,
                                          backgroundColor: Colors.grey.shade300,
                                          progressColor: progressColor6, // ไม่ใช้งาน progressColor แล้ว
                                          animation: true,
                                          animationDuration: 2000,
                                          circularStrokeCap: CircularStrokeCap.round,
                                          percent: percentsoilelec,
                                          center: OverflowBox(
                                            maxWidth: double.infinity,
                                            alignment: Alignment.center,
                                            child: Text(
                                              '$soilelec uS/cm',
                                              style: GoogleFonts.anuphan(
                                                fontSize: 30,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black87,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            ),
                              const SizedBox(height: 30),
                              FadeInAnimation(
                                delay: 2.5,
                                child: AppCard(
                                  height: 200,
                                  child: Row(
                                    children: [
                                      Column(
                                        children: [
                                          Text(
                                            'ค่า pH ในดิน',
                                            style: GoogleFonts.anuphan(
                                              fontSize: 20,
                                              fontWeight: FontWeight.normal,
                                              color: Colors.black87,
                                            ),
                                          ),

                                          // Spacer(),
                                          SizedBox(height: 10),
                                          CircularPercentIndicator(
                                            radius: 60,
                                            lineWidth: 20,
                                            backgroundColor: Colors.grey.shade300,
                                            progressColor: progressColor7, // ไม่ใช้งาน progressColor แล้ว
                                            animation: true,
                                            animationDuration: 2000,
                                            circularStrokeCap: CircularStrokeCap.round,
                                            percent: percentsoilph,
                                            center: OverflowBox(
                                              maxWidth: double.infinity,
                                              alignment: Alignment.center,
                                              child: Text(
                                                '$soilph',
                                                style: GoogleFonts.anuphan(
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black87,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 30),
                              FadeInAnimation(
                                delay: 3,
                                child: AppCard(
                                  height: 200,
                                  child: Row(
                                    children: [
                                      Column(
                                        children: [
                                          Text(
                                            'ค่าไนโตรเจน (N)',
                                            style: GoogleFonts.anuphan(
                                              fontSize: 20,
                                              fontWeight: FontWeight.normal,
                                              color: Colors.black87,
                                            ),
                                          ),

                                          // Spacer(),
                                          SizedBox(height: 10),
                                          CircularPercentIndicator(
                                            radius: 60,
                                            lineWidth: 20,
                                            backgroundColor: Colors.grey.shade300,
                                            progressColor: progressColor8, // ไม่ใช้งาน progressColor แล้ว
                                            animation: true,
                                            animationDuration: 2000,
                                            circularStrokeCap: CircularStrokeCap.round,
                                            percent: percentn,
                                            center: OverflowBox(
                                              maxWidth: double.infinity,
                                              alignment: Alignment.center,
                                              child: Text(
                                                '$n mg/kg',
                                                style: GoogleFonts.anuphan(
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black87,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 30),
                              FadeInAnimation(
                                delay: 3.5,
                                child: AppCard(
                                  height: 200,
                                  child: Row(
                                    children: [
                                      Column(
                                        children: [
                                          Text(
                                            'ค่าโพแทสเซียน (P)',
                                            style: GoogleFonts.anuphan(
                                              fontSize: 20,
                                              fontWeight: FontWeight.normal,
                                              color: Colors.black87,
                                            ),
                                          ),

                                          // Spacer(),
                                          SizedBox(height: 10),
                                          CircularPercentIndicator(
                                            radius: 60,
                                            lineWidth: 20,
                                            backgroundColor: Colors.grey.shade300,
                                            progressColor: progressColor9, // ไม่ใช้งาน progressColor แล้ว
                                            animation: true,
                                            animationDuration: 2000,
                                            circularStrokeCap: CircularStrokeCap.round,
                                            percent: percentp,
                                            center: OverflowBox(
                                              maxWidth: double.infinity,
                                              alignment: Alignment.center,
                                              child: Text(
                                                '$p mg/kg',
                                                style: GoogleFonts.anuphan(
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black87,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 30),
                              FadeInAnimation(
                                delay: 4,
                                child: AppCard(
                                  height: 200,
                                  child: Row(
                                    children: [
                                      Column(
                                        children: [
                                          Text(
                                            'ค่าฟอสฟอรัส (K)',
                                            style: GoogleFonts.anuphan(
                                              fontSize: 20,
                                              fontWeight: FontWeight.normal,
                                              color: Colors.black87,
                                            ),
                                          ),

                                          // Spacer(),
                                          SizedBox(height: 10),
                                          CircularPercentIndicator(
                                            radius: 60,
                                            lineWidth: 20,
                                            backgroundColor: Colors.grey.shade300,
                                            progressColor: progressColor10, // ไม่ใช้งาน progressColor แล้ว
                                            animation: true,
                                            animationDuration: 2000,
                                            circularStrokeCap: CircularStrokeCap.round,
                                            percent: percentk,
                                            center: OverflowBox(
                                              maxWidth: double.infinity,
                                              alignment: Alignment.center,
                                              child: Text(
                                                '$k mg/kg',
                                                style: GoogleFonts.anuphan(
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black87,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              Text(
                                'ปุ๋ยน้ำ  ${_isFerzOn == 1 ? 'เปิด' : 'ปิด'}',
                                style: GoogleFonts.anuphan(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              ElevatedButton(
                                onPressed: _toggleFerz,
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<Color>(
                                    _isFerzOn == 1 ? Colors.redAccent : Colors.lightGreen, // สีของปุ่มเป็นแดงเมื่อเปิดและเขียวเมื่อปิด
                                  ),
                                ),
                                child: Text(
                                  _isFerzOn == 1 ? 'ปิด' : 'เปิด',
                                  style: GoogleFonts.anuphan(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white, // สีข้อความในปุ่ม
                                  ),
                                ),
                              ),


                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return Text(
                    'กำลังโหลด...',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                    ),
                  );
                }
              },
            ),

            // StreamBuilder(
            //   stream: FirebaseFirestore.instance
            //       .collection("client")
            //       .where("UID",
            //       isEqualTo: FirebaseAuth
            //           .instance.currentUser?.uid)
            //       .snapshots(),
            //   builder: (context,
            //       AsyncSnapshot<QuerySnapshot> snapshot) {
            //     if (!snapshot.hasData) {
            //       return Center(
            //         child: CircularProgressIndicator(),
            //       );
            //     }
            //     var documents = snapshot.data!.docs;
            //
            //     return Column(
            //       children: documents.map((document) {
            //         return Column(
            //           children: [
            //             ListTile(
            //               leading: Icon(
            //                 Icons.house,
            //                 color: Colors.green.shade800,
            //                 size: 40,
            //               ),
            //               title: Text(
            //                 "แปลงปลูกที่ 1 : ${document['farm1']}",
            //                 style: TextStyle(fontSize: 20),
            //               ),
            //             ),
            //           ],
            //         );
            //       }).toList(),
            //     );
            //   },
            // ),

          ],
        ),
      ),
    );
  }
}
