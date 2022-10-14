part of 'batch_bloc.dart';

@override
abstract class BatchEvents {}
class RegisterBatchEvent extends BatchEvents{
  BatchRequestModel? requestModel;
  RegisterBatchEvent({this.requestModel});
}
class UpdateBatchEvent extends BatchEvents{
  BatchRequestModel? requestModel;
  UpdateBatchEvent({this.requestModel});
}
class RemoveBatchEvent extends BatchEvents{
  String? ID;
  RemoveBatchEvent({this.ID});
}
class GetSingleBatchEvent extends BatchEvents{
  String? ID;
  GetSingleBatchEvent({this.ID});
}
class GetAllBatchesEvent extends BatchEvents{
  List<BatchRequestModel>? list;
  GetAllBatchesEvent({this.list});

}
