import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

import '../../main.dart';

part 'create_channel_state.dart';

class CreateChannelCubit extends Cubit<CreateChannelState> {
  CreateChannelCubit() : super(CreateChannelInitial(<User>[]));

  Future<void> addUser(User user, List<User> users) async {
    final int index = users.indexWhere((element) => element.id == user.id);
    if (index == -1) {
      users.add(user);
    } else {
      users.removeAt(index);
    }
    emit(CreateChannelInitial(users));
  }

  Future<void> createChannel(
      BuildContext context, String name, List<User> users) async {
    if (StreamChat.of(context).currentUser != null) {
      users.add(StreamChat.of(context).currentUser!);
    }
    final channel = client.channel(
      "messaging",
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      extraData: {
        "name": name,
        "image":
            "https://cdn.tgdd.vn/GameApp/2/227337/Screentshots/farm-story-game-nong-trai-vui-ve-227337-logo-18-08-2020.png",
        "members": users.map((e) => e.id).toList(),
      },
    );
    print(channel.name.toString() + 'finish channel');
    emit(CreateChannelSuccess(channel));
  }
}
