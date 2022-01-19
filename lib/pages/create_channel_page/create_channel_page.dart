import 'package:chat_app/pages/create_channel_page/create_channel_cubit.dart';
import 'package:chat_app/resources/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:intl/intl.dart';

class CreateChannelPage extends StatefulWidget {
  const CreateChannelPage({Key? key}) : super(key: key);

  @override
  _CreateChannelPageState createState() => _CreateChannelPageState();
}

class _CreateChannelPageState extends State<CreateChannelPage> {
  final CreateChannelCubit cubit = CreateChannelCubit();
  final TextEditingController channelNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateChannelCubit, CreateChannelState>(
      bloc: cubit,
      listener: (context, state) {
        if (state is CreateChannelSuccess) {
          Navigator.pushNamed(context, '/channelPage',
              arguments: <String, dynamic>{'channel': state.channel});
        }
      },
      child: BlocBuilder<CreateChannelCubit, CreateChannelState>(
        bloc: cubit,
        builder: (context, state) {
          if (state is CreateChannelInitial) {
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                elevation: 1,
                backgroundColor: Colors.white,
                leading: TextButton(
                  child: const Text(
                    'Hủy',
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
                centerTitle: true,
                title: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Nhóm mới',
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Đã chon: ${state.selectedUsers.length}',
                      style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: TextFormField(
                            controller: channelNameController,
                            decoration:
                                InputDecoration(hintText: 'Đặt tên nhóm'),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Expanded(
                      child: UsersBloc(
                        child: UserListView(
                          filter: Filter.notEqual(
                              'id', StreamChat.of(context).currentUser!.id),
                          sort: const [
                            SortOption(
                              'name',
                              direction: 1,
                            ),
                          ],
                          selectedUsers: state.selectedUsers.toSet(),
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 8,
                          ),
                          userItemBuilder: (context, user, isSelected) {
                            return InkWell(
                              onTap: () =>
                                  cubit.addUser(user, state.selectedUsers),
                              child: Container(
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      height: 24,
                                      width: 24,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: isSelected
                                              ? AppColor.primaryColor
                                              : Colors.white,
                                          border: Border.all(
                                              color: Colors.black12)),
                                      child: isSelected
                                          ? const Icon(
                                              Icons.check,
                                              color: Colors.white,
                                            )
                                          : null,
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Container(
                                      height: 48,
                                      width: 48,
                                      decoration:  BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: user.image != null? DecorationImage(image: NetworkImage(user.image!), fit: BoxFit.cover) : null,
                                        color: AppColor.primaryColor,
                                      ),
                                      child: user.image != null?null
                                          : Center(
                                              child: Text(
                                              user.name[0].toUpperCase(),
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 24),
                                            )),
                                    ),
                                    const SizedBox(
                                      width: 16,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          user.name,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(DateFormat('dd/MM/yyyy').format(
                                            user.lastActive ?? DateTime(2022))),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                          limit: 25,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              bottomNavigationBar: state.selectedUsers.isNotEmpty
                  ? Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Colors.black,
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.fromLTRB(8, 6, 8, 24),
                      height: 78,
                      child: Row(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              itemCount: state.selectedUsers.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) =>  Container(
                                margin: EdgeInsets.symmetric(horizontal: 4),
                                height: 48,
                                width: 48,
                                decoration:  BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: state.selectedUsers[index].image != null? DecorationImage(image: NetworkImage(state.selectedUsers[index].image!), fit: BoxFit.cover) : null,
                                  color: AppColor.primaryColor,
                                ),
                                child: state.selectedUsers[index].image != null?null
                                    : Center(
                                    child: Text(
                                      state.selectedUsers[index].name[0].toUpperCase(),
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 24),
                                    )),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () => cubit.createChannel(context,
                                channelNameController.text,
                                state.selectedUsers),
                            child: Container(
                              height: 48,
                              width: 48,
                              decoration: const BoxDecoration(
                                color: AppColor.primaryColor,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.arrow_forward_rounded,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : null,
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
