import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:project_farm_app/screens/repository/authentication_repository.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  //Textfield Controller
  final email = TextEditingController();
  final password = TextEditingController();
  final name = TextEditingController();
  final mobile = TextEditingController();

  //call this function from design
 void registerUser(String email,String password){
   AuthenticationRepository.instance.createUserWithEmailAndPassword(email, password);
 }
}