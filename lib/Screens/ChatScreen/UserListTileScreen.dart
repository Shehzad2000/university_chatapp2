import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:university_chatapp2/Bloc/CreateGroupBloc/create_group_bloc.dart';
import 'package:university_chatapp2/Screens/ChatScreen/MessageScreen.dart';

import '../../Utility/Widget/ListTile.dart';

class UserListTile extends StatefulWidget {
  const UserListTile({Key? key}) : super(key: key);

  @override
  State<UserListTile> createState() => _UserListTileState();
}

class _UserListTileState extends State<UserListTile> {
  CreateGroupBloc? createGroupBloc;

  @override
  void initState() {
    createGroupBloc = BlocProvider.of<CreateGroupBloc>(context);
    createGroupBloc!.add(GetCreateGroupData("Lg6vUsFiD6jHKpeOrW9A"));
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 5),
      child: BlocBuilder<CreateGroupBloc, CreateGroupStates>(
        builder: (context, state) {
          if (state is CreateGroupLoadingState) {
          } else if (state is CreateGroupShowDataState) {
            return Container(
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                  itemCount: state.list!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      height: 60,
                      child: ChatScreenListTile(
                        title: state.list![index].groupName,
                        subtitle: "Papa",
                        onTap: () =>
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => MessageScreen(
                                      createGroupModel: state.list![index],
                                    ))),
                      ),
                    );
                  }),
            );
          }
          return Container();
        },
      ),
    );
  }
}
