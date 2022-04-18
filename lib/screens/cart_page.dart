import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/screens/product_page.dart';
import 'package:ecommerce/services/firebase_auth_services.dart';
import 'package:ecommerce/widgets/actions_bar.dart';
import 'package:ecommerce/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart' as intl;

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final FirebaseServices _firebaseServices = FirebaseServices();

  List productsPrice = [];
  Future<void> removeFromCart(productId) async {
    return (_firebaseServices.userRef
        .doc(_firebaseServices.getUserId())
        .collection('cart')
        .doc(productId)
        .delete()
        .then((value) => print("Product Deleted"))
        .catchError((error) => print("Failed to delete product: $error")));
  }

  Future<String> totalProduct() async {
    num total = 0;
    for (var element in productsPrice) {
      if (element['price'] != null) {
        total += element['price'];
      }
    }

    String totalPriceAfterFormat =
        intl.NumberFormat.currency(locale: 'vi').format(total);
    totalPrice = totalPriceAfterFormat;
    return totalPrice;
  }

  String totalPrice = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        FutureBuilder<QuerySnapshot>(
            future: _firebaseServices.userRef
                .doc(_firebaseServices.getUserId())
                .collection("cart")
                .get(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Scaffold(
                  body: Center(child: Text("Error: ${snapshot.error}")),
                );
              }

              if (snapshot.connectionState == ConnectionState.done) {
                //Hien thi du lieu trong 1 list view
                return Stack(
                  children: [
                    //Slide Show

                    //Hình ảnh , tên và giá tiền
                    Positioned(
                      child: Container(
                        constraints: BoxConstraints(
                            minWidth: double.infinity, maxHeight: 470),
                        margin: const EdgeInsets.only(top: 100.0),
                        child: Column(
                          children: [
                            Expanded(
                              child: ListView(
                                shrinkWrap: true,
                                children: snapshot.data!.docs.map((document) {
                                  // Map data = document.data() as Map;
                                  // debugPrint(data['images'][0]);

                                  return FutureBuilder(
                                    future: _firebaseServices.productRef
                                        .doc(document.id)
                                        .get(),
                                    builder: (context, productSnap) {
                                      if (productSnap.hasData) {
                                        var data = productSnap.data
                                            as DocumentSnapshot;

                                        int price = data["price"];
                                        productsPrice.add({
                                          "id": document.id,
                                          "price": price,
                                          "name": data["name"]
                                        });
                                        totalProduct();

                                        String priceAfterFormat =
                                            intl.NumberFormat.currency(
                                                    locale: 'vi')
                                                .format(price);
                                        debugPrint(totalPrice.toString());

                                        return Dismissible(
                                          direction:
                                              DismissDirection.startToEnd,
                                          key: Key(document.id),
                                          onDismissed: (direction) => {
                                            removeFromCart(document.id),
                                            // setState(() {})
                                          },
                                          background: Container(
                                              color: Color.fromARGB(
                                                  255, 234, 123, 116)),
                                          child: Container(
                                              decoration: BoxDecoration(
                                                  color: const Color.fromARGB(
                                                      255, 224, 225, 226),
                                                  border: Border.all(
                                                      color:
                                                          const Color.fromARGB(
                                                              255,
                                                              233,
                                                              230,
                                                              230)),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12.0)),
                                              margin:
                                                  const EdgeInsets.all(10.0),
                                              child: Stack(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      12.0),
                                                          child: Image.network(
                                                            data['images']?[1],
                                                            width: 100.0,
                                                          )),
                                                      Container(
                                                        margin: const EdgeInsets
                                                            .only(left: 20.0),
                                                        child: Column(
                                                          children: [
                                                            Text(
                                                              "${data['name']}",
                                                              style: const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                            ),
                                                            Text(
                                                                priceAfterFormat,
                                                                style: const TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    color: Colors
                                                                        .red)),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              )),
                                        );
                                      } else {
                                        return const SizedBox(
                                          height: 300,
                                          child: Scaffold(
                                            body: Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }

              return const SizedBox(
                height: 300,
                child: Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              );
            }),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomActionBar(
                title: "Giỏ hàng", hasBackArrow: true, hasTitle: true),
            SizedBox(
                width: double.infinity,
                height: 115.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Container(
                    //     decoration: BoxDecoration(
                    //         border: Border.all(
                    //             width: 0.9,
                    //             color: Color.fromARGB(255, 188, 188, 188)),
                    //         color: Color.fromARGB(255, 252, 255, 254)),
                    //     child: Text("Tổng số tiền: ${totalPrice} ")),
                    CustomButton(
                        text: 'Thanh toán',
                        onPress: () => {},
                        outlineBtn: true,
                        isLoading: false)
                  ],
                )),
          ],
        ),
      ],
    ));
  }
}
