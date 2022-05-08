import 'package:ecommerce/chats/my_app.dart';
import 'package:ecommerce/main.dart';
import 'package:ecommerce/maps/animated_markers_map.dart';
import 'package:ecommerce/resources/auth.dart';
import 'package:ecommerce/screens/register_page.dart';
import 'package:ecommerce/utils/utils.dart';
import 'package:ecommerce/widgets/custom_button.dart';
import 'package:ecommerce/widgets/custom_input.dart';
import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

import '../constant.dart';

const apiKey = "a4zjnzzvgp4t";
const userToken =
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoibmhhdDEyMyJ9.Nlo5YtDbl00S9hPOQN_lljUHbVd4iwZ2GYgI28StmrE";

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

//

  void mainchat() async {
    WidgetsFlutterBinding.ensureInitialized();

    final client = StreamChatClient(apiKey, logLevel: Level.INFO);

    await client.connectUser(
      User(
        id: 'nhat123',
        extraData: {
          'image':
              'http://images5.fanpop.com/image/photos/27100000/Chibi-Batman-random-27118559-197-196.jpg',
        },
      ),
      userToken,
    );

    final channel = client.channel(
      'messaging',
      id: 'Supports',
      extraData: {
        "name": "Hỗ trợ yêu cầu",
        "image":
            "http://images5.fanpop.com/image/photos/27100000/Chibi-Batman-random-27118559-197-196.jpg",
      },
    );

    await channel.watch();

    runApp(MyApp_chat(client: client, channel: channel));
  }

//
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButton(
                      text: 'Bản đồ',
                      onPress: () async {
                        await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AnimatedMarkersMap()));
                      },
                      outlineBtn: false,
                      isLoading: false),
                  CustomButton(
                      text: 'Chat',
                      onPress: () async {
                        mainchat();
                      },
                      outlineBtn: true,
                      isLoading: false)
                ],
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
