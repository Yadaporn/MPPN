import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _nameController =TextEditingController();
  final _mobileController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool showSpinner = false;

  FirebaseAuth auth = FirebaseAuth.instance;
  User? user;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // ระบุ onWillPop เพื่อป้องกันการกดปุ่ม Back
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('MPPN 2024 Login',style: TextStyle(fontSize: 18,
            fontFamily: 'Prompt-Bold'),
          ),
          automaticallyImplyLeading: false,),
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.all(0),
                    child: Image.asset("images/logonew.png",
                      width: 250, // กำหนดความกว้างของรูปภาพ
                      height: 250, // กำหนดความสูงของรูปภาพ
                       ),
                  ),
                  SizedBox(height: 20),
                  const Padding(
                    padding: EdgeInsets.all(10),
                    child: Text("เกษตรอัจฉริยะ",
                      style: TextStyle(
                        fontFamily: 'Prompt-Bold',
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40.0,
                  ),
                  TextFormField(
                    controller: _emailController,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: 'กรอกอีเมล',
                      contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                      hintStyle: GoogleFonts.anuphan(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                        color: Colors.black38,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),

                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        hintText: 'กรอกรหัสผ่าน',
                        contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(32.0))
                        ),
                      hintStyle: GoogleFonts.anuphan(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                        color: Colors.black38,
                      ),
                    ),
                  ),
                  Padding(padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: Material(
                    elevation: 5.0,
                    color: Color(0xFFFFA600), // เปลี่ยนสีเป็นสีเขียว
                    borderRadius: BorderRadius.circular(30.0),
                    child: MaterialButton(
                      onPressed: () async{
                        setState(() {
                          showSpinner = true;
                        });
                        try{
                          UserCredential userCredential = await auth.signInWithEmailAndPassword(
                            email: _emailController.text,
                            password: _passwordController.text,
                          );
                          user = userCredential.user;
                          //new
                          // await user!.updateDisplayName(_nameController.text);
                          // await user!.reload();
                          user = auth.currentUser;
                          //
                          if (user != null){
                            Navigator.pushNamed(context, "navbarroot");
                          }
                          setState(() {
                            showSpinner = false;
                          });


                        }
                        on FirebaseAuthException catch(e) {
                          if (e.code == 'user-not-found') {
                            print('No user fount that email.');
                          } else if (e.code == 'wrong-password') {
                            print('Wrong password provided.');
                          }
                          setState(() {
                            showSpinner = false; // หยุดตัวโหลด
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('เกิดข้อผิดพลาด: ${e.message}'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                        catch(e){
                          print(e);
                        }
                      },
                      // color: Colors.green,
                    minWidth: 200.0,
                    height: 42.0,
                    child: Text(
                      'เข้าสู่ระบบ',
                      style: GoogleFonts.anuphan(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                      ),
                    ),
                    ),

                  ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  InkWell(
                    child: Text(
                      'ลงทะเบียน',
                      style: GoogleFonts.anuphan(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: Colors.black54,
                      ),
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, 'register');
                    },
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  // InkWell(
                  //   child: const Text(
                  //     'Add Client',
                  //     style: TextStyle(color: Colors.blue),
                  //   ),
                  //   onTap: () {
                  //     Navigator.pushNamed(context, 'addclient');
                  //   },
                  // ),
                  // const SizedBox(
                  //   height: 8.0,
                  // ),
                ],
              ),
            ),

        ),
      ),
    );
  }
}
