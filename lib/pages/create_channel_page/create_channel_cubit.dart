import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

part 'create_channel_state.dart';

class CreateChannelCubit extends Cubit<CreateChannelState> {
  CreateChannelCubit() : super(CreateChannelInitial(<User>[]));

  Future<void> addUser (User user, List<User> users) async {
    final int index = users.indexWhere((element) => element.id == user.id);
    if (index == -1) {
      users.add(user);
    } else {
      users.removeAt(index);
    }
    emit(CreateChannelInitial(users));
  }
}
