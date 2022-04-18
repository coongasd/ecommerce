import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {Key? key,
      required this.text,
      required this.onPress,
      required this.outlineBtn,
      required this.isLoading})
      : super(key: key);

  final String text;
  final Function onPress;
  final bool outlineBtn;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    bool _outlineBtn = outlineBtn;
    bool _isLoading = isLoading;
    return GestureDetector(
      onTap: () => onPress(),
      child: Container(
          height: 60.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: _outlineBtn ? Colors.transparent : Colors.black,
              border: Border.all(color: Colors.black, width: 2.0),
              borderRadius: BorderRadius.circular(12.0)),
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
          margin: const EdgeInsets.symmetric(
            horizontal: 24.0,
            vertical: 24.0,
          ),
          child: Stack(
            children: [
              Visibility(
                visible: _isLoading ? false : true,
                child: Center(
                  child: Text(text,
                      style: TextStyle(
                          fontSize: 16.0,
                          color: _outlineBtn ? Colors.black : Colors.white,
                          fontWeight: FontWeight.w600)),
                ),
              ),
              Visibility(
                visible: _isLoading,
                child: const Center(
                  child: SizedBox(
                      height: 30.0,
                      width: 30.0,
                      child: CircularProgressIndicator()),
                ),
              ),
            ],
          )),
    );
  }
}
