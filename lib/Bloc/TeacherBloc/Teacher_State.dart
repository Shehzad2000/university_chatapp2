
// ignore_for_file: camel_case_types

import 'package:university_chatapp2/Models/RequestModels/TeacherRequestModel.dart';

abstract class TeacherStates{}
class TeacherInitialState extends TeacherStates{}
class TeacherLoadingState extends TeacherStates{}
class TeacherSuccessState extends TeacherStates{
  TeacherRequestModel? teacherRequestModel;
  TeacherSuccessState({this.teacherRequestModel});
}
class TeacherErrorState extends TeacherStates{}
class TeacherShowData extends TeacherStates{
  List<TeacherRequestModel> list;
  TeacherShowData(this.list);
}
