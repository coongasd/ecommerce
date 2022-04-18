import 'package:ecommerce/constant.dart';
import 'package:ecommerce/screens/home_page.dart';
import 'package:ecommerce/screens/login_page.dart';
import 'package:ecommerce/screens/register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: "AIzaSyBDq0P1D1nv1bXqMHRUnQWN8tsxv1XhkqA",
    appId: "1:850145455881:android:57be826d3aab8fe6bd2dd8",
    messagingSenderId: "850145455881",
    projectId: "ecommerce-b5b93",
  ));

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text("Error: ${snapshot.error}"),
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          //StreamBuilder có thể kiểm tra login state
          return StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, streamSnapshot) {
              if (streamSnapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text("Error: ${streamSnapshot.error}"),
                  ),
                );
              }
              //đã kết nối , kiểm tra người dùng đăng nhập trong if
              if (streamSnapshot.connectionState == ConnectionState.active) {
                //Lấy người dùng
                User? _user = streamSnapshot.data as User?;
                // Nếu ng dùng chưa đăng nhập, quay lại trang đăng nhập
                if (_user == null) {
                  return LoginPage();
                } else {
                  //người dùng đã đăng nhập
                  return HomePage();
                }
              }
              //Kiểm tra trạng thái auth
              return const Scaffold(
                  body: Center(
                child: Text(
                  "Checking Authentication",
                  style: Constants.regularHeading,
                ),
              ));
            },
          );
        }
        return const Scaffold(
            body: Center(
          child: Text(
            "Initializing App",
            style: Constants.regularHeading,
          ),
        ));
      },
    );
  }
}
