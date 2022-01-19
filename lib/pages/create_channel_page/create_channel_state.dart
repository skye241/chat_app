part of 'create_channel_cubit.dart';

@immutable
abstract class CreateChannelState {}

class CreateChannelInitial extends CreateChannelState {
  CreateChannelInitial(this.selectedUsers);

  final List<User> selectedUsers;

}

class CreateChannelSuccess extends CreateChannelState{
  final Channel channel;

  CreateChannelSuccess(this.channel);
}