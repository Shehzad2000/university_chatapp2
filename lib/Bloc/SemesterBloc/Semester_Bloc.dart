import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:university_chatapp2/Bloc/SemesterBloc/Semester_Event.dart';
import 'package:university_chatapp2/Bloc/SemesterBloc/Semester_State.dart';
import 'package:university_chatapp2/Models/RequestModels/SemesterRequestModel.dart';
import 'package:university_chatapp2/Repo/SemesterRepo.dart';

class SemesterBloc extends Bloc<SemesterEvents,SemesterStates>{
  var semesterRepo=SemesterRepo();
  SemesterBloc(SemesterStates initialState) : super(initialState){
   on<AddSemesterEvent>(_onRegisterSemester);
   on<UpdateSemesterEvent>(_onUpdateSemester);
   on<DeleteSemesterEvent>(_onDeleteSemester);
   on<GetSemesterEvent>(_onGetSemester);
   on<GetSemestersEvent>(_onGetSemesters);
  }


  FutureOr<void> _onRegisterSemester(AddSemesterEvent event, Emitter<SemesterStates> emit) async{
   int res=await semesterRepo.AddSemester(SemesterRequestModel(
     semesterName: event.semesterRequestModel.semesterName,
     semesterStatus: event.semesterRequestModel.semesterStatus
   ));
   if(res==200){
     emit(SemesterSuccessState());
   }else{
     emit(SemesterErrorState());
   }
  }

  FutureOr<void> _onUpdateSemester(UpdateSemesterEvent event, Emitter<SemesterStates> emit) async{
    semesterRepo.UpdateSemester(event.requestModel);
  }

  FutureOr<void> _onDeleteSemester(DeleteSemesterEvent event, Emitter<SemesterStates> emit) async{
    semesterRepo.DeleteSemester(event.ID);
  }

  FutureOr<void> _onGetSemester(GetSemesterEvent event, Emitter<SemesterStates> emit) async{
    semesterRepo.GetSemester(event.ID);
  }

  FutureOr<void> _onGetSemesters(GetSemestersEvent event, Emitter<SemesterStates> emit) async{
    emit(SemesterShowDataState(await semesterRepo.GetSemesters()));
  }
}