import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class CreateChannelPage extends StatefulWidget {
  const CreateChannelPage({Key? key}) : super(key: key);

  @override
  _CreateChannelPageState createState() => _CreateChannelPageState();
}

class _CreateChannelPageState extends State<CreateChannelPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        leading: TextButton(
          child: Text('Hủy', style: TextStyle(color: Colors.black),),
          onPressed: () => Navigator.pop(context),

        ),
        centerTitle: true,
        title: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Nhóm mới', style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),),
            Text('Đã chon: 0', style:  TextStyle(fontSize: 12, color: Colors.black, fontWeight: FontWeight.w400),),
          ],
        ),
      ),
      body: Column(
        children: [

          Expanded(
            child: UsersBloc(
              child: UserListView(
                filter: Filter.notEqual('id', StreamChat.of(context).currentUser!.id),
                sort: const [
                   SortOption(
                    'name',
                    direction: 1,
                  ),
                ],
                userItemBuilder: (context, user, isSelected) {
                  return ListTile(
                    leading: Container(
                      height: 24,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                    ),
                  );
                },
                limit: 25,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
