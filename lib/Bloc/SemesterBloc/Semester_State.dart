// ignore_for_file: file_names

import 'package:university_chatapp2/Models/RequestModels/SemesterRequestModel.dart';

abstract class SemesterStates{}
class SemesterInitialState extends SemesterStates{
}
class SemesterLoadingState extends SemesterStates{}
class SemesterSuccessState extends SemesterStates{
  SemesterRequestModel? semesterRequestModel;
  SemesterSuccessState({this.semesterRequestModel});
}
class SemesterErrorState extends SemesterStates{}
class SemesterShowDataState extends SemesterStates{
  List<SemesterRequestModel> list;
  SemesterShowDataState(this.list);
}