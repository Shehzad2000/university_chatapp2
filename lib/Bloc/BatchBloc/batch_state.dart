part of 'batch_bloc.dart';

@override
abstract class BatchStates {}

class BatchInitialState extends BatchStates {
}
class BatchLoadingState extends BatchStates {}
class BatchSuccessState extends BatchStates {
  BatchRequestModel? requestModel;
  BatchSuccessState({this.requestModel});
}
class BatchErrorState extends BatchStates {}
class BatchShowDataState extends BatchStates {
  List<BatchRequestModel>? list;
  BatchShowDataState({this.list});
}
