import 'package:ecommerce/constant.dart';
import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  const CustomInput({
    Key? key,
    required this.hintext,
    required this.textEditingController,
    required this.textInputType,
    required this.onSubmit,
    this.isPass = false,
  }) : super(key: key);

  final String hintext;
  final Function onSubmit;
  final TextEditingController textEditingController;
  final TextInputType textInputType;
  final bool isPass;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        decoration: BoxDecoration(
            border: Border.all(
              color: Color.fromARGB(255, 171, 165, 165),
              width: 2.0,
            ),
            color: Color(0xFFF2F2F2),
            borderRadius: BorderRadius.circular(12.0)),
        child: TextField(
          autofocus: true,
          onSubmitted: (value) {
            onSubmit(value);
          },
          controller: textEditingController,
          keyboardType: textInputType,
          obscureText: isPass,
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintext,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 24.0, vertical: 18.0)),
          style: Constants.regularDarkText,
        ));
  }
}
