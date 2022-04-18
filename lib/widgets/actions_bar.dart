import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/constant.dart';
import 'package:ecommerce/screens/cart_page.dart';
import 'package:ecommerce/services/firebase_auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CustomActionBar extends StatefulWidget {
  final String title;
  final bool hasBackArrow;
  final bool hasTitle;
  const CustomActionBar(
      {Key? key,
      required this.title,
      required this.hasBackArrow,
      required this.hasTitle})
      : super(key: key);

  @override
  State<CustomActionBar> createState() => _CustomActionBarState();
}

class _CustomActionBarState extends State<CustomActionBar> {
  @override
  Widget build(BuildContext context) {
    bool _hasBackArrow = widget.hasBackArrow;
    bool _hasTitle = widget.hasTitle;
    final CollectionReference _userRef =
        FirebaseFirestore.instance.collection("Users");

    User? _user = FirebaseAuth.instance.currentUser;
    FirebaseServices _firebaseServices = FirebaseServices();
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
        Colors.white,
        Colors.white.withOpacity(0),
      ], begin: Alignment(0, 0), end: Alignment(0, 1))),
      padding: const EdgeInsets.only(
        top: 36.0,
        left: 24.0,
        right: 24.0,
        bottom: 42.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (_hasBackArrow)
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                width: 42.0,
                height: 42.0,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                alignment: Alignment.center,
                child: const Image(
                  image: AssetImage("assets/images/back-arrow.png"),
                  color: Colors.white,
                ),
              ),
            ),
          if (_hasTitle)
            Text(
              widget.title,
              style: Constants.boldHeading,
            ),
          GestureDetector(
            onTap: () => {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CartPage(),
                  ))
            },
            child: Container(
              width: 42.0,
              height: 42.0,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(8.0),
              ),
              alignment: Alignment.center,
              child: StreamBuilder<QuerySnapshot>(
                  stream:
                      _userRef.doc(_user?.uid).collection("cart").snapshots(),
                  builder: (context, snapshot) {
                    int _totalItems = 0;

                    if (snapshot.connectionState == ConnectionState.active) {
                      List _documents = snapshot.data!.docs;
                      _totalItems = _documents.length;
                    }
                    if (snapshot.hasError) {}

                    return Text(
                      "$_totalItems",
                      style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
