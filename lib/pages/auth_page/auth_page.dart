import 'package:chat_app/pages/auth_page/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const List<String> userIds = ['Dog', 'Cat', 'Pig', 'Chicken'];

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({Key? key}) : super(key: key);

  @override
  _AuthenticationPageState createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  final AuthCubit cubit = AuthCubit();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      bloc: cubit,
      listener: (context, state) {
        if (state is AuthShowLoading) {
          showDialog(context: context, builder: (BuildContext context) =>
            const Center(child:  CircularProgressIndicator(),
          ));
        } else if (state is AuthSuccess) {
          Navigator.popAndPushNamed(context, 'channelListPage');
        }
      },
      child: BlocBuilder<AuthCubit, AuthState>(
        bloc: cubit,
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Đăng nhập'),
              automaticallyImplyLeading: false,
              centerTitle: true,
            ),
            body: Column(
              children: <Widget>[
                Image.asset('assets/zalo.png', height: 80,),
                Expanded(
                  child: ListView.separated(
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(16),
                      itemCount: userIds.length,
                      physics: const NeverScrollableScrollPhysics(),
                      separatorBuilder: (BuildContext context, int index) =>
                          Container(height: 16,),
                      itemBuilder: (BuildContext context, int index) =>
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(

                              ),
                              onPressed: () =>
                                  cubit.connectUser(userIds[index]),
                              child: SizedBox(
                                  height: 40,
                                  width: 80,
                                  child: Center(child: Text(userIds[index]))))),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
