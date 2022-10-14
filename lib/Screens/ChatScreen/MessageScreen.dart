import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:university_chatapp2/Bloc/ChatBloc/chat_bloc.dart';
import 'package:university_chatapp2/Bloc/CreateGroupBloc/create_group_bloc.dart';
import 'package:university_chatapp2/Models/RequestModels/ChatRequestModel.dart';
import 'package:university_chatapp2/Models/RequestModels/CreateGroupModel.dart';
import 'package:university_chatapp2/Repo/ChatRepo.dart';
import 'package:university_chatapp2/Utility/Widget/IconButtons.dart';
import 'package:university_chatapp2/Utility/Widget/ListTile.dart';

import '../../Utility/Widget/AppBar/UserAppBarWidget.dart';
import '../../Utility/Widget/AppBar/UserListTile.dart';
import 'MessageScreenDesign/RecievedMessageScreen.dart';
import 'MessageScreenDesign/SendMessageScreen.dart';

class MessageScreen extends StatefulWidget {
  MessageScreen({Key? key, this.createGroupModel}) : super(key: key);
  CreateGroupModel? createGroupModel;

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  ChatBloc? chatBloc;
  ChatRepo repo = ChatRepo();
  var messageController = TextEditingController();
  var currentUserId;
  @override
  void initState() {
    chatBloc = BlocProvider.of<ChatBloc>(context);
    chatBloc!.add(RegisterChatEvent());
    // TODO: implement initState
    super.initState();
  }

  getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    currentUserId = prefs.getString('CurrentUserID');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height*.18,
          child: const UserAppBar(),
        ),
        Container(
          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.2/1.5),
          width: MediaQuery.of(context).size.width,
          decoration:const BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.elliptical(50, 34),
                topLeft: Radius.elliptical(50, 34)),
            color: Colors.white,
            image: DecorationImage(
                image: AssetImage("assets/images/alpa.jpeg"),
                fit: BoxFit.cover),
          ),
          child: Stack(
            children: [
              StreamBuilder<List<ChatRequestModel>>(
                stream: repo
                    .getMessagesInRealTime(widget.createGroupModel!.userIds!),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) => Container(
                        child: snapshot.data![index].senderId == currentUserId
                            ? RecievedMessageScreen(
                                message: snapshot.data![index].MessageBody)
                            : SendMessageScreen(
                                message: snapshot.data![index].MessageBody),
                      ),
                    );
                  }
                  return Container();
                },
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 55,
                      child: Card(
                        color: Colors.white,
                        margin: EdgeInsets.only(left:MediaQuery.of(context).padding.left+2.0 , right: MediaQuery.of(context).padding.right+2.0, bottom: MediaQuery.of(context).padding.bottom+8.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)),
                        child: TextFormField(
                          controller: messageController,
                          textAlignVertical: TextAlignVertical.center,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Type a message",
                              prefixIcon: IconButton(
                                onPressed: () {},
                                icon:const Icon(Icons.emoji_emotions),
                              ),
                              suffixIcon: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width*.1,
                                      child: IconButtonWidget(
                                        iconData: Icons.attach_file,
                                        size: 23,
                                        color: Colors.white,
                                      )),
                                  IconButtonWidget(
                                    iconData: Icons.camera_alt,
                                    size: 23,
                                    color: Colors.grey,
                                    onPressed: () {},
                                  ),
                                ],
                              ),
                              contentPadding: EdgeInsets.all(MediaQuery.of(context).padding.top*.4)),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom*.8),
                      child: CircleAvatar(
                        radius: MediaQuery.of(context).size.height*.1/3.2,
                        child: IconButtonWidget(
                          iconData: Icons.send,
                          size: 23,
                          onPressed: () {
                            BlocProvider.of<ChatBloc>(context)
                                .add(RegisterChatEvent(
                                    requestModel: ChatRequestModel(
                              groupImage: widget.createGroupModel!.groupImage,
                              groupName: widget.createGroupModel!.groupName,
                              Date: DateTime.now(),
                              TimeSpan: DateTime.now().millisecondsSinceEpoch,
                              userIdsList: widget.createGroupModel!.userIds,
                              senderId: "Lg6vUsFiD6jHKpeOrW9A",
                              MessageBody: messageController.text,
                            )));
                            messageController.text = "";
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          height: double.infinity,
        ),
      ],
    ));
  }
}
