import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:university_chatapp2/Bloc/TeacherBloc/Teacher_Event.dart';
import 'package:university_chatapp2/Bloc/TeacherBloc/Teacher_State.dart';
import 'package:university_chatapp2/Models/RequestModels/TeacherRequestModel.dart';
import 'package:university_chatapp2/Repo/TeacherRepo.dart';

class  TeacherBloc extends Bloc<TeacherEvents,TeacherStates>{
  TeacherFireBase teacherFireBase=TeacherFireBase();
  TeacherBloc(TeacherStates initialState) : super(initialState){
   on<RegisterTeacherEvent> (_onRegisterTeacher);
   on<UpdateTeacherDetailsEvent>(_onUpdateTeacherDetail);
   on<RemoveTeacherEvent>(_onRemoveTeacher);
   on<GetTeacherDetailsEvent>(_onGetTeacherDetail);
   on<GetAllTeachersDataEvent>(_onGetAllTeachers);
   on<GetTeachersByDepIDEvent>(_onGetTeachersByDepID);
   on<TeacherLoginEvent>(_onTeacherLogin);
  }


  FutureOr<void> _onRegisterTeacher(RegisterTeacherEvent event, Emitter<TeacherStates> emit) async{
   int res=await teacherFireBase.RegisterTeacher(TeacherRequestModel(
     teacherName: event.teacherRequestModel.teacherName,
     teacherEmail: event.teacherRequestModel.teacherEmail,
     teacherContact: event.teacherRequestModel.teacherContact,
     teacherPassword: "123",
     teacherImage: null,
     teacherGender: event.teacherRequestModel.teacherGender,
     departmentID: event.teacherRequestModel.departmentID,
     adminID: null,
     positionID: event.teacherRequestModel.positionID,
     registrationDate: DateFormat.yMMMMEEEEd().format(DateTime.now()),
     teacherStatus: event.teacherRequestModel.teacherStatus
   ));
   if(res==200){
     emit(TeacherSuccessState());
   }else{
     emit(TeacherErrorState());
   }
  }

  FutureOr<void> _onUpdateTeacherDetail(UpdateTeacherDetailsEvent event, Emitter<TeacherStates> emit) async{
 teacherFireBase.UpdateTeacherRecord(event.teacherRequestModel);
  }


  FutureOr<void> _onRemoveTeacher(RemoveTeacherEvent event, Emitter<TeacherStates> emit) async{
    teacherFireBase.DeleteTeacherRecord(event.ID);
  }

  FutureOr<void> _onGetTeacherDetail(GetTeacherDetailsEvent event, Emitter<TeacherStates> emit) async{
    emit(TeacherSuccessState(teacherRequestModel: await teacherFireBase.GetTeacherRecord(event.ID)));
  }

  FutureOr<void> _onGetAllTeachers(GetAllTeachersDataEvent event, Emitter<TeacherStates> emit) async{
    emit(TeacherShowData(await teacherFireBase.GetTeachers()));
  }

  FutureOr<void> _onGetTeachersByDepID(GetTeachersByDepIDEvent event, Emitter<TeacherStates> emit) async{
    emit(TeacherShowData(await teacherFireBase.GetTeacherRecordsByDepID(event.depID)));
  }

  FutureOr<void> _onTeacherLogin(TeacherLoginEvent event, Emitter<TeacherStates> emit) async{
    int res=await teacherFireBase.TeacherLogin(event.requestModel);
    (res==200)?emit(TeacherSuccessState()):emit(TeacherErrorState());
  }
}