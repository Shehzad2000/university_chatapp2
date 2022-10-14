
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:university_chatapp2/Bloc/PositionBloc/Position_Event.dart';
import 'package:university_chatapp2/Bloc/PositionBloc/Position_State.dart';
import 'package:university_chatapp2/Models/RequestModels/PositionRequestModel.dart';
import 'package:university_chatapp2/Repo/PositionRepo.dart';

import '../DepartmentBloc/Department_Event.dart';

class PositionBloc  extends Bloc<PositionEvents,PositionStates>{
  PositionRepo positionRepo=PositionRepo();
  PositionBloc(PositionStates initialState) : super(initialState){
    on<AddPositionEvent>(_onRegisterPosition);
    on<UpdatePositionEvent>(_onUpdatePosition);
    on<DeletePositionEvent>(_onDeletePosition);
  on<GetPositionEvent>(_onGetSinglePosition);
  on<GetAllPositions>(_onGetAllPositions);
  }

  FutureOr<void> _onRegisterPosition(AddPositionEvent event, Emitter<PositionStates> emit) async{
   int res=await positionRepo.RegisterPositionData(PositionRequestModel(
      positionName: event.positionRequestModel.positionName,
      positionStatus: event.positionRequestModel.positionStatus
    ));
   if(res==200){
     emit(PositionSuccessState());
   }else{
     emit(PositionErrorState());
   }
  }

  FutureOr<void> _onUpdatePosition(UpdatePositionEvent event, Emitter<PositionStates> emit) async{
    positionRepo.UpdatePositionData(event.positionRequestModel);
  }

  FutureOr<void> _onDeletePosition(DeletePositionEvent event, Emitter<PositionStates> emit) {
  positionRepo.RemovePosition(event.ID);
  }


  FutureOr<void> _onGetSinglePosition(GetPositionEvent event, Emitter<PositionStates> emit)async {
  emit(PositionSuccessState(positionRequestModel: await positionRepo.GetPositionRecord(event.ID)));
  }

  FutureOr<void> _onGetAllPositions(GetAllPositions event, Emitter<PositionStates> emit) async{
  emit(PositionShowDataState(await positionRepo.GetPositions()));
  }
}