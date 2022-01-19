import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

part 'channel_state.dart';

class ChannelCubit extends Cubit<ChannelState> {
  ChannelCubit() : super(ChannelInitial());

  Future<void> initEvent (Channel channel) async{
    await channel.watch();

  }
}
