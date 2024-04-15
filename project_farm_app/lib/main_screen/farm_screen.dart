import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../animations/fade_in.dart';
import '../widgets/app_card.dart';

class FarmScreen extends StatefulWidget {
  const FarmScreen({super.key});

  @override
  State<FarmScreen> createState() => _FarmScreenState();
}

class _FarmScreenState extends State<FarmScreen> {
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
    double w = (MediaQuery.sizeOf(context).width / 2) - 35;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        centerTitle: true,
        backgroundColor: Colors.lightGreenAccent,
        title: Text(
          "MongKaset 2023",
          style: TextStyle(
            fontSize: 50,
            fontWeight: FontWeight.w500,
            color: Colors.black54,
          ),
        ),
      ),

        body: Padding(
          padding: const EdgeInsets.all(20),
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('client')
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .collection('DATA')
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                final clients = snapshot.data?.docs.reversed.toList();
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: clients!.map((client) {


                      final data = client.data() as Map<String, dynamic>;
                      final tempValue = data['ANBTEMP']; // เข้าถึงข้อมูล TEMP จาก Firestore
                      final tempValue2 = double.parse(tempValue);
                      final soilhumid = data['SOILHUMID'];// เข้าถึงข้อมูล LED จาก Firestore
                      final surhumid = data['SURHUMID'];
                      final soiltemp = data['SOILTEMP'];
                      final surlight = data['SURLIGHT'];
                      final soilelec = data['SOILELEC'];
                      final soilph = data['SOILPH'];
                      final n = data['N'];
                      final p = data['P'];
                      final k = data['K'];
                      final ledvalue = data['LED'];
                      final watervalue = data['WATER'];
                      // final double value = double.parse(ledValue);
                      // final ldrValue = data['LDR'];
                      // final double value1 = double.parse(ldrValue);
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
                                    delay: 1.5,
                                    child: AppCard(
                                      height: 150,
                                      child: Row(
                                        children: [
                                          Column(
                                            children: [
                                              const Text(
                                                'อุณหภูมิโดยรอบ',
                                                style: TextStyle(fontSize: 18,
                                                    fontFamily: 'Prompt-Bold'),
                                              ),

                                              // Spacer(),
                                              Text(
                                                '$tempValue  °C',
                                                style: TextStyle(fontFamily: 'Prompt-Bold',
                                                    fontSize: 26),
                                              ),
                                              // CircularPercentIndicator(
                                              //  radius: 40.0,
                                              //  lineWidth: 13.0,
                                              //  animation: true,
                                              //  percent: 0.7,
                                              //  center:  Text(
                                              //    "$tempValue °C",
                                              //    style:
                                              //    new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                                              //  ),
                                              // ),


                                              // Spacer(),
                                              // SizedBox(
                                              //   height: 30,
                                              //   width: 30,
                                              //   child: Image.asset(
                                              //     'images/temp.png',
                                              //     color: Colors.deepPurple,
                                              //   ),
                                              // ),

                                            ],
                                          ),
                                          // const Expanded(
                                          //
                                          //   child: ProgressWithText(
                                          //     value: tempValue2,
                                          //     indicatorValue: .67,
                                          //     title: '°C ',
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 30),
                                  FadeInAnimation(
                                    delay: 2.5,
                                    child: AppCard(
                                      height: 150,
                                      child: Row(
                                        children: [
                                          Column(
                                            children: [
                                              const Text(
                                                'อุณหภูมิในดิน',
                                                style: TextStyle(fontFamily: 'Prompt-Bold',
                                                    fontSize: 18),
                                              ),

                                              // Spacer(),
                                              Text(
                                                '$soiltemp  °C',
                                                style: TextStyle(fontFamily: 'Prompt-Bold',
                                                    fontSize: 26),
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
                                      height: 150,
                                      child: Row(
                                        children: [
                                          Column(
                                            children: [
                                              Text(
                                                'ความชื้นโดยรอบ',
                                                style: TextStyle(fontFamily: 'Prompt-Bold',
                                                    fontSize: 16),
                                              ),

                                              // Spacer(),
                                              Text(
                                                '$surhumid  %',
                                                style: TextStyle(fontFamily: 'Prompt-Bold',
                                                    fontSize: 26),
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
                                      height: 150,
                                      child: Row(
                                        children: [
                                          Column(
                                            children: [
                                              const Text(
                                                'ความชื้นในดิน',
                                                style: TextStyle(fontFamily: 'Prompt-Bold',
                                                    fontSize: 18),
                                              ),

                                              // Spacer(),
                                              Text(
                                                '$soilhumid  %',
                                                style: TextStyle(fontFamily: 'Prompt-Bold',
                                                    fontSize: 26),
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
                                      height: 150,
                                      child: Row(
                                        children: [
                                          Column(
                                            children: [
                                              const Text(
                                                'แสงโดยรอบ',
                                                style: TextStyle(fontFamily: 'Prompt-Bold',
                                                    fontSize: 18),
                                              ),

                                              // Spacer(),
                                              Text(
                                                '$surlight  Lux',
                                                style: const TextStyle(
                                                    fontFamily: 'Prompt-Bold',
                                                    fontSize: 26),
                                              ),
                                            ],
                                          ),
                                        ],
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
                                    delay: 1.5,
                                    child: AppCard(
                                      height: 150,
                                      child: Row(
                                        children: [
                                          Column(
                                            children: [
                                              const Text(
                                                'ค่า EC ในดิน',
                                                style: TextStyle(fontFamily: 'Prompt-Bold',
                                                    fontSize: 18),
                                              ),

                                              // Spacer(),
                                              Text(
                                                '$soilelec  ',
                                                style: const TextStyle(fontFamily: 'Prompt-Bold',
                                                    fontSize: 28),
                                              ),
                                              Text(
                                                'uS/cm',
                                                style: const TextStyle(fontFamily: 'Prompt-Bold',
                                                    fontSize: 22),
                                              ),


                                            ],
                                          ),

                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 30),
                                  FadeInAnimation(
                                    delay: 2.5,
                                    child: AppCard(
                                      height: 150,
                                      child: Row(
                                        children: [
                                          Column(
                                            children: [
                                              const Text(
                                                'ต่า pH ในดิน',
                                                style: TextStyle(fontFamily: 'Prompt-Bold',
                                                    fontSize: 18),
                                              ),

                                              // Spacer(),
                                              Text(
                                                '$soilph ',
                                                style: const TextStyle(fontFamily: 'Prompt-Bold',
                                                    fontSize: 32),
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
                                      height: 150,
                                      child: Row(
                                        children: [
                                          Column(
                                            children: [
                                              const Text(
                                                'ค่าไนโตรเจน (N)',
                                                style: TextStyle(fontFamily: 'Prompt-Bold',
                                                    fontSize: 18),
                                              ),

                                              // Spacer(),
                                              Text(
                                                '$n ',
                                                style: const TextStyle(fontFamily: 'Prompt-Bold',
                                                    fontSize: 28),
                                              ),
                                              Text(
                                                'mg/kg',
                                                style: const TextStyle(fontFamily: 'Prompt-Bold',
                                                    fontSize: 22),
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
                                      height: 150,
                                      child: Row(
                                        children: [
                                          Column(
                                            children: [
                                              const Text(
                                                'ค่าโพแทสเซียน (P)',
                                                style: TextStyle(fontFamily: 'Prompt-Bold',
                                                    fontSize: 14),
                                              ),

                                              // Spacer(),
                                              Text(
                                                '$p ',
                                                style: TextStyle(fontFamily: 'Prompt-Bold',
                                                    fontSize: 28),
                                              ),
                                              Text(
                                                'mg/kg',
                                                style: const TextStyle(fontFamily: 'Prompt-Bold',
                                                    fontSize: 22),
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
                                      height: 150,
                                      child: Row(
                                        children: [
                                          Column(
                                            children: [
                                              const Text(
                                                'ค่าฟอสฟอรัส (K)',
                                                style: TextStyle(fontFamily: 'Prompt-Bold',
                                                    fontSize: 16),
                                              ),

                                              // Spacer(),
                                              Text(
                                                '$k',
                                                style: TextStyle(fontFamily: 'Prompt-Bold',
                                                    fontSize: 28),
                                              ),
                                              Text(
                                                'mg/kg',
                                                style: const TextStyle(fontFamily: 'Prompt-Bold',
                                                    fontSize: 22),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),


                          ],
                        ),
                      );
                    }).toList(),
                  ),
                );
              }
            },
          ),

          // child: Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     Container(
          //       decoration: BoxDecoration(
          //         boxShadow: [
          //           BoxShadow(
          //               color: Colors.black.withOpacity(0.3),
          //               spreadRadius: 1,
          //               blurRadius: 20
          //           ),
          //         ],
          //       ),
          //           child: const Card(
          //             elevation: 0,
          //             color: Colors.white,
          //             child: SizedBox(
          //               width: 300,
          //               height: 100,
          //
          //               child: Center
          //                 (child: Text(
          //                 "กะเพรา",
          //                 style: TextStyle(
          //                   fontSize: 30,
          //                   fontWeight: FontWeight.w500,
          //                   color: Colors.black45,
          //                   letterSpacing: 3,
          //                 ),
          //               ),),
          //             ),
          //
          //           ),
          //     ),
          //   ],
          // ),
        ),


    );
  }
}
