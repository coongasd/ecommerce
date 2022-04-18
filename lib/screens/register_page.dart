// ignore_for_file: deprecated_member_use

import 'package:ecommerce/resources/auth.dart';
import 'package:flutter/material.dart';

import '../constant.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_input.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    //Tạo 1 thanh thông báo hiển thị lỗi
    Future<void> _alertDialogBuilder(String error) async {
      return showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return AlertDialog(
              title: Text("Thông báo"),
              content: Container(
                child: Text(error),
              ),
              actions: [
                FlatButton(
                  autofocus: true,
                  clipBehavior: Clip.none,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Đóng"),
                )
              ],
            );
          });
    }

    bool _registerFormLoading = false;

    //Form input value
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();
    final TextEditingController _usernameController = TextEditingController();

    @override
    void dispose() {
      super.dispose();
      _emailController.dispose();
      _passwordController.dispose();
      _usernameController.dispose();
    }

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
                  "Đăng ký để sử dụng",
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
                    hintext: "Tên người dùng",
                    textInputType: TextInputType.text,
                    textEditingController: _usernameController,
                  ),
                  CustomInput(
                    onSubmit: () => {},
                    hintext: "Password",
                    textInputType: TextInputType.text,
                    textEditingController: _passwordController,
                    isPass: true,
                  ),
                  CustomButton(
                    text: "Đăng ký",
                    onPress: () async {
                      // Mở dialog
                      String res = await AuthMethods().signUpUser(
                          email: _emailController.text,
                          password: _passwordController.text,
                          username: _usernameController.text);
                      _alertDialogBuilder(res);
                    },
                    outlineBtn: false,
                    isLoading: _registerFormLoading,
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 16.0,
                ),
                child: CustomButton(
                  text: "Đăng nhập",
                  onPress: () {
                    Navigator.pop(context);
                  },
                  outlineBtn: true,
                  isLoading: _registerFormLoading,
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
