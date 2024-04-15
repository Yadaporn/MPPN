// import 'package:finalapp/ui/home_screen.dart';
// import 'package:finalapp/widget/navbar_root.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:get/get.dart';

// import 'auth_controller.dart';

class LoginScreen extends StatefulWidget{
  const LoginScreen({Key? key}) : super(key: key);
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>{
  final nameController = TextEditingController();
  late DatabaseReference dbRef;
  @override
  void initState() {
    super.initState();
    dbRef = FirebaseDatabase.instance.ref().child('username');
  }

  bool passToggle = true;
  @override
  Widget build(BuildContext context){
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    return Material(
      color: Colors.white,
      child: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [

              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.all(20),
                child: Image.asset("images/Picture1.png"),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text("เกษตรอัจฉริยะ",
                  style: TextStyle(
                    fontFamily: 'Prompt-Bold',
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54,
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Padding(
                  padding: EdgeInsets.all(12),
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("อีเมล",style: TextStyle(
                        fontFamily: 'Prompt-light',
                      ),),
                      prefixIcon: Icon(Icons.person),
                    ),
                  ),
              ),
              Padding(
                padding: EdgeInsets.all(12),
                child: TextField(
                  controller: passwordController,
                  obscureText: true,
                  // obscureText: passToggle ? true : false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text("รหัสผ่าน",style: TextStyle(
                      fontFamily: 'Prompt-light',),),
                    prefixIcon: Icon(CupertinoIcons.lock_circle_fill),
                    // suffixIcon: InkWell(
                    //   onTap: (){
                    //     if(passToggle == true){
                    //       passToggle = false;
                    //     }
                    //     else{
                    //       passToggle = true;
                    //     }
                    //     setState(() { });
                    //   },
                    //   // child: passToggle ? Icon(CupertinoIcons.eye_slash_fill): Icon(CupertinoIcons.eye_fill),
                    // ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: (){
                  FirebaseAuth.instance.signInWithEmailAndPassword(
                    email: emailController.text,
                    password: passwordController.text,
                  );
                  // AuthController.instance.login(emailController.text.trim(), passwordController.text.trim());
                },
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: SizedBox(
                    width: double.infinity,
                    child: Material(
                      color: Color(0xFF45DA40),
                      borderRadius: BorderRadius.circular(10),
                      child: InkWell(
                        // onTap:() {
                        //   Navigator.push(
                        //       context,
                        //       MaterialPageRoute(
                        //         builder: (context) => NavBarRoots(),
                        //       ));
                        // },

                        child: Padding(
                          padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                          child: Center(
                            child: Text(
                              "เข้าสู่ระบบ",
                              style: TextStyle(
                                fontFamily: 'Prompt-Bold',
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
}

}