// import 'dart:developer';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:project_farm_app/screens/farm.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:iconsax/iconsax.dart';
// import 'package:project_farm_app/animations/fade_in.dart';
// import 'package:project_farm_app/screens/profile_page.dart';
// import 'package:project_farm_app/widgets/app_card.dart';
// import 'package:percent_indicator/percent_indicator.dart';
//
// import '../widgets/increasing_text.dart';
// import '../widgets/progress_with_text.dart';
//
// class TestPage extends StatefulWidget {
//   final String uid_data;
//   final String documentId;
//   // final String documentId;
//   // const TestPage({Key? key, required this.documentId}) : super(key: key);
//   const TestPage({super.key,
//     required this.documentId,
//     required this.uid_data,});
//   // const TestPage({super.key,required this.documentId});
//
//
//   @override
//   State<TestPage> createState() => TestPageState();
// }
//
// class TestPageState extends State<TestPage> {
//
//
//   final currentUser = FirebaseAuth.instance;
//   FirebaseAuth auth = FirebaseAuth.instance;
//   User? user;
//   final DatabaseReference _lightRef =
//   FirebaseDatabase.instance.reference().child('light');
//   final DatabaseReference _waterRef =
//   FirebaseDatabase.instance.reference().child('water');
//   final DatabaseReference _ferzRef =
//   FirebaseDatabase.instance.reference().child('ferz');
//   bool _isLightOn = false;
//   bool _isWaterOn = false;
//   bool _isFerzOn = false;
//   @override
//   void initState() {
//
//     if (auth.currentUser != null)
//     {
//       user= auth.currentUser;
//     }
//     // Set initial value here or load it from Firestore
//   }
//
//   void _toggleLight() {
//     _lightRef.set(!_isLightOn);
//     setState(() {
//       _isLightOn = !_isLightOn;
//     });
//   }
//   void _toggleWater() {
//     _waterRef.set(!_isWaterOn);
//     setState(() {
//       _isWaterOn = !_isWaterOn;
//     });
//   }
//   void _toggleLight3() {
//     _ferzRef.set(!_isFerzOn);
//     setState(() {
//       _isFerzOn = !_isFerzOn;
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//     double w = (MediaQuery.sizeOf(context).width / 2) - 35;
//     return Scaffold(
//       appBar: AppBar(backgroundColor: Color(0xFFFFA600),
//         title: Text('MPPN 2024',
//           style: GoogleFonts.anuphan(
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//             color: Colors.white70,
//           ),
//         ),
//         automaticallyImplyLeading: false,
//         actions: [
//           IconButton(
//             onPressed: () {
//               Navigator.pop(context); // ใช้ Navigator.pop เพื่อกลับหน้า
//             },
//             icon: const Icon(Icons.logout),
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.symmetric(horizontal: 20),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const SizedBox(height: 10),
//             FadeInAnimation(
//               delay: 1,
//               child: Row(
//                 children: [
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//
//                       Text(
//                         "Welcome ${user?.email}",
//                         style: TextStyle(fontSize: 20,
//                           fontFamily: 'Prompt-Light',),
//                       ),
//                       SizedBox(
//                         height: 16.0,
//                       ),
//                     ],
//
//                   ),
//                   const Spacer(),
//                   SizedBox(
//                     height: 70,
//                     width: 70,
//                     child: Hero(
//                       tag: const Key('image'),
//                       child: Container(
//                         decoration: const ShapeDecoration(
//                           shape: StarBorder(
//                             innerRadiusRatio: .9,
//                             pointRounding: .2,
//                             points: 10,
//                           ),
//                           image: DecorationImage(
//                             image: AssetImage('images/model.jpg'),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//
//
//                 ],
//               ),
//             ),
//             const SizedBox(
//               height: 8.0,
//             ),
//             // StreamBuilder<QuerySnapshot>(
//             //   stream: FirebaseFirestore.instance
//             //       .collection('client')
//             //       .doc(FirebaseAuth.instance.currentUser!.uid)
//             //       .collection('DATA')
//             //       .snapshots(),
//             //   builder: (context, snapshot) {
//             //     if (snapshot.connectionState == ConnectionState.waiting) {
//             //       return Center(child: CircularProgressIndicator());
//             //     } else if (snapshot.hasError) {
//             //       return Center(child: Text('Error: ${snapshot.error}'));
//             //     } else {
//             //       final clients = snapshot.data?.docs.reversed.toList();
//             //       return SingleChildScrollView(
//             //         child: Column(
//             //           crossAxisAlignment: CrossAxisAlignment.start,
//             //           children: clients!.map((client) {
//             //
//             //             final data = client.data() as Map<String, dynamic>;
//             //             final uidData = data['uid_data']; // ดึง uid_data ของแต่ละรายการ
//             //             final tempValue = data['ANBTEMP']; // เข้าถึงข้อมูล TEMP จาก Firestore
//             //             final tempValue2 = double.parse(tempValue);
//             //             final soilhumid = data['SOILHUMID'];// เข้าถึงข้อมูล LED จาก Firestore
//             //             final surhumid = data['SURHUMID'];
//             //             final soiltemp = data['SOILTEMP'];
//             //             final surlight = data['SURLIGHT'];
//             //             final soilelec = data['SOILELEC'];
//             //             final soilph = data['SOILPH'];
//             //             final n = data['N'];
//             //             final p = data['P'];
//             //             final k = data['K'];
//             //             final ledvalue = data['LED'];
//             //             final watervalue = data['WATER'];
//             //             final name = data['NAME'];
//             //             // final double value = double.parse(ledValue);
//             //             // final ldrValue = data['LDR'];
//             //             // final double value1 = double.parse(ldrValue);
//             //             return Padding(
//             //               padding: const EdgeInsets.symmetric(vertical: 10.0),
//             //               child: Row(
//             //                 crossAxisAlignment: CrossAxisAlignment.start,
//             //                 children: [
//             //                   SizedBox(
//             //                     width: w,
//             //                     child: Column(
//             //                       crossAxisAlignment: CrossAxisAlignment.start,
//             //                       children: [
//             //                         Text('$name'),
//             //                         //button
//             //                         Text(
//             //                           'น้ำ ${_isWaterOn ? 'เปิด' : 'ปิด'}',style: GoogleFonts.anuphan(
//             //                           fontSize: 20,
//             //                           fontWeight: FontWeight.bold,
//             //                         ),
//             //                         ),
//             //                         SizedBox(height: 20.0),
//             //                         ElevatedButton(
//             //                           onPressed: _toggleWater,
//             //                           child: Text(_isWaterOn ? 'ปิด' : 'เปิด',style: GoogleFonts.anuphan(
//             //                             fontSize: 30,
//             //                             fontWeight: FontWeight.bold,
//             //                           ),),
//             //                         ),
//             //
//             //                         Text(
//             //                           'แสงเสริม  ${_isLightOn ? 'เปิด' : 'ปิด'}',style: GoogleFonts.anuphan(
//             //                           fontSize: 20,
//             //                           fontWeight: FontWeight.bold,
//             //                         ),
//             //                         ),
//             //
//             //
//             //                         SizedBox(height: 20.0),
//             //                         ElevatedButton(
//             //                             onPressed: _toggleLight,
//             //                             child: Text(_isLightOn ? 'ปิด' : 'เปิด',style: GoogleFonts.anuphan(
//             //                               fontSize: 30,
//             //                               fontWeight: FontWeight.bold,
//             //                             ),)
//             //                         ),
//             //
//             //                         Text(
//             //                           'ปุ๋ยน้ำ  ${_isFerzOn ? 'เปิด' : 'ปิด'}',style: GoogleFonts.anuphan(
//             //                           fontSize: 20,
//             //                           fontWeight: FontWeight.bold,
//             //                         ),
//             //                         ),
//             //                         SizedBox(height: 20.0),
//             //                         ElevatedButton(
//             //                           onPressed: _toggleLight3,
//             //                           child: Text(_isFerzOn ? 'ปิด' : 'เปิด',style: GoogleFonts.anuphan(
//             //                             fontSize: 30,
//             //                             fontWeight: FontWeight.bold,
//             //                           ),),
//             //                         ),
//             //
//             //                         FadeInAnimation(
//             //                           delay: 1.5,
//             //                           child: AppCard(
//             //                             height: 150,
//             //                             child: Row(
//             //                               children: [
//             //                                 Column(
//             //                                   children: [
//             //
//             //                                     const Text(
//             //                                       'อุณหภูมิโดยรอบ',
//             //                                       style: TextStyle(fontSize: 18,
//             //                                           fontFamily: 'Prompt-Bold'),
//             //                                     ),
//             //
//             //                                     // Spacer(),
//             //                                     Text(
//             //                                       '$tempValue  °C',
//             //                                       style: TextStyle(fontFamily: 'Prompt-Bold',
//             //                                           fontSize: 26),
//             //                                     ),
//             //                                     // CircularPercentIndicator(
//             //                                     //  radius: 40.0,
//             //                                     //  lineWidth: 13.0,
//             //                                     //  animation: true,
//             //                                     //  percent: 0.7,
//             //                                     //  center:  Text(
//             //                                     //    "$tempValue °C",
//             //                                     //    style:
//             //                                     //    new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
//             //                                     //  ),
//             //                                     // ),
//             //
//             //
//             //                                     // Spacer(),
//             //                                     // SizedBox(
//             //                                     //   height: 30,
//             //                                     //   width: 30,
//             //                                     //   child: Image.asset(
//             //                                     //     'images/temp.png',
//             //                                     //     color: Colors.deepPurple,
//             //                                     //   ),
//             //                                     // ),
//             //
//             //                                   ],
//             //                                 ),
//             //                                 // const Expanded(
//             //                                 //
//             //                                 //   child: ProgressWithText(
//             //                                 //     value: tempValue2,
//             //                                 //     indicatorValue: .67,
//             //                                 //     title: '°C ',
//             //                                 //   ),
//             //                                 // ),
//             //                               ],
//             //                             ),
//             //                           ),
//             //                         ),
//             //                         const SizedBox(height: 30),
//             //                         FadeInAnimation(
//             //                           delay: 2.5,
//             //                           child: AppCard(
//             //                             height: 150,
//             //                             child: Row(
//             //                               children: [
//             //                                 Column(
//             //                                   children: [
//             //                                     const Text(
//             //                                       'อุณหภูมิในดิน',
//             //                                       style: TextStyle(fontFamily: 'Prompt-Bold',
//             //                                           fontSize: 18),
//             //                                     ),
//             //
//             //                                     // Spacer(),
//             //                                     Text(
//             //                                       '$soiltemp  °C',
//             //                                       style: TextStyle(fontFamily: 'Prompt-Bold',
//             //                                           fontSize: 26),
//             //                                     ),
//             //                                   ],
//             //                                 ),
//             //                               ],
//             //                             ),
//             //                           ),
//             //                         ),
//             //                         const SizedBox(height: 30),
//             //                         FadeInAnimation(
//             //                           delay: 3,
//             //                           child: AppCard(
//             //                             height: 150,
//             //                             child: Row(
//             //                               children: [
//             //                                 Column(
//             //                                   children: [
//             //                                     Text(
//             //                                       'ความชื้นโดยรอบ',
//             //                                       style: TextStyle(fontFamily: 'Prompt-Bold',
//             //                                           fontSize: 16),
//             //                                     ),
//             //
//             //                                     // Spacer(),
//             //                                     Text(
//             //                                       '$surhumid  %',
//             //                                       style: TextStyle(fontFamily: 'Prompt-Bold',
//             //                                           fontSize: 26),
//             //                                     ),
//             //                                   ],
//             //                                 ),
//             //                               ],
//             //                             ),
//             //                           ),
//             //                         ),
//             //                         const SizedBox(height: 30),
//             //                         FadeInAnimation(
//             //                           delay: 3.5,
//             //                           child: AppCard(
//             //                             height: 150,
//             //                             child: Row(
//             //                               children: [
//             //                                 Column(
//             //                                   children: [
//             //                                     const Text(
//             //                                       'ความชื้นในดิน',
//             //                                       style: TextStyle(fontFamily: 'Prompt-Bold',
//             //                                           fontSize: 18),
//             //                                     ),
//             //
//             //                                     // Spacer(),
//             //                                     Text(
//             //                                       '$soilhumid  %',
//             //                                       style: TextStyle(fontFamily: 'Prompt-Bold',
//             //                                           fontSize: 26),
//             //                                     ),
//             //                                   ],
//             //                                 ),
//             //                               ],
//             //                             ),
//             //                           ),
//             //                         ),
//             //                         const SizedBox(height: 30),
//             //                         FadeInAnimation(
//             //                           delay: 4,
//             //                           child: AppCard(
//             //                             height: 150,
//             //                             child: Row(
//             //                               children: [
//             //                                 Column(
//             //                                   children: [
//             //                                     const Text(
//             //                                       'แสงโดยรอบ',
//             //                                       style: TextStyle(fontFamily: 'Prompt-Bold',
//             //                                           fontSize: 18),
//             //                                     ),
//             //
//             //                                     // Spacer(),
//             //                                     Text(
//             //                                       '$surlight  Lux',
//             //                                       style: const TextStyle(
//             //                                           fontFamily: 'Prompt-Bold',
//             //                                           fontSize: 26),
//             //                                     ),
//             //                                   ],
//             //                                 ),
//             //                               ],
//             //                             ),
//             //                           ),
//             //                         ),
//             //                       ],
//             //                     ),
//             //                   ),
//             //                   const Spacer(),
//             //                   SizedBox(
//             //                     width: w,
//             //                     child: Column(
//             //                       crossAxisAlignment: CrossAxisAlignment.start,
//             //                       children: [
//             //                         FadeInAnimation(
//             //                           delay: 1.5,
//             //                           child: AppCard(
//             //                             height: 150,
//             //                             child: Row(
//             //                               children: [
//             //                                 Column(
//             //                                   children: [
//             //                                     const Text(
//             //                                       'ค่า EC ในดิน',
//             //                                       style: TextStyle(fontFamily: 'Prompt-Bold',
//             //                                           fontSize: 18),
//             //                                     ),
//             //
//             //                                     // Spacer(),
//             //                                     Text(
//             //                                       '$soilelec  ',
//             //                                       style: const TextStyle(fontFamily: 'Prompt-Bold',
//             //                                           fontSize: 28),
//             //                                     ),
//             //                                     Text(
//             //                                       'uS/cm',
//             //                                       style: const TextStyle(fontFamily: 'Prompt-Bold',
//             //                                           fontSize: 22),
//             //                                     ),
//             //
//             //
//             //                                   ],
//             //                                 ),
//             //
//             //                               ],
//             //                             ),
//             //                           ),
//             //                         ),
//             //                         const SizedBox(height: 30),
//             //                         FadeInAnimation(
//             //                           delay: 2.5,
//             //                           child: AppCard(
//             //                             height: 150,
//             //                             child: Row(
//             //                               children: [
//             //                                 Column(
//             //                                   children: [
//             //                                     const Text(
//             //                                       'ต่า pH ในดิน',
//             //                                       style: TextStyle(fontFamily: 'Prompt-Bold',
//             //                                           fontSize: 18),
//             //                                     ),
//             //
//             //                                     // Spacer(),
//             //                                     Text(
//             //                                       '$soilph ',
//             //                                       style: const TextStyle(fontFamily: 'Prompt-Bold',
//             //                                           fontSize: 32),
//             //                                     ),
//             //                                   ],
//             //                                 ),
//             //                               ],
//             //                             ),
//             //                           ),
//             //                         ),
//             //                         const SizedBox(height: 30),
//             //                         FadeInAnimation(
//             //                           delay: 3,
//             //                           child: AppCard(
//             //                             height: 150,
//             //                             child: Row(
//             //                               children: [
//             //                                 Column(
//             //                                   children: [
//             //                                     const Text(
//             //                                       'ค่าไนโตรเจน (N)',
//             //                                       style: TextStyle(fontFamily: 'Prompt-Bold',
//             //                                           fontSize: 18),
//             //                                     ),
//             //
//             //                                     // Spacer(),
//             //                                     Text(
//             //                                       '$n ',
//             //                                       style: const TextStyle(fontFamily: 'Prompt-Bold',
//             //                                           fontSize: 28),
//             //                                     ),
//             //                                     Text(
//             //                                       'mg/kg',
//             //                                       style: const TextStyle(fontFamily: 'Prompt-Bold',
//             //                                           fontSize: 22),
//             //                                     ),
//             //                                   ],
//             //                                 ),
//             //                               ],
//             //                             ),
//             //                           ),
//             //                         ),
//             //                         const SizedBox(height: 30),
//             //                         FadeInAnimation(
//             //                           delay: 3.5,
//             //                           child: AppCard(
//             //                             height: 150,
//             //                             child: Row(
//             //                               children: [
//             //                                 Column(
//             //                                   children: [
//             //                                     const Text(
//             //                                       'ค่าโพแทสเซียน (P)',
//             //                                       style: TextStyle(fontFamily: 'Prompt-Bold',
//             //                                           fontSize: 14),
//             //                                     ),
//             //
//             //                                     // Spacer(),
//             //                                     Text(
//             //                                       '$p ',
//             //                                       style: TextStyle(fontFamily: 'Prompt-Bold',
//             //                                           fontSize: 28),
//             //                                     ),
//             //                                     Text(
//             //                                       'mg/kg',
//             //                                       style: const TextStyle(fontFamily: 'Prompt-Bold',
//             //                                           fontSize: 22),
//             //                                     ),
//             //                                   ],
//             //                                 ),
//             //                               ],
//             //                             ),
//             //                           ),
//             //                         ),
//             //                         const SizedBox(height: 30),
//             //                         FadeInAnimation(
//             //                           delay: 4,
//             //                           child: AppCard(
//             //                             height: 150,
//             //                             child: Row(
//             //                               children: [
//             //                                 Column(
//             //                                   children: [
//             //                                     const Text(
//             //                                       'ค่าฟอสฟอรัส (K)',
//             //                                       style: TextStyle(fontFamily: 'Prompt-Bold',
//             //                                           fontSize: 16),
//             //                                     ),
//             //
//             //                                     // Spacer(),
//             //                                     Text(
//             //                                       '$k',
//             //                                       style: TextStyle(fontFamily: 'Prompt-Bold',
//             //                                           fontSize: 28),
//             //                                     ),
//             //                                     Text(
//             //                                       'mg/kg',
//             //                                       style: const TextStyle(fontFamily: 'Prompt-Bold',
//             //                                           fontSize: 22),
//             //                                     ),
//             //                                   ],
//             //                                 ),
//             //                               ],
//             //                             ),
//             //                           ),
//             //                         ),
//             //                       ],
//             //                     ),
//             //                   ),
//             //                 ],
//             //               ),
//             //             );
//             //           }).toList(),
//             //         ),
//             //       );
//             //     }
//             //   },
//             // )
//
//             StreamBuilder(
//               stream: FirebaseFirestore.instance
//                   .collection("client")
//                   .doc(FirebaseAuth.instance.currentUser!.uid)
//                   .collection("DATA")
//                   .doc(widget.uid_data)
//                   .snapshots(),
//               builder: (context, snapshot) {
//                 if (snapshot.hasData) {
//                   final data = snapshot.data;
//                   final name1 = data?['NAME'] ?? '';
//                   final uidData = data?['uid_data']?? ''; // ดึง uid_data ของแต่ละรายการ
//                   final tempValue = data?['ANBTEMP']; // เข้าถึงข้อมูล TEMP จาก Firestore
//                   final tempValue2 = double.parse(tempValue);
//                   final soilhumid = data?['SOILHUMID'];// เข้าถึงข้อมูล LED จาก Firestore
//                   final surhumid = data?['SURHUMID'];
//                   final soiltemp = data?['SOILTEMP'];
//                   final surlight = data?['SURLIGHT'];
//                   final soilelec = data?['SOILELEC'];
//                   final soilph = data?['SOILPH'];
//                   final n = data?['N'];
//                   final p = data?['P'];
//                   final k = data?['K'];
//                   final ledvalue = data?['LED'];
//                   final watervalue = data?['WATER'];
//                   return Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 10.0),
//                     child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         SizedBox(
//                           width: w,
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text('$name1'),
//                               //button
//                               Text(
//                                 'น้ำ ${_isWaterOn ? 'เปิด' : 'ปิด'}',style: GoogleFonts.anuphan(
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                               ),
//                               SizedBox(height: 20.0),
//                               ElevatedButton(
//                                 onPressed: _toggleWater,
//                                 child: Text(_isWaterOn ? 'ปิด' : 'เปิด',style: GoogleFonts.anuphan(
//                                   fontSize: 30,
//                                   fontWeight: FontWeight.bold,
//                                 ),),
//                               ),
//
//                               Text(
//                                 'แสงเสริม  ${_isLightOn ? 'เปิด' : 'ปิด'}',style: GoogleFonts.anuphan(
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                               ),
//
//
//                               SizedBox(height: 20.0),
//                               ElevatedButton(
//                                   onPressed: _toggleLight,
//                                   child: Text(_isLightOn ? 'ปิด' : 'เปิด',style: GoogleFonts.anuphan(
//                                     fontSize: 30,
//                                     fontWeight: FontWeight.bold,
//                                   ),)
//                               ),
//
//                               Text(
//                                 'ปุ๋ยน้ำ  ${_isFerzOn ? 'เปิด' : 'ปิด'}',style: GoogleFonts.anuphan(
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                               ),
//                               SizedBox(height: 20.0),
//                               ElevatedButton(
//                                 onPressed: _toggleLight3,
//                                 child: Text(_isFerzOn ? 'ปิด' : 'เปิด',style: GoogleFonts.anuphan(
//                                   fontSize: 30,
//                                   fontWeight: FontWeight.bold,
//                                 ),),
//                               ),
//
//                               FadeInAnimation(
//                                 delay: 1.5,
//                                 child: AppCard(
//                                   height: 150,
//                                   child: Row(
//                                     children: [
//                                       Column(
//                                         children: [
//
//                                           const Text(
//                                             'อุณหภูมิโดยรอบ',
//                                             style: TextStyle(fontSize: 18,
//                                                 fontFamily: 'Prompt-Bold'),
//                                           ),
//
//                                           // Spacer(),
//                                           Text(
//                                             '$tempValue  °C',
//                                             style: TextStyle(fontFamily: 'Prompt-Bold',
//                                                 fontSize: 26),
//                                           ),
//                                           // CircularPercentIndicator(
//                                           //  radius: 40.0,
//                                           //  lineWidth: 13.0,
//                                           //  animation: true,
//                                           //  percent: 0.7,
//                                           //  center:  Text(
//                                           //    "$tempValue °C",
//                                           //    style:
//                                           //    new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
//                                           //  ),
//                                           // ),
//
//
//                                           // Spacer(),
//                                           // SizedBox(
//                                           //   height: 30,
//                                           //   width: 30,
//                                           //   child: Image.asset(
//                                           //     'images/temp.png',
//                                           //     color: Colors.deepPurple,
//                                           //   ),
//                                           // ),
//
//                                         ],
//                                       ),
//                                       // const Expanded(
//                                       //
//                                       //   child: ProgressWithText(
//                                       //     value: tempValue2,
//                                       //     indicatorValue: .67,
//                                       //     title: '°C ',
//                                       //   ),
//                                       // ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                               const SizedBox(height: 30),
//                               FadeInAnimation(
//                                 delay: 2.5,
//                                 child: AppCard(
//                                   height: 150,
//                                   child: Row(
//                                     children: [
//                                       Column(
//                                         children: [
//                                           const Text(
//                                             'อุณหภูมิในดิน',
//                                             style: TextStyle(fontFamily: 'Prompt-Bold',
//                                                 fontSize: 18),
//                                           ),
//
//                                           // Spacer(),
//                                           Text(
//                                             '$soiltemp  °C',
//                                             style: TextStyle(fontFamily: 'Prompt-Bold',
//                                                 fontSize: 26),
//                                           ),
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                               const SizedBox(height: 30),
//                               FadeInAnimation(
//                                 delay: 3,
//                                 child: AppCard(
//                                   height: 150,
//                                   child: Row(
//                                     children: [
//                                       Column(
//                                         children: [
//                                           Text(
//                                             'ความชื้นโดยรอบ',
//                                             style: TextStyle(fontFamily: 'Prompt-Bold',
//                                                 fontSize: 16),
//                                           ),
//
//                                           // Spacer(),
//                                           Text(
//                                             '$surhumid  %',
//                                             style: TextStyle(fontFamily: 'Prompt-Bold',
//                                                 fontSize: 26),
//                                           ),
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                               const SizedBox(height: 30),
//                               FadeInAnimation(
//                                 delay: 3.5,
//                                 child: AppCard(
//                                   height: 150,
//                                   child: Row(
//                                     children: [
//                                       Column(
//                                         children: [
//                                           const Text(
//                                             'ความชื้นในดิน',
//                                             style: TextStyle(fontFamily: 'Prompt-Bold',
//                                                 fontSize: 18),
//                                           ),
//
//                                           // Spacer(),
//                                           Text(
//                                             '$soilhumid  %',
//                                             style: TextStyle(fontFamily: 'Prompt-Bold',
//                                                 fontSize: 26),
//                                           ),
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                               const SizedBox(height: 30),
//                               FadeInAnimation(
//                                 delay: 4,
//                                 child: AppCard(
//                                   height: 150,
//                                   child: Row(
//                                     children: [
//                                       Column(
//                                         children: [
//                                           const Text(
//                                             'แสงโดยรอบ',
//                                             style: TextStyle(fontFamily: 'Prompt-Bold',
//                                                 fontSize: 18),
//                                           ),
//
//                                           // Spacer(),
//                                           Text(
//                                             '$surlight  Lux',
//                                             style: const TextStyle(
//                                                 fontFamily: 'Prompt-Bold',
//                                                 fontSize: 26),
//                                           ),
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         const Spacer(),
//                         SizedBox(
//                           width: w,
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               FadeInAnimation(
//                                 delay: 1.5,
//                                 child: AppCard(
//                                   height: 150,
//                                   child: Row(
//                                     children: [
//                                       Column(
//                                         children: [
//                                           const Text(
//                                             'ค่า EC ในดิน',
//                                             style: TextStyle(fontFamily: 'Prompt-Bold',
//                                                 fontSize: 18),
//                                           ),
//
//                                           // Spacer(),
//                                           Text(
//                                             '$soilelec  ',
//                                             style: const TextStyle(fontFamily: 'Prompt-Bold',
//                                                 fontSize: 28),
//                                           ),
//                                           Text(
//                                             'uS/cm',
//                                             style: const TextStyle(fontFamily: 'Prompt-Bold',
//                                                 fontSize: 22),
//                                           ),
//
//
//                                         ],
//                                       ),
//
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                               const SizedBox(height: 30),
//                               FadeInAnimation(
//                                 delay: 2.5,
//                                 child: AppCard(
//                                   height: 150,
//                                   child: Row(
//                                     children: [
//                                       Column(
//                                         children: [
//                                           const Text(
//                                             'ต่า pH ในดิน',
//                                             style: TextStyle(fontFamily: 'Prompt-Bold',
//                                                 fontSize: 18),
//                                           ),
//
//                                           // Spacer(),
//                                           Text(
//                                             '$soilph ',
//                                             style: const TextStyle(fontFamily: 'Prompt-Bold',
//                                                 fontSize: 32),
//                                           ),
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                               const SizedBox(height: 30),
//                               FadeInAnimation(
//                                 delay: 3,
//                                 child: AppCard(
//                                   height: 150,
//                                   child: Row(
//                                     children: [
//                                       Column(
//                                         children: [
//                                           const Text(
//                                             'ค่าไนโตรเจน (N)',
//                                             style: TextStyle(fontFamily: 'Prompt-Bold',
//                                                 fontSize: 18),
//                                           ),
//
//                                           // Spacer(),
//                                           Text(
//                                             '$n ',
//                                             style: const TextStyle(fontFamily: 'Prompt-Bold',
//                                                 fontSize: 28),
//                                           ),
//                                           Text(
//                                             'mg/kg',
//                                             style: const TextStyle(fontFamily: 'Prompt-Bold',
//                                                 fontSize: 22),
//                                           ),
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                               const SizedBox(height: 30),
//                               FadeInAnimation(
//                                 delay: 3.5,
//                                 child: AppCard(
//                                   height: 150,
//                                   child: Row(
//                                     children: [
//                                       Column(
//                                         children: [
//                                           const Text(
//                                             'ค่าโพแทสเซียน (P)',
//                                             style: TextStyle(fontFamily: 'Prompt-Bold',
//                                                 fontSize: 14),
//                                           ),
//
//                                           // Spacer(),
//                                           Text(
//                                             '$p ',
//                                             style: TextStyle(fontFamily: 'Prompt-Bold',
//                                                 fontSize: 28),
//                                           ),
//                                           Text(
//                                             'mg/kg',
//                                             style: const TextStyle(fontFamily: 'Prompt-Bold',
//                                                 fontSize: 22),
//                                           ),
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                               const SizedBox(height: 30),
//                               FadeInAnimation(
//                                 delay: 4,
//                                 child: AppCard(
//                                   height: 150,
//                                   child: Row(
//                                     children: [
//                                       Column(
//                                         children: [
//                                           const Text(
//                                             'ค่าฟอสฟอรัส (K)',
//                                             style: TextStyle(fontFamily: 'Prompt-Bold',
//                                                 fontSize: 16),
//                                           ),
//
//                                           // Spacer(),
//                                           Text(
//                                             '$k',
//                                             style: TextStyle(fontFamily: 'Prompt-Bold',
//                                                 fontSize: 28),
//                                           ),
//                                           Text(
//                                             'mg/kg',
//                                             style: const TextStyle(fontFamily: 'Prompt-Bold',
//                                                 fontSize: 22),
//                                           ),
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//                 } else {
//                   return Text(
//                     'กำลังโหลด...',
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 30,
//                     ),
//                   );
//                 }
//               },
//             ),
//
//             // StreamBuilder(
//             //   stream: FirebaseFirestore.instance
//             //       .collection("client")
//             //       .where("UID",
//             //       isEqualTo: FirebaseAuth
//             //           .instance.currentUser?.uid)
//             //       .snapshots(),
//             //   builder: (context,
//             //       AsyncSnapshot<QuerySnapshot> snapshot) {
//             //     if (!snapshot.hasData) {
//             //       return Center(
//             //         child: CircularProgressIndicator(),
//             //       );
//             //     }
//             //     var documents = snapshot.data!.docs;
//             //
//             //     return Column(
//             //       children: documents.map((document) {
//             //         return Column(
//             //           children: [
//             //             ListTile(
//             //               leading: Icon(
//             //                 Icons.house,
//             //                 color: Colors.green.shade800,
//             //                 size: 40,
//             //               ),
//             //               title: Text(
//             //                 "แปลงปลูกที่ 1 : ${document['farm1']}",
//             //                 style: TextStyle(fontSize: 20),
//             //               ),
//             //             ),
//             //           ],
//             //         );
//             //       }).toList(),
//             //     );
//             //   },
//             // ),
//
//           ],
//         ),
//       ),
//     );
//   }
// }
