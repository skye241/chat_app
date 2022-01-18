import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'channel_state.dart';

class ChannelCubit extends Cubit<ChannelState> {
  ChannelCubit() : super(ChannelInitial());
}
