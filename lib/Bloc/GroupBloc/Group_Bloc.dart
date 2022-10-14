import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:university_chatapp2/Bloc/GroupBloc/Group_Event.dart';
import 'package:university_chatapp2/Bloc/GroupBloc/Group_State.dart';
import 'package:university_chatapp2/Bloc/GroupBloc/group_bloc.dart';
import 'package:university_chatapp2/Models/RequestModels/GroupRequestModel.dart';
import 'package:university_chatapp2/Repo/GroupRepo.dart';

class GroupBloc extends Bloc<GroupEvents,GroupStates>{
  GroupRepo groupRepo=GroupRepo();
  GroupBloc(GroupStates initialState) : super(initialState){
   on<RegisterGroup>(_onAddGroupEvent);
   on<GetAllGroupsWithDetails>(_onGetAllGroupEvents);
  on<RemoveGroup>(_onDeleteGroup);
  on<UpdateGroupDetails>(_onUpdateGroup);
  on<GetGroupDetail>(_onGetGroupDetail);
  }


  FutureOr<void> _onAddGroupEvent(RegisterGroup event, Emitter<GroupStates> emit) async{
   int res=await groupRepo.addGroup( GroupRequestModel(
    groupName: event.requestModel.groupName,
    groupImage: null,
    groupStatus: event.requestModel.groupStatus
  ));
   if(res==200){
    emit(GroupSuccessState());
   }else{
     emit(GroupErrorState());
   }
  }

  Future<FutureOr<void>> _onGetAllGroupEvents(GetAllGroupsWithDetails event, Emitter<GroupStates> emit) async {
  List<GroupRequestModel> list=await groupRepo.getGroups();
  emit(ShowGroupData(list));
  }

  FutureOr<void> _onDeleteGroup(RemoveGroup event, Emitter<GroupStates> emit) {
  groupRepo.RemoveGroup(event.ID);
  }

  FutureOr<void> _onUpdateGroup(UpdateGroupDetails event, Emitter<GroupStates> emit) async{
   groupRepo.updateGroup(event.requestModel);
  }

  FutureOr<void> _onGetGroupDetail(GetGroupDetail event, Emitter<GroupStates> emit) async{
    emit(GroupSuccessState(groupRequestModel: await groupRepo.GetSingleGroup(event.ID)));
  }
}