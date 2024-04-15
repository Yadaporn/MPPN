import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:project_farm_app/screens/old/dashboard.dart';
import 'package:project_farm_app/screens/profile_page.dart';

class SignUpWithEmailAndPasswordFailure {
  final String message;

  SignUpWithEmailAndPasswordFailure([this.message = "An unknown error occured"]);

  factory SignUpWithEmailAndPasswordFailure.code(String code){
    switch(code){
      //original dont remove const after return
      case 'weak-password' :
        return SignUpWithEmailAndPasswordFailure('Please enter a stronger password.');
      case 'invalid-email' :
        return SignUpWithEmailAndPasswordFailure('Email is not valid or badly formatted.');
      case 'email-already-in-use' :
        return SignUpWithEmailAndPasswordFailure('An account already exists for that email.');
      case 'operation-not-allowed' :
        return SignUpWithEmailAndPasswordFailure('Operation is not allowed. Please contact support.');
      case 'user-diabled' :
        return SignUpWithEmailAndPasswordFailure('This user has been disabled. Please contact support for help.');
      default:
        return SignUpWithEmailAndPasswordFailure();

    }
  }
}