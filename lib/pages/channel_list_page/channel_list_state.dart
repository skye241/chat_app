part of 'channel_list_cubit.dart';

@immutable
abstract class ChannelListState {}

class ChannelListInitial extends ChannelListState {}

class ChannelListGetData extends ChannelListState {
  final List<Channel> listChannel;

  ChannelListGetData(this.listChannel);
}
