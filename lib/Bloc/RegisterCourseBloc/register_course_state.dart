part of 'register_course_bloc.dart';

@immutable
abstract class RegisterCourseStates {}

class RegisterCourseInitialState extends RegisterCourseStates {}
class RegisterCourseLoadingState extends RegisterCourseStates {}
class RegisterCourseSuccessState extends RegisterCourseStates {}
class RegisterCourseErrorState extends RegisterCourseStates {}
class RegisterCourseShowDataState extends RegisterCourseStates {
  List<RegisterCoursesRequestModel> list;
  RegisterCourseShowDataState(this.list);
}
