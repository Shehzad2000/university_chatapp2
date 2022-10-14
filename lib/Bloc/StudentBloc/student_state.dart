part of 'student_bloc.dart';

@override
abstract class StudentStates {}

class StudentInitialState extends StudentStates {}
class StudentLoadingState extends StudentStates{}
class StudentSuccessState extends StudentStates{
  StudentRequestModel? requestModel;
  StudentSuccessState({this.requestModel});
}
class StudentErrorState extends StudentStates{}
class StudentRecordState extends StudentStates{
  List<StudentRequestModel> list;
  StudentRecordState(this.list);
}
