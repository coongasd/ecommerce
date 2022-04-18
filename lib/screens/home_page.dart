import 'package:ecommerce/constant.dart';
import 'package:ecommerce/services/firebase_auth_services.dart';
import 'package:ecommerce/tabs/home_tab.dart';
import 'package:ecommerce/tabs/saved_page.dart';
import 'package:ecommerce/tabs/search_tab.dart';
import 'package:ecommerce/widgets/bottom_tabs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final PageController _tabspageController;
  int _selectedTab = 0;
  @override
  void initState() {
    _tabspageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _tabspageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: PageView(
                controller: _tabspageController,
                onPageChanged: (num) {
                  setState(() {
                    _selectedTab = num;
                  });
                },
                children: [
                  HomeTab(),
                  SearchTab(),
                  SavedPage(),
                ]),
          ),
          BottomTabs(
            selectedTab: _selectedTab,
            tabPressed: (num) {
              setState(() {
                _tabspageController.animateToPage(num,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeOutCubic);
              });
            },
          )
        ],
      ),
    ));
  }
}
