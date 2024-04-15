import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {

  final currentUser = FirebaseAuth.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(backgroundColor: Color(0xFFFFA600),
        title: Text('MPPN 2024 โปรไฟล์ของฉัน',
          style: GoogleFonts.anuphan(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white70,
          ),
        ),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context); // ใช้ Navigator.pop เพื่อกลับหน้า
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('client')
              .where("uid", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var data = snapshot.data!.docs[index];
                    //Text(snapshot.data!.docs[index]['name']);
                    // return UserAccountsDrawerHeader(
                    //   accountName: Text(data['username']),
                    //   accountEmail: Text(data['email']),
                    // );
                    if (data['name'] != "") {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 50.0,
                          horizontal: 20.0,
                        ),
                        child: Card(
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 30.0,
                              ),
                              Stack(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(

                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(200),
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 10,
                                          spreadRadius: 5,
                                        ),
                                      ],
                                    ),
                                    child: ClipOval(
                                      child: Image.network(
                                        data['image'],
                                        // 'https://upload.wikimedia.org/wikipedia/commons/5/5f/Alberto_conversi_profile_pic.jpg',
                                        // 'https://i.natgeofe.com/n/4f5aaece-3300-41a4-b2a8-ed2708a0a27c/domestic-dog_thumb_square.jpg?w=170&h=170',
                                        //'https://www.creativefabrica.com/wp-content/uploads/2022/10/25/Person-icon-Graphics-43204353-1-1-580x386.jpg',
                                        width: 170,
                                        height: 170,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              //Image.network(data['username'])

                              const SizedBox(
                                height: 50.0,
                              ),
                              Text(
                                'ชื่อ : ' + data['name'],
                                style: GoogleFonts.anuphan(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(
                                height: 40.0,
                              ),
                              Text(
                                'อีเมล : ' + data['email'],
                                style: GoogleFonts.anuphan(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(
                                height: 40.0,
                              ),
                              Text(
                                'หมายเลขโทรศัพท์ : ' + data['mobile'],
                                style: GoogleFonts.anuphan(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(
                                height: 40.0,
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 40.0,
                          horizontal: 50.0,
                        ),
                        child: Card(
                          child: Column(
                            children: [
                              //Image.network(data['username'])
                              const SizedBox(
                                height: 50.0,
                              ),
                              Stack(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.redAccent,
                                          width: 5),
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(200),
                                      ),
                                    ),
                                    child: ClipOval(
                                      child: Image.network(
                                        //data['user_image'],
                                        //'https://upload.wikimedia.org/wikipedia/commons/5/5f/Alberto_conversi_profile_pic.jpg',
                                        'https://i.natgeofe.com/n/4f5aaece-3300-41a4-b2a8-ed2708a0a27c/domestic-dog_thumb_square.jpg?w=170&h=170',
                                        //'https://www.creativefabrica.com/wp-content/uploads/2022/10/25/Person-icon-Graphics-43204353-1-1-580x386.jpg',
                                        width: 170,
                                        height: 170,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 50.0,
                              ),
                              Text(
                                'Username : ' + data['username'],
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 23,
                                ),
                              ),
                              const SizedBox(
                                height: 40.0,
                              ),
                              Text(
                                'Email : ' + data['email'],
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 23,
                                ),
                              ),
                              const SizedBox(
                                height: 40.0,
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  });
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
