part of 'group_member_bloc.dart';

abstract class GroupMemberStates {}

class GroupMemberInitialState extends GroupMemberStates {}
class GroupMemberLoadingState extends GroupMemberStates {}
class GroupMemberSuccessState extends GroupMemberStates {
  GroupMemberRequestModel requestModel;
  GroupMemberSuccessState(this.requestModel);
}
class GroupMemberErrorState extends GroupMemberStates {}
class GroupMemberShowDataState extends GroupMemberStates {
  List<GroupMemberRequestModel> list;
  GroupMemberShowDataState(this.list);
}
