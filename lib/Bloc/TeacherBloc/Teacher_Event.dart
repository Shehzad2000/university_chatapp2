import 'package:university_chatapp2/Models/RequestModels/TeacherRequestModel.dart';
import 'package:university_chatapp2/Screens/Teacher/TeacherLogin.dart';

abstract class  TeacherEvents{}
class RegisterTeacherEvent extends TeacherEvents{
  TeacherRequestModel  teacherRequestModel;
  RegisterTeacherEvent(this.teacherRequestModel);
}
class UpdateTeacherDetailsEvent extends TeacherEvents{
  TeacherRequestModel teacherRequestModel;
  UpdateTeacherDetailsEvent(this.teacherRequestModel);
}
class RemoveTeacherEvent extends TeacherEvents{
  String? ID;
  RemoveTeacherEvent({this.ID});
}
class GetTeacherDetailsEvent extends TeacherEvents{
  String? ID;
  GetTeacherDetailsEvent(this.ID);
}
class GetAllTeachersDataEvent extends TeacherEvents{}
class GetTeachersByDepIDEvent extends TeacherEvents{
  String? depID;
  GetTeachersByDepIDEvent(this.depID);
}
class TeacherLoginEvent extends TeacherEvents{
  TeacherRequestModel requestModel;
  TeacherLoginEvent(this.requestModel);
}