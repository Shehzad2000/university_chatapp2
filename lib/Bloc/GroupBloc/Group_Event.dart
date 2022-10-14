import 'package:university_chatapp2/Models/RequestModels/GroupRequestModel.dart';

abstract class GroupEvents{}
class RegisterGroup extends GroupEvents{
  GroupRequestModel requestModel;
  RegisterGroup(this.requestModel);
}
class UpdateGroupDetails extends GroupEvents{
  GroupRequestModel requestModel;
  UpdateGroupDetails(this.requestModel);
}
class RemoveGroup extends GroupEvents{
  String? ID;
  RemoveGroup(this.ID);
}
class GetAllGroupsWithDetails extends GroupEvents{

}
class GetGroupDetail extends GroupEvents{
  String? ID;
  GetGroupDetail(this.ID);
}