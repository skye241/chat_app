import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'create_channel_state.dart';

class CreateChannelCubit extends Cubit<CreateChannelState> {
  CreateChannelCubit() : super(CreateChannelInitial());
}
