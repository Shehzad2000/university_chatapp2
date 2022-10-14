import 'package:university_chatapp2/Models/RequestModels/SemesterRequestModel.dart';

abstract class SemesterEvents{}
class AddSemesterEvent extends SemesterEvents{
  SemesterRequestModel semesterRequestModel;
  AddSemesterEvent(this.semesterRequestModel);
}
class UpdateSemesterEvent extends SemesterEvents{
  SemesterRequestModel requestModel;
  UpdateSemesterEvent(this.requestModel);
}
class DeleteSemesterEvent extends SemesterEvents{
  String? ID;
  DeleteSemesterEvent(this.ID);
}
class GetSemesterEvent extends SemesterEvents{
  String? ID;
  GetSemesterEvent(this.ID);
}
class GetSemestersEvent extends SemesterEvents{}