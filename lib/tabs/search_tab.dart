import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/DataModels/DataModel.dart';
import 'package:ecommerce/constant.dart';
import 'package:ecommerce/services/firebase_auth_services.dart';
import 'package:ecommerce/widgets/custom_input.dart';
import 'package:flutter/material.dart';
import 'package:firestore_search/firestore_search.dart';
import '../screens/product_page.dart';
import '../widgets/actions_bar.dart';
import 'package:intl/intl.dart' as intl;

class SearchTab extends StatefulWidget {
  const SearchTab({Key? key}) : super(key: key);

  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  String searchString = '';
  @override
  Widget build(BuildContext context) {
    FirebaseServices _firebaseServices = FirebaseServices();
    TextEditingController _textEditingController = TextEditingController();

    return Container(
        child: Column(
      children: [
        SizedBox(
          height: 45.0,
        ),
        CustomInput(
            hintext: 'Tìm kiếm',
            textEditingController: _textEditingController,
            textInputType: TextInputType.text,
            onSubmit: (value) {
              if (value.isNotEmpty) {
                setState(() {
                  // Update values
                  searchString = value;
                });
              }
            }),
        const Text(
          "Kết quả tìm kiếm",
          style: Constants.regularDarkText,
        ),
        Expanded(
          child: FutureBuilder<QuerySnapshot>(
              future: _firebaseServices.productRef
                  .orderBy("name")
                  .startAt([searchString]).endAt(["$searchString\uf8ff"]).get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Stack(
                    children: [
                      //Slide Show

                      //Hình ảnh , tên và giá tiền
                      Positioned(
                        child: SingleChildScrollView(
                          child: SizedBox(
                            height: 410.0,
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
                      ),
                    ],
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        )
      ],
    ));
  }
}
