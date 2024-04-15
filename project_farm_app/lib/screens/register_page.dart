import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:project_farm_app/screens/signup_controller.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final _nameController =TextEditingController();
  final _mobileController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  //new
  final controller = Get.put(SignUpController());
  final _fromKey = GlobalKey<FormState>();
  bool showSpinner = false;

  FirebaseAuth auth = FirebaseAuth.instance;
  User? user;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Color(0xFFFFA600),
        title: const Text('หน้าลงทะเบียน',
          style: TextStyle(fontSize: 18,
          fontFamily: 'Prompt-Bold'),),
      ),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            TextFormField(
              controller: _nameController,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.person_outline_rounded),
                hintText: 'ชื่อ-นามสกุล',
                hintStyle: TextStyle(
                  fontFamily: 'Prompt-Light',
                ),
                contentPadding:
                  EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                ),
              ),
            ),

            const SizedBox(
              height: 8.0,
            ),
            TextFormField(
              controller: _mobileController,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.numbers_rounded),
                hintText: 'หมายเลขโทรศัพท์',
                hintStyle: TextStyle(
                  fontFamily: 'Prompt-Light',
                ),
                contentPadding:
                EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                ),
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            TextFormField(
              controller: _emailController,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.email_outlined),
                hintText: 'อีเมล',
                hintStyle: TextStyle(
                  fontFamily: 'Prompt-Light',
                ),
                contentPadding:
                EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                ),
              ),
            ),

            const SizedBox(
              height: 8.0,
            ),
            TextFormField(
              controller: _passwordController,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.fingerprint_rounded),
                hintText: 'รหัสผ่าน',
                hintStyle: TextStyle(
                  fontFamily: 'Prompt-Light',
                ),
                contentPadding:
                EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                ),
              ),
            ),
            // const SizedBox(
            //   height: 8.0,
            // ),
            // TextFormField(
            //   controller: controller.email,
            //   textAlign: TextAlign.center,
            //   decoration: const InputDecoration(
            //     prefixIcon: Icon(Icons.email_rounded),
            //     hintText: 'Enter Email',
            //     contentPadding:
            //     EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            //     border: OutlineInputBorder(
            //       borderRadius: BorderRadius.all(Radius.circular(25.0)),
            //     ),
            //   ),
            // ),
            //
            //
            // const SizedBox(
            //   height: 8.0,
            // ),
            // TextFormField(
            //   controller: controller.password,
            //   textAlign: TextAlign.center,
            //   decoration: const InputDecoration(
            //     prefixIcon: Icon(Icons.fingerprint_rounded),
            //     hintText: 'Enter Password',
            //     contentPadding:
            //     EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            //     border: OutlineInputBorder(
            //       borderRadius: BorderRadius.all(Radius.circular(25.0)),
            //     ),
            //   ),
            // ),

            const SizedBox(
              height: 8.0,
            ),
            Padding(padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Material(
                elevation: 5.0,
                color: Colors.orange,
                borderRadius: BorderRadius.circular(25.0),
                child: MaterialButton(
                  onPressed: () async{CollectionReference collRef = FirebaseFirestore.instance.collection('client');
                  collRef.add({
                    'name' : _nameController.text,
                    'mobile': _mobileController.text,
                    'email': _emailController.text,
                    'password': _passwordController.text,

                  });
                    setState(() {
                      showSpinner = true;
                    });
                    try {

                      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
                          email: _emailController.text,
                          password: _passwordController.text,
                      );
                      user = userCredential.user;
                      await user!.updateDisplayName(_nameController.text);
                      await user!.reload();
                      user = auth.currentUser;


                      // ถ้า user ไม่เป็น null, หมายความว่าการสร้างบัญชีผู้ใช้สำเร็จ
                      if (user != null) {
                        // ใช้ UID จาก Auth เป็น Document ID ใน Firestore
                        String userId = user!.uid; // ตรงนี้ได้ userId แล้ว

                        // เพิ่มข้อมูลผู้ใช้ลงใน Firestore โดยใช้ userId เป็น ID
                        CollectionReference collRef = FirebaseFirestore.instance.collection('client');
                        await collRef.doc(userId).set({
                          'name': _nameController.text,
                          'mobile': _mobileController.text,
                          'email': _emailController.text,
                          "uid": FirebaseAuth.instance.currentUser!.uid,
                          // หมายเหตุ: ควรหลีกเลี่ยงการเก็บรหัสผ่านใน Firestore เพื่อความปลอดภัย
                        });

                        // ดำเนินการต่อ เช่น นำทางไปยังหน้าต่อไป
                        Navigator.pushNamed(context, "navbarroot");
                      }
                      setState(() {
                        showSpinner = false;
                      });
                    }
                    on FirebaseAuthException catch(e)
                    {
                      if(e.code == 'weak-password'){
                        print('The password provided is too weak.');
                      } else if(e.code == 'email-already-in-use'){
                        print('The account already exists for that email.');
                      };
                      setState(() {
                        showSpinner = false; // หยุดตัวโหลด
                      });

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('เกิดข้อผิดพลาด: ${e.message}'),
                          backgroundColor: Colors.red,
                        ),
                      );                    }
                    catch(e)
                    {
                      print(e);
                    }
                  },
                  minWidth: 200.0,
                  height: 42.0,
                  child: const Text(
                    'ลงทะเบียน',
                    style: TextStyle(fontFamily: 'Prompt-Bold',
                      color: Colors.white,
                    ),
                  ),
                ),

              ),

            ),
            const SizedBox(
              height: 8.0,
            ),
            // ElevatedButton(
            //     onPressed:() {
            //       String userId = user!.uid;
            //       CollectionReference collRef = FirebaseFirestore.instance.collection('client');
            //       collRef.doc(userId).set({
            //       'name' : _nameController.text,
            //       'mobile': _mobileController.text,
            //       'email': _emailController.text,
            //       'password': _passwordController.text,
            //     });
            //
            //
            //     },
            // child: const Text('Add Client'),
            // ),

            // SizedBox(
            //   height: 20.0,
            //   child: ElevatedButton(onPressed: (){
            //     SignUpController.instance.registerUser(
            //         controller.email.text.trim(),
            //         controller.password.text.trim());
            //
            //   }, child: const Text('signup'),
            //   ),
            // ),
            //
            
          ],
        ),
      ),
    );
  }
}
