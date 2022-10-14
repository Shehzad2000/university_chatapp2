part of 'student_bloc.dart';

@override
abstract class StudentEvents {}
class RegisterStudentEvent extends StudentEvents{
  StudentRequestModel requestModel;
  RegisterStudentEvent(this.requestModel);
}
class UpdateStudentEvent extends StudentEvents{
  StudentRequestModel requestModel;
  UpdateStudentEvent(this.requestModel);
}
class GetStudentRecordEvent extends StudentEvents{
  String? StudentID;
  GetStudentRecordEvent(this.StudentID);
}
class GetAllStudentRecordEvent extends StudentEvents{
}
class DeleteStudentRecordEvent extends StudentEvents{
  String? ID;
  DeleteStudentRecordEvent({this.ID});
}
class GetStudentByBatchEvent extends StudentEvents{
  String? ID;
  GetStudentByBatchEvent({this.ID});
}
class StudentSignInEvent extends StudentEvents{
  StudentRequestModel studentRequestModel;
  StudentSignInEvent(this.studentRequestModel);
}
class GetStudentByDepSemBatchEvent extends StudentEvents{
  String? depID,semID,batchID;
  GetStudentByDepSemBatchEvent({this.depID,this.semID,this.batchID});
}
