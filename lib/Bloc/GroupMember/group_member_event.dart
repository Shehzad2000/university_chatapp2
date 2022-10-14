part of 'group_member_bloc.dart';

abstract class GroupMemberEvents {}
class RegisterGroupMemberEvent extends GroupMemberEvents{
  GroupMemberRequestModel requestModel;
  RegisterGroupMemberEvent(this.requestModel);
}
class UpdateGroupMemberDetails extends GroupMemberEvents{
  GroupMemberRequestModel requestModel;
  UpdateGroupMemberDetails(this.requestModel);
}
class RemoveGroupMember extends GroupMemberEvents{
  String? ID;
  RemoveGroupMember(this.ID);
}
class GetGroupMemberDetails extends GroupMemberEvents{
  String? ID;
  GetGroupMemberDetails(this.ID);
}
class GetAllGroupMembersWithDetails extends GroupMemberEvents{
}