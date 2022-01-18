import 'package:chat_app/pages/channel_page/channel_page.dart';
import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class ChannelListPage extends StatefulWidget {
  const ChannelListPage({Key? key}) : super(key: key);

  @override
  _ChannelListPageState createState() => _ChannelListPageState();
}

class _ChannelListPageState extends State<ChannelListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.search),
        title: Text('Tìm bạn bè, tin nhắn...'),
        actions: <Widget>[
          const Icon(Icons.qr_code),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, 'addChannelPage');
            },
              icon: Icon(Icons.add)),
        ],
      ),
      body: ChannelsBloc(
        child: ChannelListView(
          filter:
              Filter.in_('members', [StreamChat.of(context).currentUser!.id]),
          sort: [SortOption('last_message_at')],
          limit: 20,
          channelWidget: ChannelPage(),
        ),
      ),
    );
  }
}
