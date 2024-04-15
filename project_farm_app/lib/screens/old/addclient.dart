

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Addclient extends StatefulWidget {
  const Addclient({super.key});

  @override
  State<Addclient> createState() => _AddclientState();
}

class _AddclientState extends State<Addclient> {
  // TextEditingController nameController = new TextEditingController();
  // TextEditingController mobileController = new TextEditingController();
  // TextEditingController emailController = new TextEditingController();
  final nameController =TextEditingController();
  final mobileController = TextEditingController();
  final emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool showSpinner = false;

  FirebaseAuth auth = FirebaseAuth.instance;
  User? user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent.shade100,
        title: const Text('Add Client'),

      ),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(
                hintText: 'Name',
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            TextFormField(
              controller: mobileController,
              decoration: const InputDecoration(
                hintText: 'Mobile',
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                hintText: 'Email',
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            ElevatedButton(
              onPressed: () {
                CollectionReference collRef = FirebaseFirestore.instance.collection('client');
                collRef.add({
                  "name":nameController.text,
                  "email":emailController.text,
                  "mobile":mobileController.text,
                });
            },
              child: const Text('Add Client'),
            ),
            const SizedBox(
              height: 8.0,
            ),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('ESP').snapshots(),
              builder: (context, snapshot){
                List<Row> clientWidgets = [];
                if(snapshot.hasData)
                  {
                    final clients =snapshot.data?.docs.reversed.toList();
                    for(var client in clients!)
                      {
                        final clientWidget = Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('LED :  '+client['LED']),
                            Text('LDR :  '+client['LDR']),
                            Text('TEMP :  '+client['TEMP']),
                          ],
                        );
                        clientWidgets.add(clientWidget);
                      }

                  }

                return Expanded(
                  child: ListView(
                    children: clientWidgets,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
