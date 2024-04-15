import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_farm_app/screens/old/farm_screen.dart';

import 'farm_screen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
      backgroundColor: Color(0xD9D9D9),
      appBar: AppBar(
        toolbarHeight: 100,
        centerTitle: true,
        backgroundColor: Colors.lightGreenAccent,
        title: Text(
          "New",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.black54,
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(30),
              child: Text(
                "วันที่ "+dateText+"     "+"เวลา"+timeText,
                style: const TextStyle(
                  fontSize: 40,
                  color: Colors.black54,
                  letterSpacing: 3,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            //block1
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                boxShadow: [
                    BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 20
                    ),
                  ],
                ),
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.arrow_forward_ios, color:Colors.black87),
                    label: Row(
                      children: [
                        Image.asset(
                          'images/กะเพรา.png',
                          width: 100,
                          height: 100,
                        ),
                        Text(
                          "กะเพรา",
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                            color: Colors.black45,
                            letterSpacing: 3,
                          ),
                        ),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(40), backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12), // กำหนดความโค้งของปุ่ม
                      ),
                    ),
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => FarmScreen(),
                      ));
                    },
                  ),
                ),
                SizedBox(width: 50),
                Container(
                  decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        spreadRadius: 1,
                        blurRadius: 20
                    ),
                  ],
                ),

                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.arrow_forward_ios, color:Colors.black87),
                    label: Row(
                      children: [
                        Image.asset(
                          'images/พริก.png',
                          width: 100,
                          height: 100,
                        ),
                        Text(
                          "พริก",
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                            color: Colors.black45,
                            letterSpacing: 3,
                          ),
                        ),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(40), backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12), // กำหนดความโค้งของปุ่ม
                      ),
                    ),
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(),
                      ));
                    },
                  ),
                ),
                SizedBox(width: 50),

                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 20
                      ),
                    ],
                  ),
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.arrow_forward_ios, color:Colors.black87),

                    label: Row(
                      children: [
                        Image.asset(
                            'images/ฟ้าทะลายโจร.png',
                          width: 100,
                          height: 100,
                        ),
                        Text(
                          "ฟ้าทะลายโจร",
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                            color: Colors.black45,
                            letterSpacing: 3,
                          ),
                        ),

                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(40), backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12), // กำหนดความโค้งของปุ่ม
                      ),
                    ),
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(),
                      ));
                    },
                  ),
                ),

              ],
            )
          ],
        ),
      ),
    );
  }
}
