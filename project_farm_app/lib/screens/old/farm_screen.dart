//
// import 'package:flutter/material.dart';
// import 'package:project_farm_app/screens/test.dart';
//
// import '../widgets/navbar_root.dart';
//
// class FarmScreen extends StatelessWidget{
//   List imgs = [
//     "ดีมาก.png",
//     "เฉย.png",
//     "แย่.png"
//   ];
//   List planplant = [
//     "แปลงที่ 1",
//     "แปลงที่ 2",
//     "แปลงที่ 3"
//   ];
//
//   @override
//   Widget build(BuildContext context){
//     return Scaffold(
//       backgroundColor: Color(0xFF45DA40),
//       body: SingleChildScrollView(
//           child: Column(
//             children: [
//               SizedBox(height: 40),
//               Padding(padding: EdgeInsets.symmetric(horizontal: 10),
//                 child: Stack(
//                   children: [
//                     //แถบบน ซ้ายขวา
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         InkWell(
//                           onTap: (){
//                             Navigator.push(context,
//                                 MaterialPageRoute(
//                                         builder: (context) => NavBarRoots()));
//                           },
//                           child: Icon(
//                             Icons.arrow_back_ios_new,
//                             color: Colors.white,
//                             size: 25,
//                           ),
//                         ),
//                         InkWell(
//                           onTap: (){
//                             Navigator.pop(context);
//                           },
//                           child: Icon(
//                             Icons.arrow_forward_ios,
//                             color: Colors.white,
//                             size: 25,
//                           ),
//                         ),
//                       ],
//                     ),
//                     //รูปกับคำ
//                     Padding(padding: EdgeInsets.symmetric(vertical: 10),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           CircleAvatar(radius: 50,
//                             backgroundColor: Color(0xFF45DA40),
//                             backgroundImage: AssetImage("images/กะเพรา.png"),
//                           ),
//                           SizedBox(height: 5),
//                           Text(
//                             "แปลงกะเพรา",
//                             style: TextStyle(
//                               fontFamily: 'Prompt-Bold',
//                               fontSize: 30,
//                               fontWeight: FontWeight.w500,
//                               color: Colors.white,
//                             ),
//                           ),
//                           SizedBox(height: 1),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 100),
//               Container(
//                 height: MediaQuery.of(context).size.height / 1,
//                 width: double.infinity,
//                 padding: EdgeInsets.only(
//                   top: 10,
//                   left: 15,
//                 ),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(10),
//                     topRight: Radius.circular(10),
//                   ),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisSize: MainAxisSize.max,
//                   children: [
//                     SizedBox(height: 400,
//                       child: ListView.builder(
//                         scrollDirection: Axis.vertical,
//                         itemCount: 3,
//                         itemBuilder: (context, index){
//                           return Container(
//                             margin: EdgeInsets.all(15),
//                             padding: EdgeInsets.symmetric(vertical: 50),
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(10),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: Colors.black12,
//                                   blurRadius: 4,
//                                   spreadRadius: 2,
//                                 ),
//                               ],
//                             ),
//                             child: SizedBox(
//                               width: MediaQuery.of(context).size.width / 1.4,
//                               child: Container(
//                                 child: GestureDetector(
//                                       onTap: () {
//                                       Navigator.push(context, MaterialPageRoute(builder: (context) => TestPage(),
//                                       ));
//                                       },
//                                   child: Column(
//                                     children: [
//                                       ListTile(
//                                         leading: CircleAvatar(
//                                           backgroundColor: Colors.white,
//                                           radius: 25,
//                                           backgroundImage: AssetImage("images/${imgs[index]}"),
//                                         ),
//                                         title: Padding(
//                                           padding: const EdgeInsets.all(10),
//                                           child: Text(
//                                             "${planplant[index]}",
//                                             style: TextStyle(
//                                               fontFamily: 'Prompt-Light',
//                                               fontSize: 20,
//                                               fontWeight: FontWeight.bold,
//                                             ),
//                                           ),
//                                         ),
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               GridView.builder(
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                 ),
//                 itemCount: 3,
//                 shrinkWrap: true,
//                 physics: NeverScrollableScrollPhysics(),
//                 itemBuilder: (context, index){
//                   return InkWell(
//                     onTap: () {
//                       Navigator.push(context, MaterialPageRoute(builder: (context) => TestPage(),
//                       ));
//                     },
//                     child: Container(
//                       margin: EdgeInsets.all(10),
//                       padding: EdgeInsets.symmetric(vertical: 15),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(10),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black12,
//                             blurRadius: 4,
//                             spreadRadius: 2,
//                           ),
//                         ],
//                       ),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           CircleAvatar(
//                             backgroundColor: Colors.white,
//                             radius: 35,
//                             backgroundImage: AssetImage("images/${imgs[index]}"),
//                           ),
//                           Text(
//                             "${planplant[index]}",
//                             style: TextStyle(
//                               fontFamily: 'Prompt-Bold',
//                               fontSize: 18,
//                               fontWeight: FontWeight.w500,
//                               color: Colors.black54,
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ],
//           )
//       ),
//     );
//   }
// }

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