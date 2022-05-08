import 'package:ecommerce/chats/translations.dart';
import 'package:flutter/material.dart';

import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:stream_chat_localizations/stream_chat_localizations.dart';

import 'channel_list_page.dart';

class MyApp_chat extends StatelessWidget {
  const MyApp_chat({Key? key, required this.client, required this.channel})
      : super(key: key);

  final StreamChatClient client;
  final Channel channel;

  @override
  Widget build(BuildContext context) {
    final theme = ThemeData.dark().copyWith(
      accentColor: Color.fromARGB(255, 179, 157, 157),
    );

    final defaultTheme = StreamChatThemeData.fromTheme(theme);

    final customTheme = defaultTheme.merge(StreamChatThemeData(
      channelPreviewTheme: ChannelPreviewThemeData(
          avatarTheme: AvatarThemeData(
        borderRadius: BorderRadius.circular(10),
      )),
    ));

    return MaterialApp(
        title: 'Chatter',
        debugShowCheckedModeBanner: false,
        theme: theme,
        builder: (context, widget) {
          return StreamChat(
            child: widget,
            client: client,
            streamChatThemeData: customTheme,
          );
        },
        home: StreamChannel(
          channel: channel,
          child: const ChannelListPage(),
        ),
        locale: const Locale("en"),
        supportedLocales: const [
          Locale('en'),
          Locale('es'),
          Locale("fr"),
        ],
        localizationsDelegates: [
          const TranslationsDelegate(),
          ...GlobalStreamChatLocalizations.delegates
        ]);
  }
}
