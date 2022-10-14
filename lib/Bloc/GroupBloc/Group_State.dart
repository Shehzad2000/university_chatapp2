import 'package:university_chatapp2/Models/RequestModels/GroupRequestModel.dart';

abstract class GroupStates{}
class GroupInitialState extends GroupStates{}
class GroupLoadingState extends GroupStates{}
class GroupSuccessState extends GroupStates{
  GroupRequestModel? groupRequestModel;
  GroupSuccessState({this.groupRequestModel});
}
class GroupErrorState extends GroupStates{}
class ShowGroupData extends GroupStates{
  List<GroupRequestModel> list;
  ShowGroupData(this.list);
}