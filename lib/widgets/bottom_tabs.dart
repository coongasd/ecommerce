import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BottomTabs extends StatefulWidget {
  BottomTabs({Key? key, required this.selectedTab, required this.tabPressed})
      : super(key: key);
  final int selectedTab;
  final Function tabPressed;

  @override
  State<BottomTabs> createState() => _BottomTabsState();
}

class _BottomTabsState extends State<BottomTabs> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    _selectedTab = widget.selectedTab;
    return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12.0),
                topRight: Radius.circular(12.0)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                spreadRadius: 1.0,
                blurRadius: 30.0,
              )
            ]),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              BottomTabsButton(
                onPress: () {
                  widget.tabPressed(0);
                },
                imagePath: "assets/images/home.png",
                selected: _selectedTab == 0 ? true : false,
              ),
              BottomTabsButton(
                onPress: () {
                  widget.tabPressed(1);
                },
                imagePath: "assets/images/search-interface-symbol.png",
                selected: _selectedTab == 1 ? true : false,
              ),
              BottomTabsButton(
                onPress: () {
                  widget.tabPressed(2);
                },
                imagePath: "assets/images/bookmark.png",
                selected: _selectedTab == 2 ? true : false,
              ),
              BottomTabsButton(
                imagePath: "assets/images/logout.png",
                selected: _selectedTab == 3 ? true : false,
                onPress: () async {
                  await FirebaseAuth.instance.signOut();
                },
              ),
            ],
          ),
        ));
  }
}

class BottomTabsButton extends StatefulWidget {
  const BottomTabsButton({
    Key? key,
    required this.imagePath,
    this.selected = false,
    required this.onPress,
  }) : super(key: key);
  final String imagePath;
  final bool selected;
  final Function onPress;

  @override
  State<BottomTabsButton> createState() => _BottomTabsButtonState();
}

class _BottomTabsButtonState extends State<BottomTabsButton> {
  @override
  Widget build(BuildContext context) {
    bool _selected = widget.selected;
    return GestureDetector(
      onTap: () => widget.onPress(),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 28.0, horizontal: 24.0),
        decoration: BoxDecoration(
            border: Border(
                top: BorderSide(
                    color: widget.selected
                        ? Theme.of(context).colorScheme.secondary
                        : Colors.transparent,
                    width: 2.0))),
        child: SizedBox(
          child: Image(
            image: AssetImage(widget.imagePath),
            color: _selected
                ? Theme.of(context).colorScheme.secondary
                : Colors.black,
          ),
          width: 26.0,
          height: 32.0,
        ),
      ),
    );
  }
}
