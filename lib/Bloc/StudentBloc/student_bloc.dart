import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:meta/meta.dart';
import 'package:university_chatapp2/Bloc/TeacherBloc/Teacher_State.dart';
import 'package:university_chatapp2/Models/RequestModels/DepartmentRequestModel.dart';
import 'package:university_chatapp2/Models/RequestModels/StudentRequestModel.dart';
import 'package:university_chatapp2/Repo/StudentRepo.dart';

part 'student_event.dart';
part 'student_state.dart';

class StudentBloc extends Bloc<StudentEvents, StudentStates> {
  StudentRepo studentRepo=StudentRepo();
  StudentBloc(StudentStates StudentInitial) : super(StudentInitial) {
    on<RegisterStudentEvent>(_onRegisterStudent);
    on<GetAllStudentRecordEvent>(_onGetAllStudentRecord);
    on<DeleteStudentRecordEvent>(_onRemoveStudentRecord);
    on<UpdateStudentEvent>(_onUpdateStudentDetail);
    on<GetStudentRecordEvent>(_onGetStudentRecord);
    on<GetStudentByBatchEvent>(_onGetStudentRecordByBatch);
    on<StudentSignInEvent>(_onStudentSignIn);
    on<GetStudentByDepSemBatchEvent>(_onGetStudentRecordByBatchDepSem);
  }

  FutureOr<void> _onRegisterStudent(RegisterStudentEvent event, Emitter<StudentStates> emit) async{
    int res=await studentRepo.AddStudent(StudentRequestModel(
      adminID: event.requestModel.adminID,
      studentName: event.requestModel.studentName,
      studentEmail: event.requestModel.studentEmail,
      studentContact: event.requestModel.studentContact,
      studentPassword: "123",
      studentGender: event.requestModel.studentGender,
      studentImage: null,
      semesterID: event.requestModel.semesterID,
      departmentID: event.requestModel.departmentID,
      registrationDate: DateTime.now().toString(),

      studentStatus: event.requestModel.studentStatus
    ));
    if(res==200){
      emit(StudentSuccessState());
    }else{
      emit(StudentErrorState());
    }
  }

  FutureOr<void> _onGetAllStudentRecord(GetAllStudentRecordEvent event, Emitter<StudentStates> emit) async{
  List<StudentRequestModel> list=await studentRepo.GetAllStudents();
  emit(StudentRecordState(list));
  }


  FutureOr<void> _onRemoveStudentRecord(DeleteStudentRecordEvent event, Emitter<StudentStates> emit) {
    studentRepo.RemoveStudent(event.ID);
  }

  FutureOr<void> _onUpdateStudentDetail(UpdateStudentEvent event, Emitter<StudentStates> emit) {
    studentRepo.UpdateStudentRecord(event.requestModel);
  }

  FutureOr<void> _onGetStudentRecord(GetStudentRecordEvent event, Emitter<StudentStates> emit) async{
    StudentRequestModel model=await studentRepo.GetSingleStudent(event.StudentID);
    emit(StudentSuccessState(requestModel: model));
  }

  FutureOr<void> _onGetStudentRecordByBatch(GetStudentByBatchEvent event, Emitter<StudentStates> emit) async{
    List<StudentRequestModel> list=await studentRepo.getStudentByStudentBatch(batchId: event.ID);
    emit(StudentRecordState(list));
  }

  FutureOr<void> _onStudentSignIn(StudentSignInEvent event, Emitter<StudentStates> emit) async{
    int res=await studentRepo.StudentLogin(event.studentRequestModel);
    (res==200)?emit(StudentSuccessState()):emit(StudentErrorState());
  }

  FutureOr<void> _onGetStudentRecordByBatchDepSem(GetStudentByDepSemBatchEvent event, Emitter<StudentStates> emit) async{
List<StudentRequestModel> list=await studentRepo.getStudentBySemDepBatch(depID: event.depID,semID: event.semID,batch: event.batchID);
emit(StudentRecordState(list));
  }
}
