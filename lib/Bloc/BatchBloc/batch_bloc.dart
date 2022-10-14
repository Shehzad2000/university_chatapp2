import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:university_chatapp2/Bloc/DepartmentBloc/Department_State.dart';
import 'package:university_chatapp2/Models/RequestModels/BatchRequestModel.dart';
import 'package:university_chatapp2/Models/RequestModels/BatchRequestModel.dart';
import 'package:university_chatapp2/Models/RequestModels/BatchRequestModel.dart';
import 'package:university_chatapp2/Repo/BatchRepo.dart';

import '../../Models/RequestModels/BatchRequestModel.dart';
import '../../Models/RequestModels/BatchRequestModel.dart';

part 'batch_event.dart';
part 'batch_state.dart';

class BatchBloc extends Bloc<BatchEvents, BatchStates> {
  BatchRepo repo=BatchRepo();
  BatchBloc(BatchStates batchStates) : super(BatchInitialState()) {
    on<RegisterBatchEvent>(_onRegisterBatch);
    on<UpdateBatchEvent>(_onUpdateBatch);
    on<RemoveBatchEvent>(_onRemoveBatch);
    on<GetSingleBatchEvent>(_onGetBatchDetails);
    on<GetAllBatchesEvent>(_onGetAllBatches);
  }

  FutureOr<void> _onRegisterBatch(RegisterBatchEvent event, Emitter<BatchStates> emit) async{
int res=await repo.RegisterBatch(BatchRequestModel(
  batchName: event.requestModel!.batchName,
  startDate: event.requestModel!.startDate,
  endDate: event.requestModel!.endDate,
  status: event.requestModel!.status
));
 (res==200?emit(BatchSuccessState()):emit(BatchErrorState()));
  }

  FutureOr<void> _onUpdateBatch(UpdateBatchEvent event, Emitter<BatchStates> emit) async{
  int res=await repo.UpdateBatch(event.requestModel!);
  (res==200?emit(BatchSuccessState()):emit(BatchErrorState()));
  }

  FutureOr<void> _onRemoveBatch(RemoveBatchEvent event, Emitter<BatchStates> emit) async{
  int res=await repo.RemoveBatches(event.ID);
 (res==200?emit(BatchSuccessState()):emit(BatchErrorState()));
  }

  FutureOr<void> _onGetBatchDetails(GetSingleBatchEvent event, Emitter<BatchStates> emit) async{
  BatchRequestModel? requestModel=await repo.GetBatchdetail(event.ID);
  (requestModel!=null?emit(BatchSuccessState(requestModel: requestModel)):emit(BatchErrorState()));
  }

  FutureOr<void> _onGetAllBatches(GetAllBatchesEvent event, Emitter<BatchStates> emit) async{
    List<BatchRequestModel>? list=await repo.GetAllBatches();
    list!=null?emit(BatchShowDataState(list:list)):emit(BatchErrorState());
  }
}
