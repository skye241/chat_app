import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

import '../../main.dart';

part 'channel_list_state.dart';

class ChannelListCubit extends Cubit<ChannelListState> {
  ChannelListCubit() : super(ChannelListInitial());

  Future<void> getListChannel() async {

    final filter = Filter.in_('members',['thierry']);

    final sort = [const SortOption<ChannelModel>("last_message_at", direction: SortOption.DESC)];

    final channels = await client.queryChannels(
      filter: filter,
      sort: sort,
      watch: true,
      state: true,
    ).last;
    emit(ChannelListGetData(channels));
  }

  }

