import 'package:chat_app/main.dart';
import 'package:chat_app/pages/channel_page/channel_cubit.dart';
import 'package:chat_app/resources/style.dart';
import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class ChannelPage extends StatefulWidget {
  final Channel channel;
  const ChannelPage({Key? key, required this.channel}) : super(key: key);

  @override
  _ChannelPageState createState() => _ChannelPageState();
}

class _ChannelPageState extends State<ChannelPage> {
  final ChannelCubit cubit = ChannelCubit();
  @override
  void initState() {
    cubit.initEvent(widget.channel);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return StreamChannel(
      channel: widget.channel,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: Text(widget.channel.name??'', style: const TextStyle(color: Colors.white),),
            backgroundColor: AppColor.primaryColor,
            leading: IconButton(
              onPressed: () {
                Navigator.popAndPushNamed(context, '/channelListPage');
              },
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white,),
            ),
          ),
          body: Column(
            children: <Widget>[
              Expanded(
                child: MessageListView(
                  threadBuilder: (_, parentMessage) {
                    return ThreadPage(
                      parent: parentMessage,
                    );
                  },
                ),
              ),
              MessageInput(),
            ],
          ),
        ),
      ),
    );
  }
}
