import 'package:ecommerce/screens/product_page.dart';
import 'package:ecommerce/tabs/widgets/header_content.dart';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:intl/intl.dart' as intl;

class HomeTab extends StatelessWidget {
  HomeTab({Key? key}) : super(key: key);
  final CollectionReference _productRef =
      FirebaseFirestore.instance.collection("products");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Expanded(
              child: Stack(children: <Widget>[
            FutureBuilder<QuerySnapshot>(
                future: _productRef.get(),
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
                            margin: const EdgeInsets.only(top: 100.0),
                            child: GridView.count(
                              crossAxisCount: 2,
                              shrinkWrap: true,
                              children: snapshot.data!.docs.map((document) {
                                Map data = document.data() as Map;
                                // debugPrint(data['images'][0]);
                                int price = data["price"];
                                String priceAfterFormat =
                                    intl.NumberFormat.currency(locale: 'vi')
                                        .format(price);

                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ProductPage(
                                                  productId: document.id,
                                                )));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                        border: Border.all(
                                            color: Color.fromARGB(
                                                255, 173, 172, 172)),
                                        borderRadius:
                                            BorderRadius.circular(12.0)),
                                    height: 150.0,
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 22.0,
                                      vertical: 14.0,
                                    ),
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: Center(
                                            child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(12.0),
                                                child: Image.network(
                                                  data['images']?[1],
                                                )),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 18.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("${data["name"]}",
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600)),
                                              Text(
                                                priceAfterFormat,
                                                style: const TextStyle(
                                                    color: Colors.redAccent),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
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
                }),
          ])),
          HeaderContent(),
        ],
      ),
    );
  }
}
