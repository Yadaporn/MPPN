import 'dart:typed_data';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/utils.dart';
import '../resources/image_store_methods.dart';
import '../utils/utils.dart';



class GradePage extends StatefulWidget {
  const GradePage({super.key, required this.title});

  final String title;

  @override
  State<GradePage> createState() => _GradePageState();
}

class _GradePageState extends State<GradePage> {

  Uint8List? _file;
  final TextEditingController _descriptionController = TextEditingController();

  bool _isLoading = false;
  void postImage() async {
    setState(() {
      _isLoading = true;
    });
    try {
      String res = await ImageStoreMethods().uploadPost(
          _descriptionController.text,
          _file!
      );
      if (res == 'เสร็จสิ้น') {
        setState(() {
          _isLoading = false;
        });
        showSnackBar('คัดเกรด', context);
        clearImage();
      } else {
        setState(() {
          _isLoading = false;
        });
        showSnackBar(res, context);
      }
    } catch (err) {
      showSnackBar(err.toString(), context);
    }
  }

  void clearImage(){
    setState(() {
      _file = null;
    });
  }



  _imageSelect(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: Text('กรุณาใส่รูปภาพ',
              style: GoogleFonts.anuphan(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),),
            children: [

              SimpleDialogOption(
                padding: EdgeInsets.all(20),
                child: Text('ถ่ายรูป',
                  style: GoogleFonts.anuphan(
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                    color: Colors.black54,
                  ),),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(
                    ImageSource.camera,
                  );
                  setState(() {
                    _file = file;
                  });
                },
              ),

              SimpleDialogOption(
                padding: EdgeInsets.all(20),
                child: Text('เลือกจากคลังภาพ',
                  style: GoogleFonts.anuphan(
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                    color: Colors.black54,
                  ),),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(
                    ImageSource.gallery,
                  );
                  setState(() {
                    _file = file;
                  });
                },
              ),

              SimpleDialogOption(
                padding: EdgeInsets.all(20),
                child: Text('ยกเลิก',
                  style: GoogleFonts.anuphan(
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                    color: Colors.redAccent,
                  ),),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),



            ],
          );
        });

  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Color(0xFFFFA600),
        title: Text('MPPN 2024 คัดเกรด',
          style: GoogleFonts.anuphan(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white70,
          ),
        ),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          CircleAvatar(
            backgroundImage: NetworkImage("https://i.natgeofe.com/n/4f5aaece-3300-41a4-b2a8-ed2708a0a27c/domestic-dog_thumb_square.jpg?w=170&h=170"),
          ),
          SizedBox(width: 20), // ให้ระยะห่างกับปุ่มหรือไอคอนถัดไป
        ],
      ),
      body:
      _file == null ?
      Center(
        child: Column(
          children: [
            SizedBox(height: 200),
            IconButton(
              icon: const Icon(Icons.photo_library),
              onPressed: () => _imageSelect(context),
              iconSize: 200,
            ),

            Text(
              'ถ่ายหรือเลือกภาพผลผลิต',
              style: GoogleFonts.anuphan(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),

          ],
        ),
      )
          :
      SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              _isLoading
                  ? const LinearProgressIndicator()
                  : const Padding(
                padding: EdgeInsets.only(
                  top: 0,
                ),
              ),

              const Divider(),
              SizedBox(
                height: 300,
                width: 300,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: MemoryImage(_file!),
                      fit: BoxFit.fill,
                      alignment: FractionalOffset.topCenter,
                    ),
                  ),
                ),
              ),

              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.40,
                    child: TextField(
                      controller: _descriptionController,
                      decoration: const InputDecoration(
                        hintText: 'เขียนคำบรรยาย',
                        border: InputBorder.none,
                      ),
                    ),
                  ),

                  ElevatedButton(onPressed: postImage, child: Text("โพสต์",
                    style: GoogleFonts.anuphan(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),),
                      style: ElevatedButton.styleFrom(
    foregroundColor: Colors.white, backgroundColor: Colors.orange, // สีของข้อความและไอคอนเมื่อปุ่มอยู่ในสถานะปกติ
    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),

    );
  }
}