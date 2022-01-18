import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

import '../../main.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  Future<void> connectUser (String id) async {
    emit(AuthShowLoading());
    await client.connectUser(
        User(id: id, name: id),
        client.devToken(id).rawValue
    );
    final channel = client.channel('messaging', id: 'newChannel');


    await channel.watch();
    emit(AuthSuccess(channel));
  }
}
