

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project_farm_app/screens/old/login_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_farm_app/screens/privacy.dart';
import 'package:project_farm_app/screens/profile_page.dart';

import 'login_page.dart';



class SettingsScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.only(top: 50,left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "ตั้งค่า",
            style: GoogleFonts.anuphan(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),

          Divider(height: 25),
          GestureDetector(
            onTap: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfilePage(),
                  ));
            },
            child: ListTile(

              leading: Container(

                child: Icon(
                  CupertinoIcons.person_2_square_stack,
                  color: Colors.black87,
                  size: 35,
                ),
              ),
              title: Text("โปรไฟล์ของฉัน",
                style: GoogleFonts.anuphan(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              trailing: Icon(Icons.arrow_forward_ios_rounded),
            ),
          ),

          Divider(height: 25),
          GestureDetector(
            onTap: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PrivacyPolicyWidget(),
                  ));
            },
            child: ListTile(

              leading: Container(

                child: Icon(
                  CupertinoIcons.lock,
                  color: Colors.black87,
                  size: 35,
                ),
              ),
              title: Text("นโยบายความเป็นส่วนตัว",
                style: GoogleFonts.anuphan(
                  fontSize:16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              trailing: Icon(Icons.arrow_forward_ios_rounded),
            ),
          ),
          Divider(height: 25),
          ListTile(
            onTap: (){},
            leading: Container(

              child: Icon(
                CupertinoIcons.info,
                color: Colors.black87,
                size: 35,
              ),
            ),
            title: Text("เกี่ยวกับเรา",
              style: GoogleFonts.anuphan(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            trailing: Icon(Icons.arrow_forward_ios_rounded),
          ),
          Divider(height: 25),
          GestureDetector(
            onTap: (){
              FirebaseAuth.instance.signOut();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ));
            },
            child: ListTile(

                leading: Container(

                  child: Icon(
                    Icons.logout ,
                    color: Colors.redAccent,
                    size: 35,
                  ),
                ),
                title: Text("ออกจากระบบ",
                  style: GoogleFonts.anuphan(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent,
                  ),
                ),
              trailing: Icon(Icons.arrow_forward_ios_rounded),
              ),
          ),

        ],
      ),
    );
  }
}