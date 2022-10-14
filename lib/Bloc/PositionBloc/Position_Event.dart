// ignore_for_file: file_names

import 'package:university_chatapp2/Models/RequestModels/PositionRequestModel.dart';

abstract class PositionEvents{}
class AddPositionEvent extends PositionEvents{
  PositionRequestModel positionRequestModel;
  AddPositionEvent(this.positionRequestModel);
}
class UpdatePositionEvent extends PositionEvents{
  PositionRequestModel positionRequestModel;
  UpdatePositionEvent(this.positionRequestModel);
}
class DeletePositionEvent extends PositionEvents{
  String? ID;
  DeletePositionEvent(this.ID);
}
class GetPositionEvent extends PositionEvents{
  String? ID;
  GetPositionEvent(this.ID);
}
class GetAllPositions extends PositionEvents{}