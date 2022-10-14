import 'package:university_chatapp2/Models/RequestModels/DepartmentRequestModel.dart';

abstract class DepartmentEvents{}
class AddDepartmentEvent extends DepartmentEvents{
  /* late SignUpRequestModel signUpRequestModel;
  AddAdminEvent(this.signUpRequestModel);*/

   DepartmentRequestModel? departmentRequestModel;
  AddDepartmentEvent(this.departmentRequestModel);
}
class UpdateDepartmentEvent extends DepartmentEvents{

  DepartmentRequestModel? departmentRequestModel;
  UpdateDepartmentEvent(this.departmentRequestModel);
}
class GetAllDepartmentsEvent extends DepartmentEvents{
}
class DeleteDepartmentEvent extends DepartmentEvents{
String? depId;
DeleteDepartmentEvent({this.depId});
}
class  GetSingleDepartmentEvent extends DepartmentEvents{
String? DepID;
GetSingleDepartmentEvent(this.DepID);
}