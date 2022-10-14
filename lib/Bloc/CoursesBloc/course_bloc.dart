import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:university_chatapp2/Models/RequestModels/CourseRequestModel.dart';
import 'package:university_chatapp2/Repo/CourseRepo.dart';

part 'course_event.dart';
part 'course_state.dart';

class CourseBloc extends Bloc<CourseEvents, CourseStates> {
  CourseRepo courseRepo=CourseRepo();
  CourseBloc(CourseStates) : super(CourseInitialState()) {
    on<RegisterCourseEvent>(_onRegisterCourse);
    on<UpdateCourseEvent>(_onUpdateCourse);
    on<RemoveCourseEvent>(_onRemoveCourse);
    on<CourseDetailEvent>(_onCourseDetail);
    on<ShowAllCourseWithDetailsEvent>(_onGetAllCoursesDetails);
    on<SearchCourseEvent>(_onSearchCourse);
  }

  FutureOr<void> _onRegisterCourse(RegisterCourseEvent event, Emitter<CourseStates> emit) async{
    int res=await courseRepo.RegisterCourse(CourseRequestModel(
        courseId:null,
      courseCode: event.requestModel!.courseCode,
      courseName: event.requestModel!.courseName,
      totalCreditHours: event.requestModel!.totalCreditHours,
      status: event.requestModel!.status
    ));
    emit((res==200)?CourseSuccessState():CourseErrorState());
  }

  FutureOr<void> _onUpdateCourse(UpdateCourseEvent event, Emitter<CourseStates> emit) async{
  int res=await courseRepo.UpdateCourseDetail(event.courseRequestModel!);
  emit((res==200)?CourseSuccessState():CourseErrorState());
  }

  FutureOr<void> _onRemoveCourse(RemoveCourseEvent event, Emitter<CourseStates> emit) async{
    int res=await courseRepo.RemoveCourse(event.ID!);
    emit((res==200)?CourseSuccessState():CourseErrorState());
  }

  FutureOr<void> _onCourseDetail(CourseDetailEvent event, Emitter<CourseStates> emit) async{
  emit((await courseRepo.GetCourseDetail(event.ID!)==200)?CourseSuccessState():CourseErrorState());
  }

  FutureOr<void> _onGetAllCoursesDetails(ShowAllCourseWithDetailsEvent event, Emitter<CourseStates> emit) async{
  List<CourseRequestModel>? list=await courseRepo.GetAllCourseDetail();
    emit((list!="")?CourseShowDataState(list):CourseErrorState());
  }

  FutureOr<void> _onSearchCourse(SearchCourseEvent event, Emitter<CourseStates> emit) async{
    List<CourseRequestModel> list=await courseRepo.SearchCourses(event.courseCode1 , event.courseCode2 );
    emit(CourseShowDataState(list));
  }
}
