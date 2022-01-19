import 'package:chat_app/pages/auth_page/auth_page.dart';
import 'package:chat_app/pages/channel_list_page/channel_list_page.dart';
import 'package:chat_app/pages/channel_page/channel_page.dart';
import 'package:chat_app/pages/create_channel_page/create_channel_page.dart';
import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

StreamChatClient client = StreamChatClient(
  'hg4t2zma6nkw',
  logLevel: Level.INFO,
);

void main() async {
  /// Create a new instance of [StreamChatClient] passing the apikey obtained from your
  /// project dashboard.

  /// Creates a channel using the type `messaging` and `flutterdevs`.
  /// Channels are containers for holding messages between different members. To
  /// learn more about channels and some of our predefined types, checkout our
  /// our channel docs: https://getstream.io/chat/docs/flutter-dart/creating_channels/?language=dart


  runApp(
    MyApp(
    ),
  );
}

class MyApp extends StatelessWidget {
  /// To initialize this example, an instance of [client] and [channel] is required.
  const MyApp({
    Key? key,
    // required this.client,
  }) : super(key: key);

  /// Instance of [StreamChatClient] we created earlier. This contains information about
  /// our application and connection state.
  // final StreamChatClient client;
  //
  // /// The channel we'd like to observe and participate.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: routeSettings,
      initialRoute: '/',
      theme: ThemeData(primaryColor: const Color(0xff008fe5), appBarTheme: AppBarTheme(color: Color(0xff008fe5))),
      builder: (context, widget) {
        return StreamChat(
          client: client,
          child: widget,
        );
      },
      // home: StreamChannel(
      //   channel: channel,
      //   child: const ChannelPage(),
      // ),
    );
  }
}

/// Displays the list of messages inside the channel
// class ChannelPage extends StatelessWidget {
//   const ChannelPage({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return   Scaffold(
//       appBar: const ChannelHeader(),
//       body: Column(
//         children: <Widget>[
//           Expanded(
//             child: MessageListView(
//               threadBuilder: (_, parentMessage) => ThreadPage(
//                 parent: parentMessage,
//               ),
//             ),
//           ),
//           const MessageInput(),
//         ],
//       ),
//     );
//   }
// }

MaterialPageRoute<dynamic> routeSettings(RouteSettings settings) {
  final dynamic data = settings.arguments;
  switch (settings.name) {
    case '/':
      return MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => AuthenticationPage(),
        settings: const RouteSettings(name: '/'),
      );
    case '/channelPage':
      return MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => ChannelPage(
          channel: data['channel'] as Channel,
        ),
        settings: const RouteSettings(name: '/channelPage'),
      );
    case '/detailPage':
      return MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => Scaffold(),
        settings: const RouteSettings(name: '/detailPage'),
      );
      case '/channelListPage':
      return MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => const ChannelListPage(),
        settings: const RouteSettings(name: '/channelListPage'),
      );    case '/addChannelPage':
      return MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => const CreateChannelPage(),
        settings: const RouteSettings(name: '/addChannelPage'),
      );
    default:
      return MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => Scaffold(),
        settings: const RouteSettings(name: '/detailPage'),
      );
  }
}

class ThreadPage extends StatelessWidget {
  const ThreadPage({
    Key? key,
    this.parent,
  }) : super(key: key);

  final Message? parent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ThreadHeader(
        parent: parent!,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: MessageListView(
              parentMessage: parent,
            ),
          ),
          MessageInput(
            parentMessage: parent,
          ),
        ],
      ),
    );
  }
}
