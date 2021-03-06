import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_app/models/user.dart' as model;
// import 'package:flutter/material.dart';
import 'package:instagram_app/resources/storage_method.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot snap =
        await _firestore.collection('users').doc(currentUser.uid).get();

    return model.User.fromSnap(snap);
  }

  //Sign up the user
  Future<String> signUpUser({
    required String username,
    required String email,
    required String password,
    required Uint8List file,
  }) async {
    String res = "Some error";

    try {
      if (email.isNotEmpty || password.isNotEmpty || username.isNotEmpty) {
        //register user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        String photoUrl = await StorageMethod()
            .uploadImageStorage('profilePics', file, false);
        //add user to database

        model.User user = model.User(
          username: username,
          uid: cred.user!.uid,
          email: email,
          followers: [],
          following: [],
          photoUrl: photoUrl,
        );

        await _firestore.collection('users').doc(cred.user!.uid).set(
              user.toJson(),
            );
        res = "Success";
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  //Login the user

  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error occured";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = 'Success';
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
