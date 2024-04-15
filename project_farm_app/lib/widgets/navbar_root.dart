

import 'package:flutter/material.dart';
import 'package:project_farm_app/screens/old/Choosechart.dart';
import 'package:project_farm_app/screens/old/chart_page.dart';
import 'package:project_farm_app/screens/old/farm_screen.dart';
import 'package:project_farm_app/screens/gradecheck.dart';
import 'package:project_farm_app/screens/settings_screen.dart';
import 'package:project_farm_app/screens/test.dart';

import '../screens/Choosenew.dart';
import '../screens/farm.dart';

class NavBarRoots extends StatefulWidget{

  @override
  State<NavBarRoots> createState() => _NavBarRootsState();
}


class _NavBarRootsState extends State<NavBarRoots>{
  int _selectedIndex = 0;
  final _screens = [
    //Home Screeen
    FarmPage(),
    //แปลง
    GradePage(title: 'User State'),
    //รายงาน
    ChooseChartPageNew(),
    //ตั้งค่า
    SettingsScreen()
  ];

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      body: _screens[_selectedIndex],
      bottomNavigationBar: Container(
        height: 80,
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Color(0xFFFFA600),
          unselectedItemColor: Colors.black26,
          selectedLabelStyle: TextStyle(
            fontFamily: 'Prompt-Bold',
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
          unselectedLabelStyle:TextStyle(
            fontFamily: 'Prompt-Light',
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
          currentIndex: _selectedIndex,
          onTap: (index){
            setState((){
              _selectedIndex = index;
            });
          },
          items: const[
            BottomNavigationBarItem(icon: Icon(Icons.home_filled),label: "หน้าหลัก",),
            BottomNavigationBarItem(icon: Icon(Icons.camera_enhance),label: "คัดเกรด",),
            BottomNavigationBarItem(icon: Icon(Icons.assessment),label: "รายงาน",),
            BottomNavigationBarItem(icon: Icon(Icons.settings),label: "ตั้งค่า",),
          ],
        ),
      ),
    );
  }
}
