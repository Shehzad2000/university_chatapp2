// ignore_for_file: file_names

import 'package:university_chatapp2/Models/RequestModels/PositionRequestModel.dart';

abstract class PositionStates{}
class PositionInitialState extends PositionStates{}
class PositionLoadingState extends PositionStates{}
class PositionSuccessState extends PositionStates{
  PositionRequestModel? positionRequestModel;
  PositionSuccessState({this.positionRequestModel});
}
class PositionErrorState extends PositionStates{}
class PositionShowDataState extends PositionStates{
  List<PositionRequestModel> list;
  PositionShowDataState(this.list);
}