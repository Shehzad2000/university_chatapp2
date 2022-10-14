
import 'package:university_chatapp2/Models/RequestModels/DepartmentRequestModel.dart';

abstract class DepartmentStates{}
class DepartmentInitialState extends DepartmentStates{}
class DepartmentLoadingState extends DepartmentStates{}
class DepartmentSuccessState extends DepartmentStates{
  /* List<SignUpRequestModel>? signUpModel;
  SignUpRequestModel? signUpRequestModel;
  SignUpSuccessState({this.signUpRequestModel,this.signUpModel});*/
  List<DepartmentRequestModel>? departmentModellist;
  DepartmentRequestModel? departmentRequestModel;
  DepartmentSuccessState({this.departmentRequestModel,this.departmentModellist});
}
class DepartmentErrorState extends DepartmentStates{}
class DepartmentShowDataState extends DepartmentStates{
  List<DepartmentRequestModel>? list;
  DepartmentShowDataState({this.list});
}