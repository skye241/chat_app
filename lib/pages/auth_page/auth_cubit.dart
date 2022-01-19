import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

import '../../main.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  Future<void> connectUser (User user) async {
    emit(AuthShowLoading());
    await client.connectUser(
       user,
        client.devToken(user.id).rawValue
    );
    emit(AuthSuccess());
  }
}
