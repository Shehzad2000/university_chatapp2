part of 'create_group_bloc.dart';

@override
abstract class CreateGroupEvents {}
class RegisterCreateGroupData extends CreateGroupEvents{
  CreateGroupModel? createGroupModel;
  RegisterCreateGroupData(this.createGroupModel);
}
class GetCreateGroupData extends CreateGroupEvents{
String ID ;
GetCreateGroupData(this.ID);
}
class DeleteCreateGroup extends CreateGroupEvents{
  String? ID ;
  DeleteCreateGroup(this.ID);
}
class GetGroupsByDepSemAndBatchID extends CreateGroupEvents{
  String? departmentID,semesterID,batchID ;
  GetGroupsByDepSemAndBatchID({this.departmentID,this.semesterID,this.batchID});
}
class GetGroupsByStudentID extends CreateGroupEvents{
  String? studentID;
  GetGroupsByStudentID({this.studentID});
}
class GetGroupsByTeacherID extends CreateGroupEvents{
  String? teacherID;
  GetGroupsByTeacherID({this.teacherID});
}
