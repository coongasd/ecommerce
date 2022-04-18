import 'package:ecommerce/resources/auth.dart';
import 'package:ecommerce/screens/register_page.dart';
import 'package:ecommerce/utils/utils.dart';
import 'package:ecommerce/widgets/custom_button.dart';
import 'package:ecommerce/widgets/custom_input.dart';
import 'package:flutter/material.dart';

import '../constant.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  void loginUser() async {
    String res = await AuthMethods().loginUser(
        email: _emailController.text, password: _passwordController.text);

    if (res == "success") {
      debugPrint(res);
    } else {
      showSnackBar(context, res);
    }
  }

  @override
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _loginPageLoading = false;
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: SafeArea(
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.only(top: 24.0),
                child: const Text(
                  "Chào mừng,\n mời bạn đăng nhập",
                  textAlign: TextAlign.center,
                  style: Constants.boldHeading,
                ),
              ),
              Column(
                children: [
                  CustomInput(
                    onSubmit: () => {},
                    hintext: "Email",
                    textInputType: TextInputType.text,
                    textEditingController: _emailController,
                  ),
                  CustomInput(
                    onSubmit: () => {},
                    hintext: "Password",
                    textInputType: TextInputType.text,
                    textEditingController: _passwordController,
                    isPass: true,
                  ),
                  CustomButton(
                    text: "Đăng nhập",
                    onPress: () => loginUser(),
                    outlineBtn: false,
                    isLoading: _loginPageLoading,
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 16.0,
                ),
                child: CustomButton(
                  text: "Tạo tài khoản",
                  onPress: () async {
                    await Navigator.push(
                        context,
                        await MaterialPageRoute(
                            builder: (context) => RegisterPage()));
                  },
                  outlineBtn: true,
                  isLoading: _loginPageLoading,
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
