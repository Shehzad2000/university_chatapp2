import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:university_chatapp2/Bloc/GroupBloc/Group_Bloc.dart';
import 'package:university_chatapp2/Models/RequestModels/GroupMemberRequestModel.dart';
import 'package:university_chatapp2/Repo/GroupMembersRepo.dart';

part 'group_member_event.dart';
part 'group_member_state.dart';

class GroupMemberBloc extends Bloc<GroupMemberEvents, GroupMemberStates> {
  GroupMemberRepo repo=GroupMemberRepo();
  GroupMemberBloc() : super(GroupMemberInitialState()) {
    on<RegisterGroupMemberEvent>(_onAddGroupMember);
    on<GetAllGroupMembersWithDetails>(_onGetAllGroupMembers);
    on<GetGroupMemberDetails>(_onGetMemberDetail);
    on<RemoveGroupMember>(_onDeleteMember);
    on<UpdateGroupMemberDetails>(_onUpdateMemberDetail);
  }

  FutureOr<void> _onAddGroupMember(RegisterGroupMemberEvent event, Emitter<GroupMemberStates> emit) {
  repo.AddGroupMember(GroupMemberRequestModel(
    groupID: event.requestModel.groupID,
    status: event.requestModel.status,
    studentID: event.requestModel.studentID,
    teacherID: event.requestModel.teacherID
     ));
  }

  Future<FutureOr<void>> _onGetAllGroupMembers(GetAllGroupMembersWithDetails event, Emitter<GroupMemberStates> emit) async {
  List<GroupMemberRequestModel> list=await repo.GetAllGroupMembers();
  emit(GroupMemberShowDataState(list));
  }

  FutureOr<void> _onGetMemberDetail(GetGroupMemberDetails event, Emitter<GroupMemberStates> emit) async{
  GroupMemberRequestModel requestModel=await repo.GetGroupMemberRecord(event.ID);
  emit(GroupMemberSuccessState(requestModel));
  }

  FutureOr<void> _onDeleteMember(RemoveGroupMember event, Emitter<GroupMemberStates> emit) async{
    repo.RemoveGroupMember(event.ID);
  }


  FutureOr<void> _onUpdateMemberDetail(UpdateGroupMemberDetails event, Emitter<GroupMemberStates> emit) {
  repo.UpdateGroupMember(event.requestModel);
  }
}
