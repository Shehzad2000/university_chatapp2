import 'dart:async';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:university_chatapp2/Bloc/AdminBloc/SignUpEvent.dart';
import 'package:university_chatapp2/Bloc/DepartmentBloc/Department_Event.dart';
import 'package:university_chatapp2/Models/RequestModels/DepartmentRequestModel.dart';

import '../../Repo/DepartmentRepo.dart';
import 'Department_State.dart';

class DepartmentBloc extends Bloc<DepartmentEvents, DepartmentStates> {
  // FireBase fireBase = FireBase();
  DepFireBase fireBase = DepFireBase();

  DepartmentBloc(DepartmentStates initialState) : super(initialState) {
    // TODO: implement
    on<AddDepartmentEvent>(_onAddDepartmentEvent);
    on<GetAllDepartmentsEvent>(_onGetDepartments);
    on<DeleteDepartmentEvent>(_onRemoveDepartment);
    on<GetSingleDepartmentEvent>(_onGetSingleDepartment);
    on<UpdateDepartmentEvent>(_onUpdateDepartment);

  }

  FutureOr<void> _onAddDepartmentEvent(
      AddDepartmentEvent event, Emitter<DepartmentStates> emit) async{
    int res = await fireBase.AddDepartment(DepartmentRequestModel(
      departmentID: null,
      departmentName: event.departmentRequestModel!.departmentName,
      departmentStatus: event.departmentRequestModel!.departmentStatus,
    ));
    if (res == 200) {
      emit(DepartmentSuccessState());
    } else {
      emit(DepartmentErrorState());
    }
  }

  FutureOr<void> _onGetDepartments(
      GetAllDepartmentsEvent event, Emitter<DepartmentStates> emit) async {
    List<DepartmentRequestModel> list = await fireBase.getDepartments();
    emit(DepartmentShowDataState(list: list));
  }

  FutureOr<void> _onRemoveDepartment(
      DeleteDepartmentEvent event, Emitter<DepartmentStates> emit) {
    fireBase.DeleteDep(depId: event.depId);
  }

  FutureOr<void> _onGetSingleDepartment(
      GetSingleDepartmentEvent event, Emitter<DepartmentStates> emit) async {
    DepartmentRequestModel departmentRequestModel =
        await fireBase.GetSingleDepartmentData(depID: event.DepID);
    emit(
        DepartmentSuccessState(departmentRequestModel: departmentRequestModel));
  }

  FutureOr<void> _onUpdateDepartment(
      UpdateDepartmentEvent event, Emitter<DepartmentStates> emit) async {
    fireBase.UpdateDepartment(event.departmentRequestModel);
  }
}
