import 'package:flutter/material.dart';

import '../../widgets/actions_bar.dart';

class HeaderContent extends StatelessWidget {
  const HeaderContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CustomActionBar(
      hasBackArrow: false,
      title: "Trang chủ",
      hasTitle: true,
    );
  }
}
