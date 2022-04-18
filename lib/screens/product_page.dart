import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/constant.dart';
import 'package:ecommerce/services/firebase_auth_services.dart';
import 'package:ecommerce/widgets/actions_bar.dart';
import 'package:ecommerce/widgets/image_switch.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

class ProductPage extends StatefulWidget {
  final String productId;
  const ProductPage({Key? key, required this.productId}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  FirebaseServices _firebaseServices = FirebaseServices();

  final CollectionReference _productRef =
      FirebaseFirestore.instance.collection("products");
  final CollectionReference _userRef =
      FirebaseFirestore.instance.collection("Users");

  final User? _user = FirebaseAuth.instance.currentUser;

  Future<void> _addToCart() {
    return _firebaseServices.userRef
        .doc(_user?.uid)
        .collection("cart")
        .doc(widget.productId)
        .set({});
  }

  Future<void> _addToSaved() {
    return _firebaseServices.userRef
        .doc(_user?.uid)
        .collection("saved")
        .doc(widget.productId)
        .set({});
  }

  final SnackBar _snackBar = const SnackBar(
    content: Text("Sản phẩm đã được thêm vào giỏ hàng"),
  );
  final SnackBar _snackBarForSaved = const SnackBar(
    content: Text("Sản phẩm đã được thêm vào mục đã lưu"),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder(
            future: _firebaseServices.productRef.doc(widget.productId).get(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Scaffold(
                  body: Center(child: Text("Error: ${snapshot.error}")),
                );
              }
              if (snapshot.connectionState == ConnectionState.done) {
                var documentData = snapshot.data as DocumentSnapshot;
                int price = documentData["price"];
                String priceAfterFormat =
                    intl.NumberFormat.currency(locale: 'vi').format(price);
                List imageList = documentData['images'];
                return ListView(
                  padding: EdgeInsets.all(8.0),
                  children: [
                    ImageSwitch(imageList: imageList),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18.0, vertical: 14.0),
                      child: Text(
                        "${documentData['name']}",
                        style: Constants.boldHeading,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(width: 2.0),
                          borderRadius: BorderRadius.circular(8.0)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18.0, vertical: 14.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Icon(Icons.smartphone),
                                Flexible(
                                  child: Text(
                                    "${documentData['details'][0]}",
                                    maxLines: 2,
                                    style: TextStyle(
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.camera),
                                Text(
                                  "${documentData['details'][1]}",
                                  style: TextStyle(
                                    fontSize: 14.0,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.camera_front),
                                Text(
                                  "${documentData['details'][2]}",
                                  style: TextStyle(
                                    fontSize: 14.0,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.memory),
                                Text(
                                  "${documentData['details'][3]}",
                                  style: TextStyle(
                                    fontSize: 14.0,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.sd_storage),
                                Text(
                                  "${documentData['details'][4]}",
                                  style: TextStyle(
                                    fontSize: 14.0,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18.0, vertical: 14.0),
                      child: Text(
                        "${priceAfterFormat}",
                        style: TextStyle(
                            fontSize: 18.0,
                            color: Theme.of(context).colorScheme.secondary,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(28.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              await _addToSaved();

                              Scaffold.of(context)
                                  // ignore: deprecated_member_use
                                  .showSnackBar(_snackBarForSaved);
                            },
                            child: Container(
                              width: 60.0,
                              height: 60.0,
                              decoration: BoxDecoration(
                                  color: Color(0xFFDCDCDC),
                                  borderRadius: BorderRadius.circular(12.0)),
                              alignment: Alignment.center,
                              child: const Image(
                                image: AssetImage("assets/images/bookmark.png"),
                                height: 23.0,
                                width: 31.0,
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () async {
                                await _addToCart();
                                // ignore: deprecated_member_use
                                Scaffold.of(context).showSnackBar(_snackBar);
                              },
                              child: Container(
                                margin: EdgeInsets.only(left: 16.0),
                                alignment: Alignment.center,
                                child: const Text(
                                  "Thêm vào giỏ hàng",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w600),
                                ),
                                height: 60.0,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(12.0)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                );
              }

              return Container(
                height: 300,
                child: const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              );
            },
          ),
          const CustomActionBar(title: "", hasBackArrow: true, hasTitle: false)
        ],
      ),
    );
  }
}
