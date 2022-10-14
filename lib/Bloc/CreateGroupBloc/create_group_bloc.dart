import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../Models/RequestModels/CreateGroupModel.dart';
import '../../Repo/CreateGroupRepo.dart';

part 'create_group_event.dart';
part 'create_group_state.dart';

class CreateGroupBloc extends Bloc<CreateGroupEvents, CreateGroupStates> {
  CreateGroupRepo repo=CreateGroupRepo();
  CreateGroupBloc(CreateGroupStates initialStates) : super(CreateGroupInitialState()) {
    on<GetCreateGroupData>(_onGetGroupData);
    on<GetGroupsByDepSemAndBatchID>(_onGetGroupsByDepSemAndBatchID);
    on<GetGroupsByTeacherID>(_onGetAllGroupsByTeacherID);
    on<GetGroupsByStudentID>(_onGetAllGroupsByStudentID);
  }

  FutureOr<void> _onGetGroupData(GetCreateGroupData event, Emitter<CreateGroupStates> emit) async{
    List<CreateGroupModel> list=await repo.GetData(event.ID);
    emit(CreateGroupShowDataState(list));
  }


  FutureOr<void> _onGetGroupsByDepSemAndBatchID(GetGroupsByDepSemAndBatchID event, Emitter<CreateGroupStates> emit) async{
    List<CreateGroupModel> list=await repo.GetDataByDepSemAndBatchID(event.departmentID,event.semesterID,event.batchID);
  emit(CreateGroupShowDataState(list));
  }

  FutureOr<void> _onGetAllGroupsByTeacherID(GetGroupsByTeacherID event, Emitter<CreateGroupStates> emit) async{
    List<CreateGroupModel> list=await repo.GetGroupsByTeacherID(event.teacherID);
    emit(CreateGroupShowDataState(list));
  }

  FutureOr<void> _onGetAllGroupsByStudentID(GetGroupsByStudentID event, Emitter<CreateGroupStates> emit) async{
  List<CreateGroupModel> list=await repo.GetGroupsByStudentID(event.studentID);
  emit(CreateGroupShowDataState(list));
  }
}
