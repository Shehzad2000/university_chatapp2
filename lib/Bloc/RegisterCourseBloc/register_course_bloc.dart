import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:university_chatapp2/Bloc/CoursesBloc/course_bloc.dart';
import 'package:university_chatapp2/Repo/RegisterCourseRepo.dart';

import '../../Models/RequestModels/RegisterCoursesRequestModel.dart';

part 'register_course_event.dart';
part 'register_course_state.dart';

class RegisterCourseBloc extends Bloc<RegisterCourseEvents, RegisterCourseStates> {
  RegisterCourseRepo repo=RegisterCourseRepo();
  RegisterCourseBloc(RegisterCourseStates states) : super(RegisterCourseInitialState()) {
on<RegisterMainCourseEvent>(_onMainRegisterCourse);
on<RemoveMainCourseEvent>(_onRemoveMainCourse);
  }

  FutureOr<void> _onMainRegisterCourse(RegisterMainCourseEvent event, Emitter<RegisterCourseStates> emit) async{
    repo.MainRegisterCourse(event.requestModel);
  }

  FutureOr<void> _onRemoveMainCourse(RemoveMainCourseEvent event, Emitter<RegisterCourseStates> emit) async{
    repo.RemoveMainCourseData(event.id);
  }
}
