import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //Đăng ký người dùng
  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,

    // required Uint8List file,
  }) async {
    String res = "Error";
    try {
      if (email.isNotEmpty || password.isNotEmpty || username.isNotEmpty) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        print(cred.user!.uid);
        await _firestore.collection('user').doc(cred.user!.uid).set({
          'username': username,
          'uid': cred.user!.uid,
          'email': email,
        });

        // await _firestore.collection('users').add({

        // })

        res = 'success';
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  //Đăng nhập
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Lỗi";

    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = "Succes";
      } else {
        res = "Bạn phải nhập đầy đủ";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
