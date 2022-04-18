import 'package:flutter/material.dart';

class ImageSwitch extends StatefulWidget {
  final List imageList;
  const ImageSwitch({Key? key, required this.imageList}) : super(key: key);

  @override
  State<ImageSwitch> createState() => _ImageSwitchState();
}

class _ImageSwitchState extends State<ImageSwitch> {
  int _selectedPage = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400.0,
      child: Stack(
        children: [
          PageView(
              onPageChanged: (num) {
                setState(() {
                  _selectedPage = num;
                });
              },
              children: [
                for (var i = 0; i < widget.imageList.length; i++)
                  Image.network(
                    "${widget.imageList[i]}",
                  ),
              ]),
          Positioned(
            bottom: 20.0,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var i = 0; i < widget.imageList.length; i++)
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 5.0,
                    ),
                    width: _selectedPage == i ? 25.0 : 12.0,
                    height: 12.0,
                    decoration: BoxDecoration(
                        color:
                            const Color.fromARGB(255, 0, 0, 0).withOpacity(0.8),
                        borderRadius: BorderRadius.circular(12.0)),
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
